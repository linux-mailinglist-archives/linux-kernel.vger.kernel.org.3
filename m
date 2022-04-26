Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1113150F37B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbiDZIQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbiDZIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:16:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20586D399
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C5E5B81C1E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDCC385A0;
        Tue, 26 Apr 2022 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650960778;
        bh=VWSXOFIbYMS1rdFymZLDrmNnn4C2EWrzN4zpz00Atko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8u+4ilMjjWoLlTaAvkTvffDK6Gxg9nNah1ciL0LCGPkiJ/LSKmfc019TaJTcu2YV
         f8PqP8gME3aDnrY6M570JKU1Bihz15IA+gqymPtYsgnhs8Gve6i8XtS62D/wg9CVRj
         2bcqMzQtEVnhqlc4sPGab8lmCI9kt+908OfbnSIw=
Date:   Tue, 26 Apr 2022 10:12:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH v2] arch_topology: Trace the update thermal pressure
Message-ID: <Ymeph6GLO3TgSNpY@kroah.com>
References: <20220425135317.5880-1-lukasz.luba@arm.com>
 <YmasYv5xHH7EbXXn@kroah.com>
 <61483e12-c2a2-059a-c157-aea23b8a2f4e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61483e12-c2a2-059a-c157-aea23b8a2f4e@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:26:40AM +0100, Lukasz Luba wrote:
> 
> 
> On 4/25/22 15:12, Greg KH wrote:
> > On Mon, Apr 25, 2022 at 02:53:17PM +0100, Lukasz Luba wrote:
> > > Add trace event to capture the moment of the call for updating the thermal
> > > pressure value. It's helpful to investigate how often those events occurs
> > > in a system dealing with throttling. This trace event is needed since the
> > > old 'cdev_update' might not be used by some drivers. Also, the new trace
> > > event shows capacity value, not a cooling state.
> > 
> > Wait, why are thermal events not going through the thermal system so
> > that thermal_cdev_update() would catch them?  Don't work around broken
> > systems, force them to use the correct apis.
> 
> In some platforms the thermal is controlled in FW. In Arm we have
> recently implemented a logic of our Intelligent Power Allocation
> (kernel governor gov_power_allocator.c) (and a bit more) in our
> reference FW [1]. So kernel would not controlling thermal.
> There is another platform which does similar [2]. As you can see
> in that driver, there is no cooling device created, it just handles
> the notification about reduced frequency as an IRQ. Then it
> populates this information to the task scheduler using thermal
> pressure mechanism. Thanks to that the scheduler can avoid mistakes
> in the tasks placement and not put more that that CPU real capacity.
> 
> For Arm FW thermal, I can make it, since we don't have it yet.
> We are in the middle of internal design of this FW/kernel glue and I
> haven't sent the kernel patches yet. I will follow your recommendation.
> 
> For the driver [2] I have no device, so I cannot change it and prove the
> new works safely.
> 
> But we need this trace event to discuss the design for RT task scheduler
> and impact of thermal pressure decaying delays. We have Android systems
> which suffer the RT issues known for years (like audio apps) and we
> started to tackle them. That was the motivation for this new trace
> event - a helper which everyone can 'just use' in their current code
> state and provide measurements.
> 
> We can ask maintainers of that driver [2] to follow your guidance and
> fix that cpufreq driver. That might require a split of the logic in
> there and a new thermal driver which would handle the part of thermal
> updates. If that is feasible, since I have heard that some platforms
> can cause a huge noise 'KHz' of those interrupt...
> If that is true, I might see the reason why someone goes lightweight way
> update-thermal-pressure-only and not via thermal cooling complexity.
> 
> IMO this trace event doesn't harm the design and brings also benefit
> comparing to the 'cdev_update' trace event which only provides a state
> value: [0, n]. That state value then needs additional tools to translate
> it: state -> freq -> capacity -> thermal pressure. As you can see
> this new event just stores proper value in the trace buffer, no need
> to hassle, just 'cat' the trace file. If anyone would like to help
> us and share it's trace output, we would have everything we need.

Ok, can you put this type of explaination in the changelog to make it
more obvious for us all going forward?

thanks,

greg k-h
