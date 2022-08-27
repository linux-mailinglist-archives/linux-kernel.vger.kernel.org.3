Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E005A3417
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 05:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiH0DBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 23:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiH0DA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A526872877
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 20:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4088161DC4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B83C433C1;
        Sat, 27 Aug 2022 03:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661569253;
        bh=HwbmXGwd0AgLMJiljlT4VpV8BfzBKXe5wxIb0yWwk7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SUIjL/wZO/DBoL+mByaxSH6RYV+RbNxSjDcUo3KPkX1NzxhJEi8MdKPBjpr3bN0q9
         /SFfL4ylvPWqEHhXnvk8QHib3174Iee53+WiSw5+twzXQ4EGKQOwcQGw9lnXVNLiqM
         dieaNrYJmQzdng4V+MS7DIo96UXd1G4eNVSIch0o=
Date:   Fri, 26 Aug 2022 20:00:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH mm-unstable] mm/demotion: Assign correct memory type for
 multiple dax devices with the same node affinity
Message-Id: <20220826200052.03c4e1dca09948aec4cbc311@linux-foundation.org>
In-Reply-To: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com>
References: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 15:32:24 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> With multiple dax devices having the same node affinity, the kernel wrongly assigned
> default_dram memory type to some devices after the memory hotplug operation. Fix this by
> not clearing node_memory_types on the dax device remove.
> 
> The current kernel cleared node_memory_type on successful removal of a dax device.
> But then we can have multiple dax devices with the same node affinity. Clearing the
> node_memory_type results in assigning other dax devices to the default dram type when
> we bring them online.

Thanks, I added this as a fix against "mm/demotion/dax/kmem: set node's
abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE".

Reworked this patch to apply, reworked all the subsequent patches as
a result of applying that, checked that this patch as-sent cleanly reverts
when all are applied, checked that everything compiled at each step of
the resulting series.

