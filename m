Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34D257648F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGOPl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiGOPl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:41:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E037251A03
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:41:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086DD12FC;
        Fri, 15 Jul 2022 08:41:26 -0700 (PDT)
Received: from bogus (unknown [10.57.11.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8F403F70D;
        Fri, 15 Jul 2022 08:41:23 -0700 (PDT)
Date:   Fri, 15 Jul 2022 16:41:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Message-ID: <20220715154120.wsviffws2bsgvtio@bogus>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
 <20220714150100.aqvmdgjkymc2dr5t@bogus>
 <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
 <20220714160016.honjpzg35ccq4fto@bogus>
 <50b3316b-aed0-2ef1-a7ff-69aa3991d7e4@microchip.com>
 <20220715091121.mvwsopbh52c3zztc@bogus>
 <8146f6e0-0682-4876-95d0-01e99141330d@microchip.com>
 <343b8031-f2d7-0d53-6967-d2e5925703cf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343b8031-f2d7-0d53-6967-d2e5925703cf@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 02:04:41PM +0000, Conor.Dooley@microchip.com wrote:
> On 15/07/2022 10:16, Conor Dooley wrote:
> > On 15/07/2022 10:11, Sudeep Holla wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On Thu, Jul 14, 2022 at 04:10:36PM +0000, Conor.Dooley@microchip.com wrote:
> >>> With the GFP_ATOMIC, behaviour is the same as before for me.
> >>>
> >>
> >> So you still get -ENOMEM failure on your platform. It is fine, just that
> >> I am bit curious to know why as it succeeds at device_initcall later.
> >> I was hoping this might fix your memory allocation failure.
> > 
> > Correct. 
> 
> I take that back. On today's next with patch 2 applied, I don't see a
> problem with no memory, so this does appear to have sorted the memory
> allocation failure. Sorry for misleading you & thanks!
>

No worries. Glad to hear this fixed the memory allocation issue you had
on your platform, I was hopeful based on some analysis I did. I must have
done this from first, I think I had seen the bug in my initial testing and
moved the call to detect_cache_attributes() into init_cpu_topology() instead
which fixed it but broke hotplug which I didn't notice on few platforms
I tested until Ionela tested it on a particular platform.

> With my patches for store_cpu_topology on RISC-V I do see it though,
> when called on the boot cpu. I must have mixed up which I had tested.
> I have a fix for that though & will update my patches later.
> 

Sure.

-- 
Regards,
Sudeep
