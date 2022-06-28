Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DA55E467
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbiF1NVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbiF1NVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:21:16 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1035DC4;
        Tue, 28 Jun 2022 06:19:20 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D1CFD3EEC7;
        Tue, 28 Jun 2022 15:19:17 +0200 (CEST)
Message-ID: <e57300bb-163b-2963-e55e-a5d0b0678f4f@somainline.org>
Date:   Tue, 28 Jun 2022 15:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] thermal: qcom: tsens-v1: Add support for MSM8992/4
 TSENS
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220501202025.211567-1-konrad.dybcio@somainline.org>
 <20220501202025.211567-2-konrad.dybcio@somainline.org>
 <CAA8EJpqM5i88UKSrQyG1pMM6NQb8naTri-jNt++q7oKB-zdGAg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <CAA8EJpqM5i88UKSrQyG1pMM6NQb8naTri-jNt++q7oKB-zdGAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.06.2022 17:15, Dmitry Baryshkov wrote:
> On Sun, 1 May 2022 at 23:21, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>>
>> MSM8994, despite being heavily based on MSM8974, uses the
>> 1.2 version of TSENS. Also, 8994 being 8994, it has a custom
>> way of calculating the slope.
>>
>> MSM8992 in turn is a cut-down version of MSM8994 and uses
>> the same TSENS hardware, albeit with a different set of sensors.
>>
>> Also tested on 8976 (by a person who didn't want to be named)
>> to make sure the 11->16 max_sensors changes didn't break anything.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>> Changes since v2:
>>
>> - don't use slope before it's initialized (whoops!)
>> - don't re-assign the same value to p[0..15]
>> - free calib_rsel
>> - use the same ops for 8992 and 8994
>>
>>  drivers/thermal/qcom/tsens-v1.c | 293 ++++++++++++++++++++++++++++++--
>>  drivers/thermal/qcom/tsens.c    |   6 +
>>  drivers/thermal/qcom/tsens.h    |   2 +-
>>  3 files changed, 288 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>> index 573e261ccca7..58864962f370 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -142,6 +142,99 @@
>>  #define CAL_SEL_MASK   7
>>  #define CAL_SEL_SHIFT  0
>>
>> +/* eeprom layout data for 8994 */
>> +#define MSM8994_BASE0_MASK     0x3ff
>> +#define MSM8994_BASE1_MASK     0xffc00
>> +#define MSM8994_BASE0_SHIFT    0
>> +#define MSM8994_BASE1_SHIFT    10
> 
> Generally I feel that all the _MASK values can be better generated
> using the GENMASK and newly defined _SHIFT value.
Yes, I agree, however I think it'd be better to do it for
all the defines in this file at once in a separate commit.

Konrad
> 
>> +
>> +#define MSM8994_S0_MASK        0xf00000
>> +#define MSM8994_S1_MASK        0xf000000
>> +#define MSM8994_S2_MASK        0xf0000000
>> +#define MSM8994_S3_MASK        0xf
>> +#define MSM8994_S4_MASK        0xf0
>> +#define MSM8994_S5_MASK        0xf00
>> +#define MSM8994_S6_MASK        0xf000
>> +#define MSM8994_S7_MASK        0xf0000
>> +#define MSM8994_S8_MASK        0xf00000
>> +#define MSM8994_S9_MASK        0xf000000
>> +#define MSM8994_S10_MASK       0xf0000000
>> +#define MSM8994_S11_MASK       0xf
>> +#define MSM8994_S12_MASK       0xf0
>> +#define MSM8994_S13_MASK       0xf00
>> +#define MSM8994_S14_MASK       0xf000
>> +#define MSM8994_S15_MASK       0xf0000
>> +
>> +#define MSM8994_S0_SHIFT       20
>> +#define MSM8994_S1_SHIFT       24
>> +#define MSM8994_S2_SHIFT       28
>> +#define MSM8994_S3_SHIFT       0
>> +#define MSM8994_S4_SHIFT       4
>> +#define MSM8994_S5_SHIFT       8
>> +#define MSM8994_S6_SHIFT       12
>> +#define MSM8994_S7_SHIFT       16
>> +#define MSM8994_S8_SHIFT       20
>> +#define MSM8994_S9_SHIFT       24
>> +#define MSM8994_S10_SHIFT      28
>> +#define MSM8994_S11_SHIFT      0
>> +#define MSM8994_S12_SHIFT      4
>> +#define MSM8994_S13_SHIFT      8
>> +#define MSM8994_S14_SHIFT      12
>> +#define MSM8994_S15_SHIFT      16
> 
> [skipped the rest]
> 
