Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED56A4CB036
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiCBUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbiCBUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:48:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE325D1BA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t5so2965091pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ueLCg3tmJELA0lOiV59xYuNsQ/Nirz2sRRrkKg8aSPQ=;
        b=jlWEiz82aeDhJ3ZK8Sf2LFDBbMlf/ZiXGxjGK+rpwtBtG8988DC1eHHfhGdDVbZwBS
         Ittwxzux4HQI7oE1YKmpzkti68A8+x/JI1pCNTt9m0dXpr/jdO1RGYwt1Fc1WOvxpD8G
         eMs+s4P6iFjdfNW4zjKmA1wq37ZC6kmfmMkIGYn06TtRXCu1QKwpvl2ZdlP0wwnGVnRi
         jOkszLlU+k0ILUmDA0WYGltY9Ky/kZv01h2Kipy3w9wldoPCMH603rt6ngrKE9YiSXOC
         coa2rP2YhbmpoMXul4oqo99zUMX2nGWVn/EsE/wZ0Pth/3R1g1W4T2+7PrbzVb46EuPE
         JSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ueLCg3tmJELA0lOiV59xYuNsQ/Nirz2sRRrkKg8aSPQ=;
        b=xCORCV1MguJLw7uFnaFsDZKRz5CxzngpEwMSD5azbUiIbtShw/NZa3q/5Jh2RW5npm
         OARfMadeod+WsCVaHvx1KIzV8zsykqPq/1t1Zjd4G26esnzSE1i3C5gn34ukJRmZy4Jc
         OOwsxUy6lHfLqyBqIKSWr7KQMZgx+Im+L3kAk/mfv5aukV37fc/NKfGIxQjWbsUXF2M2
         AAUAaesYK/qk38LzGKcmftcTACymT4mtyreqlHndgyt0aEp2vH7fZYdUkcKh2G1eyucD
         0gHLOfRibI4xoM4+O/Aqgf0IFzuNPho/CzXzJ3duOAQ+UEHsWCsZv/Fbttgfx2s3Eu8q
         B9Vw==
X-Gm-Message-State: AOAM532fyzuzSGKNz6XRoRlXQfWaKOZ9kqtOp7kWmYTjw+9F+58GcAiB
        0Sub8awSViMo68l5h0Br4E7dWSNP4Ft0dg==
X-Google-Smtp-Source: ABdhPJx1drPamGX0OGSlhS8Vzw5ZB39prTM1oS4YnYAxezrAjWyBt6jx5m/KMsttVgoXgBUorMWPiQ==
X-Received: by 2002:a63:28d:0:b0:365:8e16:5c19 with SMTP id 135-20020a63028d000000b003658e165c19mr27463068pgc.579.1646254089505;
        Wed, 02 Mar 2022 12:48:09 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:09 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 02/16] staging: r8188eu: mark rtw_is_cckratesonly_included as bool
Date:   Thu,  3 Mar 2022 02:17:23 +0530
Message-Id: <20220302204737.49056-3-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
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

Mark rtw_is_cckratesonly_included as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
 drivers/staging/r8188eu/include/ieee80211.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index a7b7b0f14..5a0e42ed4 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -81,7 +81,7 @@ bool	rtw_is_cckrates_included(u8 *rate)
 	return false;
 }
 
-uint	rtw_is_cckratesonly_included(u8 *rate)
+bool	rtw_is_cckratesonly_included(u8 *rate)
 {
 	u32 i = 0;
 
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 1a15db097..8c20363cd 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -874,7 +874,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val);
 
 bool	rtw_is_cckrates_included(u8 *rate);
 
-uint	rtw_is_cckratesonly_included(u8 *rate);
+bool	rtw_is_cckratesonly_included(u8 *rate);
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
 
-- 
2.30.2

