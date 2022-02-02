Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788834A6D28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245169AbiBBIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245147AbiBBIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643791565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+t98WKUfmAfPmDThATdXX8CTJNH50fOldGy238DTDyQ=;
        b=IJSKlgjLlk0t3JkyAJDPQ2r+xsJ45q0E22jopbQP+pmzu+ey5h4MyYpvnbGW+GQwwT6mZh
        0tgxYDArIKDs20VmMVQRn1AEqen6IivkEfAX9amkBut0SkKLs3uvRFHHXQgyQFybCRrvl6
        vnD90EOE4+0/mE/BPsl2fz6J/y1nfhU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-Mu-h1TXTOZGs2rNv1nr8Gw-1; Wed, 02 Feb 2022 03:46:04 -0500
X-MC-Unique: Mu-h1TXTOZGs2rNv1nr8Gw-1
Received: by mail-wr1-f69.google.com with SMTP id o26-20020adfa11a000000b001dd1d3a73c7so6587914wro.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+t98WKUfmAfPmDThATdXX8CTJNH50fOldGy238DTDyQ=;
        b=mWyW9kp4YKvdoJh4B7ea9ERDjXaH1GiYbnA9jAquuZv7K0oh05iFpCINM3MVEdpvuf
         d5Koi1jZSIjp3hGYvQIGOtE1MXtQaQuQmObX+VEyXuOatmOLObQFfOzkhmJnV+0gaHGl
         5XMr0n5/MFz5UhXdaY32kldgLH5dVKhzM/D5WDUsTKNoGi9cVuC+MiI8pcROF7fnTniN
         nfZ0aMsnHF5Cq1PNcmsEywqF7k1bukeNh4ckMhcskPQ1/mnOcQJSkW2717O6idkrc6/u
         H9kq5sqtl+Lb4Sp/C2TIRbgM4aFv+ru4QARq3FUTB8jsLJce3jTg8+U2HRB7PkXuo8Av
         JNhg==
X-Gm-Message-State: AOAM533NB2aIzLDjPNNnbn+id0CAqr4VoDOce1Ni5u6VR5gzAPI07CXR
        kuRTICUZ2tHSLYEHnuIbvWGx5fR8sV41icD/ZO/+famAYSOXQusaweTXU6LnmX6kW4x2Pkxoxj/
        QV6WKJ1U1BTjTfyYIuLEXfpUc
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr5135968wmh.93.1643791563288;
        Wed, 02 Feb 2022 00:46:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOc8cdyaslolsIIxQodJLho1aNIKNdP+8hs8Kq/JhdZJPYGQq4WH3NEN3pv9foMaQLLMG8PQ==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr5135948wmh.93.1643791563135;
        Wed, 02 Feb 2022 00:46:03 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14sm18994810wrd.91.2022.02.02.00.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:46:02 -0800 (PST)
Message-ID: <570d4384-b838-2bf6-1ff5-f8956ba7cee5@redhat.com>
Date:   Wed, 2 Feb 2022 09:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>, Sam Ravnborg <sam@ravnborg.org>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
 <YfmeztkVXwZzAwYe@ravnborg.org>
 <0yOiGD-56rTdV--oDietLeMO46Z8iFNnCNVVRg3Yh9D13AghGCYm5aP67SoswHY7Ye3vc3UEKzgtI02-F6vJ4b5xGLlE5yg6n2HznaWzYvg=@emersion.fr>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <0yOiGD-56rTdV--oDietLeMO46Z8iFNnCNVVRg3Yh9D13AghGCYm5aP67SoswHY7Ye3vc3UEKzgtI02-F6vJ4b5xGLlE5yg6n2HznaWzYvg=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 23:29, Simon Ser wrote:
> On Tuesday, February 1st, 2022 at 21:57, Sam Ravnborg <sam@ravnborg.org> wrote:
> 
>> As I wrote in another part of this thread(s) - typing the patch is easy.
>> But I do not understand the userspace implications so I need someone
>> else to say go.
> 
> User-space shouldn't really use the connector for anything except making it
> easier for the user to understand where to plug the display cable. I think a
> generic "panel" connector type makes sense.
> 

I'll drop this patch from the series. I didn't have all the context and thought
that was an opportunity to add an I2C type, since there was a SPI type already.

But seems to be more controversial than I expected and shouldn't really matter
for a tiny driver like this. I will just go ahead and use the Unknown type.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

