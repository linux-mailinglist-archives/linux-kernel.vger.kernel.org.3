Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFB4C1AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiBWSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiBWSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:13:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 124BD4831F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645639993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95fZFgzFhUpzX6RItnD0JyQ0tqRlNULc6H8xcXm68i8=;
        b=ComuE9UjRhcbdZhYkV3OnbnI9bq9DN1ULt4fYHkCcsGqQSs4Fq3jcMUa/iEuG5pcMX8go5
        xt9cjkq+EqQ7bLo3bPSnFZiVhVUil5ZNoV9GFAYOqUDbGRQa8jZ0zQivobIBt3/2UakwOi
        hcXeRg7mged8CFUwne5M7Hfm6DgLY8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-B7J0DwEOMH2rhI1d5kCUpQ-1; Wed, 23 Feb 2022 13:13:11 -0500
X-MC-Unique: B7J0DwEOMH2rhI1d5kCUpQ-1
Received: by mail-wr1-f71.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so9853753wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=95fZFgzFhUpzX6RItnD0JyQ0tqRlNULc6H8xcXm68i8=;
        b=5L7imaH3IepBoJTP9yGoCDuK0WDAmBYfFZUVz6OgNtAOc1hiIV11onalm2fOQ6aaQ1
         o7D6EIu6SUkzRC/B0nW6r9uxqz100+L17YRZ/a1+r+UdQA8+kcDi4pls77HhYvG7XBwR
         JUVfyTkflAlyOIuOB3FTcu1YQtvZ7Eirp2DGs67rHgBC/pKc2oLsAKP76Rx/AEuu+5ZD
         +UFhAImu61ADlxYWFzWQiR317R3hhJdp+JVK18/OS2pV1UC6mcwcw7Ae/WXSN4ZvTqZI
         hu9VLYQAOPunthLZokbVdCqsMdqYgdY9F80NHh/BmaWMjxHll8awwow+ztaIHc1fMP8X
         BBXw==
X-Gm-Message-State: AOAM531AZabmedQSUlPxmMdrZ9b8jHbuX0ZRoiLydwgpdiR++D18pzDt
        PBuNDM+80jakz51B7HUvF4703ixikeHTIpzl6/rpPK1/2rFvP/Zv0STtSEUstP4O9r2KmUWMBYj
        s4NzrFGusMYlFsAiCT2p/4M5G
X-Received: by 2002:a05:600c:4b92:b0:380:e46c:c35 with SMTP id e18-20020a05600c4b9200b00380e46c0c35mr723242wmp.15.1645639989691;
        Wed, 23 Feb 2022 10:13:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+OMBA5FBflXxH1bgqITdjSzJn7yz73jIBRhiyyfuoGwM/4IaCFSE4PIcSUMEwpEBhJd4yHg==
X-Received: by 2002:a05:600c:4b92:b0:380:e46c:c35 with SMTP id e18-20020a05600c4b9200b00380e46c0c35mr723183wmp.15.1645639989344;
        Wed, 23 Feb 2022 10:13:09 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e7sm250125wrg.44.2022.02.23.10.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:13:08 -0800 (PST)
Message-ID: <a9df1753-8e3b-55bb-2dab-9e7aeaa52a8d@redhat.com>
Date:   Wed, 23 Feb 2022 19:13:07 +0100
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223171235.GF3113@kunlun.suse.cz>
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

On 2/23/22 18:12, Michal Suchánek wrote:
> On Wed, Feb 23, 2022 at 05:54:54PM +0100, Javier Martinez Canillas wrote:

[snip]

>>
>> Yes, that's what I tried to say. But your commit message says "To enable
>> use of VESA modes with simplefb in legacy BIOS boot mode" and that isn't
>> accurate AFAIU (unless you meant sysfb instead).
> 
>  config SYSFB_SIMPLEFB
>         bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
>         depends on SYSFB
> +       select BOOT_VESA_SUPPORT if X86
> 
> This to me means that it's simplefb specifically that requires it, not sysfb.
> More precisely SYSFB_SIMPLEFB which is the simplefb implementation on top of
> legacy BIOS.
> 

Ok, I see what you meant. The fact that simplefb is what's named to the part
of the sysfb driver that register the "simple-framebuffer" platform device
and also the name of the fbdev driver that matches the "simple-framebuffer"
is too confusing.

My point about the subject line remains thought, I would use something like:

firmware: sysfb: Enable boot time VESA graphic mode selection for simplefb

But I'll stop bike-shedding this. I don't mind if you keep the current line
and feel free to keep my r-b tag.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

