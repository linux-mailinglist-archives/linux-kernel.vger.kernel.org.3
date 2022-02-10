Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2E4B02E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiBJCBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:01:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiBJB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:59 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED728CC1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:34:57 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 21A0uWOt069631
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:56:32 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 21A0tKwB069583;
        Thu, 10 Feb 2022 08:55:20 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Feb
 2022 09:03:31 +0800
Message-ID: <fcad21a9-c7f6-4dd9-7fa8-8a6e6f3853f2@aspeedtech.com>
Date:   Thu, 10 Feb 2022 09:03:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] media: aspeed: Use full swing as JFIF to fix incorrect
 color
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220209084225.4456-1-jammy_huang@aspeedtech.com>
 <f790f9aa-fcb7-d163-9c1c-9eb107d4b1bd@molgen.mpg.de>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <f790f9aa-fcb7-d163-9c1c-9eb107d4b1bd@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 21A0tKwB069583
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,

OK, I will update a new patch per your suggestion.

Thanks for your help.

On 2022/2/9 下午 05:06, Paul Menzel wrote:
> Dear Jammy,
>
>
> Am 09.02.22 um 09:42 schrieb Jammy Huang:
>> Current settings for video capture rgb-2-yuv is BT.601(studio swing),
>> but JFIF uses BT.601(full swing) to deocde. This mismatch will lead
>> to incorrect color. For example, input RGB value, (0, 0, 255), will
>> become (16, 16, 235) after jpg decoded.
>>
>> Add an enum, aspeed_video_capture_format, to define VR008[7:6]
>> capture format and correct default settings for video capture to fix
>> the problem.
> Maybe quote the datasheet:
>
> VR008[7:6] will decide the data format for video capture:
> 00: CCIR601 studio swing compliant YUV format
> 01: CCIR601 full swing compliant YUV format
> 10: RGB format
> 11: Gray color mode
>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>> v2:
>>    - update subject from 'media: aspeed: Fix-incorrect-color' to
>>      'media: aspeed: Use full swing as JFIF to fix incorrect'
>>    - update commit message
>>    - add enum, aspeed_video_capture_format, to define VR008[7:6]
>> ---
>>    drivers/media/platform/aspeed-video.c | 14 +++++++++++---
>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index eb9c17ac0e14..5bcf60b4628b 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -86,8 +86,6 @@
>>    #define  VE_CTRL_SOURCE			BIT(2)
>>    #define  VE_CTRL_INT_DE			BIT(4)
>>    #define  VE_CTRL_DIRECT_FETCH		BIT(5)
>> -#define  VE_CTRL_YUV			BIT(6)
>> -#define  VE_CTRL_RGB			BIT(7)
>>    #define  VE_CTRL_CAPTURE_FMT		GENMASK(7, 6)
>>    #define  VE_CTRL_AUTO_OR_CURSOR		BIT(8)
>>    #define  VE_CTRL_CLK_INVERSE		BIT(11)
>> @@ -202,6 +200,15 @@ enum {
>>    	VIDEO_CLOCKS_ON,
>>    };
>>    
>> +// for VE_CTRL_CAPTURE_FMT
>> +enum aspeed_video_capture_format {
>> +	VIDEO_CAP_FMT_YUV_STUDIO = 0,
> Maybe also append `_SWING`?
>
>> +	VIDEO_CAP_FMT_YUV_FULL,
>> +	VIDEO_CAP_FMT_RGB,
>> +	VIDEO_CAP_FMT_GRAY,
>> +	VIDEO_CAP_FMT_MAX
>> +};
>> +
>>    struct aspeed_video_addr {
>>    	unsigned int size;
>>    	dma_addr_t dma;
>> @@ -1089,7 +1096,8 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
>>    	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
>>    		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>>    		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
>> -	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
>> +	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR |
>> +		FIELD_PREP(VE_CTRL_CAPTURE_FMT, VIDEO_CAP_FMT_YUV_FULL);
>>    	u32 seq_ctrl = video->jpeg_mode;
>>    
>>    	if (video->frame_rate)
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

-- 
Best Regards
Jammy

