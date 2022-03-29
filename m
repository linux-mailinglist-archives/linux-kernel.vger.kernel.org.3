Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA284EA9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiC2JBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiC2JA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:00:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B01DDFCC;
        Tue, 29 Mar 2022 01:59:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m18so12154896plx.3;
        Tue, 29 Mar 2022 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mY4De9R7rL76ko6BC33fB4XqBVBoP3XsFOBIbCmaZbE=;
        b=UiEFFcqojWpcB9VfnNYDbUROIkzEpY7IiWN21SBsyT2Dr2WvpZmBDeU0ad+kcQamBH
         Zk4AYL99tLT0y8hoN4TrADBI7sXbyJJgS6fsK+zdt3Ahf0frA0JuKoEcHSiZUqlpJ3uC
         ZjCq1wwqgaOKbhurGQwLOFs2TJbRUSw45/bkLgwRxtKib8WSzqnkmxKsnduUmqAdvze8
         TJ05S5ff1NttNNAKbzK8TVguUvC+YnfI6kMJeKSZtn/KC4fgcwCBbqDihgOPCcQToY28
         JFC8slrqlayvbSE0cuJhIS7ULSTSQwbXtnjdaYlnd+MwwbnCRtYdigL/LBl9L2kEKYJ8
         Xv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mY4De9R7rL76ko6BC33fB4XqBVBoP3XsFOBIbCmaZbE=;
        b=kN7Uw72/pYUMpac0IV4gRAtSzwhdTTIJkivIVF47xJhOfhswKAkfu1KoTvOdFGFKWp
         PCRFGOku8CZ2TVm3cT8SxwLkn/qE+JKC6kKiedRoerldw3VE23UHtJzg+dQTZ2H8Nj/V
         mJDFF/w+LfoDSe2WB+yavBXqmQRLKTNvZfdHbBsdnmKZjUJuojKn+fHrXoEgn2ix8UW6
         V5Tc3MbZslnkFjpLOURZlbcjMeaYrpSPOVvrZuJCWpMXOMETU5eJ7wHevm+tLJxIJyTK
         6WFEKi+6nzRfJK6pFws96+GTL0FCioCPgEkj72hveLgindBkuZM1xV/rthlrXZ72wIvC
         SQLQ==
X-Gm-Message-State: AOAM530qk08Ja4YpKXoUvxq2avFIP+102Q4oM4W+UkhZtmT74HWJmNzB
        TLNADiz7PIZ3zkwi6JG8aDI=
X-Google-Smtp-Source: ABdhPJzShLo7VBeUuLFmy/JLOjtCEZsGnTkTm8qZTusC0zGJ8UFyi0JWj363J8mTIpOFJFVnschbXw==
X-Received: by 2002:a17:902:9307:b0:154:78ba:ed40 with SMTP id bc7-20020a170902930700b0015478baed40mr29569730plb.92.1648544355929;
        Tue, 29 Mar 2022 01:59:15 -0700 (PDT)
Received: from localhost.localdomain ([23.91.97.158])
        by smtp.gmail.com with ESMTPSA id ds15-20020a17090b08cf00b001c6a4974b45sm2024873pjb.40.2022.03.29.01.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:59:15 -0700 (PDT)
From:   xiaolinkui@gmail.com
To:     tsbogend@alpha.franken.de, f.fainelli@gmail.com, rppt@kernel.org,
        david@redhat.com, arnd@arndb.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaolinkui <xiaolinkui@kylinos.cn>
Subject: [PATCH] mips: fix a compilation error.
Date:   Tue, 29 Mar 2022 16:58:55 +0800
Message-Id: <20220329085855.2210-1-xiaolinkui@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: xiaolinkui <xiaolinkui@kylinos.cn>

Commit 4d5b3bdc0ecb ("MIPS: Fix a warning for virt_to_page") will
trigger a compilation error as follows with kernel v5.17-rc8:
(CONFIG_RDMA_SIW=y)

In file included from ./arch/mips/include/asm/page.h:270,
                 from ./arch/mips/include/asm/io.h:29,
                 from ./arch/mips/include/asm/mmiowb.h:5,
                 from ./include/linux/spinlock.h:64,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/net.h:19,
                 from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
./arch/mips/include/asm/page.h:255:53: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
      |                                                     ^
./include/asm-generic/memory_model.h:18:41: note: in definition of macro ‘__pfn_to_page’
   18 | #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
      |                                         ^~~
./arch/mips/include/asm/page.h:255:31: note: in expansion of macro ‘PFN_DOWN’
  255 | #define virt_to_pfn(kaddr)    PFN_DOWN(virt_to_phys((void *)(kaddr)))
      |                               ^~~~~~~~
./arch/mips/include/asm/page.h:256:41: note: in expansion of macro ‘virt_to_pfn’
  256 | #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
      |                                         ^~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_tx.c:538:23: note: in expansion of macro ‘virt_to_page’
  538 |     page_array[seg] = virt_to_page(va & PAGE_MASK);
      |                       ^~~~~~~~~~~~

Fixes: 37d15948eb72 ("MIPS: page.h: Define virt_to_pfn()")
Fixes: 4d5b3bdc0ecb ("MIPS: Fix a warning for virt_to_page")
Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 arch/mips/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 96bc798c1ec1..0f986f4ad4f0 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -252,7 +252,7 @@ static inline int pfn_valid(unsigned long pfn)
 
 #endif
 
-#define virt_to_pfn(kaddr)   	PFN_DOWN(virt_to_phys((void *)(kaddr)))
+#define virt_to_pfn(kaddr)   	PFN_DOWN(__pa(kaddr))
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 
 extern bool __virt_addr_valid(const volatile void *kaddr);
-- 
2.17.1

