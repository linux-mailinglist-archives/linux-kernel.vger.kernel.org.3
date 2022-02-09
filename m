Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6D4AEBAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiBIIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiBIIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:00:50 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D813C05CB95
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:00:53 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2197pbHw068866;
        Wed, 9 Feb 2022 15:51:37 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 15:59:49 +0800
Message-ID: <e498b84e-c8b1-f2ad-4364-f871491fb507@aspeedtech.com>
Date:   Wed, 9 Feb 2022 15:59:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] media: aspeed: Fix incorrect color
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
References: <20220209024312.2218-1-jammy_huang@aspeedtech.com>
 <554448a9-bc65-7c0b-9878-fb2c0fe9bfe4@molgen.mpg.de>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <554448a9-bc65-7c0b-9878-fb2c0fe9bfe4@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2197pbHw068866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,

Thanks for your review and suggestion.

On 2022/2/9 下午 02:23, Paul Menzel wrote:

> Dear Jammy,
>
>
> Am 09.02.22 um 03:43 schrieb Jammy Huang:
>> Current settings for rgb-2-yuv is BT.601(studio swing), but JFIF
>> uses BT.601(full swing).
> Could you please describe the problem in a little more detail? On an
> attached monitor to the BMC (which one) what incorrect colors are seen?
Aspeed video 's input is gfx' output which is ARGB format. To generate 
jpg, video
engine will transform ARGB into YUV first. Previously, aspeed video's 
default
settings is studio swing (16~235), but jpg is full swing (0~255) as you 
can see in
'Conversion to and from RGB' of https://www.w3.org/Graphics/JPEG/jfif3.pdf.

This will lead to incorrect color. For example, a RGB color on gfx, 
blue(0, 0, 255) will
become (16, 16, 235) after we see the output jpg of aspeed video.
> Maybe use:
>
>> media: aspeed: Use full swing for JFIF to fix incorrect color
Thanks, I will update a more suitable subject for this patch.
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>    drivers/media/platform/aspeed-video.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index eb9c17ac0e14..08b63b8297f0 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1089,7 +1089,7 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
>>    	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
>>    		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>>    		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
>> -	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
>> +	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR | VE_CTRL_YUV;
> Excuse my ignorance, but reading [1][2] YUV can be represented by studio
> and full swing. How is the register/bit described in the datasheet, and
> can the macro name be improved?
VR008[7:6] will decide the data format for video capture:
00: CCIR601 studio swing compliant YUV format
01: CCIR601 full swing compliant YUV format
10: RGB format
11: Gray color mode

I will update this part as well.
>
>>    	u32 seq_ctrl = video->jpeg_mode;
>>    
>>    	if (video->frame_rate)
>
> Kind regards,
>
> Paul
>
>
> [1]: https://mymusing.co/bt601-yuv-to-rgb-conversion-color/
> [2]: https://www.hisour.com/yuv-color-system-25916/

-- 
Best Regards
Jammy

