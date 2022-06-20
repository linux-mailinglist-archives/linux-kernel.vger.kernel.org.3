Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3E552188
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbiFTPtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFTPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:49:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02AA1BEA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a2so17917928lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BxFmrRIa+vekezXU2ndkJI53IFxQQRuwCL2hgCyh3rI=;
        b=EE5uYpfUwbW+yhCsitbDozwmKkNg4mpG4ZQahK3XlYeTGhDYoqvVpHCoT5xzpURTcc
         cjNo0lfLdmeVJ5IQ69SU5T0l5SyOsyTVRZ/JsJgYtYepPqmK4x7OlqRlJs6A+dxXh09z
         TyqSN8Ltk0iX1VNgQ3wwi4LxxDz9REMLqH6/vXtkx6JVA0buOi5ldRHYWRVIGBavD/oT
         b8au3yNt/IwMuIePkU8N12rbDfxXhc9SDjRLMjVsdttQ2o7IWrpQ6oW1nDpitO/31dHU
         cYm9lqncdKbu0sq+m+mFIPb1hRuVEeWq3M4mVzMtBEQ9S3WQW6hoqAGucaMBRHAv9N8q
         VRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BxFmrRIa+vekezXU2ndkJI53IFxQQRuwCL2hgCyh3rI=;
        b=wvVBTNyT95rMv3aSaclinNsxiUg9RcBoMNdrXwCVHAmZ/zZqZLvduNfCKIz35HOAqe
         fvhQ7iguo6vp/SfJoaIO1nz5sR8SI9QXGVgR4L67J+/H2161h1squlFE6LRliS0BKsmt
         I+zI8xhzMzchq0nx/72L/QIG2QQyg4H5UB2ucL5l4mysAhaVnqxOHMYizg/1tQclOdxd
         OlapqeqqwlSVeB+RtJIxPuDuW0DajxuZ1nFpSTfoL9I19z9X85EY03iy/sahXCgCjokY
         YyYNdASUB9nqfQikYWT5zKNQYfCsTnp+nlR03hR/EbTHdqp5BaK64bZM/W82JcC+v0m/
         Ss9Q==
X-Gm-Message-State: AJIora9yFgtzFh8eUDtJyQYEdpK9Q1kJCyGh1TiOGQbypBU9QVKRJrNg
        eW9aoxxb95ziL8mrpO6yDYp4qyenmFs=
X-Google-Smtp-Source: AGRyM1sqdWC3IbkXi29u50LPbXr7CiOhdvbGy2bBIGNkubnWBbrYqutLjzCLlsUENGqK/CS2NF49dA==
X-Received: by 2002:a05:6512:228c:b0:479:2fa9:6773 with SMTP id f12-20020a056512228c00b004792fa96773mr13621418lfu.413.1655740140978;
        Mon, 20 Jun 2022 08:49:00 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id m9-20020a2e9349000000b0024f3d1dae94sm1690149ljh.28.2022.06.20.08.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:49:00 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: [PATCH V1 0/2] Ability to allocate contiguous (was DMAable) pages using unpopulated-alloc
Date:   Mon, 20 Jun 2022 18:48:54 +0300
Message-Id: <1655740136-3974-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
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

Hello all.

You can find previous discussion at [1].

The purpose of this patch series is to get feedback about supporting the allocation
of contiguous pages by Linux's unpopulated-alloc.

The unpopulated-alloc feature has been enabled on Arm since the extended-regions support
reached upstream. With that (if, of course, we run new Xen version and Xen was able to
allocate extended regions), we don't allocate the real RAM pages from host memory and balloon
them out (in order to obtain physical memory space to map the guest pages into) anymore, we use
the unpopulated pages instead. And it seems that all users I have played with on Arm (I mean,
Xen PV and virtio backends) are happy with the pages provided by xen_alloc_unpopulated_pages().
It is worth mentioning that these pages are not contiguous, but this wasn't an issue so far.

There is one place, where we still steal RAM pages if user-space Xen PV backend tries
to establish grant mapping with a need to be backed by a DMA buffer for the sake of zero-copy
(see dma_alloc*() usage in gnttab_dma_alloc_pages()).

And, if I am not mistaken (there might be pitfalls which I am not aware of), we could avoid
wasting real RAM pages in that particular case also by adding an ability to allocate
unpopulated contiguous pages (which are guaranteed to be contiguous in IPA).
The benefit is quite clear here:
1. Avoid wasting real RAM pages (reducing the amount of CMA memory usable) for allocating
   physical memory space to map the granted buffer into (which can be big enough if
   we deal with Xen PV Display driver using multiple Full HD buffers)
2. Avoid superpage shattering in Xen P2M when establishing stage-2 mapping for that
   granted buffer
3. Avoid extra operations needed for the granted buffer to be properly mapped and
   unmapped such as ballooning in/out real RAM pages
   
The corresponding series is located at [2]. In my Arm64 based environment the series works good.
Only build tested on x86.

Any feedback/help would be highly appreciated.

[1] https://lore.kernel.org/xen-devel/1652810658-27810-1-git-send-email-olekstysh@gmail.com/
[2] https://github.com/otyshchenko1/linux/commits/unpopulated-cma1

Oleksandr Tyshchenko (2):
  xen/unpopulated-alloc: Introduce helpers for contiguous allocations
  xen/grant-table: Use unpopulated contiguous pages instead of real RAM
    ones

 drivers/xen/grant-table.c       |  24 +++++
 drivers/xen/unpopulated-alloc.c | 188 +++++++++++++++++++++++++++++-----------
 include/xen/xen.h               |  20 +++++
 3 files changed, 182 insertions(+), 50 deletions(-)

-- 
2.7.4

