Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976984BBA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiBRNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:37:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBRNhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:37:02 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF320F6F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:36:45 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 273D840304
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645191404;
        bh=H/bO0aBxUyDz5Z1iaHc3hPM9Zt6+vPNG7kqFlweb1Sg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=doVSvq0XpiLf28mQ6nkMDU7O+44dmL9pBuOe05xIXkeOZzmv34PfgvXhKagkH7q/V
         y1Sgox/TGi5bqyqsL3LS9YaxYv6PtUGAgbv6AAYpCRCUAJUeAhwLJ1ZE1qo3fPcyT8
         jjYd+iuTCrmu5D0ni1BVc4DzzdgNavnmqwCu3P7pTeOVC42VbNHoB6kvVNzBnYnzbH
         1l771xw9oFGcE5T2kX/k65r91Fc5srjIOPy+00xwI2ROEC0G9EfDRgV1G/5Cn11wSR
         3wha+6WsMrC0Hy8eK8+lZEfYKEEYGo0/HNscGyT+mi9H+oboqySm3vTEEDLQuQZ14y
         794L7O6WxgP+w==
Received: by mail-wr1-f69.google.com with SMTP id h24-20020adfaa98000000b001e33eb81e71so3578890wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/bO0aBxUyDz5Z1iaHc3hPM9Zt6+vPNG7kqFlweb1Sg=;
        b=eftvCTNHbx3nlESI0RAiqHzOObFWcOktsVEfXDiURPGiBuXa8bR3qsbq8DlZur5JcZ
         bX5LVwP5gcTBosev42KizxdR6ijCLMm29OiXOaf0KS6aZu8nqH/iC+SeFaxHmKniTyQG
         +daZrYIkE7IH47RSI/mtW+m9MqoTfFEl6TGpnpVIgqqWw5NQf1QOAXKIzSCQmfuapYue
         zgeKoyuGkVO9ByagLnkVPnbz6Pje3/T/08eF9ddvfn3FPTJaAxbrOzd3oeQ4cXFAJ2Fx
         QmHw7AMfYuTIrirVenBVJSa6PRDEkK7Im+514fLj/Lq/be8npwLJ0fHmlvWwm07Ktvk7
         mBuQ==
X-Gm-Message-State: AOAM530ij3QiZdN3/MW+6mfznJHwfMziWbGb1fgOIy0G78tSYxVFy3Vy
        fdh9lz+o6sTmcGJI3a2k3G5kFTwns54ckACo1WKuPdQs6IC7TyzfdZvtx0SL5MAyr+w22n8AGQb
        L0X5/UTpxHXdR9R3FSrAkeftpJBhGYfVJ7s+8WvFZNg==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr5888271wre.711.1645191402135;
        Fri, 18 Feb 2022 05:36:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyONeVylq+VBkXW8VpHpa9vSjAFyqnAnqrsQ2M08ZZvxaC3/JU4jOZLRotcih0KkieDFRj/qg==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr5888255wre.711.1645191401906;
        Fri, 18 Feb 2022 05:36:41 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id z7sm4146155wml.40.2022.02.18.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:36:41 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes 1/4] riscv: Fix is_linear_mapping with recent move of KASAN region
Date:   Fri, 18 Feb 2022 14:35:10 +0100
Message-Id: <20220218133513.1762929-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
References: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN region was recently moved between the linear mapping and the
kernel mapping, is_linear_mapping used to check the validity of an
address by using the start of the kernel mapping, which is now wrong.

Fix this by using the maximum size of the physical memory.

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 160e3a1e8f8b..004372f8da54 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -119,7 +119,7 @@ extern phys_addr_t phys_ram_base;
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
 
 #define is_linear_mapping(x)	\
-	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < kernel_map.virt_addr))
+	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
 #define kernel_mapping_pa_to_va(y)	({						\
-- 
2.32.0

