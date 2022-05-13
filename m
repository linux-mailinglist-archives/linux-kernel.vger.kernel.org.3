Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC6525D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378379AbiEMIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378276AbiEMIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:36:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 208A426272A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:36:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED0F7113E;
        Fri, 13 May 2022 01:36:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1DB3F73D;
        Fri, 13 May 2022 01:36:38 -0700 (PDT)
Message-ID: <4b124aa9-ed26-a40b-8e74-81043d051247@arm.com>
Date:   Fri, 13 May 2022 10:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2] arch_topology: support parsing cluster_id from DT
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>, Qing Wang <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
 <Yn0XE3szFk9f2VyL@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Yn0XE3szFk9f2VyL@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 16:17, Sudeep Holla wrote:
> On Wed, May 11, 2022 at 02:52:56AM -0700, Qing Wang wrote:
>> From: Wang Qing <wangqing@vivo.com>
>>
>> Use nested cluster structures in DT to support describing multi-level
>> cluster topologies and increase the parsing of nested cluster.
>>
>> Notice: the clusters describing in DT currently are not physical
>> boundaries, since changing "cluster" to "socket" is too involved and error
>> prone, this patch will not have any effect on one-level cluster topo, but
>> can support the mutil-level cluster topo to support CLUSTER_SCHED.
> 
> Sorry the socket/package_id is broken. If we are playing with cluster_id
> which is now wrongly presented as package_id, you are forced to fix that
> too. We don't want to break that in a different way or leave that as is
> since the cluster_id and package ids now show up as same now. Earlier the
> cluster_id was -1.

We can leave package_id=0 (and maybe add socket parsing later) and use
llc_id instead. Like some Arm server do via ACPI. This will leave
cluster_id for Armv9 L2 sharing. cluster_id is also used in servers for
2. level "clustering", e.g. Kunpeng920 L3-tags or Ampere Altra's SCU
boundaries.

This way we can achieve both. (1) not use package_id for cluster and (2)
have cluster_id available for 2. level cluster.

I just send out a lightly tested RFC:

https://lkml.kernel.org/r/20220513083400.343706-1-dietmar.eggemann@arm.com

> 
> I had a look when I started reviewing your patch. Assuming we don't need
> nested cluster support yet, I have some patches(not built or tested
> unfortunately yet). Let me know your thoughts. If you think you still
> need support for some kind of nested cluster, build that on top of this.
> Also I haven't bothered about sched domains as this purely relates to
> topology and how this is mapped to sched domain is orthogonal.
> 
> If anything is broken, that needs to be fixed separately there. I see the
> idea here is correct and would like to push the patches once I build/test
> and get some review/more testing.
