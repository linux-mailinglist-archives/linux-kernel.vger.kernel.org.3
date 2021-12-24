Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AF47EC46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbhLXGwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351547AbhLXGwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:52:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23CEC061401;
        Thu, 23 Dec 2021 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eO89Wys+cPjA0jK7XMPHuQKXJ2fNBHQ+5ydS0TjbuwU=; b=PBsxweIBvGcDuaDIdeRI0lPpPw
        6hsHcafd6eAhL/qGcOQg3rtzheHjmoclD7Y9TiIPMyVshTSaAgxgC2s1D6Gdqzo43pYHr2xieAP45
        XOK1/ezcUc23+BfQP1OvGhUKlznI2bfXiar0BCT0GoDa2n1zw+qIHdvRMPLixru25pCdT1GUBYV5p
        pZ6WgUcfvPloSttmffNkio6AuKktSb54lsybW5LcaAQMWQh+TBXA2oOpOjawq33bj23XSbGBcdREg
        vrpQo49qie/eQeSIE2v2vcWovgTRKZcfjPPq4oDQUfvJllgj5oC1vsv8sxaaYoxR/9n97YcD0WT9U
        x64Wsjtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0eR7-00DoaW-T6; Fri, 24 Dec 2021 06:52:17 +0000
Date:   Thu, 23 Dec 2021 22:52:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        Drew Fustini <drew@beagleboard.org>, wangjunqiang@iscas.ac.cn,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 01/13] syscalls: compat: Fix the missing part for
 __SYSCALL_COMPAT
Message-ID: <YcVuIdv65utyCK18@infradead.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
 <20211221163532.2636028-2-guoren@kernel.org>
 <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:08:45PM +0100, Arnd Bergmann wrote:
> > -__SYSCALL(__NR_ptrace, sys_ptrace)
> > +__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
> >
> 
> Right. We could merge sys_ptrace and compat_sys_ptrace() by adding
> a in_compat_syscall() check, but either way works.

I think merging them would be very useful, including merging
compat_arch_ptrace into arch_ptrace.  But we can leave that for
later.
