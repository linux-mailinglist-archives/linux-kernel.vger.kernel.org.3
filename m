Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CCE4B6A67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiBOLMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiBOLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:12:05 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D463107DBE;
        Tue, 15 Feb 2022 03:11:54 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21F9Bucp025990;
        Tue, 15 Feb 2022 12:11:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=on4k+60RiSNwLWTdRuXuMFB/7V82oPjCfha0VCpeuH4=;
 b=5CUPCiDNY9q7t2d/i6z1C9lnGp9GYZsYAZzGt4o8+GkgRmivAiWekflryER54LrT0fan
 qk0vBMK/d4Ae1rHgUeuVrvyzf3Lvswc9rZza1XHXPcnr/CFi42ebyzJdLMnFYtUWsGtL
 rADFSvXMz6Ja0qabzcucj7VYh06GZKu7wX3zE6oXv3GtwLerQimbn2w0GqJsBNwNsP12
 sB2CN960JnlPznH2g5BgPTuIgTpZZfFL9CtmF+MAjIwmcVjwAW8AMqtu6kdCjLCcj8yt
 HKhUyIQPE06qSYDOBJmo8vxPW0fvZA2SwgdZQcTV6iLiOLDlBB9p+CpZtMUSeUgmq/W0 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e89b5grs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 12:11:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DAFF1100038;
        Tue, 15 Feb 2022 12:11:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD95521E691;
        Tue, 15 Feb 2022 12:11:37 +0100 (CET)
Received: from [10.211.1.48] (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Feb
 2022 12:11:37 +0100
Message-ID: <b483084b-59ab-4821-8079-4999236aec9d@foss.st.com>
Date:   Tue, 15 Feb 2022 12:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
References: <20220126162405.1131323-1-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB941722D995004F877DC6171D88349@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <DU0PR04MB941722D995004F877DC6171D88349@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/22 09:34, Peng Fan wrote:
>> Subject: [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc VirtIO
>> device
>>
>> Update from V2 [1]:
>> In order to better handle error cases and to have something more
>> symmetrical between the functions in charge of rvdev initialization/deletion,
>> the patchset has been reworked.
>>  - Introduction in the first patch, of rproc_vdev_data structure which allows
>> to better
>>    decorrelate the rproc from the management of the rvdev structure. This
>> structure is reused
>>    in the last patch of the series for the creation of the remoteproc virtio
>> platform device.
>>  - In addition to the previous version, the management of the vring lifecycle
>> has been fully
>>    migrated to the remoteproc_virtio.c (rproc_parse_vring, rproc_alloc_vring,
>> rproc_free_vring)
>>
>> [1]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.or
>> g%2Flkml%2F2021%2F12%2F22%2F111&amp;data=04%7C01%7Cpeng.fan%4
>> 0nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C637788110748757786%7CUnknown%7CT
>> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
>> JXVCI6Mn0%3D%7C3000&amp;sdata=bFfSxpPMpPRGYcMBcwxaQ152mRzf3c
>> fwoFPjiJ0SIgw%3D&amp;reserved=0
>>
>> Patchset description:
>>
>> This series is a part of the work initiated a long time ago in the series
>> "remoteproc: Decorelate virtio from core"[2]
>>
>> Objective of the work:
>> - Update the remoteproc VirtIO device creation (use platform device)
>> - Allow to declare remoteproc VirtIO device in DT
> 
> This means not using resource table anymore with new approach?
> If yes, would that introduce a problem that different M-core images
> requires different dtb?

The resource table still exists. The main difference is that the virtio devices
would be predefined in the DT with their own resources ( memories , mailboxes,...)
No need to inherit from the rproc device.


On resource table parsing, the remoteproc looks first for pre registered 
rproc_virtio devices. If found then it uses it. Else it instantiates a new 
one (legacy method).  


> 
>>     - declare resources associated to a remote proc VirtIO
>>     - declare a list of VirtIO supported by the platform.
>> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
>>   For instance be able to declare a I2C device in a virtio-i2C node.
> 
> As my understanding virtio-i2c is a i2c bus, you could declare a i2c device
> in the virtual bus without your patchset, would you please share more?

Yes virtio-i2c is a bus, There is different methods to declare I2C device on
a bus[1].

In ST we rely on DT to statically declare an I2C device,as child of the I2C
adapter node.
I haven't implemented the virtio-I2C part yet, but it would make sense to have
such an implementation.

Which alternative have you in mind?  

[1] https://www.kernel.org/doc/html/latest/i2c/instantiating-devices.html

Thanks,
Arnaud

> 
> Thanks,
> Peng.
> 
>> - Keep the legacy working!
>> - Try to improve the picture about concerns reported by Christoph Hellwing
>> [3][4]
>>
>> [2]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.or
>> g%2Flkml%2F2020%2F4%2F16%2F1817&amp;data=04%7C01%7Cpeng.fan%4
>> 0nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C637788110748757786%7CUnknown%7CT
>> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
>> JXVCI6Mn0%3D%7C3000&amp;sdata=O2BZw5PCY19eD5xMGxrGUKC%2Fty1
>> Sdc3LE6rhK4cSXvs%3D&amp;reserved=0
>> [3]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.or
>> g%2Flkml%2F2021%2F6%2F23%2F607&amp;data=04%7C01%7Cpeng.fan%40
>> nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C686ea1d3bc2b4c6fa9
>> 2cd99c5c301635%7C0%7C0%7C637788110748757786%7CUnknown%7CTW
>> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
>> VCI6Mn0%3D%7C3000&amp;sdata=xqX50iDeL%2BtFBOgyADnEUE5HH4gogK
>> C0MwyqZSxVqNo%3D&amp;reserved=0
>> [4]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
>> work.kernel.org%2Fproject%2Flinux-remoteproc%2Fpatch%2FAOKowLclCbO
>> CKxyiJ71WeNyuAAj2q8EUtxrXbyky5E%40cp7-web-042.plabs.ch%2F&amp;da
>> ta=04%7C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e85
>> 5e2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748
>> 757786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
>> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=mvSm3wM
>> LgQ%2BDFhqjXIkG8de58zFjwPSURzw55JhGNaA%3D&amp;reserved=0
>>
>> In term of device tree this would result in such hiearchy (stm32mp1 example
>> with 2 virtio RPMSG):
>>
>> 	m4_rproc: m4@10000000 {
>> 		compatible = "st,stm32mp1-m4";
>> 		reg = <0x10000000 0x40000>,
>> 		      <0x30000000 0x40000>,
>> 		      <0x38000000 0x10000>;
>>         memory-region = <&retram>, <&mcuram>,<&mcuram2>;
>>         mboxes = <&ipcc 2>, <&ipcc 3>;
>>         mbox-names = "shutdown", "detach";
>>         status = "okay";
>>
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>
>>         vdev@0 {
>> 		compatible = "rproc-virtio";
>> 		reg = <0>;
>> 		virtio,id = <7>;  /* RPMSG */
>> 		memory-region = <&vdev0vring0>, <&vdev0vring1>,
>> <&vdev0buffer>;
>> 		mboxes = <&ipcc 0>, <&ipcc 1>;
>> 		mbox-names = "vq0", "vq1";
>> 		status = "okay";
>>         };
>>
>>         vdev@1 {
>> 		compatible = "rproc-virtio";
>> 		reg = <1>;
>> 		virtio,id = <7>;  /*RPMSG */
>> 		memory-region = <&vdev1vring0>, <&vdev1vring1>,
>> <&vdev1buffer>;
>> 		mboxes = <&ipcc 4>, <&ipcc 5>;
>> 		mbox-names = "vq0", "vq1";
>> 		status = "okay";
>>         };
>> };
>>
>> I have divided the work in 4 steps to simplify the review, This series
>> implements only the step 1:
>> step 1:  redefine the remoteproc VirtIO device as a platform device
>>   - migrate rvdev management in remoteproc virtio.c,
>>   - create a remotproc virtio config ( can be disabled for platform that not use
>> VirtIO IPC.
>> step 2: add possibility to declare and prob a VirtIO sub node
>>   - VirtIO bindings declaration,
>>   - multi DT VirtIO devices support,
>>   - introduction of a remote proc virtio bind device mechanism , =>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
>> com%2Farnopo%2Flinux%2Fcommits%2Fstep2-virtio-in-DT&amp;data=04%7
>> C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2%7C
>> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748757786
>> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
>> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=X%2B462681gcxe6
>> 2GP%2BV7ji2nef%2FuTbQVvIlddcMQwtmg%3D&amp;reserved=0
>> step 3: Add memory declaration in VirtIO subnode =>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
>> com%2Farnopo%2Flinux%2Fcommits%2Fstep3-virtio-memories&amp;data=0
>> 4%7C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2
>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748757
>> 786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
>> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=eMlXgCgrV6l46
>> h3Ywv1%2BCoX3gLBabdTZs9ybsm4t4ys%3D&amp;reserved=0
>> step 4: Add mailbox declaration in VirtIO subnode =>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
>> com%2Farnopo%2Flinux%2Fcommits%2Fstep4-virtio-mailboxes&amp;data=0
>> 4%7C01%7Cpeng.fan%40nxp.com%7C9e663eefc30a4fbb1fdb08d9e0e855e2
>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637788110748757
>> 786%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
>> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=75hApOwihqMZ
>> UUKz1VcitY2VPDc6KAIwAvH8enEZOPY%3D&amp;reserved=0
>>
>> Arnaud Pouliquen (4):
>>   remoteproc: core: Introduce virtio device add/remove functions
>>   remoteproc: core: Introduce rproc_register_rvdev function
>>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
>>   remoteproc: virtio: Create platform device for the remoteproc_virtio
>>
>>  drivers/remoteproc/remoteproc_core.c     | 159 +++----------------
>>  drivers/remoteproc/remoteproc_internal.h |  33 +++-
>>  drivers/remoteproc/remoteproc_virtio.c   | 193
>> ++++++++++++++++++++---
>>  include/linux/remoteproc.h               |   6 +-
>>  4 files changed, 227 insertions(+), 164 deletions(-)
>>
>> --
>> 2.25.1
> 
