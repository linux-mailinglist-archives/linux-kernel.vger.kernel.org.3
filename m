Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851834E79A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358673AbiCYRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiCYRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:06:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F187B517E6;
        Fri, 25 Mar 2022 10:05:10 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PEssZE032579;
        Fri, 25 Mar 2022 18:05:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=DJi9HcvZ6/ywVJhIg23NRJP5gxywHph1bbVvdHUxw0Q=;
 b=G0us+UpvHqF67kwM2X1vH2R7GbL0F3TfNzVFgLRswWe6sx19h34Ce0PM2/hATVLhLkU9
 Hvm8Qvf5mwvV7fE9mf12IST4wq0sbrqvE64aj8DDA196OAK3BvWPgqsAaC/k7BSvXw+6
 E8gtcDQBOxaZ+9jdfvxQctplvoYwKo2BQED0PaA8UqYLximiDGak96OF3CdFDVzt0HlY
 D37rOori42770oMxHFhYWE+iW75W8ctjxzNtn2UarBrpoozDQ/PKca5grUD9JWy7BOK5
 v7oBDt5g7IrKkic5a5odtXzpzTLzMW1wKWZhmXLTOlKKP5X2nDBgXsbHYMzXQVeuH+vn Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ew5fpy37d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 18:05:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D39110002A;
        Fri, 25 Mar 2022 18:05:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79FF322F7AA;
        Fri, 25 Mar 2022 18:05:05 +0100 (CET)
Received: from [10.211.6.122] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Mar
 2022 18:05:04 +0100
Message-ID: <999a0caf-0c27-d894-63a6-9708c9221433@foss.st.com>
Date:   Fri, 25 Mar 2022 18:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 00/11] Restructure the rpmsg_char driver and introduce
 rpmsg_ctrl driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <julien.massot@iot.bzh>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
 <239eeeea-af04-7163-61ca-436c6632c2a8@foss.st.com>
 <20220325155949.GA3576184@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220325155949.GA3576184@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_05,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/22 16:59, Mathieu Poirier wrote:
> On Thu, Mar 24, 2022 at 06:36:23PM +0100, Arnaud POULIQUEN wrote:
>> Hi Bjorn,
>>
>> On 1/24/22 11:25, Arnaud Pouliquen wrote:
>>> Updates from V8 [1]:
>>> - rebase on 5.17-rc1 + rpmsg char cdev release fixes[2][3]
>>> - updates based on Bjorn Andersson's comments:
>>>   - remove rpmsg_create_default_ept API, set directly the ept->priv in rpmsg_chrdev_probe
>>>     function.
>>>   - rework commit message in [8/9]rpmsg: char: Introduce the "rpmsg-raw" channel
>>>
>>> Patchset description:
>>>
>>> The current rpmsg_char module implements a /dev/rpmsg_ctrl interface that provides the ability to
>>> instantiate char devices (/dev/rpmsgX) associated with an rpmsg endpoint for communication with the
>>> remote processor.
>>> This implementation fits with QCOM rpmsg backend but not with the magement by chanel implemented
>>> in the generic rpmsg virtio backend.
>>> This series restructures the rpmsg_char driver to decorrelate the control part from the data part
>>> in order to improve its compatible with the rpmsg virtio backend.
>>>
>>> Objective:
>>> - Expose a /dev/rpmsg_ctrlX interface for the application that is no longer dedicated to the
>>>   rpmsg_char but generalized to all rpmsg services. This offers capability to create and destroy
>>>   rpmsg channels from a user's application initiative (using the new RPMSG_CREATE_DEV_IOCTL and
>>>   RPMSG_DESTROY_DEV_IOCTL controls).
>>>   An application will be able to create/establish an rpmsg communication channel to communicate
>>>   with the remote processor, and not only wait the remote processor initiative.
>>>   This is interesting for example to establish a temporary communication link for diagnosis,
>>>   calibration, debugging... or instantiate  new data flows on some user actions.
>>> - Add capability to probe the rpmsg_char device at the initiative of the remote processor
>>>  (rpmsg service announcement mechanism).
>>>   This allows platforms based on the rpmsg virtio backend to create the /dev/rpmgX interface with
>>>   a rpmsg name service announcement.
>>>
>>> Subsets:
>>>   - Extract the control part of the char dev and create the rpmsg_ctrl.c file (patches 1 to 6)
>>>   - Introduce the "rpmsg-raw" channel in rpmsg_char(patches 7 to 10)
>>>   - Introduce the RPMSG_CREATE_DEV_IOCTL IOCTL and RPMSG_DESTROY_DEV_IOCTL to instantiate RPMsg
>>>     devices (patch 11)
>>>     The application can then create or release a channel by specifying:
>>>        - the name service of the device to instantiate.   
>>>        - the source address.
>>>        - the destination address.
>>>
>>> This series has be applied and tested on 'commit e783362eb54c ("Linux 5.17-rc1") +
>>> rpmsg_char cdev release fixes [2][3]
>>>
>>> [1] https://lkml.org/lkml/2021/12/7/186
>>> [2] https://lkml.org/lkml/2022/1/10/1129
>>> [3] https://lkml.org/lkml/2022/1/10/1130
>>>
>>> Arnaud Pouliquen (11):
>>>   rpmsg: char: Export eptdev create and destroy functions
>>>   rpmsg: Create the rpmsg class in core instead of in rpmsg char
>>>   rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
>>
>>
>>>   arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
>>>   RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
>>>   arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
>>
>> Thank you for merging this series!
>>
>> I can't see in the "for next" branch[1] the 3 patches above that update configs
>> Are you expecting a specific action from me?   
> 
> Those patches will need to go through the Arm, RISC-V and arm64 subsystems.  The
> mailing list for those subsystems has been CC'ed but that isn't enough to get
> the maintainers' attention.  
> 
> I suggest sending another patchset with those 3 patches that CC the maintainers
> directly.  For the Arm patch I suggest adding Linus Walleij.

I will do what you suggest. 

My concerns in this case is about the scheduling of the integration.
I suppose that sending a second patchset for configs requests that the
rpmsg char series is first applied
But on the other hand this may lead to some failures as the RPMSG_CTRL is now
needed to create the /dev/rpmsg_ctrl0

so probably, I need to do this as fixup patch.

FYI the RISC-V patch as been reviewed by Anup Patel

Thanks,
Arnaud

> 
> Thanks,
> Mathieu
> 
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
>>
>> Regards,
>> Arnaud
>>
>>>   rpmsg: Update rpmsg_chrdev_register_device function
>>>   rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
>>>   rpmsg: char: Add possibility to use default endpoint of the rpmsg
>>>     device
>>>   rpmsg: char: Introduce the "rpmsg-raw" channel
>>>   rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls
>>>
>>>  arch/arm/configs/qcom_defconfig   |   1 +
>>>  arch/arm64/configs/defconfig      |   1 +
>>>  arch/riscv/configs/defconfig      |   1 +
>>>  arch/riscv/configs/rv32_defconfig |   1 +
>>>  drivers/rpmsg/Kconfig             |   8 +
>>>  drivers/rpmsg/Makefile            |   1 +
>>>  drivers/rpmsg/qcom_glink_native.c |   2 +-
>>>  drivers/rpmsg/qcom_smd.c          |   2 +-
>>>  drivers/rpmsg/rpmsg_char.c        | 231 +++++++++++-----------------
>>>  drivers/rpmsg/rpmsg_char.h        |  46 ++++++
>>>  drivers/rpmsg/rpmsg_core.c        |  15 +-
>>>  drivers/rpmsg/rpmsg_ctrl.c        | 243 ++++++++++++++++++++++++++++++
>>>  drivers/rpmsg/rpmsg_internal.h    |  10 +-
>>>  drivers/rpmsg/virtio_rpmsg_bus.c  |   2 +-
>>>  include/uapi/linux/rpmsg.h        |  10 ++
>>>  15 files changed, 419 insertions(+), 155 deletions(-)
>>>  create mode 100644 drivers/rpmsg/rpmsg_char.h
>>>  create mode 100644 drivers/rpmsg/rpmsg_ctrl.c
>>>
