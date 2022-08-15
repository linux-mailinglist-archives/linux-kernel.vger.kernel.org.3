Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F96592F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbiHOM4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiHOM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:56:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141D11C17
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A78FB80C82
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F511C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568189;
        bh=lvlMiVVah5yr20jbz3OzreKxmt2ds0C8MTIf3Hi13fU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MXacT48YCDUQkicSWhYVXZK42tG6S2xjTAPQxfiQ3lKe/JmVI1+i1OA+sEcFKp1U/
         trSWHpab/wzMizk2bKi6/f8TNbhKC3pE3a2hBtFuI2wEKXlgRrKZggHtnIIhAvVtGv
         ROuqF6zlf2uBPsdR/obGImgUKPiwkI1LVQdb+Q7ye5B/xxOGqaKDbPXoFcHQIvFjWk
         Sryef1GuZ/9gUKUANG+GgVnfeXBtzDL45lfghL4rBNJMNltjxxVQ6GrqVKy0uVyOQ7
         VyCpNbFXmVKMix8Jpg9qnksF3sjJgRXzY1mlcCoimfHgwnnywOB6hH/eogElg/A/Pc
         nmnI/ncFdy1Mg==
Received: by mail-ej1-f51.google.com with SMTP id y13so13326839ejp.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:56:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo0rvPfcVhCF/fJgQg46N2ubTZxEhFD+o3zAy8orfF9a57aMqq6K
        Rx+ddtHO099ja8cuKRD5DBUM0dGZrH9BOglKp7I=
X-Google-Smtp-Source: AA6agR79iSNr68RVWfkwvmQtkchdCVXRx6tdwlnUBYsBLMujOZY+I5O3UYZllXj4Q5MJmMiAUVtM7lE1fvhZ34atV0U=
X-Received: by 2002:a17:906:9b08:b0:730:5d3c:4b1b with SMTP id
 eo8-20020a1709069b0800b007305d3c4b1bmr10215312ejc.606.1660568187406; Mon, 15
 Aug 2022 05:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <202208140835.W6F1j6Da-lkp@intel.com> <Yvo8KUKJBlMtoNgI@casper.infradead.org>
In-Reply-To: <Yvo8KUKJBlMtoNgI@casper.infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Aug 2022 14:56:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com>
Message-ID: <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com>
Subject: Re: fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds
 limit (1024) in 'ntfs_read_folio'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 2:29 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Aug 14, 2022 at 08:21:36AM +0800, kernel test robot wrote:
> > Hi Matthew,
> >
> > FYI, the error/warning still remains.
>
> FYI, this is still not interesting.
> This is a hexagon 256kB PAGE_SIZE config, and so the amount of stack
> space is correspondingly larger.  The frame size warning should be
> increased to allow for this.
>
> > >> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]

I don't think we should change the frame size warning for this, there is not
generally any correlation between page size and stack usage, so that would
just hide bugs elsewhere.

NTFS has had problems with stack usage on 64K+ pages before, the last
time we addressed this using 4eec7faf6775 ("fs: ntfs: Limit NTFS_RW to
page sizes smaller than 64k"), but it looks like this time it affects both
write and read support.

I checked hexagon ntfs with 64KB pages, and that stays below the 1024 byte
limit, so we could add another dependency

--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NTFS_FS
        tristate "NTFS file system support"
+      depends on PAGE_SIZE_LESS_THAN_256KB
        select NLS
        help
          NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.

to rule out the broken case but still allow powerpc64 and arm64 with
64KB to use NTFS.

      Arnd
