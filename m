Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD780500AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiDNKVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiDNKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:21:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B271ED7;
        Thu, 14 Apr 2022 03:18:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so5643852wmb.4;
        Thu, 14 Apr 2022 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3r7O9jHU98BWgcu+jBEa/rllRwW774nvph0dWvI3Q58=;
        b=ewn8QLRlCSPgCWU2xGDKwaGsKBJvKuehotVP23Tc9czCjucDaQixnCkYBFqOh5Lorg
         OBDyN93rY2Srmdv17UVs3oPZri8dyuuZaj9ZTADrJteDGYrG4ITPCJ4vVPEpAHPzeKfT
         1erhhKcK9e9jmaDpHhfCwJ2JCZCSYKWrAwAqql9KvcOCB3OkYViPKPWWPTVw56ehd88w
         JBJ05Mli9oYcr/tSB56DIrqIbr+okc2ZgnPX3JQ9eCIQ46QqJ13oTsTDrXFI+xNBLisF
         CobF+xlEVB8LXeCRtZrhuHIsZs0i/RlWmyR4cVWo1crkT3519dKLMSecQGvlTIs6zWJi
         Sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3r7O9jHU98BWgcu+jBEa/rllRwW774nvph0dWvI3Q58=;
        b=yV23the4J7wW5RcCiGOaIiaWsCcn0NoE3JxQWwwDepLc7G6P4X4MosxpF67BwKalDx
         b7FzAUI7XHkcvEOz/3NNe06m4lly2mckfRJ7xHfgFSMmhpVyymeU31b6MULJTxUELChw
         x0TWxqL9Wfiad1EKn+UJUht7IwZwlQk8sZ0vXfSWz8CNvrNpt0wYm4aRhU9rzuXzio/7
         Gqk6JIbHv51Jnn1xk+wCbjCzBJ4WvjW+mA1Ck5k4B0Q7ndUf7cvWLYRxFdSBxS0KWfnr
         kyiNeSMkzF62go8mVPGctDKeXovUhKHzfZo4CE2+uh2NiKqQ2zhan/JQbZHghcvqhf7A
         KSzA==
X-Gm-Message-State: AOAM530B4fBwWhh7tEh6m4uQlLy/FJNcrfi0ui1pEKurtyeUOEJwSpMB
        cIude1jyLcIOadDe2BxZdUA+Wq/7U1+4Lg==
X-Google-Smtp-Source: ABdhPJzmHm+1Q6N/ukniEJqJEgv0gHvZkFocvlhvKx1KJWDfVWoIO8oyF10j0cQgKu+jK5zR9YqGEQ==
X-Received: by 2002:a05:600c:3ba9:b0:38e:c8c6:ae0d with SMTP id n41-20020a05600c3ba900b0038ec8c6ae0dmr2466305wms.120.1649931519234;
        Thu, 14 Apr 2022 03:18:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b0038e6a025d05sm1777745wmr.18.2022.04.14.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:18:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: make read-only array EWC11NHTCap static const
Date:   Thu, 14 Apr 2022 11:18:38 +0100
Message-Id: <20220414101838.296944-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array EWC11NHTCap on the stack but instead
make it static const. Also makes the object code a little smaller. Move
comment to clean up checkpatch warning.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 358c35d9589c..b4cbe499ba37 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -480,7 +480,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	}
 	memset(posHTCap, 0, *len);
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
-		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
+		/* For 11n EWC definition, 2007.07.17, by Emily */
+		static const u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (struct ht_capability_ele *)&posHTCap[4];
-- 
2.35.1

