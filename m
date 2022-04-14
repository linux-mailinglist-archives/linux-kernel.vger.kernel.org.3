Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB614501BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbiDNTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345204AbiDNTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:22:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04426ABF76
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w19so10734749lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLvcL2fLROn3t3atjcd/ETf/m7mMDU63S8SDHDmllis=;
        b=PHixjVnS4M4CDbB1CHxDVeo28b/aVzSp0mJdrnkLOhqhj+Q/2wwhqo/TFVejF1D2cn
         M+V0zaS78dJd9lsRuBeMiEdLy1jV96PMJyIQ6tdjGX+3REplXlVqvCJvz8NPjkgZDOPf
         0khIrkBNwrWYo3QJ78y6BdHbLNpK0mHknzDWftCsqrE3xGyfA0HJKlIH7azM+WvVfhCo
         FHFrJ5hJRJK3Z7+BjHY/QTvixVEHiQzKm5aCRqRcCN/lRd8u9CYEkm4z/L9bHAfjRB0R
         fxISXS4qdfBlfdENdbDSL4T/6mCEkKAVOD6Rznx/DdO6NACB2S+j7tbT1uhlqWI/zvSd
         XiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JLvcL2fLROn3t3atjcd/ETf/m7mMDU63S8SDHDmllis=;
        b=hONjbKwSm/Iz5n+ww9SpAehhaHiVnNbbDpbJ9XSKkB6dPAwPfhC3D3coCol73mTmFR
         F6JvQqAE+fK9gMPKp5MN6vWO4Pokx1jFCU6Xu2uth8cSjF6cs4FOHunWwyDjofzFW4nT
         r8v/2oEVh9LgpyvJlbbbACW5MXsu4BdaRdy9+6QGJw5E24LSrHBRUImNtpr5UKLABmO3
         QPLtBrLhqlURlbb4Bj03qxjpIPjzREQpAQ+XtMtZ1xFrwjz4ni+kBhwzm5nM886cR9tI
         i7DN4BfI1WdSYn93ozbxb70OGnd2e394PC7ZVWYz3cdrGgNajBTHxppUJMWCLOOtzriu
         N/4A==
X-Gm-Message-State: AOAM533vDodM9E31KmMmhsZb3SuGIZgc4Ma8cFesRnfqso3T7fTteEAB
        Yjvr53Q0vEniJqsdNi/kFeqxaNh1yBw=
X-Google-Smtp-Source: ABdhPJwMUxbIWiWwpSwBanMHzTQNTMGbJ4JbV9MkuLqT17euk/S+BBLtlBgciKyx0qEt1KTBdH2vcw==
X-Received: by 2002:a05:6512:1082:b0:44a:a6be:90b with SMTP id j2-20020a056512108200b0044aa6be090bmr2827259lfg.45.1649963985288;
        Thu, 14 Apr 2022 12:19:45 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l3-20020a194943000000b0046b928d2795sm85001lfj.67.2022.04.14.12.19.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:19:44 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio devices in Xen guests
Date:   Thu, 14 Apr 2022 22:19:33 +0300
Message-Id: <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Call xen_virtio_setup_dma_ops() only for Xen-aware virtio devices
in Xen guests if restricted access to the guest memory is enabled.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
 include/xen/arm/xen-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
index 621da05..28b2ad3 100644
--- a/include/xen/arm/xen-ops.h
+++ b/include/xen/arm/xen-ops.h
@@ -2,12 +2,19 @@
 #ifndef _ASM_ARM_XEN_OPS_H
 #define _ASM_ARM_XEN_OPS_H
 
+#include <linux/virtio_config.h>
 #include <xen/swiotlb-xen.h>
+#include <xen/xen-ops.h>
 
 static inline void xen_setup_dma_ops(struct device *dev)
 {
 	if (xen_swiotlb_detect())
 		dev->dma_ops = &xen_swiotlb_dma_ops;
+
+#ifdef CONFIG_XEN_VIRTIO
+	if (arch_has_restricted_virtio_memory_access() && xen_is_virtio_device(dev))
+		xen_virtio_setup_dma_ops(dev);
+#endif
 }
 
 #endif /* _ASM_ARM_XEN_OPS_H */
-- 
2.7.4

