Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45DF4B6712
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiBOJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:11:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiBOJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:11:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18A9F13DD4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:11:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A78C11063;
        Tue, 15 Feb 2022 01:11:05 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4E33F66F;
        Tue, 15 Feb 2022 01:11:03 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:11:01 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mst@redhat.com
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 3/8] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20220215091046.GF2535@e120937-lin>
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-4-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213195832.27932-4-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 07:58:27PM +0000, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 
> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - shrinked spinlocked section within virtio_poll_done to exclude
>   virtqueue_poll
> - removed poll_lock
> - use vio channel refcount acquire/release logic when polling
> - using new free_list accessors
> - added new dedicated pending_lock to access pending_cmds_list
> - fixed a few comments
> 
> v0 --> v1
> - check for deferred_wq existence before queueing work to avoid
>   race at driver removal time
> - changed mark_txdone decision-logic about message release
> - fixed race while checking for msg polled from another thread
> - using dedicated poll_status instead of poll_idx upper bits
> - pick initial poll_idx earlier inside send_message to avoid missing
>   early replies
> - removed F_NOTIFY mention in comment
> - clearing xfer->priv on the IRQ tx path once message has been fetched
> - added some store barriers
> - updated some comments
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/driver.c |   9 +-
>  drivers/firmware/arm_scmi/virtio.c | 277 ++++++++++++++++++++++++++++-
>  3 files changed, 291 insertions(+), 10 deletions(-)
> 

Hi Michael,

how do you feel about the current status of this patch and the previous
two in this series about SCMI virtio polling support after the last
fixes ?

Could we start thinking about merging this series on the SCMI side, leaving
aside for the next iteration the polling ABA-problem mitigation I proposed
in the virtio core (wrap counters and new API to enable them) that is now
in a distinct series ? (and probably needs more tests/perfs/feedback...)

Thank you,
Cristian
