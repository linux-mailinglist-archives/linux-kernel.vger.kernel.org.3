Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D048250E172
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbiDYNXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiDYNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:22:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FE19C1F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:19:31 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kn5Bl72TYz682wj;
        Mon, 25 Apr 2022 21:16:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:19:28 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 14:19:27 +0100
Date:   Mon, 25 Apr 2022 14:19:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Qing Wang <wangqing@vivo.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2 0/2] Add complex scheduler level for arm64
Message-ID: <20220425141926.00004d2e@Huawei.com>
In-Reply-To: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 04:51:24 -0700
Qing Wang <wangqing@vivo.com> wrote:

> From: Wang Qing <wangqing@vivo.com>
> 
> The DSU cluster supports blocks that are called complexes
> which contain up to two cores of the same type and some shared logic,
> which sharing some logic between the cores can make a complex area efficient.
>

Given the complex shares things like the SVE units (cortex a510)...

Why not handle this as SMT?

Seems like a blurred boundary between separate cores and SMT threads.
I think we need to express and potentially take advantage of knowledge
about what logic is being shared.

Jonathan

 
> Complex also can be considered as a shared cache group smaller
> than cluster.
> 
> This patch adds complex level for complexs by parsing cache topology
> form DT. It will directly benefit a lot of workload which loves more
> resources such as memory bandwidth, caches.
> 
> Note this patch only handle the DT case.
> 
> V2:
> fix commit log and loop more
> 
> wangqing (2):
>   arch_topology: support for describing cache topology from DT
>   arm64: Add complex scheduler level for arm64
> 
>  arch/arm64/Kconfig            | 13 ++++++++++
>  arch/arm64/kernel/smp.c       | 48 ++++++++++++++++++++++++++++++++++-
>  drivers/base/arch_topology.c  | 47 +++++++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h |  3 +++
>  4 files changed, 109 insertions(+), 2 deletions(-)
> 

