Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4C51F9B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiEIKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiEIKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:24:52 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84BCC10F7F2;
        Mon,  9 May 2022 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=s7/Z/
        JP2jcj2hU+IhLOKmOVbWLxEJfZj+K8d3T4w45E=; b=H4OJacPz0q6BZY9Pxy7/H
        cObdAISPqHrqrN8sSvX6rHCXSrpasJ5qXmcZLQU9tLh4LXv22f9JnDhKzgNCT5Ng
        B+i3PCGubtm9qHtT1dK7F3hyKKd/a7Eveznbu6MPlOlNLPpC58BjGgCv61EVgWBZ
        JmgXQSB77StcQxHBS74EOE=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp9 (Coremail) with SMTP id DcCowABnZ7Xh6nhiim5uBw--.3315S2;
        Mon, 09 May 2022 18:20:18 +0800 (CST)
Message-ID: <932f3d62-21d2-dc3c-ff0f-f77477f4e8e9@163.com>
Date:   Mon, 9 May 2022 18:20:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220509084853.17068-1-qianfanguijin@163.com>
 <20220509092740.qmpizwxappy77ggc@houat>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <20220509092740.qmpizwxappy77ggc@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABnZ7Xh6nhiim5uBw--.3315S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4kury3JFW5ur4DAFykGrg_yoWrAFyfpr
        1Utr1UGr48Jr1UJr17tr15Jr1UJr1DZF1UJr15Gr1UJr1UAF1UJr1UJr1UJr4UJr1DJr1U
        Jr1UJryUtryDJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6lk3UUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXAL77VXl2vWd-wAAs1
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/9 17:27, Maxime Ripard 写道:
> On Mon, May 09, 2022 at 04:48:53PM +0800, qianfanguijin@163.com wrote:
>> From: qianfan Zhao <qianfanguijin@163.com>
>>
>> OPP table value is get from allwinner lichee 3.10 kernel.
>>
>> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>> ---
>>   arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
>>   drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
>> index 291f4784e86c..90de119095fa 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -54,6 +54,41 @@ / {
>>   	#size-cells = <1>;
>>   	interrupt-parent = <&gic>;
>>   
>> +	cpu0_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-720000000 {
>> +			opp-hz = /bits/ 64 <720000000>;
>> +			opp-microvolt = <1000000 1000000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-912000000 {
>> +			opp-hz = /bits/ 64 <912000000>;
>> +			opp-microvolt = <1100000 1100000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <1160000 1160000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1104000000 {
>> +			opp-hz = /bits/ 64 <1104000000>;
>> +			opp-microvolt = <1240000 1240000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <1300000 1300000 1300000>;
>> +			clock-latency-ns = <2000000>;
>> +		};
>> +	};
>> +
> How were these OPPs tested? If you didn't, please test with
> https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
Thanks for yours guide. Next it the log:
root@ubuntu:~/cpuburn-arm-master# ./cpufreq-ljt-stress-test
Creating './whitenoise-1920x1080.jpg' ... done
CPU stress test, which is doing JPEG decoding by libjpeg-turbo
at different cpufreq operating points.

Testing CPU 0
  1200 MHz ............................................................ OK
  1104 MHz ............................................................ OK
  1008 MHz ............................................................ OK
   912 MHz ............................................................ OK
   720 MHz ............................................................ OK

Testing CPU 1
  1200 MHz ............................................................ OK
  1104 MHz ............................................................ OK
  1008 MHz ............................................................ OK
   912 MHz ............................................................ OK
   720 MHz ............................................................ OK

Testing CPU 2
  1200 MHz ............................................................ OK
  1104 MHz ............................................................ OK
  1008 MHz ............................................................ OK
   912 MHz ............................................................ OK
   720 MHz ............................................................ OK

Testing CPU 3
  1200 MHz ............................................................ OK
  1104 MHz ............................................................ OK
  1008 MHz ............................................................ OK
   912 MHz ............................................................ OK
   720 MHz ............................................................ OK

Overall result : PASSED
>
> And report the results
>
> Also, U-Boot sets the 1008MHz OPP by default, and the voltage to match.
> How is this going to play out on device tree where the CPU regulators
> aren't set?
I tested this patch on my custom board now, and cpu is powered by dcdc2.
So I add cpu-supply in dts on my custom board:

&cpu0 {
     cpu-supply = <&reg_dcdc2>;
};

I think I can add cpu-supply to the others.
>
> Maxime

