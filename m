Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8146DFDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbhLIBA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:00:29 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:60807 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241653AbhLIBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639011416; x=1670547416;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FX9/wHW1UB7swkH9l1Uv95qLCO4JveIAMi+icxTjyrs=;
  b=tBbGxJDkbsOsTwaFDD6e86YD0/Cu3xGUCZKbEvzGdy97FbyglL6rPtxx
   3aoIGqEo5VL9ZtPF3dMSmCT1eRIkiwGw8O6jfdUFWQTO3LmLkE8jriDe1
   v6RuGUZF5t3aAgm9VJOQn38m6hliJyphBO4kSczHnfRxhwcPvFhlJnrW9
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Dec 2021 16:56:55 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:56:55 -0800
Received: from [10.46.160.247] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 8 Dec 2021
 16:56:50 -0800
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
To:     Mark Brown <broonie@kernel.org>,
        "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, <swboyd@chromium.org>,
        <subbaram@codeaurora.org>, Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
 <Ya5VhkggWdjYyTHL@sirena.org.uk>
 <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
 <Ya97cnuwM+MuNMg3@sirena.org.uk>
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <23a47965-4ea9-5f6c-7e3c-27f5bd35f5b7@quicinc.com>
Date:   Wed, 8 Dec 2021 16:56:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya97cnuwM+MuNMg3@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 7:19 AM, Mark Brown wrote:
> On Tue, Dec 07, 2021 at 08:36:11PM +0530, Satya Priya Kakitapalli (Temp) wrote:
>> On 12/6/2021 11:55 PM, Mark Brown wrote:
>>> On Mon, Dec 06, 2021 at 06:33:26PM +0530, Satya Priya Kakitapalli (Temp) wrote:
> 
>>>> The min-dropout value (headroom) varies with boards, that's why we have a DT
>>>> property for it. We overwrite the default value in driver with actual value
>>>> read from DT
> 
>>> Interesting.  How exactly does that end up happening - presumably other
>>> systems are going to run into it?
> 
>> The parent supplies such as "vdd-l1-l2" are coming from other pmic
>> regulators, which are shared supplies with other subsystems like BT, Display
>> etc, they vary between boards as per requirements, so we cannot expect these
>> to be fixed and so are the headroom values. We get the headroom values from
>> PMIC systems team for every target.
> 
> I don't think you're talking about the thing the code is saying it's
> describing here.  The regulator API is referring to the minimum droput
> voltage that individual regulators require, that is how much higher the
> input to a single regulator must be than the voltage being output by
> that regulator.  We absolutely can and do expect this to be board
> independent, it's a function of the design of the regulator.  Sharing
> the input supply has no impact on this, the input voltage that the
> regulator needs just get fed into the requiremnts on the supply voltage.
> 
> If there is a board specific constraint on the minimum voltage that a
> given supply can have then that should be expressed using the normal
> constraint mechanism, that's nothing to do with the headroom that the
> regulators require to operate though.

The PM8008 LDOs are low noise LDOs intended to supply noise sensitive
camera sensor hardware.  They can maintain output regulation with a
fixed headroom voltage.  However, in order to guarantee high PSRR, the
headroom voltage must be scaled according to the peak load expected from
the each LDO on a given board.  Thus, we included support for a DT
property to specify the headroom per LDO to meet noise requirements
across boards.

As a minor note the PM8008 chip package has a single pin to supply LDOs
1 and 2 along with a single pin for LDOs 3 and 4.  That is why
vdd_l1_l2-supply is specified instead of vdd_l1-supply and vdd_l2-supply.

Take care,
David
