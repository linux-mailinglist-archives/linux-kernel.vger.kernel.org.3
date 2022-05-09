Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6092520399
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiEIRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiEIRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:38:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10607216043
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:34:26 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2496VWU3001166;
        Mon, 9 May 2022 12:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=t6gq3R+AfB/aX2+wHeecRH0o6mpd0KKT9eW7emaNAQ0=;
 b=jyR+xTAUDxgPGnIrGmO1aayZ3EC3Y+ukJc+fN/QD0F7LYLNenVC2UfMNHFR7dovCAUNj
 1XDNo7bmNxl1jD/j53RG9Rc7sXHxZoJLJScs0A9xAnoj3uvnhlnPIr3LLdKZa3NO4nDr
 dLDL4RBZDyfxFiG2qb2kN00ItmCkLaq8cXlWJN7cndmGx+AeIUODIhhYCzPaZhB8wZtG
 VXJtCufWWcljLGPPrZSAk9A3IJ4FuFq15IWulcUtn3AbDox/i/EJIa48K6BstGiqWPGB
 Ic3PiLtDOpoc5VdYbAxEEALgKlzRmb7FtuRw2Wytbzapfut171bQYo7bC28B7FlC2bRT Ow== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nu0a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 May 2022 12:34:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 18:34:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 18:34:13 +0100
Received: from [198.90.202.102] (lon-sw-dsktp002.ad.cirrus.com [198.90.202.102])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B83C8476;
        Mon,  9 May 2022 17:34:13 +0000 (UTC)
Message-ID: <1b64582b-59f0-5eb5-5873-8102f99f649b@opensource.cirrus.com>
Date:   Mon, 9 May 2022 18:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 00/26] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
 <YmljEm6jUr3Odsv9@sirena.org.uk> <s5hbkw7m6ew.wl-tiwai@suse.de>
 <Ynj5PG0flJhn9iYD@sirena.org.uk>
From:   Vitaly Rodionov <vitaly.rodionov@opensource.cirrus.com>
In-Reply-To: <Ynj5PG0flJhn9iYD@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z6-T7Ijtgp9gP4qhW1kfctbLi5AMhiRz
X-Proofpoint-GUID: Z6-T7Ijtgp9gP4qhW1kfctbLi5AMhiRz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Takashi

On 09/05/2022 12:21 pm, Mark Brown wrote:
> On Mon, May 09, 2022 at 10:55:35AM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
>>> On Wed, Apr 27, 2022 at 04:06:54PM +0100, Vitaly Rodionov wrote:
>>>> The CS35L41 Amplifier contains a DSP, capable of running firmware.
>>>> The firmware can run algorithms such as Speaker Protection, to ensure
>>>> that playback at high gains do not harm the speakers.
>>>> Adding support for CS35L41 firmware into the CS35L41 HDA driver also
>>>> allows us to support several extra features, such as hiberation
>>>> and interrupts.
>>> There's a bunch of changes for this driver in the ASoC tree, it looks
>>> like the bits that touch ASoC will need basing off those.
>> How is the situation for the time being?
>> I've been off in the last weeks, so couldn't follow the whole
>> thread.
> No change, Vitaly didn't update or respond as far as I remember.  We'll
> need a new version.

Sorry for delay, yes we have re-based version, I will send again.

Thanks,

Vitaly

