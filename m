Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E8495A39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348997AbiAUG7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiAUG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:59:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51499C061574;
        Thu, 20 Jan 2022 22:59:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09A16B81F4F;
        Fri, 21 Jan 2022 06:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0C6C36AE3;
        Fri, 21 Jan 2022 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642748382;
        bh=4ShAu9TMO9pCCFhxDCpJN37xIb8io+l6Oyhyz+wkc74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rkWc8GrmU4jDh8MIgKhU1tVmZnCPK978zpVeaoKL9BABXmrLvJhp7qT1axvVYenFf
         EXl+ILKxghGdYexiqzYSqUGqzgOJdRw9gxLBkPt1lugs/J2H5kUsa8aA2+geA99vJC
         kLBagAY8ht9vk/XtIQSnuK2KgVnBG1tZNY3D+9ZpekZpAe6KG4Y1gKHuohLVN8Frmz
         tT2NlAfoov0vkk9BzpknOsIfrUfWc/Co/Jj4RBd96p/9JkewBRZ2gjADB/m/KTeuzB
         RegN4xP87sZHPeAD0ROhV9YXpgX9yXjHzCBlxEjIP0LlJnVH/PD2rGtIyqpYIfLIwl
         Ft604c34avssg==
Received: by mail-vk1-f180.google.com with SMTP id 48so1865315vki.0;
        Thu, 20 Jan 2022 22:59:42 -0800 (PST)
X-Gm-Message-State: AOAM5315llELNQu4h1g/U6Q4fRld37XjlC1fehpgLa18vIjiUPleHx0M
        D4yU8yOl4Dm+pjGRLE8rCwedNF6TvqB6dYLEe2E=
X-Google-Smtp-Source: ABdhPJzfHGuI3QjQ1xrUHESSAg6lyHrYGXHJnEkduCUf4mRHX9u1+bm5wEa4HeHgEF2DEq8OtNRB3r3xOJW73X//3VQ=
X-Received: by 2002:ac5:cbc8:: with SMTP id h8mr1146902vkn.8.1642748381690;
 Thu, 20 Jan 2022 22:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-7-guoren@kernel.org> <CAK8P3a00uYPBBphpipBoqCnGFwr_C9vDzS1p1iLN==YTVOARug@mail.gmail.com>
In-Reply-To: <CAK8P3a00uYPBBphpipBoqCnGFwr_C9vDzS1p1iLN==YTVOARug@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jan 2022 14:59:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQVgDkyVdoezsrA4AN=9C7RMOxZBCyLB2JvQkKYsLud3Q@mail.gmail.com>
Message-ID: <CAJF2gTQVgDkyVdoezsrA4AN=9C7RMOxZBCyLB2JvQkKYsLud3Q@mail.gmail.com>
Subject: Re: [PATCH V3 06/17] riscv: compat: Add basic compat date type implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 5:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 20, 2022 at 8:38 AM <guoren@kernel.org> wrote:
>
> > @@ -0,0 +1,136 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __ASM_COMPAT_H
> > +#define __ASM_COMPAT_H
> > +
> > +#define compat_mode_t  compat_mode_t
> > +typedef u16            compat_mode_t;
>
> I think this one is wrong, as rv32 should get the native definition from
>
> include/uapi/asm-generic/posix_types.h:typedef unsigned int     __kernel_mode_t;
>
> I think it works if you just remove those two lines. The rest looks good to me.
Yes, you are right. compat_mode_t should be unsigned int.

>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
