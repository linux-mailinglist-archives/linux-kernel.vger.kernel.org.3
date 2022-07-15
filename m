Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBC575E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiGOJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiGOJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:11:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6BBD25599
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:11:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E052F1474;
        Fri, 15 Jul 2022 02:11:27 -0700 (PDT)
Received: from bogus (unknown [10.57.11.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D77E3F792;
        Fri, 15 Jul 2022 02:11:25 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:11:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Message-ID: <20220715091121.mvwsopbh52c3zztc@bogus>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
 <20220714150100.aqvmdgjkymc2dr5t@bogus>
 <f9b13298-5a0b-34ee-44b9-90168205cc59@microchip.com>
 <20220714160016.honjpzg35ccq4fto@bogus>
 <50b3316b-aed0-2ef1-a7ff-69aa3991d7e4@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b3316b-aed0-2ef1-a7ff-69aa3991d7e4@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 04:10:36PM +0000, Conor.Dooley@microchip.com wrote:
> On 14/07/2022 17:00, Sudeep Holla wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Jul 14, 2022 at 03:27:09PM +0000, Conor.Dooley@microchip.com wrote:
> >> On 14/07/2022 16:01, Sudeep Holla wrote:
> >>>
> >>> Interesting, need to check if it is not in atomic context on arm64.
> >>> Wonder if some configs are disabled and making this bug hidden. Let me
> >>> check.
> >>>
> > 
> > OK, it turns I didn't have necessary config options enabled. Enabling
> > them, I did see the BUG splat and changing allocation to GFP_ATOMIC
> > fixed the same. Can you try that please so that you can test if other
> > things are fine.
> > 
> >>> One possible solution is to add GFP_ATOMIC to the allocation but I want
> >>> to make sure if it is legal to be in atomic context when calling
> >>> update_siblings_masks.
> >>>
> > 
> > So I take is as legal and needs to be fixed to push my patch.
> > 
> 
> With the GFP_ATOMIC, behaviour is the same as before for me.
>

So you still get -ENOMEM failure on your platform. It is fine, just that
I am bit curious to know why as it succeeds at device_initcall later.
I was hoping this might fix your memory allocation failure.

> Therefore, with the following diff & for RISC-V/DT:
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>

Thanks !

-- 
Regards,
Sudeep
