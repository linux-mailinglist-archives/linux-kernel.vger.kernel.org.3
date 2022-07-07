Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B63569FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiGGKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiGGKaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:30:02 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EAB53D1C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:30:00 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id y9so4259098pff.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/JzY69fgYbq8dtADJobUrT4pb7r35M4xnJaXr87cK3U=;
        b=rgiYYPuFcJIxT6hilVKRcyC/Q3El0dVYuzJx4a5aYTWKaJo9v1ZUYz2wOeRkuMAWgr
         wvG3S7B+tSIuH0otkB74xV1oF2m7oXx1fdh72/MroUP1H29jgOjNLfpFXlQTPe6cCaT2
         +W3PxVJNBLiTTk+C1xmEXZa66ZzQACmEwDwjqqPnkptY36xPhDAoSuo+FKNXD4um5sAe
         cUSyuGi/9flFykx8E9rbWdP6lbUVj/inSCPbxlo9IE4mgTwasNhCPdBgPRnnyMxS8QRZ
         pckJtrANZkF5H69J6tl0zBe8dw2DuokZOES/m9WqtZOgLHstk1Cp8fJ0ciT3XJ3ek+Io
         Oyvw==
X-Gm-Message-State: AJIora8MDwszwFtuHYUNpq5k6BuYq+6WqxrG9wfdxIaMJnqOd3R2mf+i
        u0FcxEzZFdQXQ/Qaz3tnjOd1eUFVXWI=
X-Google-Smtp-Source: AGRyM1sP5WYD/HQ6rAdWuX3ltvmMcNxBEYTPCu9kKK5hzBuh5N6HbxYmHp/HV+1kgm1U4f9RpXQjfg==
X-Received: by 2002:a05:6a00:1a15:b0:527:d02b:29c6 with SMTP id g21-20020a056a001a1500b00527d02b29c6mr49866585pfv.23.1657189800287;
        Thu, 07 Jul 2022 03:30:00 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([61.3.52.131])
        by smtp.gmail.com with ESMTPSA id f73-20020a62384c000000b005251ce498cfsm2725939pfa.191.2022.07.07.03.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:29:59 -0700 (PDT)
Date:   Thu, 7 Jul 2022 15:59:54 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: don't use index pointer after iter
Message-ID: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some usages of index pointer of list(w) which may not point to
the right entry when the required entry is not found and the list traversal
completes with index pointer pointing to the last entry. So, use w_found
flag to track the case where the entry is found.

Currently, When the condition (w->dapm != dapm) is true the loop continues
and when it is not then it compares the name strings and breaks out of the
loop if they match with w pointing to the right entry and it also breaks
out of loop if they didn't match by additionally setting w to NULL. But
what if the condition (w->dapm != dapm) is never false and the list
traversal completes with w pointing to last entry then usage of it after
the iter may not be correct. And there is no way to know whether the entry
is found. So, if we introduce w_found to track when the entry is found
then we can account for the case where the entry is not actually found and
the list traversal completes.

Fixes coccinelle error:
drivers/staging/greybus/audio_helper.c:135:7-8: ERROR:
invalid reference to the index variable of the iterator on line 127

Signed-off-by: Karthik Alapati <mail@karthek.com>
---
 drivers/staging/greybus/audio_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 843760675876..7c04897a22a2 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -116,6 +116,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 {
 	int i;
 	struct snd_soc_dapm_widget *w, *next_w;
+	bool w_found = false;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *parent = dapm->debugfs_dapm;
 	struct dentry *debugfs_w = NULL;
@@ -124,15 +125,18 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
 	mutex_lock(&dapm->card->dapm_mutex);
 	for (i = 0; i < num; i++) {
 		/* below logic can be optimized to identify widget pointer */
+		w_found = false
 		list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
 					 list) {
 			if (w->dapm != dapm)
 				continue;
-			if (!strcmp(w->name, widget->name))
+			if (!strcmp(w->name, widget->name)) {
+				w_found = true;
 				break;
+			}
 			w = NULL;
 		}
-		if (!w) {
+		if (!w_found) {
 			dev_err(dapm->dev, "%s: widget not found\n",
 				widget->name);
 			widget++;
-- 
2.36.1

