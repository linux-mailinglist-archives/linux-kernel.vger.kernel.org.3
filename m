Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8EE4A5330
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiAaX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbiAaX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643671587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoObquMC1Y099gjHiKrPd1NW4/MPXx5uArpEcPqAfgo=;
        b=VVr29UUdx1lqKW/nLDNwf+jjbd38eWgo/+pSACB28biIvM/Qz5waoH8xr74g3QCEStRN+Y
        ma8ErgoqQphvJMDz18uyi0aHz05kCBDWjvlwEgbNcdJcUaWqmXkxZtDr58wMYDCGRXP8Bi
        Jy0rh6D43AJ15rcnvyvUSe4+GvPn+tk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-_z7Y6qOTPQarSeqrXQ7q5Q-1; Mon, 31 Jan 2022 18:26:24 -0500
X-MC-Unique: _z7Y6qOTPQarSeqrXQ7q5Q-1
Received: by mail-wm1-f69.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so436027wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YoObquMC1Y099gjHiKrPd1NW4/MPXx5uArpEcPqAfgo=;
        b=qYSkVVZz6fyXaSTyHJKOZuLJEN/WNZbxAdcZ1r0Z0677HB3rivcdLit9wGUt0Xa+7M
         DxBJSBg4cSeAj/+mjwfZsr5DN2+tAg5yqNGwEQHE/qbOcFZQbu01E1NefV+/srFXnF1g
         W0wjCXoroT2XrAWouSd+rJ8vcuxjb99POi+gTXC9Xnvz8SdHMcAhQn/jV/h7TO93VBMO
         mRDsrqnWTYVXkZUqQI1EwhHWX++24zLDI8JX53RVnFxnn8S0LeB+pJPpndVAvnXw6CbU
         Y2XCGm9fKQ/dFy+T1rEUID0OpPG5XLwrJ8fJZVnDDo8l5/T/uoLw2WHManZzpCovc3Z+
         rfMQ==
X-Gm-Message-State: AOAM530vwlNMKd14HlHrGOAXXuVcyOQpJY1tGWHG4uhzr6Dsx5DcNUXR
        A1H3igr3g24mChhBIVeFWfhmiBMWwAylstuWsSMi/C+3HqsGlslvKuFnomJ+QgrpIP0RuATOlBo
        8gxebrZNQOgflwvR3z1uhkHXj
X-Received: by 2002:a1c:440a:: with SMTP id r10mr20863796wma.142.1643671583665;
        Mon, 31 Jan 2022 15:26:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvDyBUYLTU/L1b51CS4uxvaGJqLeLCo2c7D1CjSfutkqldhTLTiY2yHFXAdgxPYSuz6ErDnQ==
X-Received: by 2002:a1c:440a:: with SMTP id r10mr20863790wma.142.1643671583508;
        Mon, 31 Jan 2022 15:26:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h4sm15500586wre.0.2022.01.31.15.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:26:23 -0800 (PST)
Message-ID: <03ffaaa6-1a8c-68fa-dd17-1e6d0e1e4868@redhat.com>
Date:   Tue, 1 Feb 2022 00:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfhMESTylI1NTKDg@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 21:52, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 09:12:21PM +0100, Javier Martinez Canillas wrote:
>> There isn't a connector type for display controllers accesed through I2C,
>> most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.
>>
>> Add an I2C connector type to match the actual connector.
>>
>> As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
>> type"), user-space should be able to cope with a connector type that does
>> not yet understand.
>>
>> Tested with `modetest -M ssd1307 -c` and shows the connector as unknown-1.
> I had expected unknown-21??
>

As you pointed out in patch 3/4, I forgot to change DRM_MODE_CONNECTOR_Unknown
to DRM_MODE_CONNECTOR_I2C after adding this patch...
 
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>> ---

Thanks!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

