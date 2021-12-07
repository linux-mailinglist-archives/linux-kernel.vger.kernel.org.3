Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9B46B827
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhLGJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:57:56 -0500
Received: from marcansoft.com ([212.63.210.85]:43248 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhLGJ54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:57:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8C2A341EA7;
        Tue,  7 Dec 2021 09:54:21 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] drm/format-helper: Add
 drm_fb_xrgb8888_to_xrgb2101010_toio()
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20211207072943.121961-1-marcan@marcan.st>
 <20211207072943.121961-3-marcan@marcan.st>
 <03a52a64-7be3-b401-7711-b7b1452f433d@suse.de>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <c339c133-25d0-3c8e-e776-b61108836528@marcan.st>
Date:   Tue, 7 Dec 2021 18:54:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <03a52a64-7be3-b401-7711-b7b1452f433d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for the review!

On 07/12/2021 18.40, Thomas Zimmermann wrote:
> Hi
> 
> Am 07.12.21 um 08:29 schrieb Hector Martin:
>> Add XRGB8888 emulation support for devices that can only do XRGB2101010.
>>
>> This is chiefly useful for simpledrm on Apple devices where the
>> bootloader-provided framebuffer is 10-bit.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>    drivers/gpu/drm/drm_format_helper.c | 62 +++++++++++++++++++++++++++++
>>    include/drm/drm_format_helper.h     |  3 ++
>>    2 files changed, 65 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
>> index dbe3e830096e..edd611d3ab6a 100644
>> --- a/drivers/gpu/drm/drm_format_helper.c
>> +++ b/drivers/gpu/drm/drm_format_helper.c
>> @@ -409,6 +409,59 @@ void drm_fb_xrgb8888_to_rgb888_toio(void __iomem *dst, unsigned int dst_pitch,
>>    }
>>    EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_toio);
>>    
>> +static void drm_fb_xrgb8888_to_xrgb2101010_line(u32 *dbuf, const u32 *sbuf,
>> +						unsigned int pixels)
>> +{
>> +	unsigned int x;
>> +
>> +	for (x = 0; x < pixels; x++) {
>> +		*dbuf++ = ((sbuf[x] & 0x000000FF) << 2) |
>> +			  ((sbuf[x] & 0x0000FF00) << 4) |
>> +			  ((sbuf[x] & 0x00FF0000) << 6);
> 
> This isn't quite right. The lowest two destination bits in each
> component will always be zero. You have to do the shifting as above and
> for each component the two highest source bits have to be OR'ed into the
> two lowest destination bits. For example the source bits in a component
> are numbered 7 to 0
> 
>    | 7 6 5 4 3 2 1 0 |
> 
> then the destination bits should be
> 
>    | 7 6 5 4 3 2 1 0 7 6 |
> 

I think both approaches have pros and cons. Leaving the two LSBs always 
at 0 yields a fully linear transfer curve with no discontinuities, but 
means the maximum brightness is slightly less than full. Setting them 
fully maps the brightness range, but creates 4 double wide steps in the 
transfer curve (also it's potentially slightly slower CPU-wise).

If you prefer the latter I'll do that for v2.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
