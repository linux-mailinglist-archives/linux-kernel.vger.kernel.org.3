Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1DE4C96F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiCAUcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiCAUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:32:08 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B059E9C6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646166592; x=1677702592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pwbnZ7nqDFIvv/c4BSkAveh+9Y+Gghfcais2Rp9Mvyg=;
  b=bOAVPwoGtcVVD5kY7p72PP08Zr8vEkHw4HxpOtKX8FYFymfsivd1Aeey
   ItujT/FAy5X6cmZo/k3Kx62KGSVCRS9Tq6I4WTew+OfNFQBRkqlzsTb95
   TvPPSFR9IJF3EWk3OiY8pBjKA5s4Q6r78Cp7F2vvd6hc9NguLH5v9T8L3
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 12:29:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 12:29:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 12:29:51 -0800
Received: from ubuntu.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 12:29:50 -0800
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] configs/debug: set CONFIG_DEBUG_INFO=y properly
Date:   Tue, 1 Mar 2022 15:29:20 -0500
Message-ID: <20220301202920.18488-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_INFO can't be set by user directly, so set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y instead. Otherwise, we end
up with no debuginfo in vmlinux which is a big no-no for kernel
debugging.

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 kernel/configs/debug.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e9ffb0cc1eec..07df6d93c4df 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -16,7 +16,7 @@ CONFIG_SYMBOLIC_ERRNAME=y
 #
 # Compile-time checks and compiler options
 #
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_FRAME_WARN=2048
 CONFIG_SECTION_MISMATCH_WARN_ONLY=y
-- 
2.30.2

