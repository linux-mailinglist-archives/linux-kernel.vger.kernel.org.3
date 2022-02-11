Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FE4B2388
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344962AbiBKKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349253AbiBKKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6569EFCF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644576017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rr2p39qO1PszvSAuu6FevETTuy4phR00cC1/L7uwXE4=;
        b=RmuDRPOCeNotMzhaL2yUlxHnj4DX0EZz56HYm3WcVXMFrUvytIgRF46/enE/5cUennWzLK
        cOe6b4NwogXRVjioyaPDEYCmOMQblbf0sgha3aELJQV1ZKQ/m+cSGYDRbjPTcq0CNpS7ah
        HNJftDNq8V64y1dkgMcPYSij14idI78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-LfWbPqhsMaiezUbBrsHvBA-1; Fri, 11 Feb 2022 05:40:16 -0500
X-MC-Unique: LfWbPqhsMaiezUbBrsHvBA-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso2340827wmb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rr2p39qO1PszvSAuu6FevETTuy4phR00cC1/L7uwXE4=;
        b=Qo3sNid/RsAH3CYdNuMns+jKiaILW/wKPUiWUH357vgVS7EfgSvdwPc1UQQt9K9vFD
         gCXjXIfEAFfGgpR2UK1frlTGkJBiITvSEIwJjDgm+owWQpEhyEt9S2VGxe4Z5nIfKjf/
         Ujw+DQ1sirQc6hEslY5GMqDFe1rz8M5KwPB92D1IyWGQL8BUTlSs0cQF01g8u6YZmG1z
         U81WbXwkTHGhytawcHX7igwHlMKRZe1yAHOFo+uvC9eud2sT587BZBvY9mhBkpoZMo3x
         IHHR3NPi/le4FhGac2b3inTjVuwqpboQN3q4E0M9utNR2Ei6FWqT4hXQCZDghWXS0pDj
         o8Ow==
X-Gm-Message-State: AOAM532/1LlB2YAu5YVkkhz+2N+nU/KxabulOV9l2cPkla65rLGSmQGB
        E/mJnCf16Q57VYLQDlVFHa6/HPyJqqwc4CygW9p4pho7s6tH/yxW/QvaiosYSe2D0/RWkexPD6L
        D1wLZZ1i4sy5tJI0Rc7hyr2H4
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr849157wrl.599.1644576014928;
        Fri, 11 Feb 2022 02:40:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFwUlqoA2Q/hc1lootDkLF4/JkL1kUKbH/6LwiUXn6iAC9iHdzV840Do6ORLJXrajVa5H83A==
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr849134wrl.599.1644576014664;
        Fri, 11 Feb 2022 02:40:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6sm24340579wrw.54.2022.02.11.02.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 02:40:14 -0800 (PST)
Message-ID: <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
Date:   Fri, 11 Feb 2022 11:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgY6OqN+guBlt/ED@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On 2/11/22 11:28, Andy Shevchenko wrote:
> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
>> Pull the per-line conversion logic into a separate helper function.
>>
>> This will allow to do line-by-line conversion in other helpers that
>> convert to a gray8 format.
> 
> ...
> 
>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
>> +{
>> +	unsigned int x;
>> +
>> +	for (x = 0; x < pixels; x++) {
>> +		u8 r = (*src & 0x00ff0000) >> 16;
>> +		u8 g = (*src & 0x0000ff00) >> 8;
>> +		u8 b =  *src & 0x000000ff;
>> +
>> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
>> +		*dst++ = (3 * r + 6 * g + b) / 10;
>> +		src++;
>> +	}
> 
> Can be done as
> 
> 	while (pixels--) {
> 		...
> 	}
> 
> or
> 
> 	do {
> 		...
> 	} while (--pixels);
> 

I don't see why a while loop would be an improvement here TBH.

In any case, I just pulled the line conversion logic as a separate
function with minimal code changes since doing that should be in a
separate patch.

Feel free to post a patch if you want to change that while loop.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

