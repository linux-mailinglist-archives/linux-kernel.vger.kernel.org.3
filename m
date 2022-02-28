Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA14E4C6551
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiB1JEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiB1JEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:04:04 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4CE201AF;
        Mon, 28 Feb 2022 01:03:05 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21S23AnE021067;
        Mon, 28 Feb 2022 10:02:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=r2K3KfZiBxSqGnFUFhrDt37OlVAmowgJ0HAxohwVpRI=;
 b=RRsSlEeSqc3ljzwyFUldtIOrW0rF3l/RpzpyKlo5WOIFX11yX2gncogfqU/EalUxpzue
 iAamm8nNmrSHyWr0BiJMem097ykCHKuQyOLJQIa4SiU3YIiP9eJPPJ3uI0uKiGGYXRzS
 UvEAtjwHcteYoeeIpz3VcgTtrW2MN+/59zjdp3uDZ7z/pSIOO/Maum/wgZMtqViccuh9
 usv8SyjgcShAxuzg5i/F1X4W6k4yYRzD/hRu+ETz2sk2EEGVBa8hpuSRyx7yPbIFFci8
 2IKBeG05vm5l1tidomPMSrmmNt6PtG2Q6YfgKOHN2Xncd7ZdbUUakAzlf+vR4mhk+Zhy sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eg7pkvcyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 10:02:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E448B10002A;
        Mon, 28 Feb 2022 10:02:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D97362171E4;
        Mon, 28 Feb 2022 10:02:48 +0100 (CET)
Received: from [10.211.4.83] (10.75.127.44) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 28 Feb
 2022 10:02:48 +0100
Message-ID: <f6c4ce33-cf94-6794-3825-06a7ffe0a472@foss.st.com>
Date:   Mon, 28 Feb 2022 10:02:47 +0100
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
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, Xiang Xiao <xiaoxiang@xiaomi.com>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
 <ab97c2a5-7705-eae8-9bc2-908e7a9cb709@gmail.com>
 <670ee336-9ad4-401e-e3b2-02531e975e51@foss.st.com>
 <15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_03,2022-02-26_01,2022-02-23_01
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

On 2/25/22 22:45, Philipp Rossak wrote:
> Hi Arnaud,
> 
> On 24.02.22 09:29, Arnaud POULIQUEN wrote:
>> Hi Philipp,
>>
>> On 2/23/22 22:28, Philipp Rossak wrote:
>>> Hi Arnaud,
>>>
>>> thanks for working on this! I'm currently testing/using this patch
>>> series on my imx7d project because it adds the capability that the
>>> remote processor can register it's endpoints dynamically (as mentioned
>>> in the objectives).
>>
>> Thanks for your feedback on this work!
>> Don't hesitate to add your tested-by, this help maintainers for the
>> reviews.
>>
> I will do this.
>>>
>>> After a few tests, debugging, and checking the openamp specification [1]
>>> I think that you missed the second ns_announcement that should be sent
>>> from linux master to the slave after it created the channel/endpoint.
>>> Without this second announcement the remote processor is not able to
>>> send messages to the linux master because it doesn't know the
>>> destination address until it receives a message from the linux master.
>>
>> Yes I detected this issues, it is not related to the series
>> but to the remoteproc_virtio backend.
>>
>> As you mentioned, after the ns announcement from Linux, the remote
>> processor
>> send first messages. But the Linux virtio does not do the match
>> between the
>> local channel created and the remote endpoint.
>>
> 
> I'm not sure if we talk about the same. I'm basically talking about the
> dynamic binding, not dynamic endpoint creation.

Regarding your following description, yes it is not exactly the same issue.
  

> I think I already found the issue. I will try to get a bit more into
> detail.
> 
> 1. Linux: starts co-processor via remoteproc
> 2. co-processor: boots and reaches the point where it creates the
> endpoint like it is done in this ST example[1].
> Be aware the src address is RPMSG_ADDR_ANY
> 3. co-processor: reaches the point where it sends the ns_announcement to
> linux ns endpoint
> 4. linux: receives the ns announcment, creates the channel, bindes the
> endpoint and checks here [2] if the source address is not RPMSG_ADDR_ANY
> and in this case it is not sending a ns_announcement (that's the issue
> when we use dynamic endpoints)

The ns annoucement is used to notify the remote processor that a new channel
has been created locally. Today the ns anoucement is not used to inform that

The local endpoint has been binded.

This behavior is something that as already been identified as a limitation in
the virtio rpmsg.

Xiang Xiao had proposed some time ago a mechanism for the OpenAMP [5], the
Linux part is missing. We need a common solution between Linux and OpenAMP, but
that also compatible with legacy. 
From MPOV Xiang's approach seem a good starting point.  
If you are interesting on working on this enhancement of the rpmsg virtio, feel
free to do so.

> 5. linux: according the openamp spec [3] it should now send the
> ns_announcement to the co-processor (slave)
> 6. co-processor: should receive the ns announcement and binds now the
> endpoint
> 7. co-processor: can now send messages to linux
> 
> This is basically what I'm expecting.
> 
> 
> Do you think this is a bug or is the dynamic endpoint binding not
> handled? This line is there since ever [4] ...

As you mentioned this is a legacy limitation that should be addressed.
It is not related to this work.

Thanks,
Arnaud

> 
> Any other thoughts about this?
> 
>> This is a feature that is missing in the rpmsg virtio, and perhaps in
>> rpmsg protocol
>> itself (a ns annoucement ack message or something similar).
>>
>>
>> A fix for the remoteproc virtio is available here:
>> https://github.com/arnopo/meta-st-stm32mp-oss/commit/3e57fe73bd19c9bb835ac5a118e50727758b0b96
>>
>>
>> Don't hesitate to give me feedback on the fix, if you test it.
> 
> I added it to my branch and till now I don't see any side effects
>>
>> I plan to propose the fix after this series.
>>
>> Thanks,
>> Arnaud
>>
>>>
>>> Cheers,
>>> Philipp
>>>
> 
> Cheers,
> Philipp
> 
> [1]:
> https://github.com/STMicroelectronics/STM32CubeMP1/blob/master/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_raw/Src/openamp.c#L242
> 
> 
> [2]:
> https://elixir.bootlin.com/linux/v5.17-rc5/source/drivers/rpmsg/virtio_rpmsg_bus.c#L425
> 
> 
> [3]:
> https://github.com/OpenAMP/open-amp/blob/main/docs/img/coprocessor-rpmsg-ns.png
> 
> 
> [4]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcabbccabffe7326f046f25737ba1084f463c65c
> 

[5] https://github.com/OpenAMP/open-amp/pull/160
