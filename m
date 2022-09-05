Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA65AD812
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiIERHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiIERHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:07:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187665E652
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:07:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C39139F;
        Mon,  5 Sep 2022 10:07:55 -0700 (PDT)
Received: from bogus (unknown [10.57.45.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD8B93F534;
        Mon,  5 Sep 2022 10:07:47 -0700 (PDT)
Date:   Mon, 5 Sep 2022 18:07:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     vincent.guittot@linaro.org, ionela.voinescu@arm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, 21cnbao@gmail.com, jonathan.cameron@huawei.com,
        linuxarm@huawei.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v3] arch_topology: Make cluster topology span at least
 SMT CPUs
Message-ID: <20220905170723.ppikgcjtjwe2nj63@bogus>
References: <20220905122615.12946-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905122615.12946-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 08:26:15PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently cpu_clustergroup_mask() will return CPU mask if cluster span more
> or the same CPUs as cpu_coregroup_mask(). This will result topology borken
> on non-Cluster SMT machines when building with CONFIG_SCHED_CLUSTER=y.
> 
> Test with:
> qemu-system-aarch64 -enable-kvm -machine virt \
>  -net none \
>  -cpu host \
>  -bios ./QEMU_EFI.fd \
>  -m 2G \
>  -smp 48,sockets=2,cores=12,threads=2 \
>  -kernel $Image \
>  -initrd $Rootfs \
>  -nographic
>  -append "rdinit=init console=ttyAMA0 sched_verbose loglevel=8"
> 
> We'll get below error:
> [    3.084568] BUG: arch topology borken
> [    3.084570]      the SMT domain not a subset of the CLS domain
> 
> Since cluster is a level higher than SMT, fix this by making cluster
> spans at least SMT CPUs.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Sorry for missing to figure this out earlier and thanks for fixing it.
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
