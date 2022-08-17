Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8548F596E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiHQMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiHQMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:31:12 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4B83F0C;
        Wed, 17 Aug 2022 05:31:11 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd78be.dip0.t-ipconnect.de [93.221.120.190])
        by mail.itouring.de (Postfix) with ESMTPSA id 14C27103762;
        Wed, 17 Aug 2022 14:31:10 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id C18A5F01600;
        Wed, 17 Aug 2022 14:31:09 +0200 (CEST)
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Chris Murphy <lists@colorremedies.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <8b361f8e-cc4f-466c-90f0-031a43436af2@www.fastmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <6eece869-5cab-57b6-6f8f-98eaf65a742f@applied-asynchrony.com>
Date:   Wed, 17 Aug 2022 14:31:09 +0200
MIME-Version: 1.0
In-Reply-To: <8b361f8e-cc4f-466c-90f0-031a43436af2@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-17 13:57, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 5:52 AM, Holger Hoffstätte wrote:
>> On 2022-08-16 17:34, Chris Murphy wrote:
>>>
>>> On Tue, Aug 16, 2022, at 11:25 AM, Nikolay Borisov wrote:
>>>> How about changing the scheduler either mq-deadline or noop, just
>>>> to see if this is also reproducible with a different scheduler. I
>>>> guess noop would imply the blk cgroup controller is going to be
>>>> disabled
>>>
>>> I already reported on that: always happens with bfq within an hour or
>>> less. Doesn't happen with mq-deadline for ~25+ hours. Does happen
>>> with bfq with the above patches removed. Does happen with
>>> cgroup.disabled=io set.
>>>
>>> Sounds to me like it's something bfq depends on and is somehow
>>> becoming perturbed in a way that mq-deadline does not, and has
>>> changed between 5.11 and 5.12. I have no idea what's under bfq that
>>> matches this description.
>>
>> Chris, just a shot in the dark but can you try the patch from
>>
>> https://lore.kernel.org/linux-block/20220803121504.212071-1-yukuai1@huaweicloud.com/
>>
>> on top of something more recent than 5.12? Ideally 5.19 where it applies
>> cleanly.
> 
> The problem doesn't reliably reproduce on 5.19. A patch for 5.12..5.18 would be much more testable.

If you look at the changes to sbitmap at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/lib/sbitmap.c

you'll find that they are relatively recent, so Yukai's patch will probably also apply
to 5.18 - I don't know. Also look at the most recent commit which mentions
"Checking free bits when setting the target bits. Otherwise, it may reuse the busying bits."

Reusing the busy bits sounds "not great" either and (AFAIU) may also be a cause for
lost wakeups, but I'm sure Jan and Ming know all that better than me.

Especially Jan's suggestions re. disabling BFQ cgroup support is probably the easiest
thing to try first. What you're observing may not have a single root cause, and even if
it does, it might not be where we suspect.

-h
