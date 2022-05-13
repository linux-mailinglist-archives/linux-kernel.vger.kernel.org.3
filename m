Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0564B525DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378723AbiEMI4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378300AbiEMI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:56:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F9965DA7E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:56:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35DFC113E;
        Fri, 13 May 2022 01:56:32 -0700 (PDT)
Received: from bogus (unknown [10.57.65.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4993F73D;
        Fri, 13 May 2022 01:56:30 -0700 (PDT)
Date:   Fri, 13 May 2022 09:56:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arch_topology: support parsing cluster_id from DT
Message-ID: <20220513085624.wnawifzi3nqhbuh3@bogus>
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
 <Yn0XE3szFk9f2VyL@bogus>
 <4b124aa9-ed26-a40b-8e74-81043d051247@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b124aa9-ed26-a40b-8e74-81043d051247@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:36:26AM +0200, Dietmar Eggemann wrote:
> On 12/05/2022 16:17, Sudeep Holla wrote:
> > On Wed, May 11, 2022 at 02:52:56AM -0700, Qing Wang wrote:
> >> From: Wang Qing <wangqing@vivo.com>
> >>
> >> Use nested cluster structures in DT to support describing multi-level
> >> cluster topologies and increase the parsing of nested cluster.
> >>
> >> Notice: the clusters describing in DT currently are not physical
> >> boundaries, since changing "cluster" to "socket" is too involved and error
> >> prone, this patch will not have any effect on one-level cluster topo, but
> >> can support the mutil-level cluster topo to support CLUSTER_SCHED.
> > 
> > Sorry the socket/package_id is broken. If we are playing with cluster_id
> > which is now wrongly presented as package_id, you are forced to fix that
> > too. We don't want to break that in a different way or leave that as is
> > since the cluster_id and package ids now show up as same now. Earlier the
> > cluster_id was -1.
> 
> We can leave package_id=0 (and maybe add socket parsing later) and use
> llc_id instead. Like some Arm server do via ACPI. This will leave
> cluster_id for Armv9 L2 sharing. cluster_id is also used in servers for
> 2. level "clustering", e.g. Kunpeng920 L3-tags or Ampere Altra's SCU
> boundaries.
>

OK I need to brush up my knowledge there. IIUC, the cluster id and llc_id are
different and I don't believe you can mix them. There are platforms with
system-wide(meaning including all the clusters) last level cache. This
may break on those platforms.

Also IIRC ACPI PPTT has both find_cpu_cluster and find_last_level_cache
(names may differ as I haven't looked at the code) which are entirely
different. They may be same on some platforms but the information source
is definitely different.

> This way we can achieve both. (1) not use package_id for cluster and (2)
> have cluster_id available for 2. level cluster.
> 
> I just send out a lightly tested RFC:
> 
> https://lkml.kernel.org/r/20220513083400.343706-1-dietmar.eggemann@arm.com
> 

OK, I will take a look, but llc_id and cluster_id are fundamentally different.
Let me see what you have done in the patch exactly and comment there.

-- 
Regards,
Sudeep
