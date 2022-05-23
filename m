Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08553147D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbiEWOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiEWOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3D5F1EECD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653315065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQ2F3mi+DuL7lUq4YcbWoe7vDTV3N7hMeos9Mv7PPDg=;
        b=Ka7ZS8slLInCkXYXRrJZ0GOY2QKuXg9eSKcQ4vjAK+aOABUZPYR8jmT/CzWUMVfV3HKMEZ
        7za2SxKZy78t5+rZHCdxHay15Uv4GQETOlVIwz3Dt59P8l+22XrO3jksj825XAeACfXul2
        VFPuP/nEztX7f1RBaTs23jZiADFlEDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-ZNQwAjzZPt6AwPYU1adGJw-1; Mon, 23 May 2022 10:11:04 -0400
X-MC-Unique: ZNQwAjzZPt6AwPYU1adGJw-1
Received: by mail-wm1-f70.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so5687249wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQ2F3mi+DuL7lUq4YcbWoe7vDTV3N7hMeos9Mv7PPDg=;
        b=tuvz1Mi2RwVd/Uu+jaYOp3k5lGY0zsNatmyJFZHvME/ZwfUWnv7gnTTjI13zHAV+SH
         RJwF4lgARd/AI8ICPi0Uudj3n9UjIIZ2jnftD97fEciRp5+iq+iN/xs9TQjfIB0FwDR/
         JCNvDi0KsBKv1BLxx4qehfaK7lIy78cwSIUuVY3KjB4LZ8diEWgtkStBPXKEiLt/zTjV
         Yot8LI2cfZXblhHtS9cvBbYFz7SaEAg0q94LHFI9VFlGHrqDsK1F2XPB+A8mPSvBDHXG
         Nz43cRBTlMhfkQJYPfhNn52eCtsJeRjbiWie8aXogZFbOE8prmPKKreN6lwlpty4EKPi
         psCg==
X-Gm-Message-State: AOAM530WE+Yj4DU8VUL1Zgb5CWCYAnmUp3gLD/g63lv5YwsJD41y4iVt
        jskUnRpoh/E2yLDeHi0/HL2EU0JLUt7hQnJ/3AkXY4laPZpHL+dI+DMEc1Xq2CCoI6wBdNLnehE
        Bmgy84iBj9GaOTGbtVctypS7U
X-Received: by 2002:a05:6000:1a45:b0:20e:6164:d86c with SMTP id t5-20020a0560001a4500b0020e6164d86cmr18845479wry.561.1653315063178;
        Mon, 23 May 2022 07:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymLcijc3WiiGUvKg1xxfLQz9gs2q9wfB9ZCIjGILyrJP57aIq3qOAI307PMuGJbT3BHnIfYw==
X-Received: by 2002:a05:6000:1a45:b0:20e:6164:d86c with SMTP id t5-20020a0560001a4500b0020e6164d86cmr18845462wry.561.1653315062962;
        Mon, 23 May 2022 07:11:02 -0700 (PDT)
Received: from [172.20.10.7] ([90.167.95.5])
        by smtp.gmail.com with ESMTPSA id l15-20020adfbd8f000000b0020e65d7d36asm10459492wrh.11.2022.05.23.07.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:11:02 -0700 (PDT)
Message-ID: <0389b672-a4f4-4943-7b3e-7732685ae6c2@redhat.com>
Date:   Mon, 23 May 2022 16:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/st7735r: Fix module autoloading for Okaya RH128128T
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <20220520091602.179078-1-javierm@redhat.com>
 <CAMuHMdVmFGjGbHz1yo7tOzqtUbMTDkUxaMo2fVSp1HMU=_1emA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVmFGjGbHz1yo7tOzqtUbMTDkUxaMo2fVSp1HMU=_1emA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 5/20/22 14:02, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> CC spi
> 
> On Fri, May 20, 2022 at 11:16 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
>> registered via OF. This means that the st7735r.ko module won't autoload if
>> a DT has a node with a compatible "okaya,rh128128t" string.
>>
>> In that case, kmod expects a "MODALIAS=of:N*T*Cokaya,rh128128t" uevent but
>> instead will get a "MODALIAS=spi:rh128128t", which is not present in the
>> list of aliases:
>>
>>   $ modinfo drivers/gpu/drm/tiny/st7735r.ko | grep alias
>>   alias:          of:N*T*Cokaya,rh128128tC*
>>   alias:          of:N*T*Cokaya,rh128128t
>>   alias:          of:N*T*Cjianda,jd-t18003-t01C*
>>   alias:          of:N*T*Cjianda,jd-t18003-t01
>>   alias:          spi:jd-t18003-t01
>>
>> To workaround this issue, add in the SPI table an entry for that device.
>>
>> Fixes: d1d511d516f7 ("drm: tiny: st7735r: Add support for Okaya RH128128T")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch!
> We really need to fix this at the subsystem level.
> 

Yes, agreed.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks! I've pushed this to drm-misc (drm-misc-next) with your Reviewed-by
and David's Acked-by.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

