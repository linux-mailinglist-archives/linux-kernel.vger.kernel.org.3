Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961E52FD44
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiEUO1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiEUO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:27:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DCD3AA5E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:27:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so9946609pfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Wnmi121K1JVbPRwWXICyVmVgS8S2HmhoyOXYg7NFFL4=;
        b=ni332OKkuHnZTj1kfvaljAvtoPZQeCglR10T5HNYqOfG3u1aegRjNB2gooie43Y2On
         A/sB3Dhjti4QPsMKwu9cOcylfEWnW8dZIYHQ6aXyipHOtEPp9bmfA4cWn23Q9J0s/fyF
         AGTO6c39BKi5zVgNVabno48Kom6UbJlvnZexYowkwBjhZTEEG3gAEE3HPWNzwXnLhFq3
         PQuE2JcgeBJ1dnAbiaImAMm+6fcBBrNlezgvBm0n+PPGFgffeGTvOtMU0BLW7UwjYn1S
         3PACxt6PVVuuPior6j263Y8UtMlt0L3BN7TKkk3G5UKOzLGIbLQZnOvUR/iN/IMIdEIr
         4JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Wnmi121K1JVbPRwWXICyVmVgS8S2HmhoyOXYg7NFFL4=;
        b=X9egkONYHp4AlMXhP+Hs5GRtjN1FDe2iJfY7uaLmaVjTIX7/0oyKZsLkIOQho2jNsh
         8N9iK27UkV1hLkKm12C/zql3kcpd50agdGJfwn+lIIIXWL2/eGJ0V/V3anmCtGtdIPpv
         BDQtbTS1OfJ7cSVweUdVt3uNy5H7eJzu1qm6g5j3Y9ktb4wBnpVuwzK0+tUWX1B2yVrX
         XHfd0F66T6mnkU5CqfwFG2z1918mesdyDQRU0MelYNekaxSeqAutQ9u3TkAOgUjV3x/D
         BY8sl3wOojGl+d/JKC6SeLB4ES026hgBvgYfxOx092JxQ/eFPzoW/HHIo4n9EdbgoAeL
         Bnkw==
X-Gm-Message-State: AOAM531TbD6lhen9fJuBgplix3rweb32jSnUyf53r1xBXKUcdV9MVYVS
        71IcwN2lHvNXfkI/JGmE+793fHa+S9otbH96CA==
X-Google-Smtp-Source: ABdhPJyzo9Ue0nYMBJo6AaF4i4Pc0LYe5wMZR1u1sg7yoJVHYC1SL70jFt00pjYqZsgKomJ4G+HmAN5cDr7HWyLhnmE=
X-Received: by 2002:a05:6a00:4486:b0:50d:fc41:a9a with SMTP id
 cu6-20020a056a00448600b0050dfc410a9amr15166524pfb.71.1653143253416; Sat, 21
 May 2022 07:27:33 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 21 May 2022 22:27:22 +0800
Message-ID: <CAMhUBj=5jD5AjyaF8UmMXAZGFnMEgTruFM2KYL3GGZt-ABcHBQ@mail.gmail.com>
Subject: [BUG] vDPA/ifcvf: got a warning when removing the module
To:     mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com,
        xieyongji@bytedance.com, elic@nvidia.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
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

Hello,

I found a bug in the ifcvf driver.
When removing the module, I got the following warning:

[   14.478123] general protection fault, probably for non-canonical
address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
[   14.478701] KASAN: null-ptr-deref in range
[0x0000000000000028-0x000000000000002f]
[   14.479922] RIP: 0010:vdpa_mgmtdev_unregister+0x39/0x150
[   14.484063] Call Trace:
[   14.484186]  <TASK>
[   14.484292]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
[   14.484536]  ifcvf_remove+0x3a/0x50 [ifcvf]
[   14.484743]  pci_device_remove+0x92/0x240

The reason is that the 'ifcvf_mgmt_dev' is zero which means that
ifcvf_vdpa_dev_add() was not executed.
Since I am not familiar with the driver, I cannot find a proper solution for it.

Zheyu Ma
