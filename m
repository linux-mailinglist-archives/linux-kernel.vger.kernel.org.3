Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25757CD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiGUOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGUOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:14:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8276C119
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:14:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q16so1794146pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuXMSQ36nSusUUMBALQ3dzyi8fmdnN+BS6RFuCmYlZg=;
        b=ZP7YaKj7s2VtFhhan69q4hB0HJGOyf4M87x0EzKLo18Jz1CFNZzGjXYZo7Mvuxj6yQ
         48YYTupyPRgUBAi27s4pKUyBh0uQJ6KvA4AB93rOGV1Wb4C2oJM3cnMF5rugkGwomTU9
         HFzAvW34XExJIeh0NljBWK57guKs9MuhIdMJLGU5ux9hpqwtTqTCQAhOM5yVmqLFJeie
         886Xfd4udXA3PL1iEHxLLFuvlJViqs5AV1ERfQyCBdQb4cBYzzve4b2M8zOF7im11XZb
         6eSXLtRpQGRRtmEmnZw30GyCR2WDcqEMvjHP431y8ZsnG9fkzL1S5iuG7cJuFIIvq0jq
         WAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuXMSQ36nSusUUMBALQ3dzyi8fmdnN+BS6RFuCmYlZg=;
        b=wZF2hR2JnajMclxIRIIYztF9PoVKrKHSnVujhtUoFWuIe4/aUoMexlDKIMmahZ8MJ4
         7qjbTK7S8RPs+Ri5M5WbN7VhYnPvk44uVACJ5L0Kj951AmG95ONK3YcVIVqsf2+aTBrM
         KV/R7l9LIV3OAEuXhEmJ4Tu0OcsX8D31UWqWLL5jOtTGxDcJ1BkMYfE+meLME/h4QVfT
         KixZ5Oj188xw7TTenTdaUm7mSSvArJCgJyjcYhDbQMlkemU3oo1iN3R0i16mciScAn+J
         obOQtaMdLiuT/Vo0gUStmQRWXacRrYnbnhP9dTfMD0BEXaW/6q7Yw7Zdd/ofHYMQ0nUJ
         Z+MQ==
X-Gm-Message-State: AJIora+IjussmeGkyOQkzkFY3A9YS/jnBV5xTBZC2I0MhL/cO87gHQJ1
        +RVSzRlm0I9dUBFfE8hSZuU=
X-Google-Smtp-Source: AGRyM1u01IOSYOqwFqB/coJZbKD/Aj4cnTFxkXxxRpqbCXkWIH/BSNNrWyucPaUNVvvGmGjklneRVg==
X-Received: by 2002:a05:6a00:b4c:b0:52a:f6e7:818b with SMTP id p12-20020a056a000b4c00b0052af6e7818bmr44269274pfo.26.1658412877903;
        Thu, 21 Jul 2022 07:14:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:6d29:af18:34a6:1c34])
        by smtp.googlemail.com with ESMTPSA id 186-20020a6215c3000000b0052536c695c0sm1866493pfv.170.2022.07.21.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 07:14:37 -0700 (PDT)
From:   Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     abhijeet.srivastava2308@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: r8188eu: Inserted empty line after declarations
Date:   Thu, 21 Jul 2022 19:42:39 +0530
Message-Id: <20220721141407.45663-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220721141051.45447-1-abhijeet.srivastava2308@gmail.com>
References: <20220721141051.45447-1-abhijeet.srivastava2308@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script. Resending this patch after
correcting my Username

Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
v2: 
	- Fix my name on the patch
v3:
	- Fix commit message
 drivers/staging/r8188eu/core/rtw_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 5b6a891b5d67..6fbf6e4234cf 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -25,6 +25,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
 		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
+
 		if (c2h && c2h != (void *)pevtpriv)
 			kfree(c2h);
 	}
@@ -323,6 +324,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	/* prepare ssid list */
 	if (ssid) {
 		int i;
+
 		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
 			if (ssid[i].SsidLength) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
@@ -334,6 +336,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	/* prepare channel list */
 	if (ch) {
 		int i;
+
 		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
 				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
-- 
2.34.1

