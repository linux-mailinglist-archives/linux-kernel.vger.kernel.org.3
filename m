Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698444946CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358585AbiATFXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:23:47 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:29664 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234514AbiATFXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:23:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1642656225; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vEiCXHErX20m/K0YBx8lGnkGsE7rCgRUytoX0CrA3Qk=;
 b=Q9V5SMBH4RJpcY/kieguRN3peC4hBRR0YEZGdqUWqF47PyvJ5qipgFl1S/rEx23QMO2xmTuU
 ptB4stATTl/gFGHxPGCH08OAzjQrBSF6JiyRsJudxxgzWaKG2Q66ES0upDzh33pnD2g2A1eE
 eHYKdZB8TWKSy63LwZH6yDkigzE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61e8f1dfe0071250cfff8890 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Jan 2022 05:23:43
 GMT
Sender: kathirav=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C8DEC4360D; Thu, 20 Jan 2022 05:23:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 073CEC4338F;
        Thu, 20 Jan 2022 05:23:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Jan 2022 10:53:41 +0530
From:   Kathiravan T <kathirav@codeaurora.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
In-Reply-To: <87ee53fv01.fsf@tarshish>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <87ee53fv01.fsf@tarshish>
Message-ID: <1965fc315525b8ab26cf9f71f939c24d@codeaurora.org>
X-Sender: kathirav@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-19 23:44, Baruch Siach wrote:
> Hi Sean,
> 
> On Tue, Jan 18 2022, Sean Anderson wrote:
>> This is a rework of patches 3-5 of [1]. It attempts to correctly 
>> program
>> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. 
>> Since
>> we no longer need a special property duplicating this configuration,
>> snps,ref-clock-period-ns is deprecated.
>> 
>> Please test this! Patches 3/4 in this series have the effect of
>> programming REFCLKPER and REFCLK_FLADJ on boards which already 
>> configure
>> the "ref" clock. I have build tested, but not much else.
> 
> Tested here on IPQ6010 based system. USB still works. But the with 
> "ref"
> clock at 24MHz, period is calculated as 0x29. Previous
> snps,ref-clock-period-ns value used to be 0x32.
> 
> Is that expected?
> 
> Thanks,
> baruch
> 


Hi Baruch,

Yes, it is 0x29 for IPQ60xx based SoCs. In downstream it was wrongly 
mentioned as 0x32, which was corrected recently.

Thanks,
Kathiravan T.

>> 
>> [1] 
>> https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/
>> 
>> Changes in v2:
>> - Document clock members
>> - Also program GFLADJ.240MHZDECR
>> - Don't program GFLADJ if the version is < 2.50a
>> - Add snps,ref-clock-frequency-hz property for ACPI
>> 
>> Sean Anderson (7):
>>   dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
>>   usb: dwc3: Get clocks individually
>>   usb: dwc3: Calculate REFCLKPER based on reference clock
>>   usb: dwc3: Program GFLADJ
>>   usb: dwc3: Add snps,ref-clock-frequency-hz property for ACPI
>>   arm64: dts: zynqmp: Move USB clocks to dwc3 node
>>   arm64: dts: ipq6018: Use reference clock to set dwc3 period
>> 
>>  .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +-
>>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   3 +-
>>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   4 +-
>>  drivers/usb/dwc3/core.c                       | 112 
>> +++++++++++++++---
>>  drivers/usb/dwc3/core.h                       |  17 ++-
>>  6 files changed, 120 insertions(+), 27 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
