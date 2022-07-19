Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D15797CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiGSKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGSKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:39:38 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC5248F5;
        Tue, 19 Jul 2022 03:39:38 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 605F63F715;
        Tue, 19 Jul 2022 12:39:36 +0200 (CEST)
Message-ID: <d5dd721e-b0d7-f76d-d40c-b4927c236460@somainline.org>
Date:   Tue, 19 Jul 2022 12:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization
 workaround quirk
Content-Language: en-US
To:     bhupesh.sharma@linaro.org, linux-pm@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
 <09ff7e3a-7dd5-db35-3795-89151afb5363@somainline.org>
 <e69cb444-2bee-870e-08ca-bbe3237d8166@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <e69cb444-2bee-870e-08ca-bbe3237d8166@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.07.2022 08:34, bhupesh.sharma@linaro.org wrote:
> Hi Konrad,
> 
> On 7/15/22 8:26 PM, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>>
>>
>> On 1.07.2022 16:58, Bhupesh Sharma wrote:
>> > Since for some QCoM tsens controllers, its suggested to
>> > monitor the controller health periodically and in case an
>> > issue is detected, to re-initialize the tsens controller
>> > via trustzone, add the support for the same in the
>> > qcom tsens driver.
>> >
>> > Note that Once the tsens controller is reset using scm call,
>> > all SROT and TM region registers will enter the reset mode.
>> >
>> > While all the SROT registers will be re-programmed and
>> > re-enabled in trustzone prior to the scm call exit, the TM
>> > region registers will not re-initialized in trustzone and thus
>> > need to be handled by the tsens driver.
>> >
>> > Cc: Amit Kucheria <amitk@kernel.org>
>> > Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> > Cc: linux-pm@vger.kernel.org
>> > Cc: linux-arm-msm@vger.kernel.org
>> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > ---
>> Hi, I think this should be also checked and applied on init. This
>> seems required for at least SM6375, as the controller starts (or
>> well, doesn't start...) in an unknown state and the driver does
>> not like it, as the TSENS_EN indicates it is disabled.
>> Downstream runs this right at probe..
> 
> Hmm.. very interesting. I was not aware of the SM6375 case, as for SM8150
> the controller starts in a valid state but may require reinit during operation.
> 
> So, I did not use the downstream approach to do it right at _probe() and then
> later while get_temp() is called.
> 
> Let me add that in v2. BTW do you want me to set the need_reinit_wa as true
> for SM6375 as well, or would you like to add that with a followup-patch ?
Please set it, I'll happily test it!

Konrad
> 
> Regards,
> Bhupesh
