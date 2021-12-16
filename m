Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA18477657
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhLPPsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbhLPPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:48:19 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE266C061746
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:48:18 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a11so23645433qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wfctcVVlvOvt9f1b90AP0qfvEFDdPLvVlI6Ah6jwx70=;
        b=nz+YfyYL/oKEUv6MGMhq48iP1tS+LAiivJDAKUSh6DCSztPVdwtakPs+dk6kI8kwXi
         umC+nf/N8aa02kZDvJM2cc7kryknVQiS0wR9S9W4auSsoZut5oz7iEQ0BMIsjcTYUJ3s
         /fKRpDet8gk+2Rzy6S7Sv6/FneaoSZ5K+vM28zcEix+RK6fLTsVCqJbZMcTFP1tFvjic
         U6Bb+X8r/vPD0udjssleEx66rz+vpzrYkZu1y9Zx7EfprcR/7mrUnor+HTmd7/QMdzoy
         9gPFOo/Dc11iyDI2WOMKK0mgPFllwkoy6FhEwhPfx3zLjtPdQSe1Si9pzl+XTYCUPbc6
         YmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wfctcVVlvOvt9f1b90AP0qfvEFDdPLvVlI6Ah6jwx70=;
        b=D1TsYLRPvLl7RXck1PXSgRiBhn8KIGc8YDJJx9rfbPYyn5N8dNe9tnmxaDUenrTWhB
         PoU1RMGjKeyiaRQ5r56o705oiBVmiNjfp08J1gyAo2hTtjSgVJNf/iRLlte2VZmXuGUS
         jiOITuymnAwpGW7XU5jMc/9Zi1GX1r1ciXIE9HyEeowky/WDoj/IK51QWRSw2wBrCAl/
         Z3Bl7iwkBXJDDCphEgPXGAglgoEt/7IweGg/Scc4ECuBNMmZxssQDq/nGMbAZiU303cn
         GjeU5LYGexOtJFPi1YFHX8wdGwPb0vutaX80m5VHIXNml9QmS6XyAwc2pBSyjmiZFoJF
         wqcQ==
X-Gm-Message-State: AOAM530e3fIoSgOQ2/WhGrddvi4kWGzzrLnhRZep06+7MA/M27f2imvm
        0in/8wYqnlatA5SF895OkmHGtGpHibVNCA==
X-Google-Smtp-Source: ABdhPJxTINUKnk11z7iqvevHHCAiRCPQVxS5oCLArk9MrxP7ubV5CKOXP13GS/LifdMmEdi71/jH/w==
X-Received: by 2002:a37:410:: with SMTP id 16mr12574934qke.672.1639669697790;
        Thu, 16 Dec 2021 07:48:17 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id bj32sm2958975qkb.75.2021.12.16.07.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:48:17 -0800 (PST)
Subject: Re: [PATCH V6 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
To:     Souradeep Chowdhury <schowdhu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org
References: <cover.1628617260.git.schowdhu@codeaurora.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <396edd95-4f38-6830-99da-11e73d62a0cf@linaro.org>
Date:   Thu, 16 Dec 2021 10:48:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1628617260.git.schowdhu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 1:54 PM, Souradeep Chowdhury wrote:
> DCC(Data Capture and Compare) is a DMA engine designed for debugging purposes.In case of a system
> crash or manual software triggers by the user the DCC hardware stores the value at the register
> addresses which can be used for debugging purposes.The DCC driver provides the user with sysfs
> interface to configure the register addresses.The options that the DCC hardware provides include
> reading from registers,writing to registers,first reading and then writing to registers and looping
> through the values of the same register.
> 
> In certain cases a register write needs to be executed for accessing the rest of the registers,
> also the user might want to record the changing values of a register with time for which he has the
> option to use the loop feature.

Hello Souradeep,

First of all, I think this is very a useful feature to have. I have some 
generic design related queries/comments on driver and the interface 
exposed to the user space. Also, I do not understand the h/w well here, 
so feel free to correct me if I am wrong.

1. Linked list looks like a very internal feature to the h/w. It really 
is not an info that user should be aware of. I tried reading the code a 
bit. IUC, every time a s/w trigger is issued the configs in all the 
enabled linked lists are executed. The final ram dump that you get from 
/dev/dcc_sram is a dump of contents from all the enabled list? Is this 
understanding correct ? And we are talking of at-most 4 linked list?
If yes, I think it might be better to have a folder per linked list with 
config, config_write etc. Also if possible it will be better to dump the 
results to a file in the specific folder instead of reading from 
/dev/dcc_sram.
If no, there is no real need for user to know the linked list, right? 
Choosing of linked list can be done by kernel driver in this case with 
no input needed from user.

2. Now to the sysfs interface itself, I know lot of thought has gone 
into sysfs vs debugfs considerations. But, have you considered using 
netlink interface instead of sysfs. Netlink interface is used for 
asynchronous communication between kernel and user space. In case of 
DCC, the communication appears to be asynchronous, where in user asks 
the kernel to capture some info and kernel can indicate back to user 
when the info is captured. Also the entire mess surrounding echoing addr 
/ value / offset repeatedly into a sysfs entry can be avoided using 
netlink interface.

-- 
Warm Regards
Thara (She/Her/Hers)
> 
> The options mentioned above are exposed to the user by sysfs files once the driver is probed.The
> details and usage of this sysfs files are documented in Documentation/ABI/testing/sysfs-driver-dcc.
> 
> As an example let us consider a couple of debug scenarios where DCC has been proved to be effective
> for debugging purposes:-
> 
> i)TimeStamp Related Issue
> 
> On SC7180, there was a coresight timestamp issue where it would occasionally be all 0 instead of proper
> timestamp values.
> 
> Proper timestamp:
> Idx:3373; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x13004d8f5b7aa; CC=0x9e
> 
> Zero timestamp:
> Idx:3387; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x0; CC=0xa2
> 
> Now this is a non-fatal issue and doesn't need a system reset, but still needs
> to be rootcaused and fixed for those who do care about coresight etm traces.
> Since this is a timestamp issue, we would be looking for any timestamp related
> clocks and such.
> 
> o we get all the clk register details from IP documentation and configure it
> via DCC config syfs node. Before that we set the current linked list.
> 
> /* Set the current linked list */
> echo 3 > /sys/bus/platform/devices/10a2000.dcc/	
> 
> /* Program the linked list with the addresses */
> echo 0x10c004 > /sys/bus/platform/devices/10a2000.dcc/config
> echo 0x10c008 > /sys/bus/platform/devices/10a2000.dcc/config
> echo 0x10c00c > /sys/bus/platform/devices/10a2000.dcc/config
> echo 0x10c010 > /sys/bus/platform/devices/10a2000.dcc/config
> ..... and so on for other timestamp related clk registers
> 
> /* Other way of specifying is in "addr len" pair, in below case it
> specifies to capture 4 words starting 0x10C004 */
> 
> echo 0x10C004 4 > /sys/bus/platform/devices/10a2000.dcc/config
> 
> /* Enable DCC */
> echo 1 > /sys/bus/platform/devices/10a2000.dcc/enable
> 
> /* Run the timestamp test for working case */
> 
> /* Send SW trigger */
> echo 1 > /sys/bus/platform/devices/10a2000.dcc/trigger
> 
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram1.bin
> 
> /* Run the timestamp test for non-working case */
> 
> /* Send SW trigger */
> echo 1 > /sys/bus/platform/devices/10a2000.dcc/trigger
> 
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram2.bin
> 
> Get the parser from [1] and checkout the latest branch.
> 
> /* Parse the SRAM bin */
> python dcc_parser.py -s dcc_sram1.bin --v2 -o output/
> python dcc_parser.py -s dcc_sram2.bin --v2 -o output/
> 
> Sample parsed output of dcc_sram1.bin:
> 
> <hwioDump version="1">
>          <timestamp>03/14/21</timestamp>
>              <generator>Linux DCC Parser</generator>
>                  <chip name="None" version="None">
>                  <register address="0x0010c004" value="0x80000000" />
>                  <register address="0x0010c008" value="0x00000008" />
>                  <register address="0x0010c00c" value="0x80004220" />
>                  <register address="0x0010c010" value="0x80000000" />
>              </chip>
>      <next_ll_offset>next_ll_offset : 0x1c </next_ll_offset>
> </hwioDump>
> 
> ii)NOC register errors
> 
> A particular class of registers called NOC which are functional registers was reporting
> errors while logging the values.To trace these errors the DCC has been used effectively.
> The steps followed were similar to the ones mentioned above.
> In addition to NOC registers a few other dependent registers were configured in DCC to
> monitor it's values during a crash. A look at the dependent register values revealed that
> the crash was happening due to a secured access to one of these dependent registers.
> All these debugging activity and finding the root cause was achieved using DCC.
> 
> DCC parser is available at the following open source location
> 
> https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/dcc_parser
> 
> Changes in v6:
> 
> *Added support in the dcc driver to handle multiple Qualcomm SoCs including SC7180,SC7280,SDM845
>   along with existing SM8150.
>   
> *Added the support node in the respective device tree files for SC7180,SC7280,SDM845.
> 
> Souradeep Chowdhury (7):
>    dt-bindings: Added the yaml bindings for DCC
>    soc: qcom: dcc:Add driver support for Data Capture and Compare
>      unit(DCC)
>    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>      support
>    arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support
>      node
> 
>   Documentation/ABI/testing/sysfs-driver-dcc         |  114 ++
>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      |   43 +
>   MAINTAINERS                                        |    8 +
>   arch/arm64/boot/dts/qcom/sc7180.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sm8150.dtsi               |    6 +
>   drivers/soc/qcom/Kconfig                           |    8 +
>   drivers/soc/qcom/Makefile                          |    1 +
>   drivers/soc/qcom/dcc.c                             | 1549 ++++++++++++++++++++
>   10 files changed, 1747 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc
>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>   create mode 100644 drivers/soc/qcom/dcc.c
> 

