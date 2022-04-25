Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9150E9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiDYUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbiDYUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:20:43 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A421832
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:17:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6744222170;
        Mon, 25 Apr 2022 20:17:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E09C721F3E;
        Mon, 25 Apr 2022 20:17:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650917856; a=rsa-sha256;
        cv=none;
        b=U+SjjHMoOExG3kDCYhODOkewAZips9bS4fMVW9LzyNYowd4iLFdbUFl3b6KfWEfYUtbRsn
        CmeePNbK2vWDh0pwtJ+eT0HoLViYpcb62yKKcp7OHcEDYGd7kvIuN4e6zt577Qzag4rD+a
        3+r92eqsVFdE+76bBe5Chgxey+cjCWwK4GQ/A3YJ/EI5zK6Fm4yD0dQMjWGVC1eU4QNnrS
        46jT904dIB9N0XyDNQwNHwWJguJiAdy9vw0FqxK19xjyl67ZJQsw/VrcnDG8QGVjbPkfQF
        Cz7ARRix0oX9ys1vmvB9WtLALbV/cFcawnwXEURFajqXYXqRryPf924pGtzP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650917856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6zh5F+jPIE5B2KMd//wepyBpImwUBWJ8d5VzR30wV3c=;
        b=MbMmf/otaCMAcsgU3fczXX16R2GK7r2rKIpQj2ksdGn6QqEoTURQfvedehyroNcTvAMn9P
        cwJn3XPpYLBPFUJaS99npoBK5ARGOM/XyLcp8/C2IybXPm1ZNY4+nPRz9nip4Q7+mRkhz/
        wdxXw+oj8BYscSQQbWr6ReatAP7QOM8z3+tnRqcZc0WyxljZ0eWxNgJBueTRk0d/uLaHyE
        PMegZpKtPvc6CL24NQBvWl6CQfGJweQHJGbXe5DGFP1uGoLLx7Oe9IvSNc96OlVui97+Jm
        BMC3Ryv1tvQyfC87x2dx4glJqnrugj8gID7Jik2JjG1L48wSDH/9ic8U2Pre7Q==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-dbvc4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.168 (trex/6.7.1);
        Mon, 25 Apr 2022 20:17:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Bubble: 04da64d03139273e_1650917857159_376882223
X-MC-Loop-Signature: 1650917857159:3692506912
X-MC-Ingress-Time: 1650917857158
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4KnGXF4LMlz39;
        Mon, 25 Apr 2022 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650917854;
        bh=6zh5F+jPIE5B2KMd//wepyBpImwUBWJ8d5VzR30wV3c=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=gBFBkLd4y39ZL66DqgPXptgkgqNkIJg1j3Y6gBsXk0EvO0gofnWG2iqI5bYk4fLH4
         QRx8/sxAVNE+PHDd6nKgWGs9uDZrfgitGtPNR/WxQRZLtYKKNjBElTzaD3Dn8FGfjR
         SXrzPuPEBtd9QqfE2NLY+dS63lwizhqKAkmnpg+Ivim+Bz2WbzwEE9Su96oV74HH6O
         q6cWNWkdThSrU/pb6I6kJjzwI41PHYhzuQdf69xgkzN1u7q7Mq32X+522KshdW6epE
         U1lUF1qi6S4Sp6gDFxDPFbJjGx6yYzdwNPcmFd9aZ+wMagooVc+Khf1cPvxzy6CERX
         i/NCWJaaiaViw==
Date:   Mon, 25 Apr 2022 13:17:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <20220425201728.5kzm4seu7rep7ndr@offworld>
Mail-Followup-To: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>, MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
References: <610ccaad03f168440ce765ae5570634f3b77555e.camel@intel.com>
 <CAAPL-u9ktM82zAW_OVwqTmQsr-XC8XOPmAsjoiCLo18cxUWA=A@mail.gmail.com>
 <8e31c744a7712bb05dbf7ceb2accf1a35e60306a.camel@intel.com>
 <CAAPL-u9uP+FUh7Yn0ByOECo+EP32ZABnCvNPKQB9JCA68VHEqQ@mail.gmail.com>
 <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com>
 <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
 <8735i1zurt.fsf@linux.ibm.com>
 <ea9d01e16de655af85c0041c96964d83f59fb6d2.camel@intel.com>
 <c576a992-5a50-5dd3-644c-a45d4338fc85@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c576a992-5a50-5dd3-644c-a45d4338fc85@linux.ibm.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022, Aneesh Kumar K V wrote:

>On 4/25/22 11:40 AM, ying.huang@intel.com wrote:
>>On Mon, 2022-04-25 at 09:20 +0530, Aneesh Kumar K.V wrote:
>>>"ying.huang@intel.com" <ying.huang@intel.com> writes:
>>>
>>>>Hi, All,
>>>>
>>>>On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:
>>>>
>>>>[snip]
>>>>
>>>>>I think it is necessary to either have per node demotion targets
>>>>>configuration or the user space interface supported by this patch
>>>>>series. As we don't have clear consensus on how the user interface
>>>>>should look like, we can defer the per node demotion target set
>>>>>interface to future until the real need arises.
>>>>>
>>>>>Current patch series sets N_DEMOTION_TARGET from dax device kmem
>>>>>driver, it may be possible that some memory node desired as demotion
>>>>>target is not detected in the system from dax-device kmem probe path.
>>>>>
>>>>>It is also possible that some of the dax-devices are not preferred as
>>>>>demotion target e.g. HBM, for such devices, node shouldn't be set to
>>>>>N_DEMOTION_TARGETS. In future, Support should be added to distinguish
>>>>>such dax-devices and not mark them as N_DEMOTION_TARGETS from the
>>>>>kernel, but for now this user space interface will be useful to avoid
>>>>>such devices as demotion targets.
>>>>>
>>>>>We can add read only interface to view per node demotion targets
>>>>>from /sys/devices/system/node/nodeX/demotion_targets, remove
>>>>>duplicated /sys/kernel/mm/numa/demotion_target interface and instead
>>>>>make /sys/devices/system/node/demotion_targets writable.
>>>>>
>>>>>Huang, Wei, Yang,
>>>>>What do you suggest?
>>>>
>>>>We cannot remove a kernel ABI in practice.  So we need to make it right
>>>>at the first time.  Let's try to collect some information for the kernel
>>>>ABI definitation.
>>>>
>>>>The below is just a starting point, please add your requirements.
>>>>
>>>>1. Jagdish has some machines with DRAM only NUMA nodes, but they don't
>>>>want to use that as the demotion targets.  But I don't think this is a
>>>>issue in practice for now, because demote-in-reclaim is disabled by
>>>>default.
>>>
>>>It is not just that the demotion can be disabled. We should be able to
>>>use demotion on a system where we can find DRAM only NUMA nodes. That
>>>cannot be achieved by /sys/kernel/mm/numa/demotion_enabled. It needs
>>>something similar to to N_DEMOTION_TARGETS
>>>
>>
>>Can you show NUMA information of your machines with DRAM-only nodes and
>>PMEM nodes?  We can try to find the proper demotion order for the
>>system.  If you can not show it, we can defer N_DEMOTION_TARGETS until
>>the machine is available.
>
>
>Sure will find one such config. As you might have noticed this is very
>easy to have in a virtualization setup because the hypervisor can
>assign memory to a guest VM from a numa node that doesn't have CPU
>assigned to the same guest. This depends on the other guest VM
>instance config running on the system. So on any virtualization config
>that has got persistent memory attached, this can become an easy
>config to end up with.

And as hw becomes available things like CXL will also start to show
"interesting" setups. You have a mix of volatile and/or pmem nodes
with different access costs, so: CPU+DRAM, DRAM (?), volatile CXL mem,
CXL pmem, non-cxl pmem.

imo, by default, slower mem should be demotion candidates regardless of
type or socket layout (which can be a last consideration such that this
is somewhat mitigated). And afaict this is along the lines of what Jagdish's
first example refers to in patch 1/5.

>
>>>>2. For machines with PMEM installed in only 1 of 2 sockets, for example,
>>>>
>>>>Node 0 & 2 are cpu + dram nodes and node 1 are slow
>>>>memory node near node 0,
>>>>
>>>>available: 3 nodes (0-2)
>>>>node 0 cpus: 0 1
>>>>node 0 size: n MB
>>>>node 0 free: n MB
>>>>node 1 cpus:
>>>>node 1 size: n MB
>>>>node 1 free: n MB
>>>>node 2 cpus: 2 3
>>>>node 2 size: n MB
>>>>node 2 free: n MB
>>>>node distances:
>>>>node   0   1   2
>>>> =A0=A00:  10  40  20
>>>> =A0=A01:  40  10  80
>>>> =A0=A02:  20  80  10
>>>>
>>>>We have 2 choices,
>>>>
>>>>a)
>>>>node	demotion targets
>>>>0	1
>>>>2	1
>>>
>>>This is achieved by
>>>
>>>[PATCH v2 1/5] mm: demotion: Set demotion list differently

Yes, I think it makes sense to do 2a.

Thanks,
Davidlohr
