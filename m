Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21494CB033
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiCBUsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbiCBUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:48:51 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152448389
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ay5so2634217plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2PjyD0od2VK8o284HiNQaL0WzyAhAStKIsfNQ9ArB0=;
        b=fFFvQBPJXWtHeQCHONh5v5ntNQ7cJ7QvCYiq6WK+gC/ATdr+H91A7hxohgKSGkCjnb
         xgtsiJc4Dp8lwSF27XNZmzidsjUaNfGAmD00QCo8TevAM97WCCttzFNmDfoaoxIcJp0g
         kshI5tLlcNCj34SWtftv7aFYUdhqM4ZdKfswP5l12ZQk2qKIUvY2oXLtaWwzLZzuoIcK
         LALepfGbRRV3mIwhyupYCRhqZLBtk9KK3uFuc3hQehuM0FN07cke9zPUtkWP71DzyVtM
         c0w9UfUsd64qNRkoj5a+9gTz7yMz/o/Uuf5Qp0WuoT7eKq8v8L2UsxMytd4mmn0zr9m9
         fQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2PjyD0od2VK8o284HiNQaL0WzyAhAStKIsfNQ9ArB0=;
        b=bjdohufWPmtdUnW3TDtyyYMG/Pa26r/2eNH35Px0pmbu0DyVgdzKaohw3c+tE8pkIj
         G5Tt0DakX1XBUmsMDvewQ/vOk212kATgeE5Zhlw1K0PyPp0JOxS303duZSN4LeFBQBOq
         YQr7Ct94mrDWYhHsAWTq9wt+nr0zohSIPIWYLM6eBRCmnkXdqxdah+D91X+xpvHi+P5k
         bv57UK1wNQ4pugHkVMl9oL1JOPTE0oydrY/bNdEq/VRKgkHzaIkw9qTGDrPkskH3/Vvi
         por/uV5at1CJMvZiatG7s8urG0ahlLzoXACO3XtpyE3gRoxvOt7plrdxWYP52tgnsX7+
         WFCA==
X-Gm-Message-State: AOAM530bjju/yqDfsDplKV/zLwyWx5/LeAoMSN1sdUb1/aZ7XHfiuFbU
        /tBQtvhX4NasUD42tNayAnc=
X-Google-Smtp-Source: ABdhPJwbO+QfDmpfMX0CCubakQuZwNurnyfYXKq6QOhwph5DJInXLiLWQi2dwkcZlBhLM6n6kVwCMQ==
X-Received: by 2002:a17:902:e747:b0:150:2a7:735e with SMTP id p7-20020a170902e74700b0015002a7735emr32418436plf.32.1646254086383;
        Wed, 02 Mar 2022 12:48:06 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:06 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 01/16] staging: r8188eu: mark rtw_is_cckrates_included as bool
Date:   Thu,  3 Mar 2022 02:17:22 +0530
Message-Id: <20220302204737.49056-2-makvihas@gmail.com>
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

Mark rtw_is_cckrates_included as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
 drivers/staging/r8188eu/include/ieee80211.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 62354c319..a7b7b0f14 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -68,7 +68,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint	rtw_is_cckrates_included(u8 *rate)
+bool	rtw_is_cckrates_included(u8 *rate)
 {
 	u32	i = 0;
 
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 3a860e132..1a15db097 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -872,7 +872,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
-uint	rtw_is_cckrates_included(u8 *rate);
+bool	rtw_is_cckrates_included(u8 *rate);
 
 uint	rtw_is_cckratesonly_included(u8 *rate);
 
-- 
2.30.2

