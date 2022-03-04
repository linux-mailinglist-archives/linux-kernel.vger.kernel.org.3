Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65A44CD945
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiCDQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiCDQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:42:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DA4E1B7619
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:41:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99903143D;
        Fri,  4 Mar 2022 08:41:16 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073C73F73D;
        Fri,  4 Mar 2022 08:41:14 -0800 (PST)
Date:   Fri, 4 Mar 2022 16:41:12 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com
Subject: Re: [PATCH v5 0/8] Add SCMI Virtio & Clock atomic support
Message-ID: <YiJBFwnhqy2krQJs@e120937-lin>
References: <20220217131234.50328-1-cristian.marussi@arm.com>
 <20220304111032-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304111032-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:13:47AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 17, 2022 at 01:12:26PM +0000, Cristian Marussi wrote:
> > Hi,
> > 
> > This small series is the tail-subset of the previous V8 series about atomic
> > support in SCMI [1], whose 8-patches head-subset has now been queued on
> > [2]; as such, it is based on [2] on top of tag scmi-updates-5.17:
> > 
> > commit 94d0cd1da14a ("firmware: arm_scmi: Add new parameter to
> > 		     mark_txdone")
> > 
> > Patch [1/8] substitute virtio-scmi ready flag and lock with a reference
> > counter to keep track of vio channels lifetime while removing the need of
> > a wide spinlocked section (that would cause issues with introduction of
> > virtio polling support)
> > 
> > Patch [2/8] adds a few helpers to handle the TX free_list and a dedicated
> > spinlock to reduce the reliance on the main one.
> > 
> > Patch [3/8] adds polling mode to SCMI VirtIO transport in order to support
> > atomic operations on such transport.
> > 
> > Patches [4,5/8] introduce a new optional SCMI binding, atomic-threshold-us,
> > to configure a platform specific time threshold used in the following
> > patches to select with a finer grain which SCMI resources should be
> > eligible for atomic operations when requested.
> > 
> > Patch [6/8] exposes new SCMI Clock protocol operations to allow an SCMI
> > user to request atomic mode on clock enable commands.
> > 
> > Patch [7/8] adds support to SCMI Clock protocol for a new clock attributes
> > field which advertises typical enable latency for a specific resource.
> > 
> > Finally patch [8/8] add support for atomic operations to the SCMI clock
> > driver; the underlying logic here is that we register with the Clock
> > framework atomic-capable clock resources if and only if the backing SCMI
> > transport is capable of atomic operations AND the specific clock resource
> > has been advertised by the SCMI platform as having:
> > 
> > 	clock_enable_latency <= atomic-threshold-us
> > 
> > The idea is to avoid costly atomic busy-waiting for resources that have
> > been advertised as 'slow' to operate upon. (i.e. a PLL vs a gating clock)
> > 
> > To ease testing the whole series can be find at [3].
> > 
> > Any feedback/testing welcome as usual.
> > 
> > Thanks,
> > Cristian
> 
> 
> SCMI specific stuff so I don't have anything to add here.
> 
> By the way, it does not look like anything regarding SCMI atomic support
> is needed in the virtio spec - is it true the interface with the device
> is unaffected?
> 

Yes SCMI atomic uses the existing VirtIO SCMI Device specification and the
existing  VirtIO common API for polling.

The only addition on the implementation side is the polling ABA problem
mitigation that I proposed as an addiional mechanism (wrap counters) in
the Virtio core with:

https://lore.kernel.org/linux-arm-kernel/20220208152520.52983-1-cristian.marussi@arm.com/#r

I'll repost soon this latter series about wrap counters on top of the merged
SCMI atomic series so as to make use of this mitigation from SCMI while in
polling mode.

Thanks for the feedback,
Cristian
