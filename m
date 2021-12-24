Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB147EDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352248AbhLXJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:28:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41560 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352232AbhLXJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:28:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77867B81A58;
        Fri, 24 Dec 2021 09:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2BFC36AEE;
        Fri, 24 Dec 2021 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640338113;
        bh=PLFbhEnthe2tnia9t8u1jYkAlCDJSzqn6fyBcMDKv1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uKNEKY8/qLIxOIc3KS1/XZqJFJHYDGPb+1dwhzC/WlxSPz+hVEzHiJXip08NifPH1
         DGRFjrG/UuYim/Mxw9pF+qsY1TUkZrBU8WZERUoReUAUNUDYWQTAGXmVmNAfnqncl3
         txAYYvPvhzhz/Yucu+RAyqr1IQq0eF6hmHKmk+gse9szo7yvKzaJgSfxqlSEAo6Ijk
         axzK0OdGQHJOHzqOw/QyCRDYjWz2AM8XVu/7JfUPgrpIIX6gv2rysWj45SaQ86olLB
         +JHhZPwLgUDDRYrxFRAY2G6s9FEMQ8S4acNM0llT2g9xFsN2tSTo8epGbvTDamA7l2
         Il829e4Y0gajA==
Received: by mail-vk1-f179.google.com with SMTP id x17so3815064vkx.3;
        Fri, 24 Dec 2021 01:28:33 -0800 (PST)
X-Gm-Message-State: AOAM532eFJ2kC3M3xNMRBzpAxFXph/U4dS6CVnfPuLx7uDCQeRjdG7x/
        yIEWV1YPf3TOzc/HV4nddrMJF3O7l4Zc6SHlDQc=
X-Google-Smtp-Source: ABdhPJwW7NSOoagEdqoBmUtuhDfgJjtWgSXSdapmfy6cK8l0WMX3tLWmnQIXstx9eCAaF/D3NeIIDS+4RysDGs/44Ns=
X-Received: by 2002:a1f:a4c5:: with SMTP id n188mr1850928vke.35.1640338112154;
 Fri, 24 Dec 2021 01:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-4-guoren@kernel.org>
 <YcVuYEt2LQArK5iL@infradead.org>
In-Reply-To: <YcVuYEt2LQArK5iL@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Dec 2021 17:28:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR=RQ_zhkUYXHyCkG26m6HasdwrsaXsUU-k8snO2rhh-Q@mail.gmail.com>
Message-ID: <CAJF2gTR=RQ_zhkUYXHyCkG26m6HasdwrsaXsUU-k8snO2rhh-Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] riscv: compat: Add basic compat date type implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 2:53 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Dec 22, 2021 at 12:35:22AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement asm/compat.h for struct compat_xxx, RLIM_INFINITY,
> > OFF_T_MAX, is_compat_task, compat_user_regset, regset convert.
>
> Much of this really has no busines being duplicated over all the
> architectures.  I have an old series to consolidate a fair amount
> of compat.h cruft, I'll see if I can resurrect that.
Sounds good. I hope you could do that after my patchset merges. Thx.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
