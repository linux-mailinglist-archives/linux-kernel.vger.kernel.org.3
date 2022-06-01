Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673D253AB2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356176AbiFAQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiFAQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:44:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909490CE8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:44:29 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251GD9Lw013228;
        Wed, 1 Jun 2022 11:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=8JmM4oK3zicQ8AMY1tUoSEXJdzasmZmWSpyRHYe8enQ=;
 b=L/kkIbLbtQIJ9I3vWKhAjHezDOGVZt98MukU62+rhBBualRcZCwWiIlRqZfrsTtTw0lw
 /W+foEYWfxZdhLCAiFmWdY1zR3+w0V7pNHMjXIAiSZooa9lZ3p9XtA3vJjZ9JBoVd/og
 Y/cPbJm9eyr+vLNi6SAxlSGYFPo/Vqrtrd3fL+Guxs7lGvsgSAUHrOq84Qm/IuNfXfSr
 U0LSgcwbIAOkhtcOp4drdmXJJKy7zYUKKEOVsZsnQ+KAoylQdJNpC6iyTEmN//XUuawu
 v2uXwx0HcP9DfStB08JC3VIRHytazXi+ysiKxnbySjJEm/fNhlJ8qh1KYkMjUj3eNT3a cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gbh51mgy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Jun 2022 11:43:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 17:43:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 1 Jun 2022 17:43:31 +0100
Received: from [198.61.65.68] (unknown [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 70941458;
        Wed,  1 Jun 2022 16:43:31 +0000 (UTC)
Message-ID: <008e3188-f35d-4323-08ea-de5f3a88333a@opensource.cirrus.com>
Date:   Wed, 1 Jun 2022 17:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <871qwf0x8t.wl-tiwai@suse.de>
 <20220530090846.GS38351@ediswmail.ad.cirrus.com>
 <87czfvxtsc.wl-tiwai@suse.de>
 <20220530093639.GT38351@ediswmail.ad.cirrus.com>
 <87a6azxr7h.wl-tiwai@suse.de>
 <20220530103415.GU38351@ediswmail.ad.cirrus.com>
 <871qwbxpsb.wl-tiwai@suse.de>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <871qwbxpsb.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MOD9ZZq_-P5NvfVDB-krZ1iJyKdTnsB4
X-Proofpoint-ORIG-GUID: MOD9ZZq_-P5NvfVDB-krZ1iJyKdTnsB4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 11:45, Takashi Iwai wrote:
> On Mon, 30 May 2022 12:34:15 +0200,
> Charles Keepax wrote:
>>
>> On Mon, May 30, 2022 at 12:14:26PM +0200, Takashi Iwai wrote:
>>> On Mon, 30 May 2022 11:36:39 +0200,
>>> Charles Keepax wrote:
>>>> On Mon, May 30, 2022 at 11:18:43AM +0200, Takashi Iwai wrote:
>>>>> On Mon, 30 May 2022 11:08:46 +0200,
>>>>> Charles Keepax wrote:
>>>>>> On Fri, May 27, 2022 at 06:13:38PM +0200, Takashi Iwai wrote:
>>>>>>> On Wed, 25 May 2022 15:16:21 +0200,
>>>>>>> Vitaly Rodionov wrote:
>>>> Yeah that should be what is happening here. Although it looks
>>>> like this code might be removing all the controls if the firmware
>>>> is unloaded. I will discuss that with the guys, we normal just
>>>> disable the controls on the wm_adsp stuff.
>>>
>>> OK, that sounds good.  Basically my concern came up from the code
>>> snippet doing asynchronous addition/removal via work.  This showed
>>> some yellow signal, as such a pattern doesn't appear in the normal
>>> implementation.  If this is (still) really necessary, it has to be
>>> clarified as an exception.
>>>
>>
>> Hm... ok we will think about that. I think that part will
>> probably still be necessary. Because there is an ALSA control
>> that selects the firmware, then it is necesarry to defer creating
>> the controls to some work, since you are already holding the
>> lock.
> 
> Well, if an ALSA control can trigger the firmware loading, that's
> already fragile.  A firmware loading is a heavy task, which should
> happen only at probing and/or resuming in general.  Do we have other
> drivers doing the f/w loading triggered by a kctl...?
> 

On Wolfson/Cirrus codecs the firmware isn't to "make the chip work".
The DSP is programmable to allow for additional audio processing
algorithms. Which algorithm you need depends on the audio use case(s)
you are running, and can change as you change use-case. Many of the
codecs don't have enough DSP memory to hold all possible algorithms.
Which is why the firmware load has always been triggered from ALSA
controls in the ASoC code. It's not something that can be loaded
once in probe().
