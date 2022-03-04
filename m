Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2269F4CD835
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiCDPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbiCDPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:45:50 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8BE33A2;
        Fri,  4 Mar 2022 07:45:02 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2je013723;
        Fri, 4 Mar 2022 09:44:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Z4PNEb44rzAmhz7LlNft3ZiCpWyK5xAbOEcnRHxyPoU=;
 b=qIpEJ3EWoV1DZnFSePQg2JQ4nKm2gIVxLXEoyE+R1BHXZaaZPOAVEJ0f1UZKGJqe/+pH
 FmSiaOIPR+eIuxHy+FeIGLS9EQCJUUJeapZY9hEkVAXbBJDt6maEp3RZ5+rfyTSuU+Iq
 q6jngQyXjzA6y10WAuk/D84f0XyviUqs7Mcq8AHUjFTjc6W5V6EClxf/wG20L9emWm3i
 OjXoK5VyCMtwI636ZPaeUck3ThxlRWRveGUtPrMyA3Zg/+Ot2gTFzUVIXdagXmGCeLxN
 VMgoIdAlOWmGetWP3nhxMroK8VwVcNif4haaJIGp1b0KJUr2UwniOFDRUf+4gyL+FqY/ gQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h5hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:44:17 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:44:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:44:16 +0000
Received: from [198.61.65.198] (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7D791B06;
        Fri,  4 Mar 2022 15:44:15 +0000 (UTC)
Message-ID: <d2b9dbba-b255-53d4-4698-ac233e6159d9@opensource.cirrus.com>
Date:   Fri, 4 Mar 2022 15:44:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   <tanureal@opensource.cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH v2 01/20] ASoC: cs35l41: Fix GPIO2 configuration
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
 <20220304150721.3802-2-tanureal@opensource.cirrus.com>
 <20220304152226.GE38351@ediswmail.ad.cirrus.com>
In-Reply-To: <20220304152226.GE38351@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GWr-N8vf8EX8BexWVkJe6iTMll-5Vo-5
X-Proofpoint-ORIG-GUID: GWr-N8vf8EX8BexWVkJe6iTMll-5Vo-5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 3:22 PM, Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> On Fri, Mar 04, 2022 at 03:07:02PM +0000, Lucas Tanure wrote:
> > From: David Rhodes <drhodes@opensource.cirrus.com>
> >
> > Fix GPIO2 polarity and direction configuration
> >
> > Fixes: fe1024d50477b ("ASoC: cs35l41: Combine adjacent register writes")
> > Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> > Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> 
> Really sorry I only just spotted this but you are missing your
> own sign off here. You always need to personally sign each patch
> you are sending up.
> 
> Thanks,
> Charles
> 
Yes, sorry about that. I will give some time for more reviews on this version and fix it on v3.
