Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003E356ABCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiGGTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGGTYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:24:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD0117A97;
        Thu,  7 Jul 2022 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657221892; x=1688757892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ORdQBw6sZ68sMUr9383tBJmurYYF7UyCB1v1Uwl5lU=;
  b=pgZ0A11IwyvKPbz5Rmtd2O6vITx51G4gEcsMzNmGvKigfH9winz9KlUk
   8WzuZx/pHK+PvTWabdMWVrS/BO3xVjpswsJvkCluZenaPvAro4shFWOtt
   yZS1ebI8eCIdDkiZb1mRlT6dOfZaWOm6NBZhEkIXar9pkidsQv2jB7rW6
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Jul 2022 12:24:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 12:24:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 12:24:51 -0700
Received: from [10.216.25.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 12:24:46 -0700
Message-ID: <cdf2b538-1cc2-d163-7cc3-f92d8433087a@quicinc.com>
Date:   Fri, 8 Jul 2022 00:54:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Stephen Boyd" <swboyd@chromium.org>
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
 <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=XCgsyTRT-T5jKN6c7tJ=du8gbpkMccm2VZpz+TFWyLsw@mail.gmail.com>
 <BL0PR02MB45643EEB3C1571E0F2364B8FFABE9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=Up_NNd5RNJ+xLrPOHfPb_YG1ut=BjU=O2yP8w2hG9Ugw@mail.gmail.com>
 <69e3fec3-bd49-8877-f1f8-453b09b8c940@quicinc.com>
 <CAD=FV=VhA=iGnip_DOdNOZn_mjqgC=37o4tWFQXNpTAqf=09sA@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=VhA=iGnip_DOdNOZn_mjqgC=37o4tWFQXNpTAqf=09sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 7/6/2022 11:51 PM, Doug Anderson wrote:
> Hi,
>
> On Wed, Jul 6, 2022 at 10:44 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Hi,
>>
>>
>> On 7/6/2022 8:56 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Jul 4, 2022 at 11:57 AM Vijaya Krishna Nivarthi (Temp)
>>> <vnivarth@qti.qualcomm.com> wrote:
>>>> Hi,
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Doug Anderson <dianders@chromium.org>
>>>>> Sent: Friday, July 1, 2022 8:38 PM
>>>>> To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
>>>>> Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Konrad
>>>>> Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-arm-
>>>>> msm <linux-arm-msm@vger.kernel.org>; linux-serial@vger.kernel.org; LKML
>>>>> <linux-kernel@vger.kernel.org>; Mukesh Savaliya (QUIC)
>>>>> <quic_msavaliy@quicinc.com>; Matthias Kaehlcke <mka@chromium.org>;
>>>>> Stephen Boyd <swboyd@chromium.org>
>>>>> Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
>>>>> otherwise could return a sub-optimal clock rate.
>>>>>
>>>>> WARNING: This email originated from outside of Qualcomm. Please be wary
>>>>> of any links or attachments, and do not enable macros.
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Fri, Jul 1, 2022 at 4:04 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
>>>>> <quic_vnivarth@quicinc.com> wrote:
>>>>>
> Ah, you are correct. So just:
>
> div = DIV_ROUND_UP(freq, desired_clk);
>
> ...because freq _has_ to be greater than mult. If it was < "mult -
> offset" we would have ended the loop. If it was between "mult -
> offset" and "mult + offset" (inclusive) then we would have success. So
> freq must be > "mult + offset" at the end of the loop.
>
> -Doug


Thank you, uploaded V3.


