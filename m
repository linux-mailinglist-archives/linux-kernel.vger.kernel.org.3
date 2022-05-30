Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C25376F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiE3IW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiE3IWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:22:16 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B21148
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:22:14 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 30 May
 2022 16:22:15 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 30 May
 2022 16:22:12 +0800
Message-ID: <61130a41-a626-c860-e321-9295f9c9d0dd@meizu.com>
Date:   Mon, 30 May 2022 16:22:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: rtl8712: Fix pointer dereferenced before
 checking
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
 <YpR85JgzGsTzYm3W@kroah.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <YpR85JgzGsTzYm3W@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/5/30 下午4:14, Greg Kroah-Hartman 写道:
> On Mon, May 30, 2022 at 04:05:32PM +0800, Haowen Bai wrote:
>> The padapter->recvpriv.signal_qual_data is dereferencing before null
>> checking, so move it after checking.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>  drivers/staging/rtl8712/rtl8712_recv.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
>> index 7f1fdd058551..8ed94b259dbe 100644
>> --- a/drivers/staging/rtl8712/rtl8712_recv.c
>> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
>> @@ -863,10 +863,12 @@ static void process_link_qual(struct _adapter *padapter,
>>  {
>>  	u32	last_evm = 0, tmpVal;
>>  	struct rx_pkt_attrib *pattrib;
>> -	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
>> +	struct smooth_rssi_data *sqd;
>>  
>>  	if (!prframe || !padapter)
>>  		return;
>> +
>> +	sqd = &padapter->recvpriv.signal_qual_data;
> How can padapter ever be NULL in this codepath?
>
> thanks,
>
> greg k-h
Just the original  code, show me

if (!prframe || !padapter)

It would be null, and then return.

-- 
Haowen Bai

