Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A84C2643
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiBXIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiBXIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:30:30 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4027B99B;
        Thu, 24 Feb 2022 00:29:37 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21O3wL0S007085;
        Thu, 24 Feb 2022 09:29:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5vxBlUo7IqSUsV8ak9FdX0a2AbnJY1ZznkqgwSpJMok=;
 b=FD2xbYxeUb94ev/5iLRiUuaKg3IftMpVAhgnSJ1kEA928Ejy973Z8e9Aw1z8jsPLrlUK
 La5oI0Nup18Olsc1hAJrJKWg/tsF9zaMXuwo/GU+S9zs/bPa3YSr5zGY1pGlDWDuMKfO
 Bcs3beuVlZP7PfY3rHOwhghrQcaEEpnub53W0e9D0wmwdIoLaqjw/3knqI0r85+WbMkt
 0fAkJxScOWhpZGT1dt99SJ8S4LMr0hU6rlAqk5smlAajQYYlsoEXX7wn5dRsA1xvRMDE
 00LbEoJqV2Sh/JwXmXSr7Eh8+S2g7KHil6fbZXDgU8HuBo4GvlQEysEkrPcKhvMfGblB dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3edfyaft40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 09:29:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8FCA010002A;
        Thu, 24 Feb 2022 09:29:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 87A2F216EDD;
        Thu, 24 Feb 2022 09:29:26 +0100 (CET)
Received: from [10.201.20.246] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 24 Feb
 2022 09:29:25 +0100
Message-ID: <670ee336-9ad4-401e-e3b2-02531e975e51@foss.st.com>
Date:   Thu, 24 Feb 2022 09:29:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 00/11] Restructure the rpmsg_char driver and introduce
 rpmsg_ctrl driver
Content-Language: en-US
To:     Philipp Rossak <embed3d@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
 <ab97c2a5-7705-eae8-9bc2-908e7a9cb709@gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <ab97c2a5-7705-eae8-9bc2-908e7a9cb709@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 2/23/22 22:28, Philipp Rossak wrote:
> Hi Arnaud,
> 
> thanks for working on this! I'm currently testing/using this patch
> series on my imx7d project because it adds the capability that the
> remote processor can register it's endpoints dynamically (as mentioned
> in the objectives).

Thanks for your feedback on this work! 
Don't hesitate to add your tested-by, this help maintainers for the reviews. 

> 
> After a few tests, debugging, and checking the openamp specification [1]
> I think that you missed the second ns_announcement that should be sent
> from linux master to the slave after it created the channel/endpoint.
> Without this second announcement the remote processor is not able to
> send messages to the linux master because it doesn't know the
> destination address until it receives a message from the linux master.

Yes I detected this issues, it is not related to the series
but to the remoteproc_virtio backend.

As you mentioned, after the ns announcement from Linux, the remote processor
send first messages. But the Linux virtio does not do the match between the
local channel created and the remote endpoint.

This is a feature that is missing in the rpmsg virtio, and perhaps in rpmsg protocol
itself (a ns annoucement ack message or something similar).


A fix for the remoteproc virtio is available here:
https://github.com/arnopo/meta-st-stm32mp-oss/commit/3e57fe73bd19c9bb835ac5a118e50727758b0b96

Don't hesitate to give me feedback on the fix, if you test it.

I plan to propose the fix after this series.    

Thanks,
Arnaud

> 
> Cheers,
> Philipp
> 
> 
> [1]:
> https://github.com/OpenAMP/open-amp/blob/main/docs/img/coprocessor-rpmsg-ns.png
> 
> 
> On 24.01.22 11:25, Arnaud Pouliquen wrote:
>> Updates from V8 [1]:
>> - rebase on 5.17-rc1 + rpmsg char cdev release fixes[2][3]
>> - updates based on Bjorn Andersson's comments:
>>    - remove rpmsg_create_default_ept API, set directly the ept->priv
>> in rpmsg_chrdev_probe
>>      function.
>>    - rework commit message in [8/9]rpmsg: char: Introduce the
>> "rpmsg-raw" channel
>>
>> Patchset description:
>>
>> The current rpmsg_char module implements a /dev/rpmsg_ctrl interface
>> that provides the ability to
>> instantiate char devices (/dev/rpmsgX) associated with an rpmsg
>> endpoint for communication with the
>> remote processor.
>> This implementation fits with QCOM rpmsg backend but not with the
>> magement by chanel implemented
>> in the generic rpmsg virtio backend.
>> This series restructures the rpmsg_char driver to decorrelate the
>> control part from the data part
>> in order to improve its compatible with the rpmsg virtio backend.
>>
>> Objective:
>> - Expose a /dev/rpmsg_ctrlX interface for the application that is no
>> longer dedicated to the
>>    rpmsg_char but generalized to all rpmsg services. This offers
>> capability to create and destroy
>>    rpmsg channels from a user's application initiative (using the new
>> RPMSG_CREATE_DEV_IOCTL and
>>    RPMSG_DESTROY_DEV_IOCTL controls).
>>    An application will be able to create/establish an rpmsg
>> communication channel to communicate
>>    with the remote processor, and not only wait the remote processor
>> initiative.
>>    This is interesting for example to establish a temporary
>> communication link for diagnosis,
>>    calibration, debugging... or instantiate  new data flows on some
>> user actions.
>> - Add capability to probe the rpmsg_char device at the initiative of
>> the remote processor
>>   (rpmsg service announcement mechanism).
>>    This allows platforms based on the rpmsg virtio backend to create
>> the /dev/rpmgX interface with
>>    a rpmsg name service announcement.
>>
>> Subsets:
>>    - Extract the control part of the char dev and create the
>> rpmsg_ctrl.c file (patches 1 to 6)
>>    - Introduce the "rpmsg-raw" channel in rpmsg_char(patches 7 to 10)
>>    - Introduce the RPMSG_CREATE_DEV_IOCTL IOCTL and
>> RPMSG_DESTROY_DEV_IOCTL to instantiate RPMsg
>>      devices (patch 11)
>>      The application can then create or release a channel by specifying:
>>         - the name service of the device to instantiate.
>>         - the source address.
>>         - the destination address.
>>
>> This series has be applied and tested on 'commit e783362eb54c ("Linux
>> 5.17-rc1") +
>> rpmsg_char cdev release fixes [2][3]
>>
>> [1] https://lkml.org/lkml/2021/12/7/186
>> [2] https://lkml.org/lkml/2022/1/10/1129
>> [3] https://lkml.org/lkml/2022/1/10/1130
>>
>> Arnaud Pouliquen (11):
>>    rpmsg: char: Export eptdev create and destroy functions
>>    rpmsg: Create the rpmsg class in core instead of in rpmsg char
>>    rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
>>    arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
>>    RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
>>    arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
>>    rpmsg: Update rpmsg_chrdev_register_device function
>>    rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
>>    rpmsg: char: Add possibility to use default endpoint of the rpmsg
>>      device
>>    rpmsg: char: Introduce the "rpmsg-raw" channel
>>    rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls
>>
>>   arch/arm/configs/qcom_defconfig   |   1 +
>>   arch/arm64/configs/defconfig      |   1 +
>>   arch/riscv/configs/defconfig      |   1 +
>>   arch/riscv/configs/rv32_defconfig |   1 +
>>   drivers/rpmsg/Kconfig             |   8 +
>>   drivers/rpmsg/Makefile            |   1 +
>>   drivers/rpmsg/qcom_glink_native.c |   2 +-
>>   drivers/rpmsg/qcom_smd.c          |   2 +-
>>   drivers/rpmsg/rpmsg_char.c        | 231 +++++++++++-----------------
>>   drivers/rpmsg/rpmsg_char.h        |  46 ++++++
>>   drivers/rpmsg/rpmsg_core.c        |  15 +-
>>   drivers/rpmsg/rpmsg_ctrl.c        | 243 ++++++++++++++++++++++++++++++
>>   drivers/rpmsg/rpmsg_internal.h    |  10 +-
>>   drivers/rpmsg/virtio_rpmsg_bus.c  |   2 +-
>>   include/uapi/linux/rpmsg.h        |  10 ++
>>   15 files changed, 419 insertions(+), 155 deletions(-)
>>   create mode 100644 drivers/rpmsg/rpmsg_char.h
>>   create mode 100644 drivers/rpmsg/rpmsg_ctrl.c
>>
