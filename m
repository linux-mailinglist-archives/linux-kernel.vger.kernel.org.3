Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1208575258
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiGNQAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGNQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:00:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D85F6431
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:00:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C42941D13;
        Thu, 14 Jul 2022 09:00:20 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 246513F70D;
        Thu, 14 Jul 2022 09:00:19 -0700 (PDT)
Date:   Thu, 14 Jul 2022 17:00:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Message-ID: <20220714160016.honjpzg35ccq4fto@bogus>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
 <20220714150100.aqvmdgjkymc2dr5t@bogus>
 <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 03:27:09PM +0000, Conor.Dooley@microchip.com wrote:
> On 14/07/2022 16:01, Sudeep Holla wrote:
> > 
> > Interesting, need to check if it is not in atomic context on arm64.
> > Wonder if some configs are disabled and making this bug hidden. Let me
> > check.
> >

OK, it turns I didn't have necessary config options enabled. Enabling
them, I did see the BUG splat and changing allocation to GFP_ATOMIC
fixed the same. Can you try that please so that you can test if other
things are fine.

> > One possible solution is to add GFP_ATOMIC to the allocation but I want
> > to make sure if it is legal to be in atomic context when calling
> > update_siblings_masks.
> >

So I take is as legal and needs to be fixed to push my patch.

> >>>
> >>> Anyways give this a try, also test the CPU hotplug and check if nothing
> >>> is broken on RISC-V. We noticed this bug only on one platform while
> >>
> >> So, our system monitor that runs openSBI does not actually support
> >> any hotplug features yet, so:
> > 
> > OK, we can ignore hotplug on RISC-V for now then. We have tested on multiple
> > arm64 platforms(DT as well as ACPI).
> > 
> 
> Well, other vendors implementations of firmware-come-bootloaders-
> running-openSBI may support it, but (currently) ours does not.
> But, if no-one else is speaking up about this, my arch-topo changes
> or your original patchset...

OK

-- 
Regards,
Sudeep
