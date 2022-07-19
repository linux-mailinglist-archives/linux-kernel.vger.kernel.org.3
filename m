Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968F57A29A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiGSPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbiGSPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:05:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 953F133E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:05:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC52813D5;
        Tue, 19 Jul 2022 08:05:18 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3948A3F70D;
        Tue, 19 Jul 2022 08:05:16 -0700 (PDT)
Date:   Tue, 19 Jul 2022 16:05:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 09/21] arch_topology: Add support to parse and detect
 cache attributes
Message-ID: <20220719150513.a525arh663qlhkob@bogus>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <20220704101605.1318280-10-sudeep.holla@arm.com>
 <CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com>
 <73f9d00c-b64c-7c70-c49f-99d3894fad24@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f9d00c-b64c-7c70-c49f-99d3894fad24@conchuod.ie>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:37:22PM +0100, Conor Dooley wrote:
> On 19/07/2022 15:22, Geert Uytterhoeven wrote:
> > Hi Sudeep,
> > 
> 
> Hey Geert,
> 
[...]

> > 
> > This is triggered
> > 
> >      Early cacheinfo failed, ret = -12
> > 
> > on all my RV64 platforms (K210, PolarFire, StarLight).
> 
> This should be fixed by Sudeeps most recent patchset, at least
> it was when I tested it!
> https://lore.kernel.org/all/20220713133344.1201247-1-sudeep.holla@arm.com/
>

Conor you beat me in the response speed :).

> > -12 = -ENOMEM.
> > 
> > The boot continues regardless, and the K210 even has enough spare
> > RAM after boot to run "ls", unlike two weeks ago ;-)
> >

Yes Conor initially reported this and I suspected something to do with
per-cpu allocation as the early cacheinfo failed but succeeded in device
initcall level. However when fixing some hotplug issue, I moved the
detection of cache attributes on all cpus from boot cpu to individual
CPUs in the secondary startup which seem to fix the issue as I assume the
per-cpu allocation is ready to use at that stage.

However we still have one pending issue[0] to address even after [1], but
that doesn't affect DT platforms.

-- 
Regards,
Sudeep

[0] https://lore.kernel.org/all/20220718174151.GA462603@roeck-us.net/
[1] https://lore.kernel.org/all/20220715102609.2160689-1-sudeep.holla@arm.com/
