Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB94C1B03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbiBWSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiBWSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 411004EA30
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645641300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypIs7bkNYvlEnOXn/O+REGsfb4DaXi/zE6H2OQf1oCs=;
        b=cy4JSxBDdDfPM7KwtHSJ5r4b02KLDG3otxXobM8IFST83UqM+5TKhT5R0xuu7751Ve10yN
        OpaK4UBbTjL7Ni5x6P0rN/0HqGouNzWv/xJlUSwxrlyb75L8UkE9coBjVDC1aMG5gtaJWq
        ttnywj4/vsmojHHtXWA4ZVKMiIsUXkQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-ZUfSqHPJPX6ThdeYux4GPw-1; Wed, 23 Feb 2022 13:34:59 -0500
X-MC-Unique: ZUfSqHPJPX6ThdeYux4GPw-1
Received: by mail-wr1-f72.google.com with SMTP id c16-20020adfa310000000b001ed9cd8f4c7so1856602wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ypIs7bkNYvlEnOXn/O+REGsfb4DaXi/zE6H2OQf1oCs=;
        b=PthbttkBA5ZN5hts4mCwScKNgIMy4RuuVP5G9euEEPKJtfQk6oFMRj/swrCxRib8hl
         rsTHR4OfcrOzYfPtxPM59X2v5Wj4w+P5cCe/hlvhmhdLtaqa2igRTXESE1oHgy0zFOfw
         bbwe6KxMxgKqa9Bc5zLV25r+TMmlcav2FiNgeiRqZv4mLrkEqf7zFi8eX/Y3ifZGbhS3
         J3KKXKjcxs1Du/+WIB0Kw8N1z2g8iiXPaLcdUV43azBQh294tbSOzXR/zM8x10BezkJs
         z4vXtX6JFmtUIYGW0yNAyB4UETykeOLJEh0rqjukStfen0lwMQsnmGRft6qhgQTeNLO5
         B0Mg==
X-Gm-Message-State: AOAM531RKCYqCwzrhtw42+3O/vCJrst0WfIq81wjsmAbVxa8CKbvI7EV
        6u0OC06r6nsggjJEEhfSs6O8r2qtyVKCODP2Uz2LeNEBl/oAA4jk/7t5Nz8RzT0w8Ql2ZqxHPm7
        OQg45z/KzwqikACyfpeuVcJq+
X-Received: by 2002:a05:600c:1e84:b0:380:d32d:6add with SMTP id be4-20020a05600c1e8400b00380d32d6addmr779460wmb.21.1645641297940;
        Wed, 23 Feb 2022 10:34:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTHgN+Rdge2lsZegxKPa8wLCjjbMqeVpYlQilsAJnylW5S2vTRVysSyPJI9A+AOG/fZzzhQg==
X-Received: by 2002:a05:600c:1e84:b0:380:d32d:6add with SMTP id be4-20020a05600c1e8400b00380d32d6addmr779436wmb.21.1645641297738;
        Wed, 23 Feb 2022 10:34:57 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e7sm294678wrg.44.2022.02.23.10.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:34:57 -0800 (PST)
Message-ID: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
Date:   Wed, 23 Feb 2022 19:34:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
 <20220223164528.GE3113@kunlun.suse.cz>
 <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
 <20220223171235.GF3113@kunlun.suse.cz>
 <a9df1753-8e3b-55bb-2dab-9e7aeaa52a8d@redhat.com>
 <20220223182341.GG3113@kunlun.suse.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223182341.GG3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 2/23/22 19:23, Michal Suchánek wrote:

[snip]

>> My point about the subject line remains thought, I would use something like:
>>
>> firmware: sysfb: Enable boot time VESA graphic mode selection for simplefb
> 
> I see where the confusion comes from.
>

Yeah. And just to clarify, the "simplefb" in the subject line I proposed
was about the sysfb simplefb and not the fbdev simplefb :)
 
> The efifb (and probably vesafb) has implicit unstated dependency on
> sysfb. So the drivers that select BOOT_VESA_SUPPORT should instead
> depend on SYSFB, and then SYSFB can select BOOT_VESA_SUPPORT, and it
> will look much saner.
>

That indeed would be much nicer. And I agree with you that there's an
implicit dependency that should be made explicit since SYSFB is what
registers the "efi-framebuffer" or "vesa-framebuffer" if SYSFB_SIMPLEFB
is not enabled.

Should SYSFB should only select BOOT_VESA_SUPPORT if x86 ? I know that
in practice shouldn't matter because BOOT_VESA_SUPPORT is under x86 but
I guess is more correct if that's the case.

And I think that FB_SIMPLE should depend on SYSFB_SIMPLEFB if !OF (since
a "simple-framebuffer" platform device could be registered by OF if a
Device Tree node with compatible "simple-framebuffer" exists).

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

