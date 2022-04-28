Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051A513D67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352082AbiD1VZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiD1VZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:25:33 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616D814A8;
        Thu, 28 Apr 2022 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=Jdhw4RcX258hgXLhcMoYYmZvdHzTup3MPfZ+5D3auOo=; b=TXtmndcVVnErA5hi38ovBwiRfP
        ztLBRA0jdspZd33heWruET19S4K4aTnENk4CTWNKYcxu+oHMSDN8EivN+lCEst6sSNfXsTkzCf0bU
        VtWGywpHWUdKfERBjvLAZj95odrps6jUAW4G946t5s688MPvc1RtWFO4/ixN7Rtw3vUPI+gZHIopy
        t+72vtUOvk7N/e1xhxhH1DywoGxkzalz7HAlain8TIvACUn8UlJrkpp7gPSnmvBnrH0Gh586PRLsb
        0F8nV/Wbee4vG4ZrynBGe8B7bSaF92LWir2fHYqm5aCqYKEOedih9m+crmndpNWhLLEG0/nok+9ZX
        xu085q2g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nkBaT-001ALJ-GV; Thu, 28 Apr 2022 15:22:10 -0600
Message-ID: <4f0b44aa-77a4-9896-b780-eb52241954ae@deltatee.com>
Date:   Thu, 28 Apr 2022 15:22:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     Xiao Ni <xni@redhat.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
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
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CALTww28SuvhzCL6p4L9y9ZH5Mmgss-tTm_QzbEo60hZOXAUS0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: xni@redhat.com, guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-25 10:12, Xiao Ni wrote:
>> I do know that lkp-tests has run it on this series as I did get an error
>> from it. But while I'm pretty sure that error has been resolved, I was
>> never able to figure out how to run them locally.
>>
> 
> Hi Logan
> 
> You can clone the mdadm repo at
> git://git.kernel.org/pub/scm/utils/mdadm/mdadm.git
> Then you can find there is a script test under the directory. It's not
> under the tests directory.
> The test cases are under tests directory.

So I've been fighting with this and it seems there are just a ton of
failures in these tests without my changes. Running on the latest master
(52c67fcdd6dad) with stock v5.17.5 I see major brokenness. About 17 out
of 44 tests that run failed. I had to run with --disable-integrity
because those tests seem to hang on an infinite loop waiting for the md
array to go into the U state (even though it appears idle).

Even though I ran the tests with '--keep-going', the testing stopped
after the 07revert-grow reported errors in dmesg -- even though the only
errors printed to dmesg were that of mdadm segfaulting.

Running on md/md-next seems to get a bit further (to
10ddf-create-fail-rebuild) and stops with the same segfaulting issue (or
perhaps the 07 test only randomly fails first -- I haven't run it that
many times). Though most of the tests between these points fail anyway.

My upcoming v3 patches cause no failures that are different from the
md/md-next branch. But it seems these tests have rotted to the point
that they aren't all that useful; or maybe there are a ton of
regressions in the kernel already and nobody was paying much attention.
I have also tried to test certain cases that appear broken in recent
kernels anyway (like reducing the number of disks in a raid5 array hangs
on the first stripe to reshape).

In any case I have a very rough ad-hoc test suite I've been expanding
that is targeted at testing my specific changes. Testing these changes
has definitely been challenging. In any case, I've published my tests here:

https://github.com/Eideticom/raid5-tests

Logan
