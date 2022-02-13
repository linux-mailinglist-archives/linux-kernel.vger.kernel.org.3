Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2318F4B3D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiBMTZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Feb 2022 14:25:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiBMTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:25:45 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E608318;
        Sun, 13 Feb 2022 11:25:38 -0800 (PST)
Date:   Sun, 13 Feb 2022 19:25:26 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/12] iio: buffer-dma: Get rid of outgoing queue
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Message-Id: <EMC97R.6CF1131XF9J13@crapouillou.net>
In-Reply-To: <20220213185740.0322a83d@jic23-huawei>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220207125933.81634-2-paul@crapouillou.net>
        <20220213185740.0322a83d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Le dim., févr. 13 2022 at 18:57:40 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> On Mon,  7 Feb 2022 12:59:22 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  The buffer-dma code was using two queues, incoming and outgoing, to
>>  manage the state of the blocks in use.
>> 
>>  While this totally works, it adds some complexity to the code,
>>  especially since the code only manages 2 blocks. It is much easier 
>> to
>>  just check each block's state manually, and keep a counter for the 
>> next
>>  block to dequeue.
>> 
>>  Since the new DMABUF based API wouldn't use the outgoing queue 
>> anyway,
>>  getting rid of it now makes the upcoming changes simpler.
>> 
>>  With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and 
>> can
>>  be removed.
>> 
>>  v2: - Only remove the outgoing queue, and keep the incoming queue, 
>> as we
>>        want the buffer to start streaming data as soon as it is 
>> enabled.
>>      - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally 
>> the
>>        same as IIO_BLOCK_STATE_DONE.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
> 
> Trivial process thing but change log should be here, not above as we 
> don't
> want it to end up in the main git log.

I'm kinda used to do this now, it's the policy for sending patches to 
the DRM tree. I like it because "git notes" disappear after rebases and 
it's a pain. At least like this I don't lose the changelog.

But okay, I'll change it for v3, if there's a v3.

Cheers,
-Paul

>>   drivers/iio/buffer/industrialio-buffer-dma.c | 44 
>> ++++++++++----------
>>   include/linux/iio/buffer-dma.h               |  7 ++--
>>   2 files changed, 26 insertions(+), 25 deletions(-)
>> 


