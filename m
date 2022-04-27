Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F573511316
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359206AbiD0IBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiD0IBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5156F517D2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E110A61BBD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6642C385A7;
        Wed, 27 Apr 2022 07:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651046299;
        bh=mE6x4iTlX7XDpvguF39C/1/ZadyoBD4PGaWQhRwJ2XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUVjlRuT+7C7W2EzixGj/qPE71wC76XqDAimbEcmld5o7PIfZOW3oOLJ8vJiZyi+A
         bh+H+d2Se3rxAarHz7SnPeQYMZS8mq0fqDdSiOcg8l1BZKAxl6T94UsTXkLVWJyxLE
         QXYHIkXa678jDQwMH1lXis1t6DnDEzVqJTIjMsvs=
Date:   Wed, 27 Apr 2022 09:58:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH v3] arch_topology: Trace the update thermal pressure
Message-ID: <Ymj3l6cdxfmQ+hb0@kroah.com>
References: <20220427073551.19032-1-lukasz.luba@arm.com>
 <Ymj0ZZeUnhq4W/Ws@kroah.com>
 <38c8a684-5fcc-cfb3-424c-d353a7bafe03@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c8a684-5fcc-cfb3-424c-d353a7bafe03@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:52:50AM +0100, Lukasz Luba wrote:
> 
> 
> On 4/27/22 08:44, Greg KH wrote:
> > On Wed, Apr 27, 2022 at 08:35:51AM +0100, Lukasz Luba wrote:
> > > Add trace event to capture the moment of the call for updating the thermal
> > > pressure value. It's helpful to investigate how often those events occur
> > > in a system dealing with throttling. This trace event is needed since the
> > > old 'cdev_update' might not be used by some drivers.
> > > 
> > > The old 'cdev_update' trace event only provides a cooling state
> > > value: [0, n]. That state value then needs additional tools to translate
> > > it: state -> freq -> capacity -> thermal pressure. This new trace event
> > > just stores proper thermal pressure value in the trace buffer, no need
> > > for additional logic. This is helpful for cooperation when someone can
> > > simply sends to the list the trace buffer output from the platform (no
> > > need from additional information from other subsystems).
> > > 
> > > There are also platforms which due to some design reasons don't use
> > > cooling devices and thus don't trigger old 'cdev_update' trace event.
> > > They are also important and measuring latency for the thermal signal
> > > raising/decaying characteristics is in scope. This new trace event
> > > would cover them as well.
> > > 
> > > We already have a trace point 'pelt_thermal_tp' which after a change to
> > > trace event can be paired with this new 'thermal_pressure_update' and
> > > derive more insight what is going on in the system under thermal pressure
> > > (and why).
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > The kernel test robot did not report that you needed to add a new trace
> > event :(
> > 
> 
> I got feedback from the test robot for v1, which figured out that
> the riscv configuration is broken. You can find it here
> https://lore.kernel.org/lkml/202204201654.vcszVDGb-lkp@intel.com/
> 
> So, I've added that tag following:
> "If you fix the issue, kindly add following tag as appropriate"
> 
> Should this only be honored when a patch actually got into next
> and then following patch with a fix would have that tag?

Yes.  And you can mention it in the version information about what
changed between each patch version below the --- line, but as is, you
can see how this does not make sense.

thanks,

greg k-h
