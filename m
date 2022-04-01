Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45284EEB0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiDAKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbiDAKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:13:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B75926E01C;
        Fri,  1 Apr 2022 03:11:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC4F12FC;
        Fri,  1 Apr 2022 03:11:51 -0700 (PDT)
Received: from bogus (unknown [10.57.43.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 264DE3F66F;
        Fri,  1 Apr 2022 03:11:49 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:11:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Message-ID: <20220401101147.xtweqtftmtwa3txk@bogus>
References: <20220331190443.851661-1-keescook@chromium.org>
 <YkbFvYRkcXgo3mpK@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkbFvYRkcXgo3mpK@e110455-lin.cambridge.arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 10:28:29AM +0100, Liviu Dudau wrote:
> On Thu, Mar 31, 2022 at 12:04:43PM -0700, Kees Cook wrote:
> > When building multi_v7_defconfig+CONFIG_SMP=n, -Warray-bounds exposes
> > a couple negative array index accesses:
> > 
> > arch/arm/mach-vexpress/spc.c: In function 've_spc_clk_init':
> > arch/arm/mach-vexpress/spc.c:583:21: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
> >   583 |   if (init_opp_table[cluster])
> >       |       ~~~~~~~~~~~~~~^~~~~~~~~
> > arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
> >   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
> >       |       ^~~~~~~~~~~~~~
> > arch/arm/mach-vexpress/spc.c:592:18: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
> >   592 |    init_opp_table[cluster] = true;
> >       |    ~~~~~~~~~~~~~~^~~~~~~~~
> > arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
> >   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
> >       |       ^~~~~~~~~~~~~~
> > 
> > Skip this logic when built !SMP.
> > 
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Sudeep, can you please take this through your tree for sending it to arm-soc?
>

Sure, I will do that as soon as -rc1 is out.

-- 
Regards,
Sudeep
