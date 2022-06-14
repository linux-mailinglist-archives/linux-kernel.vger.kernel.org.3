Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5D54ACDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiFNJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFNJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:05:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CA93B3F6;
        Tue, 14 Jun 2022 02:05:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A885E1F460;
        Tue, 14 Jun 2022 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655197540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2bKk1eux29BS2pq1HDoXZ0yBcr1SUOn0HG/pe+JV0c=;
        b=r6zqMUFihDnVftQV1SSUgRhkfWSeILh0kWjrqKqC7OsSKDoYK70NMIG4dx2UCz/sOX20d+
        0dAOzFYplXTfR6TsZ/D7lE31X8h2XvI1ukbg4ugPOHKnxPJAZbZxI4JCbJnXn7VJhSvbjO
        YJVptu3VuGkadXJu+LiwQ5sqBfhxDIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655197540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2bKk1eux29BS2pq1HDoXZ0yBcr1SUOn0HG/pe+JV0c=;
        b=rOYANPC/wruYjQy2yahevLTHWv6QVNdWgzz3oYJIXQqOm0JeuMH/Spg04rafUfX4PjnLT4
        jNLNRsQjrQ0ejZBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5600B2C141;
        Tue, 14 Jun 2022 09:05:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/8] tty/vt: consolemap: use ARRAY_SIZE(), part II.
Date:   Tue, 14 Jun 2022 11:05:30 +0200
Message-Id: <20220614090537.15557-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614075713.32767-1-jslaby@suse.cz>
References: <20220614075713.32767-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code still uses constants (macros) as bounds in loops after commit
17945d317a52 (tty/vt: consolemap: use ARRAY_SIZE()). The contants are at
least macros used also in the definition of the arrays. But use
ARRAY_SIZE() on two more places to ensure the loops never run out of
bounds even if the array definition change.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v2]
    - fix build error (which was fixed by 4/7 in v1)

 drivers/tty/vt/consolemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index fff97ae87e00..2039237b5266 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -232,7 +232,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 	}
 	memset(q, 0, MAX_GLYPH);
 
-	for (j = 0; j < E_TABSZ; j++) {
+	for (j = 0; j < ARRAY_SIZE(translations[m]); j++) {
 		glyph = conv_uni_to_pc(conp, t[j]);
 		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
@@ -367,7 +367,7 @@ int con_get_trans_old(unsigned char __user * arg)
 	unsigned char outbuf[E_TABSZ];
 
 	console_lock();
-	for (i = 0; i < E_TABSZ ; i++)
+	for (i = 0; i < ARRAY_SIZE(outbuf); i++)
 	{
 		ch = conv_uni_to_pc(vc_cons[fg_console].d, p[i]);
 		outbuf[i] = (ch & ~0xff) ? 0 : ch;
-- 
2.36.1

