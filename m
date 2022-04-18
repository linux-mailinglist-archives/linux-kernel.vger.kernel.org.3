Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59163504AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiDRCXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiDRCXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:23:15 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392717E25;
        Sun, 17 Apr 2022 19:20:36 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 Apr
 2022 10:20:37 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 18 Apr
 2022 10:20:35 +0800
Message-ID: <3d1b3b5b-6125-f14b-6a0b-85f5c94d6f7a@meizu.com>
Date:   Mon, 18 Apr 2022 10:20:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] iio: gp2ap020a00f: Fix signedness bug
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
 <1649985637-18854-1-git-send-email-baihaowen@meizu.com>
 <20220415185205.26a3d352@jic23-huawei>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <20220415185205.26a3d352@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/16/22 1:52 AM, Jonathan Cameron 写道:
> On Fri, 15 Apr 2022 09:20:37 +0800
> Haowen Bai <baihaowen@meizu.com> wrote:
>
>> function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL 
>> errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so 
>> we have to change u8 -> int.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> Hi,
>
> The return value is not checked in *read_event_val(), so if we actually got
> -EINVAL (in reality we can't because the switch in *_get_thresh_reg*) always
> matches) then we'd use it to index an array (after performing some maths on
> the value).  So please also add a check that the return value is not
> negative in read_event_val()
>
> Same is true or write_event_val.
>
>
> Note that the bug here is probably the fact we return -EINVAL in the
> first place. We could just stop doing that but it would be non obvious
> when looking at the code that we couldn't get a failure to match in
> the switch statement - so fixing as you have done (plus the extra
> check I'm requesting) is probably the neatest solution.
>
> Thanks,
>
> Jonathan
>
>
>> ---
>> V1->V2: s8 is not enough to hold an (arbitrary) error code. To be on the safe
>> side we need to use int
>>
>>  drivers/iio/light/gp2ap020a00f.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
>> index b820041159f7..b0e62d3c6fa0 100644
>> --- a/drivers/iio/light/gp2ap020a00f.c
>> +++ b/drivers/iio/light/gp2ap020a00f.c
>> @@ -994,7 +994,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
>> +static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
>>  					     enum iio_event_direction event_dir)
>>  {
>>  	switch (chan->type) {
>> @@ -1025,7 +1025,7 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
>>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>>  	bool event_en = false;
>>  	u8 thresh_val_id;
>> -	u8 thresh_reg_l;
>> +	int thresh_reg_l;
>>  	int err = 0;
>>  
>>  	mutex_lock(&data->lock);
>> @@ -1082,7 +1082,7 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
>>  				       int *val, int *val2)
>>  {
>>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>> -	u8 thresh_reg_l;
>> +	int thresh_reg_l;
>>  	int err = IIO_VAL_INT;
>>  
>>  	mutex_lock(&data->lock);
hi Jonathan Cameron

Thank you for your suggestion. resended :).

-- 
Haowen Bai

