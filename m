Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3124F4907
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356147AbiDEWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358857AbiDELRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380589305
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:49:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n6so11778267ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zD1kXeS1kclzzdV89Yh6GTfc9Fb/ROE7/kA41SKYvPA=;
        b=JvijGFR0Mo9047KejSeh5imWsynBG2ab7mdKpGSk7iREVkHWUP3qVkSoBI0i3ZVSuy
         mOy3gQC42UCpZuE4FUymaZWOexVhTNqRrF5NbQq73XC6wR4SVrJk5cy20KHR3+7Fhxcm
         OP0uasULbcaUt+1O+/sRRcSJEGx8bS3LLDmwfvKf0HXlVdctfTDKdd4pMJtxIFgpnHhI
         DxKL1+9KcO57fxRSSP+Bu+hV34vEgYuBJRz53q/Rz5bpg/xT7vPLOIK0b8txP4NVBPMh
         aBGoRyyGSPkBMa0cOCAnpTUryFbV0A4fcouQpVkU3z6sxZ9XN14IIQEAG63rAnpelzxO
         U+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zD1kXeS1kclzzdV89Yh6GTfc9Fb/ROE7/kA41SKYvPA=;
        b=W67/uXHBFAqB1Q6ZhKJZqu1vK8QE9HtpxgcGAYE/y5dM+3xwmCdZ7j8tsYMeVCs8te
         mc5X7Dyj7N+3GbUDMwBKBfvbxSeyp/TIjnbxaoDXBiw9jZ5bMft2mI67WoDZtNqN1gAd
         EJZW42OMsPG5caePljrLGJB9Uz3ZQJ+8QOVedhqmVb0a6SStAWAXAID+JJqJTnsk8Tax
         Mj/GYkCgXk4Vj1UH5zjibaFhBNfb3sZcLsm4jj25ls5SksDJOGfrXoCbp4nULnpGjBqS
         1ZQQVwJSjdPoMVCfMZpWVCjbwYWJnIb6bCDe9h8fcQPxlv1vYUw6JWBsUlzeiprvtj1A
         PLpw==
X-Gm-Message-State: AOAM530uoJfyN4k9sJeAdVieFidwrmJ7kBR9T6JYe9c1yzP5T4APHcx+
        kzCictbL3cGibHLwVJ+TwFg=
X-Google-Smtp-Source: ABdhPJwmvbxYcATdJGs6tIu5uarpASeWFbRGq3gJjHqxw8Y9mHDS0WnAWMzFzkswBpgf0+/IjidnQQ==
X-Received: by 2002:a17:906:d146:b0:6da:f381:4dfe with SMTP id br6-20020a170906d14600b006daf3814dfemr2856426ejb.670.1649155766340;
        Tue, 05 Apr 2022 03:49:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm2436702edl.28.2022.04.05.03.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:49:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/4] staging: r8188eu: cur_ant is set but never used
Date:   Tue,  5 Apr 2022 12:49:07 +0200
Message-Id: <20220405104910.9769-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405104910.9769-1-straube.linux@gmail.com>
References: <20220405104910.9769-1-straube.linux@gmail.com>
MIME-Version: 1.0
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

In rtw_select_and_join_from_scanned_queue() the local variable cur_ant
is set but never used. Remove the variable and related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
- made it the first patch in the series
- changed subject line

 drivers/staging/r8188eu/core/rtw_mlme.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f94b1536a177..24ceb8028f89 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1458,7 +1458,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
-	u8	supp_ant_div = false;
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
@@ -1485,12 +1484,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_free_assoc_resources(adapter, 0);
 	}
 
-	GetHalDefVar8188EUsb(adapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &supp_ant_div);
-	if (supp_ant_div) {
-		u8 cur_ant;
-		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
-	}
-
 	ret = rtw_joinbss_cmd(adapter, candidate);
 
 exit:
-- 
2.35.1

