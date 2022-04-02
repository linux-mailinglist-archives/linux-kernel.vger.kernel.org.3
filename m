Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431564EFE4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbiDBDys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiDBDyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:54:45 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69C20A953
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:52:51 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 2 Apr
 2022 20:03:16 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Sat, 2 Apr
 2022 11:52:48 +0800
Message-ID: <94f5e266-4412-cf45-9ac3-bbe78477f0c4@meizu.com>
Date:   Sat, 2 Apr 2022 11:52:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ipmi: ssif: potential NULL dereference in
 msg_done_handler()
To:     <minyard@acm.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1648783665-19237-1-git-send-email-baihaowen@meizu.com>
 <20220401124809.GF29333@minyard.net>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <20220401124809.GF29333@minyard.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-123.meizu.com (172.16.1.123) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Corey
Thank you for your kindly reply and suggestion. :)

在 4/1/22 8:48 PM, Corey Minyard 写道:
> On Fri, Apr 01, 2022 at 11:27:45AM +0800, Haowen Bai wrote:
>> msg could be null without checking null and return, but still dereference
>> msg->rsp[2] and will lead to a null pointer trigger.
> Actually:
>
>   If you look at the big picture (how the rest of the code works), it's
>   not possible for msg to be NULL in these cases.  However, being
>   defensive here is probably a good idea.
>
>   There are two of these cases, why didn't you fix both of them?
>
>   This still doesn't fix the problem.  There is an "else if" in both
>   cases that also uses msg.
>
> You can't just look at the output of some code analysis tool and make a
> blind decision like this.  You have to look at the big picture.  And you
> have to analyze the code carefully.
>
> The right way to be defensive here is to add:
> 	if (!msg) {
> 		ipmi_ssif_unlock_cond(ssif_info, flags);
> 		break;
> 	}
> in both cases.  And probably add a log, since this means something else
> went wrong.
>
> Anyway, I'll add a patch for defensive measure and give you credit for
> pointing it out.
>
> -corey
>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>  drivers/char/ipmi/ipmi_ssif.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
>> index f199cc1..9383de3 100644
>> --- a/drivers/char/ipmi/ipmi_ssif.c
>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>> @@ -814,7 +814,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>>  		break;
>>  
>>  	case SSIF_GETTING_EVENTS:
>> -		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
>> +		if ((result < 0) || (len < 3) || (msg && (msg->rsp[2] != 0))) {
>>  			/* Error getting event, probably done. */
>>  			msg->done(msg);
>>  
>> -- 
>> 2.7.4
>>

-- 
Haowen Bai

