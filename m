Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B8545DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbiFJHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbiFJHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:54:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8C20B7C5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43E63B8083A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5CEC34114;
        Fri, 10 Jun 2022 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654847672;
        bh=DBQYB/NWje6Nr8mT58sp4vpMjE0yrhfHsUXtKYObB0w=;
        h=From:To:Cc:Subject:Date:From;
        b=dfpTaBopnWG8CcOHUvKfiXJy+VJv1UcOzVc6Z6N+l9InOyBVJwFs849QCxxzYSuYE
         EW99L4QqeD0vt0deGSi4RRQGZLn/BRQkWg9sQKk7CdXWoK6+LCkk4fbuCTicgkM9vp
         /BV/G6fv3ANFXgcuGbSmHfJtVMkPePd1mvH6kfzTsk9fOxLbveFqWaocqtFJNq50M+
         4WsgShqDTwrP+wdCsuQsAnFQbjzJMgCrF8KRV6oiY+u43X75v9HJ1bPUL/JaHppo+A
         j2ZVHOVMtOInwISsrCLAUAffB0Knc60YzO/I30TIhiz4+u15AX2HM+kn+J6tZA16Bh
         Kvzis5ZaKrdBA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzZTP-0004vk-7o; Fri, 10 Jun 2022 09:54:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jared Kangas <kangas.jd@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] staging: greybus: audio: replace safe list iteration
Date:   Fri, 10 Jun 2022 09:53:47 +0200
Message-Id: <20220610075347.18917-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No entry is being removed from the list when iterating the widget list
in gbaudio_dapm_free_controls() so there's no need to use
list_for_each_entry_safe().

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/audio_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 07461a5d97c7..05e91e6bc2a0 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -115,7 +115,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 			       int num)
 {
 	int i;
-	struct snd_soc_dapm_widget *w, *next_w, *tmp_w;
+	struct snd_soc_dapm_widget *w, *tmp_w;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *parent = dapm->debugfs_dapm;
 	struct dentry *debugfs_w = NULL;
@@ -125,8 +125,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 	for (i = 0; i < num; i++) {
 		/* below logic can be optimized to identify widget pointer */
 		w = NULL;
-		list_for_each_entry_safe(tmp_w, next_w, &dapm->card->widgets,
-					 list) {
+		list_for_each_entry(tmp_w, &dapm->card->widgets, list) {
 			if (tmp_w->dapm == dapm &&
 			    !strcmp(tmp_w->name, widget->name)) {
 				w = tmp_w;
-- 
2.35.1

