Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07B55A4673
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiH2Juy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH2Juw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:50:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226BC24BFA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:50:52 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5Kb9I007486;
        Mon, 29 Aug 2022 04:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Ac1E2dHlHNO3x2YovIPvIWmXBzgoM79hvAsvFpx0KBo=;
 b=Tc08a30i0ip9GJ71TVtXMDIYCV24uqfkO2ABQbCDQW7cAQ1iJ0VKFAyHeQxR/9K10ZX4
 m3V1LjUdLvU4j3wExX7csAwXiEcRvwnwK70RM7TExLypYzgj2Pb9FDwOVBbXUx+WbcSs
 ca8IW+TMsnW70E7pqbXMq43c9mp8f9UG090XtUjBy94IKSwkR0uGYrB0BpFcMsJqkRYj
 mNVn1MoosMQCK0vqYJvEoQ4ymL3jSpUdH3woSvwMSiqa2KiQ0j0i1t0y4x9GQDHeNBk6
 iXmpZ/fdtbNQ/D64OoLZMKUT+w8TiHnMW74DY+/WffyL1pycMiZ6tefsSOEoW5LGLXc8 NQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j7gp21u5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 04:50:37 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 29 Aug
 2022 04:50:35 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Mon, 29 Aug 2022 04:50:35 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E511F459;
        Mon, 29 Aug 2022 09:50:34 +0000 (UTC)
Message-ID: <b163327f-587d-d933-35de-7058cdcd6b9e@opensource.cirrus.com>
Date:   Mon, 29 Aug 2022 10:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] soundwire: bus: Fix lost UNATTACH when re-enumerating
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
 <20220825122241.273090-4-rf@opensource.cirrus.com>
 <adfdf06a-e1a3-e47c-a71f-5e5dccef6fd0@linux.intel.com>
 <e9deb2fb-458a-8136-5ba7-a9e2b0f2d174@opensource.cirrus.com>
 <01e03c55-1fcf-1e33-78e8-398a50b622ce@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <01e03c55-1fcf-1e33-78e8-398a50b622ce@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ykjxJIMpY9jph5RvS6dhUuZyA2n6Im8u
X-Proofpoint-ORIG-GUID: ykjxJIMpY9jph5RvS6dhUuZyA2n6Im8u
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 09:06, Pierre-Louis Bossart wrote:
> 
<SNIP>
> 
> Thanks for the detailed answer, this sequence of events will certainly
> defeat the Cadence IP and the way sticky bits were handled.
> 
> The UNATTACHED case was assumed to be a really rare case of losing sync,
> i.e. a SOFT_RESET in SoundWire parlance.
> 
> If you explicitly do a device reset, that would be a new scenario that
> was not considered before on any of the existing SoundWire commercial
> devices. It's however something we need to support, and your work here
> is much appreciated.
> 
> I still think we should re-check the actual status from a PING frame, in
> order to work with more current data than the sticky bits taken at an
> earlier time, but that would only be a minor improvement.
> 
> I also have a vague feeling that additional work is needed to make sure
> the DAIs are not used before that second enumeration and all firmware
> download complete. I did a couple of tests last year where I used the
> debugfs interface to issue a device reset command while streaming audio,
> and the detach/reattach was not handled at the ASoC level.
> 
> I really don't see any logical flaws in your patch as is, so
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 

I have pushed an alternative fix that waits until it sees an UNATTACHED
status before reprogramming the device ID.
https://lore.kernel.org/lkml/20220829094458.1169504-1-rf@opensource.cirrus.com/T/#t

I've tested it with 4 amps on the same bus, all being reset after their
firmware has been downloaded.

I leave it to you to choose which fix you prefer. The second fix is
simpler and I didn't see any problems in testing.
