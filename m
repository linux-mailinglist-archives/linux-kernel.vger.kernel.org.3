Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3AD4EFFC1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbiDBIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDBIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:48:36 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA851AA8DB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:46:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id r127so3854502qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YqDHv1Dcqlo0ogbTU2Jr0hT3fjTdhXMWahuhrdf37Y=;
        b=IG5oQIX6y5ByBMTG8lac6rfxF7hpKlBQ4aRS1dzhtdWKyeLYqgYZGOnPDxj8L3MSRO
         yGgnVURctVRZTs7lXXcf5v4Xdv12DNrOQUVWHbi4kgKM9hF7wZg879gQWC7GhkjFLf3g
         12hc+21dSTjdTZC0BhDW9wEc4GlJKHi7ijGchvH8zfAMcF+PdO2kFTc09TkRnIISyzKK
         qMGw+4GV+lfvbnh0DlXitNwBJxrUTERFU9CAiBbpoR34XYOQ9Ye8cBfHOFckUmW2GahJ
         z7tXvdMh0UwcP72iSYcbYDoAI7NfkaN4AYKv/IZhEhJsThVcp2u7PPjU5XzeoUX/58zO
         AhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YqDHv1Dcqlo0ogbTU2Jr0hT3fjTdhXMWahuhrdf37Y=;
        b=LolM43Cc5IOgcFvHffRVdRruG3YAZvw2IXbGl+iH5YF1FzMz0/aV5ZrPttt2GKW6eE
         NHJ1hlSHHUHSqE3HlVa6/cXpnzBEVQEGbVZ6VYXS2u8s7HE1DEaTIy8FHWCf7j2yiBKA
         J+OFqB2s/FcMYfbuO6si0x57TqwcniVL1u/ywl6q56u4fGF2MpuQ2SxRvFdduoAiEMVW
         v/e6eP253vtcLMFabtGxDUtl0QoXU4tTn1zmylz3Ck7ht5JQi04KGMQW+QbBwBidDv20
         DSFZmLCPQn+3HsDCDxJIImeuoDBZ+ZriYE9psd1o9AYqibUa35XsIgtYuF65+dUia446
         /GIA==
X-Gm-Message-State: AOAM5328kYmiYtwmRY3EhwSSTUaIAvd/51JcMN1Y3LX1ka5wwMcBqvTI
        BI3a9OifwnH/KcPG7B56eSU=
X-Google-Smtp-Source: ABdhPJxUBnwdNlOt1Lts4rbRLPzp0VJ+uYVvYsB1MOmsUemb0j+ms7qXDhRRXA3uAu+V+rTTtLk2EQ==
X-Received: by 2002:a05:620a:4083:b0:67d:a6e3:523c with SMTP id f3-20020a05620a408300b0067da6e3523cmr8806183qko.601.1648889204160;
        Sat, 02 Apr 2022 01:46:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b0067d47fb5aa4sm2642237qko.63.2022.04.02.01.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:46:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, robh@kernel.org, lv.ruyi@zte.com.cn,
        frank.rowand@sony.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/devicetree: Fix refcount leak in dtb_lapic_setup
Date:   Sat,  2 Apr 2022 08:46:36 +0000
Message-Id: <20220402084636.2413425-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

If dn is true that meas the of_find_compatible_node function 
successfully returns a node pointer with refcount incremented, 
use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/x86/kernel/devicetree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..6498825cf48d 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -156,6 +156,7 @@ static void __init dtb_lapic_setup(void)
 	dn = of_find_compatible_node(NULL, NULL, "intel,ce4100-lapic");
 	if (dn) {
 		ret = of_address_to_resource(dn, 0, &r);
+		of_node_put(dn);
 		if (WARN_ON(ret))
 			return;
 		lapic_addr = r.start;
-- 
2.25.1

