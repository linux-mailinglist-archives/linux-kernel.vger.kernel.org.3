Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716F4F6EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiDGANz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiDGANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:13:33 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9E207CBB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:09:54 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-d39f741ba0so4678681fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3TZZdYlHpJ9zQ9+NpoUHz/1y7UC3tFPbsEEkYgz4bA=;
        b=c9LOJGRDQMra2LMoB5ZPAOT+aH/VpOSvbkO47XqbH6K8cABaR3uTC2Qg4cgGXXQDWY
         k354xfAnwqN9xynjUpTA/LWBtwmnP61HEH9RplA56vtp9ftLwXL3FVjxH+Y0fOBri6AX
         BGvZ8qlkRrSWG6visci4beQHVkgd7qLfSfmk7o4wt8MWjGB4YTLOG+pRjXnz8YzPis/1
         /6/e6IQQewIsZY6e22Gfh3MD+6NnXz2EVFl+Gy2+EuOXmEQe/TfG0Rr5tA1g2lGT9JAV
         JAcxaRBhtC9Fik4JQkjALoUOeeZyhfwWAmQDss2VAkYl3x6BTLjZLb0YgYlM5gQ+lFn8
         p75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3TZZdYlHpJ9zQ9+NpoUHz/1y7UC3tFPbsEEkYgz4bA=;
        b=BLbnwybheTj3LW6S6g31txAJfVUlAZ45wumUrU2+UL9Xstux5ilp1S7e+S31UtYcaI
         mE+wRQiDtY8H+Dvclpe9Nm/C12777qeds0ebKDcrQdTjQxwIO/OHi1MHLbKnWQKN0D8A
         0nXdQsv3PJreS41MzNETB/68h7cPKR1gnoM8jd8QBouNE9PFcwb6coIQieNCj9RVFzda
         kg1+QrFdItJF7+MeF+fea+wrrSiRumy3H5L5dqoP1TCL/nykdcAVIxu0IYYmKkncI9Yo
         KlKgh7B2gPk1nMteojx6UEP3hHLMEzONUGghzv9Rmz8FRsP4DJRrl9ruvI7rWcn+/wA2
         f7Zg==
X-Gm-Message-State: AOAM531F67/CDwYL1rauy/JW4Dnoq5gyJsu1leE/Pvjw+hYRmxx6iU4G
        w2r3/v9vVNsWliQlMuwBjQ8=
X-Google-Smtp-Source: ABdhPJwx94W0va2ciedTNwdpNQ0uiUlrLDLSOlBdI1+ZpNRj4i5MgVWcvks78AT28AwwsY50SOQ8lQ==
X-Received: by 2002:a05:6870:c189:b0:da:b3f:2b5d with SMTP id h9-20020a056870c18900b000da0b3f2b5dmr5266198oad.252.1649290193810;
        Wed, 06 Apr 2022 17:09:53 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id b21-20020a9d7555000000b005b24c85da2csm7249588otl.51.2022.04.06.17.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 17:09:53 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/2] staging: rtl8192u: use min_t/max_t macros instead of if else
Date:   Wed,  6 Apr 2022 19:09:44 -0500
Message-Id: <9855c33d65558f7d2e66805009444288b99f9248.1649288226.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649288226.git.remckee0@gmail.com>
References: <cover.1649288226.git.remckee0@gmail.com>
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
Found with minmax coccinelle script.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index dba3f2db9f48..8f2cd669c5d4 100644
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
+			pHTInfo->CurrentAMPDUFactor = min_t(u8, pPeerHTCap->MaxRxAMPDUFactor,
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
+	pHTInfo->CurrentMPDUDensity = max_t(u8, pHTInfo->MPDU_Density,
+					    pPeerHTCap->MPDUDensity);
+
 	if (ieee->pairwise_key_type != KEY_TYPE_NA)
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
-- 
2.32.0

