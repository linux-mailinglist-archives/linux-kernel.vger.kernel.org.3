Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76E9571790
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiGLKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGLKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:49:46 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B055D31925
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:49:44 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26CAnYEO041672;
        Tue, 12 Jul 2022 19:49:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 12 Jul 2022 19:49:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26CAnXP1041666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Jul 2022 19:49:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5c45c8a3-7516-7b87-fd87-fa49d6d18ce6@I-love.SAKURA.ne.jp>
Date:   Tue, 12 Jul 2022 19:49:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] rapidio/tsi721: Replace flush_scheduled_work() with
 flush_work().
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <ad924306-d15c-9f1e-13dc-eaf674878022@I-love.SAKURA.ne.jp>
 <6143d632-7c3a-35c5-1766-a3ae74c1c259@I-love.SAKURA.ne.jp>
 <1d2ce082-821e-13d2-f2b0-8a0ba00470b0@I-love.SAKURA.ne.jp>
In-Reply-To: <1d2ce082-821e-13d2-f2b0-8a0ba00470b0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we start testing this change?

On 2022/06/26 22:56, Tetsuo Handa wrote:
> Is this change correct?
> 
> On 2022/06/12 22:31, Tetsuo Handa wrote:
>> Since "struct tsi721_device" is per a device struct, I assume that
>> tsi721_remove() needs to wait for only two works associated with that
>> device. Therefore, wait for only these works using flush_work().
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>> Changes in v2:
>>   Use flush_work() instead of introducing a dedicated WQ.
>>
>> Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
>> using a macro") for background.
>>
>>  drivers/rapidio/devices/tsi721.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
>> index b3134744fb55..0a42d6a2af24 100644
>> --- a/drivers/rapidio/devices/tsi721.c
>> +++ b/drivers/rapidio/devices/tsi721.c
>> @@ -2941,7 +2941,8 @@ static void tsi721_remove(struct pci_dev *pdev)
>>  
>>  	tsi721_disable_ints(priv);
>>  	tsi721_free_irq(priv);
>> -	flush_scheduled_work();
>> +	flush_work(&priv->idb_work);
>> +	flush_work(&priv->pw_work);
>>  	rio_unregister_mport(&priv->mport);
>>  
>>  	tsi721_unregister_dma(priv);

