Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B8520C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiEJDsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiEJDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:48:48 -0400
X-Greylist: delayed 166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 20:44:52 PDT
Received: from p3plwbeout27-02.prod.phx3.secureserver.net (p3plsmtp27-02-2.prod.phx3.secureserver.net [216.69.139.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932B8656C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:44:52 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id oGlAnV6qJMV9joGlBnGDpW; Mon, 09 May 2022 20:42:05 -0700
X-CMAE-Analysis: v=2.4 cv=WtvujfTv c=1 sm=1 tr=0 ts=6279df0d
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=c8wRBholBsc881OVBegA:9 a=QEXdDO2ut3YA:10
 a=kzUPhV2tFCwA:10 a=1LVkccGuNtIA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  oGlAnV6qJMV9j
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1noGlA-00082F-0Q; Tue, 10 May 2022 04:42:04 +0100
Message-ID: <fdfad5c9-3e5d-efbe-a39e-c26e3fd11975@squashfs.org.uk>
Date:   Tue, 10 May 2022 04:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: squashfs performance regression and readahea
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
References: <PH0PR11MB519282C2834C7BB7B5431F34ECC79@PH0PR11MB5192.namprd11.prod.outlook.com>
 <Ynfzh2ifG85MZEoN@casper.infradead.org>
 <CAJMQK-jNYoJVqsri4REV=E3bG8AS7T82HrVSAUPzbUiWask01A@mail.gmail.com>
 <CAJMQK-i3OQxcG7=LzTG4k70BP0j6PstWw0C45xcEi6iVLn_2ag@mail.gmail.com>
 <CAEVVKH-m+3+xJMbM1vRM3d=AaPSv2xg4Qx8_WPw_29JByONS8A@mail.gmail.com>
 <YnkVaGB74xqWJqdG@casper.infradead.org>
 <13af40a9-6b60-6875-8326-0827e34182d5@squashfs.org.uk>
 <YnnPYD+VtQB6hlnL@casper.infradead.org>
 <1dff431e-f51d-edb0-5abc-353ceeef50ed@squashfs.org.uk>
In-Reply-To: <1dff431e-f51d-edb0-5abc-353ceeef50ed@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfK/YcTsyUrpSKLpwR3+EC8S3KJylfUFCwVpfnfPpwY6hLzWpsxZjSi8auhVuiGHhYdjwuj0RUqfUyKNgIYm4zEByJj12wZiebDAfc6JmxQhGAvKLQxKo
 xgHX23+SN3RC8kBHtHnjzdYXdV1xqtqgaV9fmCd+0CIMFVamZ6Aiua8B+HailbNpRROESi+zRV/kPf6bulDP1okUKAb+bMhA7tA=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 04:20, Phillip Lougher wrote:
> On 10/05/2022 03:35, Matthew Wilcox wrote:
>> On Tue, May 10, 2022 at 02:11:41AM +0100, Phillip Lougher wrote:
>>> On 09/05/2022 14:21, Matthew Wilcox wrote:
>>>> On Mon, May 09, 2022 at 08:43:45PM +0800, Xiongwei Song wrote:
>>>>> Hi Hsin-Yi and Matthew,
>>>>>
>>>>> With the patch from the attachment on linux 5.10, ran the command as I
>>>>> mentioned earlier,
>>>>> got the results below:
>>>>> 1:40.65 (1m + 40.65s)
>>>>> 1:10.12
>>>>> 1:11.10
>>>>> 1:11.47
>>>>> 1:11.59
>>>>> 1:11.94
>>>>> 1:11.86
>>>>> 1:12.04
>>>>> 1:12.21
>>>>> 1:12.06
>>>>>
>>>>> The performance has improved obviously, but compared to linux 4.18, 
>>>>> the
>>>>> performance is not so good.
>>>>>
>>>>> Moreover, I wanted to test on linux 5.18. But I think I should revert
>>>>> 9eec1d897139 ("squashfs: provide backing_dev_info in order to disable
>>>>> read-ahead"),
>>>>> right?  Otherwise, the patch doesn't work?
>>>>
>>>> I've never seen patch 9eec1d897139 before.  If you're going to point
>>>> out bugs in my code, at least have the decency to cc me on it.  It
>>>> should never have gone in, and should be reverted so the problem can
>>>> be fixed properly.
>>>
>>> You are not in charge of what patches goes into Squashfs, that is my
>>> perogative as maintainer of Squashfs.
>>
>> I think you mean 'prerogative'.  And, no, your filesystem is not your
>> little fiefdom, it's part of a collaborative effort.
>>
> 
> This isn't a spelling contest, and if that's the best you can do you
> have already failed.
> 
> Be carefull here also, I have been maintainer of Squashfs for 20 years,
> and was kernel maintainer for both Ubuntu and Redhat for 10 years, and
> so I am experienced member of the community.
> 
> You reply is bordering on offensive and arrogant, especially considering
> it is unwarranted.  I did not set out to offend you, and I don't
> appreciate it.
> 
> About 8 years ago I decided to refrain from active involvement in the
> kernel community, because I decided the level of discourse was
> disgusting, and I had enough of it.
> 
> I poped up now to defend my approval of the Huawei patch.  I am *quite*
> happy not to have any more involvement until necessary.
> 
> So having said what I want to say, I will leave it at that. You have
> just proved why I have minimised my involvement.
> 
> No doubt you'll throw your toys out the pram, but, I'm no
> longer listening so don't bother.
> 
> 
>>> That patch (by Huawei) fixes the performance regression in Squashfs
>>> by disabling readahead, and it is good workaround until something
>>> better.
>>
>> You *didn't even report the problem to me*.  How can it be fixed if I'm
>> not aware of it?

Despite having been insulted, I have done your homework for you.

This is where the problem was raised last year, with you directly
emailed.

https://lore.kernel.org/all/CAJMQK-g9G6KQmH-V=BRGX0swZji9Wxe_2c7ht-MMAapdFy2pXw@mail.gmail.com/T/

>>
> 
> There was a email discussion last year, which I responded to, and got
> ignored.  I will find it out tomorrow, perhaps.  But I will probably
> not bother, because life is too short.
> 

Afterwards you started a thread on "Readahead for compressed data",
which I responded to.

https://lore.kernel.org/all/YXHK5HrQpJu9oy8w@casper.infradead.org/T/


> Cheers
> 
> Phillip

