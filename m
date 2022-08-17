Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475785975A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiHQSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiHQSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:21:42 -0400
X-Greylist: delayed 30524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 11:21:41 PDT
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE797D62;
        Wed, 17 Aug 2022 11:21:41 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd78be.dip0.t-ipconnect.de [93.221.120.190])
        by mail.itouring.de (Postfix) with ESMTPSA id A5886103762;
        Wed, 17 Aug 2022 20:21:39 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 6B29EF01600;
        Wed, 17 Aug 2022 20:21:39 +0200 (CEST)
Subject: Re: stalling IO regression since linux 5.12, through 5.18
To:     Jan Kara <jack@suse.cz>, Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
 <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
 <20220817181554.znqljc6mmci45ukd@quack3>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <902f766d-160a-f384-67d5-fa77c1d5caec@applied-asynchrony.com>
Date:   Wed, 17 Aug 2022 20:21:39 +0200
MIME-Version: 1.0
In-Reply-To: <20220817181554.znqljc6mmci45ukd@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-17 20:15, Jan Kara wrote:
> On Wed 17-08-22 13:57:00, Chris Murphy wrote:
>> On Wed, Aug 17, 2022, at 12:47 PM, Chris Murphy wrote:
>> Can you boot with
>>>> "megaraid_sas.host_tagset_enable = 0" kernel option and see whether the
>>>> issue reproduces?
>>
>> This has been running an hour without symptoms. It's strongly suggestive,
>> but needs to run overnight to be sure. Anecdotally, the max write IO is
>> less than what I'm used to seeing.
> 
> OK, if this indeed passes then b6e68ee82585 ("blk-mq: Improve performance
> of non-mq IO schedulers with multiple HW queues") might be what's causing
> issues (although I don't know how yet...).
> 
> 								Honza

Certainly explains why BFQ turned up as a suspect, considering it's still
single-queue (fair MQ scheduling is .. complicated).

-h
