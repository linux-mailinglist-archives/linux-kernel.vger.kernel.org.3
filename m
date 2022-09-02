Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697DA5AA4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiIBA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:56:19 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE55F9B6;
        Thu,  1 Sep 2022 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=vVnYtZTJIhjbiBT/O5D4BbKrgrt19+JwsWC0KXjleUU=; b=CLXseuYcpgPHWuuGOVPmAi8OPk
        ltw6b4xvveVazKwxBcwiGM7K895pcyYvDbNuzHTnKxixBnT7uWZe/cZMKsEIv25ZuP0FYY9r5w+iP
        bC1zFE3zwxCzRaDJAYdEgIquSVPTaC4pB3AKhGL+k/nt//XxMJ039We8/5GMbWO30TfKl4NDrtSG1
        lYD9ztMHqYQPkA1Ifa4OtrfquimctWBOw6z3a3msKmSVOV6dwbnNfGOaE/QYZBdoWQBd+hSfHVH8t
        qCWPQG0uER9doEY9iY7++/IwX/ljUK1AyS2PFfKyrq9PzmAZKi9NZYSw9mhyoCKIabAiUjG2AEVhv
        Hv/Ivurg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oTuyf-00E1It-1U; Thu, 01 Sep 2022 18:56:10 -0600
Message-ID: <cd0170a7-86ab-ebb3-0aed-93b2e18be432@deltatee.com>
Date:   Thu, 1 Sep 2022 18:56:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
 <917c01c1-1e2b-66f9-69f1-ed706b7ffc8f@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <917c01c1-1e2b-66f9-69f1-ed706b7ffc8f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, yukuai1@huaweicloud.com, song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-01 18:49, Guoqing Jiang wrote:
> 
> 
> On 9/2/22 2:41 AM, Logan Gunthorpe wrote:
>> Hi,
>>
>> On 2022-08-29 07:15, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Currently, wait_barrier() will hold 'resync_lock' to read
>>> 'conf->barrier',
>>> and io can't be dispatched until 'barrier' is dropped.
>>>
>>> Since holding the 'barrier' is not common, convert 'resync_lock' to use
>>> seqlock so that holding lock can be avoided in fast path.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> I've found some lockdep issues starting with this patch in md-next while
>> running mdadm tests (specifically 00raid10 when run about 10 times in a
>> row).
>>
>> I've seen a couple different lock dep errors. The first seems to be
>> reproducible on this patch, then it possibly changes to the second on
>> subsequent patches. Not sure exactly.
> 
> That's why I said "try mdadm test suites too to avoid regression." ...

You may have to run it multiple times, a single run tends not to catch
all errors. I had to loop the noted test 10 times to be sure I hit this
every time when I did the simple bisect.

And ensure that all the debug options are on when you run it (take a
look at the Kernel Hacking section in menuconfig). You won't hit this
bug without at least CONFIG_PROVE_LOCKING=y.

Logan

