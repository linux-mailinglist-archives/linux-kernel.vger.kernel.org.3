Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A6513FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353030AbiD2Awa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiD2Aw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:52:29 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F37887AD;
        Thu, 28 Apr 2022 17:49:12 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651193351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9uNLyxy24U8cwCidXNlnBYk/A7+jJ6jFr9CcVcV/Es=;
        b=U5r5GPhyzH8g2Kj75Xv/YHm+AjYWFh/NIdFTuupxFoYM4l5wRQ5LtF+LIBiqWiXUMrGVHW
        NdkXX/W4RYAYLW3jNUi3yVRmUNRaU2p4YPavBAfD8tt6ufIfqcbgH3tW5rwAnNua7dFDCf
        rWk09wsNSKfS3B+8okqOnlEGJlqyrYI=
To:     Logan Gunthorpe <logang@deltatee.com>, Xiao Ni <xni@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <CALTww28fwNpm0O_jc7-2Xr0JSX9i6F1kgoUQ8m_k6ZgPa1XxXw@mail.gmail.com>
 <c14c0103-9cbd-7d0f-486b-344dd33725ab@deltatee.com>
 <4094aed9-d22d-d14f-07a7-5abe599beeab@linux.dev>
 <8d8fbf24-51b5-a076-b7ad-fcbb7d5c275e@deltatee.com>
 <CALTww28SuvhzCL6p4L9y9ZH5Mmgss-tTm_QzbEo60hZOXAUS0A@mail.gmail.com>
 <4f0b44aa-77a4-9896-b780-eb52241954ae@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <cba5f13e-0481-9dc9-36a4-ed29bf34220f@linux.dev>
Date:   Fri, 29 Apr 2022 08:49:03 +0800
MIME-Version: 1.0
In-Reply-To: <4f0b44aa-77a4-9896-b780-eb52241954ae@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 5:22 AM, Logan Gunthorpe wrote:
>
> On 2022-04-25 10:12, Xiao Ni wrote:
>>> I do know that lkp-tests has run it on this series as I did get an error
>>> from it. But while I'm pretty sure that error has been resolved, I was
>>> never able to figure out how to run them locally.
>>>
>> Hi Logan
>>
>> You can clone the mdadm repo at
>> git://git.kernel.org/pub/scm/utils/mdadm/mdadm.git
>> Then you can find there is a script test under the directory. It's not
>> under the tests directory.
>> The test cases are under tests directory.
> So I've been fighting with this and it seems there are just a ton of
> failures in these tests without my changes. Running on the latest master
> (52c67fcdd6dad) with stock v5.17.5 I see major brokenness. About 17 out
> of 44 tests that run failed. I had to run with --disable-integrity
> because those tests seem to hang on an infinite loop waiting for the md
> array to go into the U state (even though it appears idle).
>
> Even though I ran the tests with '--keep-going', the testing stopped
> after the 07revert-grow reported errors in dmesg -- even though the only
> errors printed to dmesg were that of mdadm segfaulting.
>
> Running on md/md-next seems to get a bit further (to
> 10ddf-create-fail-rebuild) and stops with the same segfaulting issue (or
> perhaps the 07 test only randomly fails first -- I haven't run it that
> many times). Though most of the tests between these points fail anyway.
>
> My upcoming v3 patches cause no failures that are different from the
> md/md-next branch. But it seems these tests have rotted to the point
> that they aren't all that useful; or maybe there are a ton of
> regressions in the kernel already and nobody was paying much attention.

I can't agree with you anymore. I would say some patches were submitted
without run enough tests, then after one by one kernel release, the thing
becomes worse.

This is also the reason that I recommend run mdadm tests since md raid
is a complex subsystem, perhaps a simple change could cause regression.
And considering there are really limited developers and reviewers in the
community, the chance to cause regression get bigger.

> I have also tried to test certain cases that appear broken in recent
> kernels anyway (like reducing the number of disks in a raid5 array hangs
> on the first stripe to reshape).
>
> In any case I have a very rough ad-hoc test suite I've been expanding
> that is targeted at testing my specific changes. Testing these changes
> has definitely been challenging. In any case, I've published my tests here:
>
> https://github.com/Eideticom/raid5-tests

If I may, is it possible to submit your tests to mdadm as well? So we can
have one common place to contain enough tests.

Thanks,
Guoqing
