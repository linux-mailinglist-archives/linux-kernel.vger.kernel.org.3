Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318AC53314A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiEXTGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiEXTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:06:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321EBC83
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:06:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a38so14203457pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9iK1Y/xvkraMUDUhvCrqdJBBlhbpRh8+1syBMwtJ3ms=;
        b=jjcIPpFhWhkWqmKA74ZUjcTZPVuqn+/WecT0fu0v8fD45EL2KnifCnV3+oSGKr/6tG
         OLcuCPPQI70JIW3Q79v4jPYvIlWji8SugJwfQgHjIrmVqhWNp2NxhO0NpN0min+yGIPj
         tkC50LHhJnn0iZrarDw3vesTHvhMlRQfzPDEp2pxwSUyRwwzJRqD9Valq4Y4LyDgWUGe
         +g/diqOPEkCka+s/C0GR7exGaNQxnG7oZu0iMbVAvqueAWG/Y6C7DCx0taknbo57xp3d
         QpC7lbl5YFUjQ0JlPNKXT/9GBKGdx7gdYO5M6bwuBSJ+lU651fTRWf6DHtQv42DZwVmR
         F2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9iK1Y/xvkraMUDUhvCrqdJBBlhbpRh8+1syBMwtJ3ms=;
        b=aY/iNgJfO0gL8XlcKnoyERVqJ7TuCClrtfR8AtRrb5W5Qr0QE7dnZsIt+hMunxs1mg
         wcMQrAXGcTeoH+GbxlfRq9nrgb7B8Ts6xywbZPtsKGwTqDGD6r9ugiSbV/1S73iid1dO
         9+K1ScshR1cjkH957SdqbMvdIllQcb9L8/4LOpRyUSbhBXFiRNjiC1A6vPDGY/ZHL7K4
         O4YKTJ2W+t646JESC3qCkgBwglYeErfssY0qEwzhWk9zTn1pmDh1dK9OZd7DA7gFYJWU
         MseQNYAyWQtRoaYgZ4mDABPJPDgzY/yl5lz0rKqrp7Rq9nscHGpi6PEAD9acWYmh5fs8
         wxpQ==
X-Gm-Message-State: AOAM532w/1reoUrbiffYUFdtLLNto/7yjCI6Bdta4unEZgjosvmx+jJQ
        LakPP74+gnSOxvVtrslzGQqi1Q==
X-Google-Smtp-Source: ABdhPJzmeh8RWIGak6xk08iqrJXPyqCEog91d8uB5qCyKw21A2cc3mzzZFfiJdtDcsjswaxxOzl5Gw==
X-Received: by 2002:a63:f158:0:b0:3db:8563:e8f5 with SMTP id o24-20020a63f158000000b003db8563e8f5mr25801523pgk.191.1653419174346;
        Tue, 24 May 2022 12:06:14 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id u14-20020a62d44e000000b0050dc7628153sm9682826pfl.45.2022.05.24.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:06:13 -0700 (PDT)
Date:   Tue, 24 May 2022 19:06:10 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Bug when mapping designware PCIe MSI msg
Message-ID: <Yo0soniFborDl7+C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've been debugging a PCIe dma mapping issue and I believe I have tracked the
bug down to how the designware PCIe host driver is mapping the MSI msg. In
commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume") [1],
the PCIe driver was re-worked to drop allocating a page for the MSI msg in
favor of using an address from the driver data. Then in commit 660c486590aa
("PCI: dwc: Set 32-bit DMA mask for MSI target address allocation") [2],
a 32-bit DMA mask was enforced for this MSI msg address in order to support
both 32-bit and 64-bit MSI address capable hardware. Both of these changes
together expose a bug on hardware that supports an MSI address greather than
32-bits. For example, the Pixel 6 supports a 36-bit MSI address and therefore
calls:

  dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));

Before [2], this was fine because getting an address for the driver data that
was less than or equal to 36-bits was common enough to not hit this issue, but
after [2] I started hitting the below DMA buffer overflow when the driver data
address was greater than 32-bits:

  exynos-pcie-rc 14520000.pcie: DMA addr 0x000000088536d908+2 overflow (mask ffffffff, bus limit 0).
          : WARNING: CPU: 3 PID: 8 at kernel/dma/direct.h:99 dma_map_page_attrs+0x254/0x278
  ...
  Hardware name: Oriole DVT (DT)
  Workqueue: events_unbound deferred_probe_work_func
  pstate  : 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc      : dma_map_page_attrs+0x254/0x278
  lr      : dma_map_page_attrs+0x250/0x278
  sp      : ffffffc0080938b0
  ...
  Call trace:
          : dma_map_page_attrs+0x254/0x278
          : dma_map_single_attrs+0xdc/0x10c
          : dw_pcie_host_init+0x4a0/0x78c
          : exynos_pcie_rc_add_port+0x7c/0x104 [pcie_exynos_gs]
          : exynos_pcie_rc_probe+0x4c8/0x6ec [pcie_exynos_gs]
          : platform_probe+0x80/0x200
          : really_probe+0x1cc/0x458
          : __driver_probe_device+0x204/0x260
          : driver_probe_device+0x44/0x4b0
          : __device_attach_driver+0x200/0x308
          : __device_attach+0x20c/0x330


The underlying issue is that using the driver data (which can be a 64-bit
address) for the MSI msg mapping causes a DMA_MAPPING_ERROR when the dma mask
is less than 64-bits. I'm not familiar enough with the dma mapping code to
suggest a full-proof solution to solve this; however, I don't think reverting
[1] is a great solution since it addresses a valid issue and reverting [2]
doesn't actually solve the bug since the driver data address isn't restricted
by the dma mask.

I hope that helps explain the issue. Please let me know your thoughts on how we
should address this.

Thanks,
Will


[1] https://lore.kernel.org/all/20201009155505.5a580ef5@xhacker.debian/
[2] https://lore.kernel.org/r/20201117165312.25847-1-vidyas@nvidia.com
