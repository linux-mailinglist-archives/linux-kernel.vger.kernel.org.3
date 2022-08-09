Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DC58E1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiHIV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiHIV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:28:41 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6061DAD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:28:40 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10dc1b16c12so15558791fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=E2PBH54C+fEWj4YcL87ROyWSx34hfirEMrXLjLTIjHY=;
        b=VcdAZ1qkx3IguxUwgqH/l0H+AeyeSQu4I2Fr/0AJpfyK+PJknfx92gx0lk4UZCXbYZ
         uVrJ8MXLGwFoh3cvj2ZVlLV0GFBwp1SqN3IqcYh9cbG9TmtFzUSuadZEaGcZ7Z6ri45b
         dwWlaIKpSsgYrBOBtMEMj2Z3+WlPinFFCjntyYedv7u5I8PDqneUsI8uYKZUjDl/N5oM
         xbV3faguNUsnkl2WntHchMfG+K8JfC8EI1M085tqIGFC1MNYn4+Vg3X7aNJKT2Ns2XKM
         PWvud3h06pT8NTisYgqNYYA7+tJtwaOVx+2ER0lQMM3GnPsfxiKUw4+mblr0LxXvMhVT
         9Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=E2PBH54C+fEWj4YcL87ROyWSx34hfirEMrXLjLTIjHY=;
        b=jDs+m8KPArNG04PCXVsIvVDmjPyRMY2ZAgZaY/JuUvtxerdHrJcApkj9a4OABQvpFS
         SnfsSsf7NwW9WKQJYa5knHIuRrQYGR0Rsm2aSv3bMlbBEDLStEOsU3p3+epStNxXj8PU
         0gd9H/ulPkvYbn6VWR46M7yXmeGO11mcgZEJd0ABjVNWGbVgyDhDaGfTq91Pr/2ZoYzM
         T5xz9zOhvjkX567ipHcoNfWKlkGxxSxVQ33bH3I7E49M/17a8NdIK/Qmizz+RLVb68M6
         BZm5IGrafMQkRWZDeXcyEtyPya/Z7DYOdLXQ25snpqDKJ+csASFiSHOQsqNCuckpDaSA
         m+Ag==
X-Gm-Message-State: ACgBeo06tYC8em4T94D501KqFzZYk8PgqXfMaK6BFBYa2+K3QBqnX4dm
        EGxNr7+cdvO//zm5l4VvLy8E3B426u68dGF0RS5Nnp+FzqH3ew==
X-Google-Smtp-Source: AA6agR5nVaQrbQtoSRq42cpyfctzYj4LBO73cbnhl5M+RycIG1O6U/KI9OCCAMM1gR2gUicj2h3WB+dJ24+D5E8MFas=
X-Received: by 2002:a05:6870:3292:b0:10c:d1fa:2e70 with SMTP id
 q18-20020a056870329200b0010cd1fa2e70mr177807oac.281.1660080519626; Tue, 09
 Aug 2022 14:28:39 -0700 (PDT)
MIME-Version: 1.0
From:   Kallol Biswas <nucleodyne@gmail.com>
Date:   Tue, 9 Aug 2022 14:28:29 -0700
Message-ID: <CA+QbAV6YEN1h=T1H3-+1vg+DpSe8Uxzz2wH9u00GXe6L6TB-Uw@mail.gmail.com>
Subject: mm/memory-failure: __get_any_page: unknown zero refcount
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running a memory RAS test on a new platform I encountered the
following on the 5.10.117 kernel.

__get_any_page: 0x77df: unknown zero refcount page type 7fffe000000000

The address 0x77df000 is in a system ram area:
00100000-5c9c0017 : System RAM

The page is not a huge page, not on the free buddy list and not in use.

__get_any_page()
..................
 if (!get_hwpoison_page(p)) {
    if (PageHuge(p)) {
      pr_info("%s: %#lx free huge page\n", __func__, pfn);
      ret = 0;
    } else if (is_free_buddy_page(p)) {
      pr_info("%s: %#lx free buddy page\n", __func__, pfn);
      ret = 0;
    } else if (page_count(p)) {
      /* raced with allocation */
      ret = -EBUSY;
    } else {
      pr_info("%s: %#lx: unknown zero refcount page type %lx\n",
        __func__, pfn, p->flags);


Sparse mem configs are set:
cat /boot/config-5.10.117-2.el7.nutanix.20220304.1002776.x86_64 | grep -i sparse
CONFIG_SPARSE_IRQ=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y

Can someone help understand why we have such a page in the system?
What the purpose is.

Thank you,
Kallol
