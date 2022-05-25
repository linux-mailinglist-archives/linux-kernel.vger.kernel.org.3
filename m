Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372EE5338E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiEYI5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiEYI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:57:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118D06F4B8;
        Wed, 25 May 2022 01:57:20 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P5QfC4020613;
        Wed, 25 May 2022 10:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=c57UgkWh7O6lvwSTiPRPjjG/R07L2Mni3TEW2sc6zV4=;
 b=RqurYWClYSvygZrFiEo1tPYrsxTsyeXJMgQvnWsTs+r2wwiG/wXanZ9D++o2B8xUmJub
 3STzv8/yjfYMUnXwtPWj3s+aBJCeUo3jVrr9QTN3elX1ZsfYsnZ0pU1RJjDv5Q1mtyXJ
 +vzAX6v6z9o/K8IeiffrLkgwesk/4lit9LnIICCidwkbHgE8jpvsY3rRi5E3tVhoIfh8
 TxtZXozB8l9GIXFehb1IpRsBRgz5Scl7wEbpkd1RmL/+6sDWB7TZcBJuaIy8IjYxmtzx
 Z7dQ1+ru6Pz8qH5Xh5UU7ukufxLzoqI3x7hXhapEm1WvArPfeUD+mSTSd7I5vL/nsytU Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g93ur42ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 10:57:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5B4310002A;
        Wed, 25 May 2022 10:57:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5027F217B7E;
        Wed, 25 May 2022 10:57:10 +0200 (CEST)
Received: from [10.211.8.221] (10.75.127.50) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 25 May
 2022 10:57:07 +0200
Message-ID: <e54bcfcb-8e37-9caa-b330-a7411820b7ce@foss.st.com>
Date:   Wed, 25 May 2022 10:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 00/10] Introduction of rpmsg flow control service
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Xiang Xiao <xiaoxiang@xiaomi.com>
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
 <CANLsYkw7wjfVPTvA7SniMV8tBommm5E5w2FA0KMyRYn0BKVDyA@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <CANLsYkw7wjfVPTvA7SniMV8tBommm5E5w2FA0KMyRYn0BKVDyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_03,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 5/24/22 17:34, Mathieu Poirier wrote:
> Hi Arnaud,
> 
> I added your patchset to my review list.  Unfortunately it sits behind
> a sizable backlog and as such I won't be able to get to it for some
> time.

No worries, I hope to get some feedbacks and to have discussion on the
topic from some other people as well 
FYI, as a similar Pull request exists on OpenAMP github, I requsted in the
OpenAMP PR to centralize all the discussions around the design choice in this
thread. The aim is that we have a single discussion thread to find a consensus
on the way of implementing such service on virtio backend.

Creating a specific rpmsg service is one approach, some other can exist...

Regards,
Arnaud


> 
> Thanks,
> Mathieu
> 
> On Fri, 20 May 2022 at 02:30, Arnaud Pouliquen
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>> This series proposes an implementation for the rpmsg virtio transport
>> backend, of the signaling API proposed by Deepak Kumar Singh:
>> "rpmsg and glink signaling API support" [1]
>>
>> The aim of the series is to offer the possibility for an endpoint to inform
>> a remote endpoint about its state, based on a software flow control[2].
>>
>> For this a new rpmsg service( with a fixed address 64) is proposed.
>> It is responsible for:
>> - transmitting local endpoint flow control information to the remote side,
>> - informing a local endpoint about a remote endpoint flow control.
>>
>> For the rpmsg virtio transport layer the service is negotiated thanks to the
>> virtio feature flag: VIRTIO_RPMSG_F_FC
>>
>> Notice that this pull request introduces new feature in the rpmsg protocol,
>> So it has to be aligned with OpenAMP implementation.
>> Pending OpenAMP pull request is available here:
>> https://github.com/OpenAMP/open-amp/pull/394
>>
>>
>> [1]https://lkml.org/lkml/2022/1/18/867
>> [2]https://en.wikipedia.org/wiki/Software_flow_control
>>
>> Arnaud Pouliquen (8):
>>   rpmsg: core: Add rpmsg device remote flow control announcement ops
>>   rpmsg: virtio: Implement the announce_remote_fc ops
>>   rpmsg: Introduce flow control channel driver
>>   rpmsg: virtio: Add support of the VIRTIO_RPMSG_F_FC feature
>>   rpmsg: virtio: Implement the set_flow_control ops
>>   rpmsg: Add the destination address in rpmsg_set_flow_control
>>   rpmsg: tty : Add the support of the flow control
>>   rpmsg: virtio: Set default dst address on flow control
>>
>> Deepak Kumar Singh (2):
>>   rpmsg: core: Add signal API support
>>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
>>
>>  drivers/rpmsg/Kconfig            |  11 +++
>>  drivers/rpmsg/Makefile           |   1 +
>>  drivers/rpmsg/rpmsg_char.c       |  56 +++++++++++++--
>>  drivers/rpmsg/rpmsg_core.c       |  47 +++++++++++++
>>  drivers/rpmsg/rpmsg_fc.c         | 113 +++++++++++++++++++++++++++++++
>>  drivers/rpmsg/rpmsg_internal.h   |   9 +++
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 111 +++++++++++++++++++++++++++++-
>>  drivers/tty/rpmsg_tty.c          |  50 ++++++++++++++
>>  include/linux/rpmsg.h            |  15 ++++
>>  include/linux/rpmsg/fc.h         |  51 ++++++++++++++
>>  10 files changed, 456 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/rpmsg/rpmsg_fc.c
>>  create mode 100644 include/linux/rpmsg/fc.h
>>
>> --
>> 2.25.1
>>
