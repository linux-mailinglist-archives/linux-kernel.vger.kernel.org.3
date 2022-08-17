Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581D5975E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiHQSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiHQSiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:38:19 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5954C603;
        Wed, 17 Aug 2022 11:38:18 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd78be.dip0.t-ipconnect.de [93.221.120.190])
        by mail.itouring.de (Postfix) with ESMTPSA id 9BD74103762;
        Wed, 17 Aug 2022 20:38:16 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 654FAF01600;
        Wed, 17 Aug 2022 20:38:16 +0200 (CEST)
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
 <c7b102fc-84d7-47c0-b017-50609687f9a4@www.fastmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <8a75ee2c-0972-6e14-36e1-053122de7a35@applied-asynchrony.com>
Date:   Wed, 17 Aug 2022 20:38:16 +0200
MIME-Version: 1.0
In-Reply-To: <c7b102fc-84d7-47c0-b017-50609687f9a4@www.fastmail.com>
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

On 2022-08-17 20:16, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 5:52 AM, Holger Hoffstätte wrote:
> 
>> Chris, just a shot in the dark but can you try the patch from
>>
>> https://lore.kernel.org/linux-block/20220803121504.212071-1-yukuai1@huaweicloud.com/
>>
>> on top of something more recent than 5.12? Ideally 5.19 where it applies
>> cleanly.
> 
> 
> This patch applies cleanly on 5.12.0. I can try newer kernels later, but as the problem so easily reproduces with 5.12 and the problem first appeared there, is why I'm sticking with it. (For sure we prefer to be on 5.19 series.)
> 
> Let me know if I should try it still.

I just started running it in 5.19.2 to see if it breaks something;
no issues so far but then again I didn't have any problems to begin with
and only do peasant I/O load, and no MegaRAID.
However if it applies *and builds* on 5.12 I'd just go ahead and see what
catches fire. But you need to set the megaraid setting to fail, otherwise we
won't be able to see whether this is really a contributing factor,
or indeed the other commit that Jan identified.
Unfortunately 5.12 is a bit old already and most of the other important
fixes to sbitmap.c probably won't apply due to some other blk-mq changes.

In any case the plot thickens, so keep going. :)

-h
