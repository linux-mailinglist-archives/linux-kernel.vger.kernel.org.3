Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7A4D1713
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbiCHMSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiCHMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692C24090;
        Tue,  8 Mar 2022 04:17:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m2so10927822pll.0;
        Tue, 08 Mar 2022 04:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dr9s0/aBCglOTnR8EG3bSxaTvIl2jybWyOsb5Ha4FcU=;
        b=PSkaBDSc6grc6PHIEsor63W0fjW3myNhfSTd6Li5v2oYVoT9oAVdfi/xaBzdZGEDIE
         j6RovrxKJjj7RZUvqqJIe8/CQ5PTFbFKU2H4FDXkplqhc1AWHsigaZHmdUk2h/1tyHyu
         sWocJccy9EgKPU8zDWaST/iX1CCTGM0GRsaVMuq7+V7k5wvaF+ydROOeRyAm5x4LZdlA
         uTFhr1hspElL8g1HiPOYFNEqG6g33Z3frdiHxA0ANBMf4G4RlYiWXLzGo63VxqT1Hp4B
         AIbSwRAFFgfmmlRLoM2bU+3VxaCa7HC3kxCJr7SzZqf2wCwIWJcZtSiajLZJ/fEngN1D
         jG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dr9s0/aBCglOTnR8EG3bSxaTvIl2jybWyOsb5Ha4FcU=;
        b=PQGhJZJ2lL2Jx7hOWxAzBV4+3j1b59L+4IDp8qz7fdcUAZE2WfpmW0JpIkStuBLmi2
         CZHqvabVqP0H6skI/E9IqbaPmOCwzHlEeJPtAPeH/pZcpQtJUkAzXMzP3MfsNTtV0i9k
         WpPupgowSpBK/t3D7W539hFMDWjifrYxo/UDSlADqW/2z0yuvCV0U/U+uWfLx5G5UIzD
         upGuH7WbXJn3QtYW64y17aQPz/Qp5QlfWMu79IGMZhDBZSVfv+miM7JmR6AArXGFbAyk
         Bb5rYSxjhAJhch/WJhvOIp9IAu/bvf4smTnlC7Cxt5LZjsoxrL2SzlhTn34wmffK9PXd
         y4Pw==
X-Gm-Message-State: AOAM531Ys7lQH9vZ1WeSJtbja4rNHCirBTCxFySLhG1QchHdWeeGTJxp
        D1UeSgyiOtYfwpKD2a1u0gJH86qDlcABlHwHBA==
X-Google-Smtp-Source: ABdhPJzbtHPd5CWJbQ12WkPTeJNvlBn3yn3IeG8sbtzPWcqUyMaCCNndp6gtz+A61gNXzi9jFnYtioH8qh/Q45FXhJI=
X-Received: by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP id
 z7-20020a17090a540700b001bf43cef11bmr4291512pjh.31.1646741869517; Tue, 08 Mar
 2022 04:17:49 -0800 (PST)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 8 Mar 2022 20:17:38 +0800
Message-ID: <CAMhUBj=ty1=zk6oQY2c9N0u3jo9O7t-6oN6OJSoMXpkJBYv9KA@mail.gmail.com>
Subject: [BUG] scsi: sym53c8xx_2: warning in ___free_dma_mem_cluster()
To:     willy@infradead.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a bug when proing the sym53c8xx driver.

When the initialization process fails on sym_find_frimware(), the
driver frees the related resources, which cause a warning in kernel.

The following log reveals it:

[    3.736968] WARNING: CPU: 6 PID: 1 at kernel/dma/mapping.c:528
dma_free_attrs+0xf1/0x110
[    3.737503] Modules linked in:
[    3.737503] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1+ #31
[    3.737503] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    3.737503] RIP: 0010:dma_free_attrs+0xf1/0x110
[    3.737503] Call Trace:
[    3.737503]  <TASK>
[    3.737503]  ___free_dma_mem_cluster+0x18e/0x6a0
[    3.737503]  __sym_mfree_dma+0x2ec/0x740
[    3.737503]  sym_hcb_free+0x147/0x6e0
[    3.737503]  sym_attach+0xec1/0x1380
[    3.737503]  sym2_probe+0x852/0xab0
[    3.737503]  ? sym_log_bus_error+0x140/0x140
[    3.737503]  local_pci_probe+0x13f/0x210
[    3.737503]  pci_device_probe+0x34c/0x6d0
[    3.737503]  ? pci_uevent+0x470/0x470
[    3.737503]  really_probe+0x24c/0x8d0
[    3.737503]  __driver_probe_device+0x1b3/0x280
[    3.737503]  driver_probe_device+0x50/0x380
[    3.737503]  __driver_attach+0x416/0x580
[    3.737503]  ? driver_attach+0x40/0x40
[    3.737503]  bus_for_each_dev+0x10d/0x160
[    3.737503]  bus_add_driver+0x2f7/0x520
[    3.737503]  driver_register+0x2e9/0x3e0
[    3.737503]  sym2_init+0x16a/0x1fa
[    3.737503]  ? pqi_init+0x174/0x174
[    3.737503]  do_one_initcall+0x10c/0x260
[    3.737503]  ? pqi_init+0x174/0x174
[    3.737503]  ? do_initcall_level+0x133/0x133
[    3.737503]  ? parse_args+0x19e/0x940
[    3.737503]  ? lock_is_held_type+0xe2/0x140
[    3.737503]  do_initcall_level+0x103/0x133
[    3.737503]  do_initcalls+0x46/0x76
[    3.737503]  kernel_init_freeable+0x292/0x396
[    3.737503]  ? rest_init+0x240/0x240
[    3.737503]  kernel_init+0x14/0x1b0
[    3.737503]  ? rest_init+0x240/0x240
[    3.737503]  ret_from_fork+0x22/0x30

Regards,
Zheyu Ma
