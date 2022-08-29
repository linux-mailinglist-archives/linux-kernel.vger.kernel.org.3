Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297D5A4CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiH2NBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2NBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:01:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB644546
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:52:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j5so4001487plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1h0GBYq+NzsJ/IQWpsMALuubNJw9yhw9UY7GXjQZX2I=;
        b=ly0bq1ZUCL2qcHcPFimIvf/jf2n+3ztJSeEDt76XL8nGh/7Vdfya9mlUMRvFnmI91M
         H3rOxCSe3ZGibiyt0eRCJF6ZwLecL22VRrXsa3aEPF4fVUjUb7hxhgVIBC8/h3ZEDNXe
         0gATDU9hxpIdN5OfnsTvkFwfJTkedE0c3qjPjgjCV1YRKIdTwaVQphn547SHivwBniZl
         d42yw0AoFFgwUM74b7V+hpD7Lcbn3sMUu/X51qEpjwBqv4mvw2H/HIRwCNMa9oJFkudy
         kkIW3wvE4SUkCnDi/GPbL/d2yiHBIvrkdzbVYa+DULtsMycy6sjTKdFNbF0AIsQLKNhG
         LO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1h0GBYq+NzsJ/IQWpsMALuubNJw9yhw9UY7GXjQZX2I=;
        b=mEJDQmuLYZcASdzTToE4GxWxnDULzknWOwCQCDD4b6wolXr2rspzwVq6CHkkQHa8+c
         PjB/A+KCabbt8nTjynT8qBbqjVUrEI+rpQ4dsnEM5De/yHTGSUfOezEq1CyfOR00hP8k
         QbDjzlM5ku7g42AkpcTdwfn9cJPxyUvlIPjQu/GpVf7/gO6OaeTRQnb9asiwqA0uMmUq
         BT34cRAlbW7zzBiBr3gTDRiSQEivMwrnraoBCSQzMmR7AVTQhid7PNg9CXMDoiKqVefd
         l6xQStC0mQtXzYf1nSZjCVrDWVc17/cO34Y8DtqpRqZtt45NMwh/wIRe0VTFXlZ7Wsb+
         Zo3A==
X-Gm-Message-State: ACgBeo1m+vVNMrIr9/3uqmPcdJxPkquDqY6uafaXAEnDYI6oA3mLy1SU
        9TTuqK2ToAVDOwChHCcmFR363A==
X-Google-Smtp-Source: AA6agR5GnXD87AIZDH/MOs+m0yJ9z56WeZdrn946KWQs2uuKa8c1y3AeCfRoXvhxEhTjciRVcdOgew==
X-Received: by 2002:a17:90b:2745:b0:1fb:1666:80f6 with SMTP id qi5-20020a17090b274500b001fb166680f6mr18203726pjb.103.1661777570505;
        Mon, 29 Aug 2022 05:52:50 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.81.110])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7517607plh.170.2022.08.29.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:52:49 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/4] Add PMEM support for RISC-V
Date:   Mon, 29 Aug 2022 18:22:22 +0530
Message-Id: <20220829125226.511564-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux NVDIMM PEM drivers require arch support to map and access the
persistent memory device. This series adds RISC-V PMEM support using
recently added Svpbmt and Zicbom support.

These patches can also be found in riscv_pmem_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (4):
  RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
  RISC-V: Move riscv_init_cbom_blocksize() to cacheflush.c
  RISC-V: Implement arch specific PMEM APIs
  RISC-V: Enable PMEM drivers

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/configs/defconfig        |  1 +
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/include/asm/io.h         | 10 ++++++++
 arch/riscv/include/asm/pgtable.h    |  2 ++
 arch/riscv/mm/Makefile              |  1 +
 arch/riscv/mm/cacheflush.c          | 37 +++++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c     | 36 ----------------------------
 arch/riscv/mm/pmem.c                | 21 ++++++++++++++++
 9 files changed, 75 insertions(+), 36 deletions(-)
 create mode 100644 arch/riscv/mm/pmem.c

-- 
2.34.1

