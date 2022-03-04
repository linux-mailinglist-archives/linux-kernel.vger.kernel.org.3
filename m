Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93604CD8CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbiCDQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiCDQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C468158788
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646410437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yN23TSpZltgqZyjDlAMTyjfsqXzU9shHSN2L6xQbb+U=;
        b=KVu7EHwC/OulCGteRWDzve5EYdXGc9vm84c7Kim6yIiGEz0uq35QpvkvWNrcKV+3EkxqHs
        Sg0kkG2aBHbeZUkr8NNpQMFEVUhZJZH/05Ebogy2mR5ahfS0goaPDrWjJW2LMlWoXkr7WS
        WeQihnXxbDmPVJveSvo1o8VbjUuCYgg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-2AnBSRU9O_OtVLQzetcadg-1; Fri, 04 Mar 2022 11:13:54 -0500
X-MC-Unique: 2AnBSRU9O_OtVLQzetcadg-1
Received: by mail-ed1-f69.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so4829835edw.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yN23TSpZltgqZyjDlAMTyjfsqXzU9shHSN2L6xQbb+U=;
        b=wnPqlIIAbA/qeoeP9NYU4+aKQZgGMAsaGsvgpzHqD0Nt7ge28AnWVHEtEYoqmKhsFq
         9y44OTlUnPyyNXpiX1/v9z89DQlxS/U+R2MeIY6/I7EB6gyIs4OgF6aWAlQjsiELnYEN
         G7orp1N9DLaLuP5LokvBLPMNvF3HbVt8izkpUd2BYK0oEyXP4Pujr/ByL+lPqp9w989P
         bP7iAb5lbUsrhJ4uev2Q3LKyTkQY8X2Z0NTcng6pLRDm8dxtoAlg+n2aZqixH6v9xshE
         HIzZUDDRj0oOP1yUZLi7H7xnL+XxXtl9/IzReQZsN4N5EtCBqMy4u6iGEOfakub2+HBn
         Wuew==
X-Gm-Message-State: AOAM532ATBsAybZGk53T+XSkc0JrUUhUoYJbqtBFbJvmXzmAbRhTLLtl
        4yZhW3+/jZw2Kqq0njoXLgBZNfWERc9cYYEresT5UUmMBJhB4A/PHbBKUH/GH8qb5E+qBECMI+i
        zzQzdWex1JxKxkOO4MA27Q3ZS
X-Received: by 2002:a17:907:8a04:b0:6b4:e098:741a with SMTP id sc4-20020a1709078a0400b006b4e098741amr31559908ejc.550.1646410433168;
        Fri, 04 Mar 2022 08:13:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywVCdqNAuEyGLyRAIYXc7m5Hm1uJr5dpRKmCREEY2y36QorfEYGEA6Ebi8WzNksObwfDDTyQ==
X-Received: by 2002:a17:907:8a04:b0:6b4:e098:741a with SMTP id sc4-20020a1709078a0400b006b4e098741amr31559874ejc.550.1646410432839;
        Fri, 04 Mar 2022 08:13:52 -0800 (PST)
Received: from redhat.com ([2.52.16.157])
        by smtp.gmail.com with ESMTPSA id c14-20020a170906340e00b006ce98f2581asm1859825ejb.205.2022.03.04.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:13:52 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:13:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com
Subject: Re: [PATCH v5 0/8] Add SCMI Virtio & Clock atomic support
Message-ID: <20220304111032-mutt-send-email-mst@kernel.org>
References: <20220217131234.50328-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217131234.50328-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 01:12:26PM +0000, Cristian Marussi wrote:
> Hi,
> 
> This small series is the tail-subset of the previous V8 series about atomic
> support in SCMI [1], whose 8-patches head-subset has now been queued on
> [2]; as such, it is based on [2] on top of tag scmi-updates-5.17:
> 
> commit 94d0cd1da14a ("firmware: arm_scmi: Add new parameter to
> 		     mark_txdone")
> 
> Patch [1/8] substitute virtio-scmi ready flag and lock with a reference
> counter to keep track of vio channels lifetime while removing the need of
> a wide spinlocked section (that would cause issues with introduction of
> virtio polling support)
> 
> Patch [2/8] adds a few helpers to handle the TX free_list and a dedicated
> spinlock to reduce the reliance on the main one.
> 
> Patch [3/8] adds polling mode to SCMI VirtIO transport in order to support
> atomic operations on such transport.
> 
> Patches [4,5/8] introduce a new optional SCMI binding, atomic-threshold-us,
> to configure a platform specific time threshold used in the following
> patches to select with a finer grain which SCMI resources should be
> eligible for atomic operations when requested.
> 
> Patch [6/8] exposes new SCMI Clock protocol operations to allow an SCMI
> user to request atomic mode on clock enable commands.
> 
> Patch [7/8] adds support to SCMI Clock protocol for a new clock attributes
> field which advertises typical enable latency for a specific resource.
> 
> Finally patch [8/8] add support for atomic operations to the SCMI clock
> driver; the underlying logic here is that we register with the Clock
> framework atomic-capable clock resources if and only if the backing SCMI
> transport is capable of atomic operations AND the specific clock resource
> has been advertised by the SCMI platform as having:
> 
> 	clock_enable_latency <= atomic-threshold-us
> 
> The idea is to avoid costly atomic busy-waiting for resources that have
> been advertised as 'slow' to operate upon. (i.e. a PLL vs a gating clock)
> 
> To ease testing the whole series can be find at [3].
> 
> Any feedback/testing welcome as usual.
> 
> Thanks,
> Cristian


SCMI specific stuff so I don't have anything to add here.

By the way, it does not look like anything regarding SCMI atomic support
is needed in the virtio spec - is it true the interface with the device
is unaffected?

> [1]: https://lore.kernel.org/linux-arm-kernel/20211220195646.44498-1-cristian.marussi@arm.com/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=scmi-updates-5.17
> [3]: https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_atomic_clk_virtio_V5/
> 
> ---
> v4 --> v5
> - dt_bindings: fixed example and removed dtschema warnings/errors
> - dt_bindings: added 'default: 0' clause
> - introduced vio_msg refcounts and helpers to avoid premature reuse of
>   freed messages when both poling and IRQ path are active on a buffer
> - better handling of timed out polled messages on late replies using
>   new VIO_MSG_POLL_TIMEOUT state
> - fixed comments on locks
> - removed unneeded virtqueue re-enable when fail to acquire channel in
>   complete_cb
> 
> V3 --> V4
> - renamed optional DT property to atomic-threshold-us
> 
> V2 --> V3
>  - split out virtio_ring RFC patch into a distinct series
>  - calling virtqueue_broke_device when cleaning up channel
>  - removed RFC tags from CLK related patches
> 
> V1 --> V2
>  - added vio channel refcount support patch
>  - reviewed free_list support and usage
>  - added virtio_ring RFC patch
>  - shrinked spinlocked section within virtio_poll_done to exclude
>    virtqueue_poll call
>  - removed poll_lock
>  - use vio channel refcount acquire/release logic when polling
>  - using new free_list accessors
>  - added new dedicated pending_lock to access pending_cmds_list
>  - fixed a few comments
> 
> Cristian Marussi (8):
>   firmware: arm_scmi: Add a virtio channel refcount
>   firmware: arm_scmi: Review virtio free_list handling
>   firmware: arm_scmi: Add atomic mode support to virtio transport
>   dt-bindings: firmware: arm,scmi: Add atomic-threshold-us optional
>     property
>   firmware: arm_scmi: Support optional system wide atomic-threshold-us
>   firmware: arm_scmi: Add atomic support to clock protocol
>   firmware: arm_scmi: Add support for clock_enable_latency
>   clk: scmi: Support atomic clock enable/disable API
> 
>  .../bindings/firmware/arm,scmi.yaml           |  10 +
>  drivers/clk/clk-scmi.c                        |  71 ++-
>  drivers/firmware/arm_scmi/Kconfig             |  15 +
>  drivers/firmware/arm_scmi/clock.c             |  34 +-
>  drivers/firmware/arm_scmi/driver.c            |  33 +-
>  drivers/firmware/arm_scmi/virtio.c            | 591 +++++++++++++++---
>  include/linux/scmi_protocol.h                 |   9 +-
>  7 files changed, 655 insertions(+), 108 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

