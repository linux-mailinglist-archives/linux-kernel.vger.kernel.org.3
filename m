Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6760459EF03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiHWWZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiHWWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:25:19 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C56B160
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:25:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 1D14520135;
        Wed, 24 Aug 2022 00:25:16 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TXZswaRAW6Ks; Wed, 24 Aug 2022 00:25:16 +0200 (CEST)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 0A4B52011A;
        Wed, 24 Aug 2022 00:25:16 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oQcKh-00GY3V-28;
        Wed, 24 Aug 2022 00:25:15 +0200
Message-ID: <20220823222515.412752202@ens-lyon.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Aug 2022 00:25:03 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [patch 2/2] speakup: Notify synthesizers of the punctuation level change
References: <20220823222501.483597563@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if speakup does the filtering itself, it does not filter out A_PUNC
characters (because these are needed e.g. for prosody), so we have to tell
synthesizers whether they should filter them out or not.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 drivers/accessibility/speakup/speakup_soft.c |   26 ++++++++++++++++++++++++--
 drivers/accessibility/speakup/spk_types.h    |    2 +-
 drivers/accessibility/speakup/varhandlers.c  |   12 ++++++++----
 3 files changed, 33 insertions(+), 7 deletions(-)

--- a/drivers/accessibility/speakup/varhandlers.c
+++ b/drivers/accessibility/speakup/varhandlers.c
@@ -138,6 +138,7 @@ struct st_var_header *spk_get_var_header
 		return NULL;
 	return p_header;
 }
+EXPORT_SYMBOL_GPL(spk_get_var_header);
 
 struct st_var_header *spk_var_header_by_name(const char *name)
 {
@@ -221,15 +222,17 @@ int spk_set_num_var(int input, struct st
 		*p_val = val;
 	if (var->var_id == PUNC_LEVEL) {
 		spk_punc_mask = spk_punc_masks[val];
-		return 0;
 	}
 	if (var_data->u.n.multiplier != 0)
 		val *= var_data->u.n.multiplier;
 	val += var_data->u.n.offset;
-	if (var->var_id < FIRST_SYNTH_VAR || !synth)
+
+	if (!synth)
+		return 0;
+	if (synth->synth_adjust && synth->synth_adjust(synth, var))
+		return 0;
+	if (var->var_id < FIRST_SYNTH_VAR)
 		return 0;
-	if (synth->synth_adjust)
-		return synth->synth_adjust(var);
 
 	if (!var_data->u.n.synth_fmt)
 		return 0;
@@ -245,6 +248,7 @@ int spk_set_num_var(int input, struct st
 	synth_printf("%s", cp);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(spk_set_num_var);
 
 int spk_set_string_var(const char *page, struct st_var_header *var, int len)
 {
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -26,6 +26,7 @@
 static int softsynth_probe(struct spk_synth *synth);
 static void softsynth_release(struct spk_synth *synth);
 static int softsynth_is_alive(struct spk_synth *synth);
+static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var);
 static unsigned char get_index(struct spk_synth *synth);
 
 static struct miscdevice synth_device, synthu_device;
@@ -41,7 +42,7 @@ static struct var_t vars[] = {
 	{ INFLECTION, .u.n = {"\x01%dr", 5, 0, 9, 0, 0, NULL } },
 	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
 	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
-	{ PUNCT, .u.n = {"\x01%db", 0, 0, 2, 0, 0, NULL } },
+	{ PUNCT, .u.n = {"\x01%db", 0, 0, 3, 0, 0, NULL } },
 	{ VOICE, .u.n = {"\x01%do", 0, 0, 7, 0, 0, NULL } },
 	{ FREQUENCY, .u.n = {"\x01%df", 5, 0, 9, 0, 0, NULL } },
 	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
@@ -133,7 +134,7 @@ static struct spk_synth synth_soft = {
 	.catch_up = NULL,
 	.flush = NULL,
 	.is_alive = softsynth_is_alive,
-	.synth_adjust = NULL,
+	.synth_adjust = softsynth_adjust,
 	.read_buff_add = NULL,
 	.get_index = get_index,
 	.indexing = {
@@ -426,6 +427,27 @@ static int softsynth_is_alive(struct spk
 	return 0;
 }
 
+static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
+{
+	struct st_var_header *punc_level_var;
+	struct var_t *var_data;
+
+	if (var->var_id != PUNC_LEVEL)
+		return 0;
+
+	/* We want to set the the speech synthesis punctuation level
+	 * accordingly, so it properly tunes speaking A_PUNC characters */
+	var_data = var->data;
+	if (!var_data)
+		return 0;
+	punc_level_var = spk_get_var_header(PUNCT);
+	if (!punc_level_var)
+		return 0;
+	spk_set_num_var(var_data->u.n.value, punc_level_var, E_SET);
+
+	return 1;
+}
+
 module_param_named(start, synth_soft.startup, short, 0444);
 
 MODULE_PARM_DESC(start, "Start the synthesizer once it is loaded.");
--- a/drivers/accessibility/speakup/spk_types.h
+++ b/drivers/accessibility/speakup/spk_types.h
@@ -195,7 +195,7 @@ struct spk_synth {
 	void (*catch_up)(struct spk_synth *synth);
 	void (*flush)(struct spk_synth *synth);
 	int (*is_alive)(struct spk_synth *synth);
-	int (*synth_adjust)(struct st_var_header *var);
+	int (*synth_adjust)(struct spk_synth *synth, struct st_var_header *var);
 	void (*read_buff_add)(u_char c);
 	unsigned char (*get_index)(struct spk_synth *synth);
 	struct synth_indexing indexing;

