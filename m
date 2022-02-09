Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7034AF626
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiBIQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiBIQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32A06C05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644423048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFGitWE2+XjLxofbVGLQx4GJSy8OuJZkaSySeP1Crog=;
        b=IFxn8zoj2KqZFXDKt3Aco+x7SJHWtYMeeibidLMBx6J9kwATDjY2fmf0Aru4vGCTVxu5G9
        4SwRHW8wsXnDtYvQhjs3QbNR2WCoY37C6XUV6htGqA7VIG2mK7kkSC3y6VyyWga6jp3Cce
        1gkfedDebcqRmPVwieCsVNk5apCoUa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-F1gGqbQtMrOpzMjk-eaMsg-1; Wed, 09 Feb 2022 11:10:47 -0500
X-MC-Unique: F1gGqbQtMrOpzMjk-eaMsg-1
Received: by mail-wr1-f69.google.com with SMTP id g17-20020adfa591000000b001da86c91c22so1294786wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mFGitWE2+XjLxofbVGLQx4GJSy8OuJZkaSySeP1Crog=;
        b=GTN7nmoZeGv79eGYEj5VyAbW3ZtdSbt9RiHyM5LpBK8jkQ9WZJY2icBvPZSn8aYbXt
         IyBmOKWEZF33Gync3BreiB7fhNYb6366KTk/e8ZlwkBEKcrc/7yIjThB4Zg9jgo/SsUv
         KfYrRu32ZrqbMKAm48UwKphRc/AC5J+ZHgfbe4ouuLE7WjDBHepfi0yjsMUqo/Vr3x8F
         0HBYMSSmPyhoRULb6KUjFfxCvB4XU53EQXQC9O4CUeVa5pJ1xo0hbav+AYZTiz5YYtHp
         +5zbqQtsFiIQMXT2d8qopl8gMH2PWPt35UvzvvKHo9QFy5hU32B2oEoUfXz0Su2SJ2sL
         Vmmw==
X-Gm-Message-State: AOAM531UmTkonvtQghOpJwbUeZ/fFwEV/JvU9jNawDEah4ZLyjn2zv1q
        thCsF+vvBXIoL99RKt0jcgAaNU75HHqWuqVLXTWWCuZewPQRym6gqjBgGe4PjSfYtGKhNmMGVSu
        zpBAk1Q9yOQOu6TVunNkceC85
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr3214210wmq.44.1644423044643;
        Wed, 09 Feb 2022 08:10:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3zGpKODhlGXZHF/WUPS4W/m1RBSXDfqzPUnuyKsIXdGF/OBtwjUhqThnva+EpdQTtV3YvBQ==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr3214181wmq.44.1644423044396;
        Wed, 09 Feb 2022 08:10:44 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c18sm6654588wro.81.2022.02.09.08.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:10:44 -0800 (PST)
Message-ID: <ee81dc1f-2a45-9113-f1fb-47ef226a0da5@redhat.com>
Date:   Wed, 9 Feb 2022 17:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI
 support
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <e6efb2fd-300e-5282-1f2e-a68130d0b45a@redhat.com>
 <YgPbleB+LAQ5ZXyB@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPbleB+LAQ5ZXyB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 16:19, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 02:04:17PM +0100, Javier Martinez Canillas wrote:
>> On 2/9/22 13:25, Geert Uytterhoeven wrote:
>>> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
>>> <javierm@redhat.com> wrote:
> 
>> Yes, I know. Didn't feel like it, because the patch is a WIP anyways
>> (I haven't tested it but was included just for illustration purposes).
>>
>> If someone confirms that works then I will include a proper DT binding
>> in the next revision.
> 
> In a few weeks I hope I can do this.
>

Thanks, there's no rush. I just included this for your convenience because you
mentioned that have an display with a SPI interface.
 
> But you know Linux is almost always broken (*) on the certain embedded device
> if nobody keep an eye each rc cycle. It might take time to return it in shape
> first.
> 
> *) Speaking out of my own experience with device(s) that I possess.
> 

Unfortunately that's my experience too. I'll keep this patch in the series and
marked as RFC. But in v4 will extend the DT binding to mention the SPI devices.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

