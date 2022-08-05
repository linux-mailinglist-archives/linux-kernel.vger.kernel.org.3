Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6E58A902
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbiHEJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiHEJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F5DC76949
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659692890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JGXjlckN6O3TaYu7WH0RynAN6PGi/OJ02XD8PcQh3VU=;
        b=ZVYYhBdKOTZspnTbe5tSOk5ZPCN59Ih1wkW8XLkUeaIAgMihKpRPoymXJuLPuv7mWtwdtv
        fIR/pUkS35i7fCLXmXIHon0+YpAWe/NqMoBD8oXKrL6+Nj/j1aWwO5JhvI+HFWnrmCSj3j
        GtPU2xcxV+1hp8zvTnOFnuVVwJT9v9g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-Bd270-BlPK6YAZeBYNn-FA-1; Fri, 05 Aug 2022 05:48:09 -0400
X-MC-Unique: Bd270-BlPK6YAZeBYNn-FA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-31f5960500bso17798067b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JGXjlckN6O3TaYu7WH0RynAN6PGi/OJ02XD8PcQh3VU=;
        b=hJ/FYTUq9JsLLIdkVIKtOue78KFol5pdLSKdh4VPUSxPsintMENOT7wsl8zGRhmjdE
         RnNPj1pN0rFuBdy3PjHkibmI/QVZ9GLDRzxNFyHSSfvWN3swBACwy3O5dH1Sy25MVSbr
         pTEFzNrx1FvBBrJb89SYQ12e9eWZJKFO19UPragFgKZSOpu7cmZfT+HJd4VqslPWYO91
         ey5KJ+Y35BNdxKMb4HMc77V7pfZA27C3MWeFiT9TnuaYlHwz3q8/zeXcCF9Y4fMhS/9Y
         G0g4NULShKZHYEV6LSE913QztTp7JISsacLP77+2/LD8j9EiYp1D86DamLcNwA2wHZBM
         wV+g==
X-Gm-Message-State: ACgBeo35W6euyDyHBMhqlbYXF2xeUhNg91AMlCxMF8ICp9Nmvv/EsbAB
        Hp8h4onKQGARqd1O2KEy5+M4VNCEauQmlrhiLNaTOO59IdVlqoaQ03oFP67Z9DQGkL0YsSGsYDt
        2xu9ctU2lGiBLoF4QeDaI2nXne4ttIBpoitR5Fc5R
X-Received: by 2002:a81:d34a:0:b0:31f:4467:4ae0 with SMTP id d10-20020a81d34a000000b0031f44674ae0mr5241453ywl.477.1659692888294;
        Fri, 05 Aug 2022 02:48:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ASS2Fx9gAPH6yJx8HN9U+GWh1ghQITFYgwEcHE8GkgxmM8O+fgr3r6GhQC9OhrI+MMm5ZPxt9AnlbTnZfTNQ=
X-Received: by 2002:a81:d34a:0:b0:31f:4467:4ae0 with SMTP id
 d10-20020a81d34a000000b0031f44674ae0mr5241446ywl.477.1659692888067; Fri, 05
 Aug 2022 02:48:08 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 5 Aug 2022 11:47:57 +0200
Message-ID: <CA+QYu4rPbfH-4wNR06Vn=31RCGKFFEB-KRskn52Jtig_UugYzg@mail.gmail.com>
Subject: [5.19.0] [aarch64] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
To:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since commit "c1c76700a0d6" we started to hit the following call trace
on aarch64 VMs when looking at journalctl log

kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072
bytes, linear)
kernel: ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
kernel: ------------[ cut here ]------------
kernel: WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
kernel: Modules linked in:
kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0 #1
kernel: pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
kernel: pc : __alloc_pages+0x1a0/0x290
kernel: lr : alloc_page_interleave+0x24/0xbc
kernel: sp : ffff80000803bb90
kernel: x29: ffff80000803bb90 x28: 0000000000000000 x27: 0000000000000000
kernel: x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
kernel: x23: 000000000000001e x22: 0000000000000000 x21: 000000000000001e
kernel: x20: 000000000000001e x19: 0000000000040b20 x18: 0000000000000014
kernel: x17: 6e69206562207961 x16: 6d2079676f6c6f70 x15: 6f74206568636163
kernel: x14: 20646e6120555043 x13: 6574617275636361 x12: 6e69206562207961
kernel: x11: 6d2079676f6c6f70 x10: 6f74206568636163 x9 : ffffa4f6617fd5e8
kernel: x8 : ffffa4f663ed0440 x7 : 0000000000000007 x6 : 0000000000000000
kernel: x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffa4f663c53532
kernel: Call trace:
kernel:  __alloc_pages+0x1a0/0x290
kernel:  alloc_page_interleave+0x24/0xbc
kernel:  alloc_pages+0x10c/0x16c
kernel:  kmalloc_order+0x3c/0xc0
kernel:  kmalloc_order_trace+0x38/0x130
kernel:  __kmalloc+0x2e8/0x350
kernel:  detect_cache_attributes+0x9c/0x110
kernel:  update_siblings_masks+0x34/0x270
kernel:  store_cpu_topology+0x7c/0xc0
kernel:  smp_prepare_cpus+0x34/0x108
kernel:  kernel_init_freeable+0x108/0x1b8
kernel:  kernel_init+0x30/0x150
kernel:  ret_from_fork+0x10/0x20
kernel: ---[ end trace 0000000000000000 ]---
kernel: Early cacheinfo failed, ret = -12
kernel: cblist_init_generic: Setting adjustable number of callback queues.
kernel: cblist_init_generic: Setting shift to 2 and lim to 1.

test logs: https://datawarehouse.cki-project.org/kcidb/tests/4712644
cki issue tracker: https://datawarehouse.cki-project.org/issue/1485

kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/605193135/build%20aarch64/2816138306/artifacts/kernel-mainline.kernel.org-redhat_605193135_aarch64.config
kernel build: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/605193135/publish%20aarch64/2816138315/artifacts/kernel-mainline.kernel.org-redhat_605193135_aarch64.tar.gz

Thanks,
Bruno Goncalves

