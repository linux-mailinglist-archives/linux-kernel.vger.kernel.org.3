Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36694F8C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiDHBPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiDHBPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:15:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9012C9DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:13:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so1648877otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1Kle3EQr1/CPSHsj2wGFWYkLo1imKPjNuOAYNOExHs=;
        b=UFGH/oIFlHTTJQozUrkXJKx7CPyl9/4A2J2k+KuS6wljCHDWMr4GNoPjm9TMSc2d+5
         Wz/iTpOA2hnbvguleQgxhxycamUICCHpdxLfu6T7YsGjFTkLMubpnQTU5bCO7T8pQzF6
         BbVdLtSzpsq/8++edOSOco+p4nbZB38+mAuO1XOpQ+Ckcc9gk21WhK5nJhwibKNmL5df
         KSBUFHBSq7ux69Lo/oJUm+4P38ZYDi2vIEOGA8Ccd1ay+j85CQC44LpXKDCGoUp8y/0Y
         t1tN2qeZHIODOJUix+Eudc8Gbf9xd+vkhu2/98xEvqaOUAu0MK217JEXVXNVgF9sxnu/
         lvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1Kle3EQr1/CPSHsj2wGFWYkLo1imKPjNuOAYNOExHs=;
        b=zyu+ZGdamQqE9eDHB6xNeXNddZlLpmCwt1PVgZ9QADzx2XsADhsZkJMdpSEvuLTit5
         FGfj3my9yhi9k0pk8nI0WCQnNoUKjtd6OyeLy4cHl9ge28+1B+xEhsipzNfJsOLJrHQe
         vSXF6ajCUEhhb9w4oG+tr/dC12e9A/GOXXG/wM4brisSSLO7APmItvQHggkFWhKcRgWZ
         6ewWgzqS+u5rA22Un5ib8xCcXm6kBTxhAQ/TFIp0Ki6PobHX3E8apA+b4/w4lcWnM+Em
         S/R3B1K48ZSC3RszBm6MldTdWa74vxi91470tZekfOvcOwVWK7bhj1Hlz2yexcc/hKJ3
         gcLw==
X-Gm-Message-State: AOAM532EIkpMSTN4S2eAhzvHrv6QXGtGEt/Fl8sQlC6CNbAITht05lgE
        Qbbn8/yly+snQay7iPNoLsXkmhgs9MgDDg==
X-Google-Smtp-Source: ABdhPJxA8Gat5vXXgIRovYAAo79QdQpB+QXY0jkhdAEwFcyrXxNjPRcfY0o6rJkCIwNpV0iPlknIVA==
X-Received: by 2002:a05:6830:11d6:b0:5b2:5a37:3cc7 with SMTP id v22-20020a05683011d600b005b25a373cc7mr5731636otq.381.1649380382380;
        Thu, 07 Apr 2022 18:13:02 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000ccfbea4f23sm9085214oae.33.2022.04.07.18.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 18:13:02 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8192u: use min_t/max_t macros instead of if else
Date:   Thu,  7 Apr 2022 20:12:51 -0500
Message-Id: <65518c0b366bf199903c6c530774c61ba6087165.1649378587.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649378587.git.remckee0@gmail.com>
References: <cover.1649378587.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace if else statement with min_t or max_t macros to increase
readability and conform to Linux kernel coding style. The _t versions
of the macros must be used to avoid applying typeof to the bit fields
pPeerHTCap->MaxRxAMPDUFactor, and pPeerHTCap->MPDUDensity.

Using u32 assures the reader that the value with not be truncated
without having to look up the types of the variables involved.
Found with minmax coccinelle script.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index dba3f2db9f48..358c35d9589c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -940,10 +940,8 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
 		} else {
-			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
-				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
-			else
-				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
+			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
+							    HT_AGG_SIZE_32K);
 		}
 	}
 
@@ -951,10 +949,9 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * <2> Set AMPDU Minimum MPDU Start Spacing
 	 * 802.11n 3.0 section 9.7d.3
 	 */
-	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
-		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
-	else
-		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
+	pHTInfo->CurrentMPDUDensity = max_t(u32, pHTInfo->MPDU_Density,
+					    pPeerHTCap->MPDUDensity);
+
 	if (ieee->pairwise_key_type != KEY_TYPE_NA)
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
-- 
2.32.0

