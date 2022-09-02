Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABA05AA755
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiIBFk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiIBFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:40:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B104DF20
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662097255; x=1693633255;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=BfQPvi3TdP7Kz3uTSqeZ22PJmFXw1j3AImJ2haLhM+M=;
  b=SkjrMU1girL5ueuxN5MVFuowP10zW7nmm/sGLabKsM1ZyCLztV2TI7jJ
   Ue0AlFcsd0ZHrZOCr5yFflt/7ajV+8wO6iJ6WkmK2RkHP2s49Isp44dDP
   ew/hGrVrwTyMmm646QFCq/yRbEaxuTuGXIlJ2OW/x64YSpwS57Hgwvqxu
   AbqOCB0d6YO2xyPJrtlJjPX8jZxyQprbdC8ujYQmJ+QvI8b3Fb+ITHdWU
   O234Iz7DH4E01zvDeqUMCy4I8cnofM9i6c5PQm3lxDv66kAD5AicuVdKg
   9AKaNYIv6VwD1y+GePQYvFczqqmvwTVcw7lnuc65KTnfrUxVP8QRII7GJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276300832"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="276300832"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 22:40:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="941158445"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 22:40:51 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
        <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
        <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
        <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com>
Date:   Fri, 02 Sep 2022 13:40:50 +0800
In-Reply-To: <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 2 Sep 2022 10:53:40 +0530")
Message-ID: <87fshaz63h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 9/2/22 10:39 AM, Wei Xu wrote:
>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memor=
y tier
>>>>>> related details can be found. All allocated memory tiers will be lis=
ted
>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>
>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>
>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>> preference.
>>>>>
>
>
> I missed replying to this earlier. I will keep memory_tiering as subsyste=
m name in v4=20
> because we would want it to a susbsystem where all memory tiering related=
 details can be found
> including memory type in the future. This is as per discussion=20
>
> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=3Dr-io3gkX7gorUunS2Ufs=
tudCWuihrA=3D0g@mail.gmail.com

I don't think that it's a good idea to mix 2 types of devices in one
subsystem (bus).  If my understanding were correct, that breaks the
driver core convention.

>>>>>>
>>>>>> A directory hierarchy looks like
>>>>>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>>>>>> memory_tier4/
>>>>>> =E2=94=9C=E2=94=80=E2=94=80 nodes
>>>>>> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tier=
ing
>>>>>> =E2=94=94=E2=94=80=E2=94=80 uevent
>>>>>>
>>>>>> All toptier nodes are listed via
>>>>>> /sys/devices/virtual/memory_tiering/toptier_nodes
>>>>>>
>>>>>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
>>>>>> 0,2
>>>>>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>>>>>> 0,2
>>>>>
>>>>> I don't think that it is a good idea to show toptier information in u=
ser
>>>>> space interface.  Because it is just a in kernel implementation
>>>>> details.  Now, we only promote pages from !toptier to toptier.  But
>>>>> there may be multiple memory tiers in toptier and !toptier, we may
>>>>> change the implementation in the future.  For example, we may promote
>>>>> pages from DRAM to HBM in the future.
>>>>>
>>>>
>>>>
>>>> In the case you describe above and others, we will always have a list =
of
>>>> NUMA nodes from which memory promotion is not done.
>>>> /sys/devices/virtual/memory_tiering/toptier_nodes shows that list.
>>>
>>> I don't think we will need that interface if we don't restrict promotion
>>> in the future.  For example, he can just check the memory tier with
>>> smallest number.
>>>
>>> TBH, I don't know why do we need that interface.  What is it for?  We
>>> don't want to expose unnecessary information to restrict our in kernel
>>> implementation in the future.
>>>
>>> So, please remove that interface at least before we discussing it
>>> thoroughly.
>>=20
>> I have asked for this interface to allow the userspace to query a list
>> of top-tier nodes as the targets of userspace-driven promotions.  The
>> idea is that demotion can gradually go down tier by tier, but we
>> promote hot pages directly to the top-tier and bypass the immediate
>> tiers.
>>=20
>> Certainly, this can be viewed as a policy choice.  Given that now we
>> have a clearly defined memory tier hierarchy in sysfs and the
>> toptier_nodes content can be constructed from this memory tier
>> hierarchy and other information from the node sysfs interfaces, I am
>> fine if we want to remove toptier_nodes and keep the current memory
>> tier sysfs interfaces to the minimal.
>>
>
>
> Ok I can do a v4 with toptier_nodes dropped.

Thanks!

Best Regards,
Huang, Ying
