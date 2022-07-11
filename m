Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E271570572
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiGKOW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGKOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:22:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CA61DBB;
        Mon, 11 Jul 2022 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657549347; x=1689085347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sfjIT/djBYVbzdx1PLoXfSGzu5iNZ9VhjYTlVYVGdrQ=;
  b=DXFpkpagTuOhPFtznQ8sniDGoLT8ZAj/eY9yIFFYNvTCy6ixRlCaGwXj
   MIgtGEjOhgjf2e31xwIJ6nFE17Pu4R1o14LkSdvfR/Xf6IoYl0C9K3TCt
   YbnEvcEjOhn16+T/32DUNaZrgRkm0LURAB41qlhm2VJdmF+JjFmeNLfPX
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Jul 2022 07:22:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 07:22:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Jul 2022 07:22:25 -0700
Received: from [10.216.22.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Jul
 2022 07:22:21 -0700
Message-ID: <c91aab06-4263-8a96-3943-948cc64cdca6@quicinc.com>
Date:   Mon, 11 Jul 2022 19:52:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V3] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Content-Language: en-CA
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <jirislaby@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <dianders@chromium.org>, <mka@chromium.org>, <swboyd@chromium.org>
References: <1657221457-32494-1-git-send-email-quic_vnivarth@quicinc.com>
 <Ysgs9MwCLyqeWgge@kroah.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <Ysgs9MwCLyqeWgge@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/8/2022 6:41 PM, Greg KH wrote:
> On Fri, Jul 08, 2022 at 12:47:37AM +0530, Vijaya Krishna Nivarthi wrote:
>> In the logic around call to clk_round_rate(), for some corner conditions,
>> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
>> exact clock rate was not found lowest clock was being returned.
>>
>> Search for suitable clock rate in 2 steps
>> a) exact match or within 2% tolerance
>> b) within 5% tolerance
>> This also takes care of corner conditions.
>>
>> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>> v3: simplified algorithm further, fixed robot compile warnings
>> v2: removed minor optimisations to make more readable
>> v1: intial patch contained slightly complicated logic
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 88 +++++++++++++++++++++--------------
>>   1 file changed, 53 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 2e23b65..ac2df1c 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -943,52 +943,71 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>>   	return 0;
>>   }
>>   
>> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>> -			unsigned int sampling_rate, unsigned int *clk_div)
>> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
>> +			unsigned int *clk_div, unsigned int percent_tol)
>>   {
>> -	unsigned long ser_clk;
>> -	unsigned long desired_clk;
>> -	unsigned long freq, prev;
>> +	unsigned long freq;
>>   	unsigned long div, maxdiv;
>> -	int64_t mult;
>> -
>> -	desired_clk = baud * sampling_rate;
>> -	if (!desired_clk) {
>> -		pr_err("%s: Invalid frequency\n", __func__);
>> -		return 0;
>> -	}
>> +	u64 mult;
>> +	unsigned long offset, abs_tol, achieved;
>>   
>> +	abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
>>   	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
>> -	prev = 0;
>> -
>> -	for (div = 1; div <= maxdiv; div++) {
>> -		mult = div * desired_clk;
>> -		if (mult > ULONG_MAX)
>> +	div = 1;
>> +	while (div <= maxdiv) {
>> +		mult = (u64)div * desired_clk;
>> +		if (mult != (unsigned long)mult)
>>   			break;
>>   
>> -		freq = clk_round_rate(clk, (unsigned long)mult);
>> -		if (!(freq % desired_clk)) {
>> -			ser_clk = freq;
>> -			break;
>> -		}
>> +		offset = div * abs_tol;
>> +		freq = clk_round_rate(clk, mult - offset);
>>   
>> -		if (!prev)
>> -			ser_clk = freq;
>> -		else if (prev == freq)
>> +		/* Can only get lower if we're done */
>> +		if (freq < mult - offset)
>>   			break;
>>   
>> -		prev = freq;
>> +		/*
>> +		 * Re-calculate div in case rounding skipped rates but we
>> +		 * ended up at a good one, then check for a match.
>> +		 */
>> +		div = DIV_ROUND_CLOSEST(freq, desired_clk);
>> +		achieved = DIV_ROUND_CLOSEST(freq, div);
>> +		if (achieved <= desired_clk + abs_tol &&
>> +			achieved >= desired_clk - abs_tol) {
>> +			*clk_div = div;
>> +			return freq;
>> +		}
>> +
>> +		div = DIV_ROUND_UP(freq, desired_clk);
>>   	}
>>   
>> -	if (!ser_clk) {
>> -		pr_err("%s: Can't find matching DFS entry for baud %d\n",
>> -								__func__, baud);
>> -		return ser_clk;
>> +	return 0;
>> +}
>> +
>> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>> +			unsigned int sampling_rate, unsigned int *clk_div)
>> +{
>> +	unsigned long ser_clk;
>> +	unsigned long desired_clk;
>> +
>> +	desired_clk = baud * sampling_rate;
>> +	if (!desired_clk) {
>> +		pr_err("%s: Invalid frequency\n", __func__);
> Note, this is a driver, ALWAYS use dev_err() and friends instead.
>
> Also do not allow userspace to flood the kernel logs like this looks is
> possible, this should just be dev_dbg().
>
> And of course, never use __func__, it's not needed anymore for
> dev_dbg().

Ok.

>
>> +		return 0;
> Why if you have a error, are you returning 0?

Yes, and it has been so earlier too.

0 is an invalid clock rate and will be handled accordingly by caller.

>>   	}
>>   
>> -	*clk_div = ser_clk / desired_clk;
>> -	if (!(*clk_div))
>> -		*clk_div = 1;
>> +	/*
>> +	 * try to find a clock rate within 2% tolerance, then within
>> +	 */
>> +	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
>> +	if (!ser_clk)
>> +		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
>> +
>> +	if (!ser_clk)
>> +		pr_err("Couldn't find suitable clock rate for %lu\n", desired_clk);
> return an error?
>
> dev_err().

As mentioned, we didn't (and don't) return error from here but 0.

>
>> +	else
>> +		pr_debug("desired_clk-%lu, ser_clk-%lu, clk_div-%lu\n",
>> +			desired_clk, ser_clk, *clk_div);
> dev_dbg()?
Ok.
>
> Also, as the kernel test robot says, this does not build cleanly :(

change to dev_dbg should take care of these.

Will do.

Thank you.

Vijay/


>
> thanks,
>
> greg k-h
