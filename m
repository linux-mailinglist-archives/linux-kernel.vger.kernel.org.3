Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26D5159A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382008AbiD3Bre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382005AbiD3Br2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:47:28 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26479D0A89;
        Fri, 29 Apr 2022 18:44:08 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651283046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cEuqwKIaSP2kvNUTwixjyAdVoYgUrWdJBLxS94+imU=;
        b=TvNQtUvD81fbf0fqqgSr7oSIEarpOMlvCT4L3vuEwsCK8CsdlTMU6FgEBl/JgVx2Jzd5rQ
        SHtKE3bXEQRzdJ39Y5wSVmHR1ThuuYAm8sHPPkbT42/N3msCpD3cFhc0bBcAaErLRyexga
        ds9KKWF/BceFkEm2qNqLEeAnccIhmpA=
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
 <cba5f13e-0481-9dc9-36a4-ed29bf34220f@linux.dev>
 <bc98075a-034c-d1fe-485f-2b7af85df91b@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <e720b318-6bd7-ed7e-973b-38ca80ab04ee@linux.dev>
Date:   Sat, 30 Apr 2022 09:44:01 +0800
MIME-Version: 1.0
In-Reply-To: <bc98075a-034c-d1fe-485f-2b7af85df91b@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/22 12:01 AM, Logan Gunthorpe wrote:
>
> On 2022-04-28 18:49, Guoqing Jiang wrote:
>> I can't agree with you anymore. I would say some patches were submitted
>> without run enough tests, then after one by one kernel release, the thing
>> becomes worse.
> I'm not sure where we disagree here. I certainly don't want to introduce
> regressions myself. I haven't submitted v3 yet because I've become less
> certain that there are no regressions in it. The point of my last email
> was try to explain that I am taking testing seriously.

That is my intention too, no more new regression.

>> This is also the reason that I recommend run mdadm tests since md raid
>> is a complex subsystem, perhaps a simple change could cause regression.
>> And considering there are really limited developers and reviewers in the
>> community, the chance to cause regression get bigger.
> While I'd certainly like to run mdadm tests, they appear to be very
> broken to me. Too broken for me to fix all of it -- I don't have time
> for fixing that many issues.

I do agree it is not reasonable to ask you to fix them,  just compare 
the test result
with and without your set, at least there is no more new failure as said.

> Seems I'm not the only one to run into this problem recently:
>
> https://lore.kernel.org/linux-raid/20220111130635.00001478@linux.intel.com/T/#t
>
> And it's a shame nobody could even bother to remove the unsupported 0.9
> metadata tests from the repo as a result of this conversation.
>
>> If I may, is it possible to submit your tests to mdadm as well? So we can
>> have one common place to contain enough tests.
> I'd certainly consider that if I could run the test suite. Though one
> hitch is that I've found I need to run my tests repeatedly, for hours,
> before hitting some rare bugs. Running the tests only once is much
> easier to pass. It's hard to fully test things like this with so many
> rare retry paths in a simple regression test.

Let's focus on raid456 test given the code only touches raid5, you can 
pass argument
like this, FYI.

mdadm> ./test --raidtype=raid456 --dev=loop

Thanks,
Guoqing
