Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C5E5A1F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiHZDEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiHZDEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA3CD516
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0A52B82F5E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DB0C433C1;
        Fri, 26 Aug 2022 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661483069;
        bh=/iG96OYo1XeZWM/rIXNwAOleoeyGKzs1KDF0HE+y5HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zSSbObLTEf3Zqzgsjq6mh8WAaTMtF3D/YhJcTVLqXqh8DXFBttlh7G1KI4YxBd+xv
         GD0EmtjcD1al546B5IN5Kpm0T2jqwXSQMCynj+vog7vs7nRqUau8a0RhPqPaNY+hML
         bt/v6ZsgpXaQqU0FXL4ZSLM7PwfMD+T8OCMsJuRc=
Date:   Thu, 25 Aug 2022 20:04:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
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
Subject: Re: [PATCH] mm/demotion: Fix kernel error with memory hotplug
Message-Id: <20220825200428.5d42ff3ecac4a0dc3a5d0020@linux-foundation.org>
In-Reply-To: <87k06v3l6h.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220825092019.379069-1-aneesh.kumar@linux.ibm.com>
        <0602b3b4-214f-94b1-61fe-2b2528ff529b@redhat.com>
        <5b0d911b-4cc2-f1ae-b33b-79aca6e3124c@linux.ibm.com>
        <87k06v3l6h.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On Fri, 26 Aug 2022 08:25:42 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> >> Do we have to cc stable?
> >> 
> >
> > That patch is not yet merged upstream. It is in mm-unstable. I guess Andrew can fold the change
> > into the original patch?
> 
> I think it may better to reply the original patch and name this patch as
> fix, for example,
> 
>   mm/demotion: Add hotplug callbacks to handle new numa node onlined fix
> 
> I found Andrew uses this kind of name before for fixing.

Doesn't matter much - figuring out which-patch-did-this-patch-fix is,
shall we say, a common operation at akpm headquarters ;)

This was an easy one, thanks to the Fixes:.  The patch didn't actually
apply at the desired point in the series, and that's pretty common. 
All fixed up now, thanks.



