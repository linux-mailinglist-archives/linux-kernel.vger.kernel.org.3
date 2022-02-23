Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816CD4C18AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiBWQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbiBWQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82889527D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645634095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clONYmZ5X2qlfrfzJXRhqvS1L3/caQ4kzeJBK6mGohk=;
        b=ercBwKn+MFV+8vGY1W14XWigiUxu3lmI55faiI5FSDPo/OBqeFHtVzp+AEl2MfahEbsauw
        yqThiG67o+oR5AfU+Y7Vyl9DZrmbYRoBTQAmhkZwK7W+bGgG7KE0BU45RGL/B6y8eJw/v4
        bcGWHzuUuHKkZdy1FQZJpinOs/Ci5Rg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-Mqk6tT2xOxaaGomKIQfxTw-1; Wed, 23 Feb 2022 11:34:54 -0500
X-MC-Unique: Mqk6tT2xOxaaGomKIQfxTw-1
Received: by mail-wm1-f69.google.com with SMTP id az39-20020a05600c602700b00380e48f5994so1221361wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=clONYmZ5X2qlfrfzJXRhqvS1L3/caQ4kzeJBK6mGohk=;
        b=SDlInbwZyV1sBz4Ll2AlJDvMIo1k/Aok0RBA1MiJUemNbc2Lz3MCnxvQd+j7JfSO4Q
         3i382yVmdI2b/fyYzEZoJfThGqHrO7K3IBNdrLI1H6OQXxNTeeOC1HBEXY2AjQIDpRiv
         1y+nfWlt8OiJFIWy6e+C5Zq/FuWbVA8WEtq6GLot2cvUFIU3BWnBkUR7uDvf1WQ87L4r
         3gYltxRtEnrS5bVw3FWS/qq4zN3rmqsD1roysUQTzLE7eldjn4/TcDTxnBF1kZApyPRW
         ckHOT4huCYCbb2tDhsDBtiEZuvbZ+wssqr+zs9wyHA1UGgDb6I2wulpxWMaUTqLejiji
         Dfjw==
X-Gm-Message-State: AOAM53077EGCY9EqvNISfr7QfqFQg1QHLWmLAvyIYuw0frU6oJRunTJV
        kFHPXl5uiSjOJDOajIykY2ONTXv/XTu/l20ohDUdLJ01TNW948b4da7LWzjAqfRAlq0ZdhJ6wgB
        MfBSCVRUGDNn3EnSzxvFFwawA
X-Received: by 2002:adf:e544:0:b0:1ed:b6d5:d26b with SMTP id z4-20020adfe544000000b001edb6d5d26bmr327968wrm.634.1645634093126;
        Wed, 23 Feb 2022 08:34:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBzj3eVsLKn39DYPTvyzPcJE9MCfAnVshf1YYTW2KZMiRN8LC5w3bIaIsgJsQ3ygOVbXPktQ==
X-Received: by 2002:adf:e544:0:b0:1ed:b6d5:d26b with SMTP id z4-20020adfe544000000b001edb6d5d26bmr327942wrm.634.1645634092830;
        Wed, 23 Feb 2022 08:34:52 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a1sm40095wrf.42.2022.02.23.08.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:34:52 -0800 (PST)
Message-ID: <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
Date:   Wed, 23 Feb 2022 17:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220218160436.23211-1-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On 2/18/22 17:04, Michal Suchanek wrote:
> Since switch to simplefb/simpledrm VESA graphic modes are no longer
> available with legacy BIOS.
>

Maybe you can mention that is the "vga=" kernel command line parameter
since that may be more evident to people reading the commit message ?
 
> The x86 realmode boot code enables the VESA graphic modes when option
> FB_BOOT_VESA_SUPPORT is enabled.
> 
> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop

I think you meant "VESA modes with the sysfb driver" ? or something like
that since otherwise it seems that you meant to use it with the simplefb
(drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
"vga=" param as far as I understand (it just uses whatever was setup).

The name sysfb_simplefb is really horrible, because it is too confusing
and probably we should change it at some point...

Patch itself looks good to me though.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

