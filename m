Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D702546E872
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhLIMbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhLIMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639052883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCUALssbY0oxqy20XeNiM0IZqaDHE6HLbBTKKFbR5aM=;
        b=ZTusAF6R62hh9jyVs8XDPVrks6DlnKWLJXg/PpEqNksIf+ZQyPEGuXy5LMAg/otyKLuca+
        84IhVUQ9/2AgWMPJHoSGUw8hnrRWGGNiD1/Tftr3dFVXaHxdBPcb4/ghlJFJY4+3cClqnd
        4Inlnt4xi/j2KeOMF5nGjyPpYcWAeIc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-JOBOkZNkPfKQYtxIgl3XXg-1; Thu, 09 Dec 2021 07:28:02 -0500
X-MC-Unique: JOBOkZNkPfKQYtxIgl3XXg-1
Received: by mail-wr1-f70.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so1349534wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kCUALssbY0oxqy20XeNiM0IZqaDHE6HLbBTKKFbR5aM=;
        b=XM8rzYGOnlISZVysnM6gzVSXicb0EW4WbYrK/o+BhMAmyihhnlTbOgdfPLC0tCbpzq
         mbC6Uk9ECVQtmVjtEiYV4VvsUPVEMCd+Q96POiW4mZPyr4cQwg9Rd1O+IvG5/KhpSHpx
         9QvXvGyl0tgigxRC50Rup0ndI6mnc41/1IPdnknIhpgdKWERScvMKHMMONux2itq/EBv
         St9Q+tuNFyPr/7v8wFGfE8gnXTyts+DXSboN4c3CeB2KEMkeiDMmmNVBcir2ItIQJNMZ
         QlHrdWGbPgBjoxN7XxN1ZNlSarJK1tX0HY753j5IR0C0Q02z+T4ycFqrfMJYpGemdemX
         sK3w==
X-Gm-Message-State: AOAM530yAwvsJZriRsvYF1bZexl4+zzTqLuUn7MMuKK7ThARC3NpMurR
        fFqNbxkT0RpMZUeaCBuvkrG9kFnNBYd9Vzrw+/UjDFJwyjphwd3vSRnuadUwnFiqYIhAm0gcSIg
        nh/+hEWcHkxy7XozgEx61yKDy
X-Received: by 2002:a1c:770e:: with SMTP id t14mr6760490wmi.173.1639052881395;
        Thu, 09 Dec 2021 04:28:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL2h9N0KGbtDzZwoPUZ5+FGiLDImgFcG7uRNO/NF0d9BGrzMDui9+5mHA0hYe5k4W8nm+zlQ==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr6760456wmi.173.1639052881165;
        Thu, 09 Dec 2021 04:28:01 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m20sm9483469wmq.11.2021.12.09.04.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 04:28:00 -0800 (PST)
Message-ID: <408dd9d0-22bb-f5de-b578-9fd20df89a98@redhat.com>
Date:   Thu, 9 Dec 2021 13:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] Revert "drm/fb-helper: improve DRM fbdev emulation
 device names"
Content-Language: en-US
To:     Johannes Stezenbach <js@sig21.net>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20211020165740.3011927-1-javierm@redhat.com>
 <Yath6T5ET17GbkI7@sig21.net>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yath6T5ET17GbkI7@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johannes,

Sorry for the late response. I was on holidays for a week and just came back.

On 12/4/21 13:41, Johannes Stezenbach wrote:
> Hi,
> 
> On Wed, Oct 20, 2021 at 06:57:40PM +0200, Javier Martinez Canillas wrote:
>> This reverts commit b3484d2b03e4c940a9598aa841a52d69729c582a.
>>
>> That change attempted to improve the DRM drivers fbdev emulation device
>> names to avoid having confusing names like "simpledrmdrmfb" in /proc/fb.
>>
>> But unfortunately, there are user-space programs such as pm-utils that
>> match against the fbdev names and so broke after the mentioned commit.
>>
>> Since the names in /proc/fb are used by tools that consider it an uAPI,
>> let's restore the old names even when this lead to silly names like the
>> one mentioned above.
> 
> I would like to ask about the fate of this patch. It doesn't
> seem to have been picked up by anyone, does it?
>

Thanks for the reminder. I've just pushed this to the drm-misc-fixes branch.
 
> 
> Thanks,
> Johannes
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

