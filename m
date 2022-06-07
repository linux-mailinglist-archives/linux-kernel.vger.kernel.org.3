Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6245653F454
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiFGDKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFGDKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:10:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB55B0D26;
        Mon,  6 Jun 2022 20:10:31 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHFdf2GRkzRhpp;
        Tue,  7 Jun 2022 11:07:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 11:10:29 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 11:10:28 +0800
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <tj@kernel.org>,
        <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <20220523085902.wmxoebyq3crerecr@quack3.lan>
 <25f6703e-9e10-75d9-a893-6df1e6b75254@kernel.dk>
 <20220523152516.7sr247i3bzwhr44w@quack3.lan>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <21cd1c49-838a-7f03-ab13-9a4f2ac65979@huawei.com>
Date:   Tue, 7 Jun 2022 11:10:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220523152516.7sr247i3bzwhr44w@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2022/05/23 23:25, Jan Kara д��:
> On Mon 23-05-22 06:36:58, Jens Axboe wrote:
>> On 5/23/22 2:59 AM, Jan Kara wrote:
>>> On Mon 23-05-22 09:10:38, yukuai (C) wrote:
>>>> ? 2022/05/21 20:21, Jens Axboe ??:
>>>>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>>>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>>>>> Hi, Paolo
>>>>>>>>
>>>>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>>>>> since we spotted this problem...
>>>>>>>>
>>>>>>>
>>>>>>> friendly ping ...
>>>>>> friendly ping ...
>>>>>
>>>>> I can't speak for Paolo, but I've mentioned before that the majority
>>>>> of your messages end up in my spam. That's still the case, in fact
>>>>> I just marked maybe 10 of them as not spam.
>>>>>
>>>>> You really need to get this issued sorted out, or you will continue
>>>>> to have patches ignore because folks may simply not see them.
>>>>>
>>>> Hi,
>>>>
>>>> Thanks for your notice.
>>>>
>>>> Is it just me or do you see someone else's messages from *huawei.com
>>>> end up in spam? I tried to seek help from our IT support, however, they
>>>> didn't find anything unusual...
>>>
>>> So actually I have noticed that a lot of (valid) email from huawei.com (not
>>> just you) ends up in the spam mailbox. For me direct messages usually pass
>>> (likely matching SPF records for originating mail server save the email
>>> from going to spam) but messages going through mailing lists are flagged as
>>> spam because the emails are missing valid DKIM signature but huawei.com
>>> DMARC config says there should be DKIM signature (even direct messages are
>>> missing DKIM so this does not seem as a mailing list configuration issue).
>>> So this seems as some misconfiguration of the mails on huawei.com side
>>> (likely missing DKIM signing of outgoing email).
>>
>> SPF/DKIM was indeed a problem earlier for yukaui patches, but I don't
>> see that anymore. Maybe it's still an issue for some emails, from them
>> or Huawei in general?
> 
> Hum, for me all emails from Huawei I've received even today fail the DKIM
> check. After some more digging there is interesting inconsistency in DMARC
> configuration for huawei.com domain. There is DMARC record for huawei.com
> like:
> 
> huawei.com.		600	IN	TXT	"v=DMARC1;p=none;rua=mailto:dmarc@edm.huawei.com"
> 
> which means no DKIM is required but _dmarc.huawei.com has:
> 
> _dmarc.huawei.com.	600	IN	TXT	"v=DMARC1;p=quarantine;ruf=mailto:dmarc@huawei.com;rua=mailto:dmarc@huawei.com"
> 
> which says that DKIM is required. I guess this inconsistency may be the
> reason why there are problems with DKIM validation for senders from
> huawei.com. Yu Kuai, can you perhaps take this to your IT support to fix
> this? Either make sure huawei.com emails get properly signed with DKIM or
> remove the 'quarantine' record from _dmarc.huawei.com. Thanks!
> 
> 								Honza
> 
Hi, Jan and Jens

I just got response from our IT support:

'fo' is not set in our dmarc configuration(default is 0), which means
SPF and DKIM verify both failed so that emails will end up in spam.

It right that DKIM verify is failed because there is no signed key,
however, our IT support are curious how SPF verify faild.

Can you guys please take a look at ip address of sender? So our IT
support can take a look if they miss it from SPF records.

Thanks,
Kuai
