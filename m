Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56E515022
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378723AbiD2QE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353800AbiD2QE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:04:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794965521F;
        Fri, 29 Apr 2022 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=esLsTjeFbAhjqEsGKQ/uoZ2kISCKtGjxsP23AmIceA8=; b=f+/sRa+D999SGzSah6vs1/IzWF
        3nHHgiLgnFgqNa07JhCg7ofLXX9BJmNxqTqqPfXAwaO+bH2k4FvR7p5KTn1jxcHN5ZSBXZxnXJldW
        Jezy3ymIxYt33vN9hm9o88qDjRmzoNo4zBQS4q/HGqwzIX8HougCQ8CSMpcNo6t2CuiKqgDKlQOfu
        h6vU4NRae1w9EBWuXZvW0HBjeMU3M2M2Sqd9Tb+CnhXyparigF5ai5bfyXDgnqyh5MKpNwQ/HzUHM
        yCpeyIwJWsRpJw/Yoqtfo24I7tfNWYLfcbrZfSg4Z9CwuQWkpcyGBerPNl14OxaV3EB903SU330ap
        /XRzOeFw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nkT3h-001soD-GU; Fri, 29 Apr 2022 10:01:30 -0600
Message-ID: <bc98075a-034c-d1fe-485f-2b7af85df91b@deltatee.com>
Date:   Fri, 29 Apr 2022 10:01:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, Xiao Ni <xni@redhat.com>
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
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <cba5f13e-0481-9dc9-36a4-ed29bf34220f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, xni@redhat.com, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-28 18:49, Guoqing Jiang wrote:
> I can't agree with you anymore. I would say some patches were submitted
> without run enough tests, then after one by one kernel release, the thing
> becomes worse.

I'm not sure where we disagree here. I certainly don't want to introduce
regressions myself. I haven't submitted v3 yet because I've become less
certain that there are no regressions in it. The point of my last email
was try to explain that I am taking testing seriously.

> This is also the reason that I recommend run mdadm tests since md raid
> is a complex subsystem, perhaps a simple change could cause regression.
> And considering there are really limited developers and reviewers in the
> community, the chance to cause regression get bigger.

While I'd certainly like to run mdadm tests, they appear to be very
broken to me. Too broken for me to fix all of it -- I don't have time
for fixing that many issues. Seems I'm not the only one to run into this
problem recently:

https://lore.kernel.org/linux-raid/20220111130635.00001478@linux.intel.com/T/#t

And it's a shame nobody could even bother to remove the unsupported 0.9
metadata tests from the repo as a result of this conversation.

> If I may, is it possible to submit your tests to mdadm as well? So we can
> have one common place to contain enough tests.

I'd certainly consider that if I could run the test suite. Though one
hitch is that I've found I need to run my tests repeatedly, for hours,
before hitting some rare bugs. Running the tests only once is much
easier to pass. It's hard to fully test things like this with so many
rare retry paths in a simple regression test.

Logan
