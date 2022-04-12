Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFC4FDC49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347760AbiDLKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356814AbiDLJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B4ED11C08
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:58:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DAED1570;
        Tue, 12 Apr 2022 01:58:43 -0700 (PDT)
Received: from bogus (unknown [10.57.41.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF7A3F5A1;
        Tue, 12 Apr 2022 01:58:42 -0700 (PDT)
Date:   Tue, 12 Apr 2022 09:58:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Qing Wang <wangqing@vivo.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch_topology: Do not set llc_sibling if llc_id is
 invalid
Message-ID: <20220412085839.hkpyookqdl6bcjbn@bogus>
References: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
 <CAHp75Vc-frdJSAMxK1YpHwmPa_-0fTpRxq=QObcux3Jt=5+9kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc-frdJSAMxK1YpHwmPa_-0fTpRxq=QObcux3Jt=5+9kw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 06:07:45PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 11, 2022 at 12:10 PM Qing Wang <wangqing@vivo.com> wrote:
> >
> > From: Wang Qing <wangqing@vivo.com>
> >
> > When ACPI is not enabled, cpuid_topo->llc_id = cpu_topo->llc_id = -1, which
> > will set llc_sibling 0xff(...), this is misleading.
> 
> Shouldn't it be a Fixes tag then?
>

I thought about that. One the file has moved and lot of refactoring before the
move after the code was first introduced. Since no one has seen any issues as
the mask matches all the CPUs on a single chip SoC and this is not user visible,
I didn't push for the fixes tag.

Anyways the original commit introducing the feature is
Commit 37c3ec2d810f ("arm64: topology: divorce MC scheduling domain from core_siblings")
which was merged in v4.18 if I read git log correctly.

I am happy to backport if needed.

> > Don't set llc_sibling(default 0) if we don't know the cache topology.
> 
> ...
> 
> > -               if (cpuid_topo->llc_id == cpu_topo->llc_id) {
> > +               if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
> 
> I'm wondering if more strict check is better here, i.e.
> 
>                if (cpu_topo->llc_id >= 0 && cpuid_topo->llc_id ==
> cpu_topo->llc_id) {
>

Yes I would agree. But I think Qing is just following other similar checks in
the file. All such ids are initialised to -1 and are assigned only valid
values >= 0. I am OK to keep it as is to keep it aligned with other similar
checks.

-- 
Regards,
Sudeep
