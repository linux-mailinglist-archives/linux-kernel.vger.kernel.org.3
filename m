Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA35A55D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiH2UzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiH2UzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:55:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D541F9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:54:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so2754079pja.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc;
        bh=GEtwMjD/OIVlmkpbYEiHU4MKz+tfzFSV5uKsJpcHyfY=;
        b=SX5tThtFcX1rw5/i3Uy9JWlKDJA54aA6jyBep9G2KRko2X0Z5FI+0+xn59Qj3jcObj
         Z9ZlGq4TriU0njPRbu3reIfTnKBHArZXhvWXOYcevMPigBWBWxEWk+OCVjReJL8QMaIY
         MFr8xFNZlZP6YAJKGXmAT/l+3dz4SSJqkbGnGRTD0k8Z4vdneOoIW7JVBfkSvoxZA23o
         cAN39LPzKsrsPQESdCvmC5TBr+5bab+EOLAoPuP4P+M8hPat2oCvrRYD64Jy17vjtWlY
         FgRy+ZZoALrfZWs02UQi/qlb8cEp4rBjwJ60xyn5tFLjQnPwGZ/JhW3nU1u2VG/t8Az6
         VHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=GEtwMjD/OIVlmkpbYEiHU4MKz+tfzFSV5uKsJpcHyfY=;
        b=epd+cfYD+3oRXndo+ObnIVPoM/+gPUn3u9SklWCd8mzOB1EMYtX2cy2uD4xdx7G2Sl
         0eJpsbmQgarfps2qHgV8KL9M14RZh37JxpwuESJ3uFSN6pkcKXRejAboCxjL8n1opAbv
         dglM0VGCXbKPGfh1BymtdhTlksjy7M3na5ZIGBZ3NVwMYhk47IFLxKtsFTquLuDc8wx9
         mRD37onR7d9zdjYuL7DBm2NSC/tjKfoXaE5Rp6uXuLuG88uzRFc1QdxwmnLVFk0IRAgp
         AaDOWz/okqICnIbPdLNUt8cKwh2u1jcXM5wN0ckiJGctSXcJEdFmwAe1it02z9L4cjio
         9K7w==
X-Gm-Message-State: ACgBeo31ZaI1w1wtlRHF9VCFDTmXb5JagDXiBx2M6VYOG5MzMIsmZ1lp
        LityC6HiwsCBqpOd82POrC2QpA==
X-Google-Smtp-Source: AA6agR4C7JudXsZj1PSNIQ/LL8c8PrA2AoQh1ZQzSSGEnGXXx0fmXEwDItVOPqXOtycsS5cVqt8qNw==
X-Received: by 2002:a17:902:ced2:b0:16e:e19b:c5c9 with SMTP id d18-20020a170902ced200b0016ee19bc5c9mr18815203plg.136.1661806483563;
        Mon, 29 Aug 2022 13:54:43 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090a2c4500b001efa9e83927sm7016156pjm.51.2022.08.29.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:42 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
In-Reply-To: <CAFCwf12P6DckVUJL7V_Z7ASj+8A3yyx9eX5MpZPF47Rzg6CjEA@mail.gmail.com>
Date:   Mon, 29 Aug 2022 13:54:42 -0700
Message-ID: <7hh71uixd9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded (and sorry I misspelled your name last time),

Oded Gabbay <oded.gabbay@gmail.com> writes:

> On Tue, Aug 23, 2022 at 9:24 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Hi Obed,
>>
>> Oded Gabbay <oded.gabbay@gmail.com> writes:
>>
>> [...]
>>
>> > I want to update that I'm currently in discussions with Dave to figure
>> > out what's the best way to move forward. We are writing it down to do
>> > a proper comparison between the two paths (new accel subsystem or
>> > using drm). I guess it will take a week or so.
>>
>> Any update on the discussions with Dave? and/or are there any plans to
>> discuss this further at LPC/ksummit yet?
> Hi Kevin.
>
> We are still discussing the details, as at least the habanalabs driver
> is very complex and there are multiple parts that I need to see if and
> how they can be mapped to drm.
> Some of us will attend LPC so we will probably take advantage of that
> to talk more about this.

OK, looking forward to some more conversations at LPC.

>>
>> We (BayLibre) are upstreaming support for APUs on Mediatek SoCs, and are
>> using the DRM-based approach.  I'll also be at LPC and happy to discuss
>> in person.
>>
>> For some context on my/our interest: back in Sept 2020 we initially
>> submitted an rpmesg based driver for kernel communication[1].  After
>> review comments, we rewrote that based on DRM[2] and are now using it
>> for some MTK SoCs[3] and supporting our MTK customers with it.
>>
>> Hopefully we will get the kernel interfaces sorted out soon, but next,
>> there's the userspace side of things.  To that end, we're also working
>> on libAPU, a common, open userspace stack.  Alex Bailon recently
>> presented a proposal earlier this year at Embedded Recipes in Paris
>> (video[4], slides[5].)
>>
>> libAPU would include abstractions of the kernel interfaces for DRM
>> (using libdrm), remoteproc/rpmsg, virtio etc. but also goes farther and
>> proposes an open firmware for the accelerator side using
>> libMetal/OpenAMP + rpmsg for communication with (most likely closed
>> source) vendor firmware.  Think of this like sound open firmware (SOF[6]),
>> but for accelerators.
>
> I think your device and the habana device are very different in
> nature, and it is part of what Dave and I discussed, whether these two
> classes of devices can live together. I guess they can live together
> in the kernel, but in the userspace, not so much imo.

Yeah, for now I think focusing on how to handle both classes of devices
in the kernel is the most important.

> The first class is the edge inference devices (usually as part of some
> SoC). I think your description of the APU on MTK SoC is a classic
> example of such a device.

Correct.

> You usually have some firmware you load, you give it a graph and
> pointers for input and output and then you just execute the graph
> again and again to perform inference and just replace the inputs.
>
> The second class is the data-center, training accelerators, which
> habana's gaudi device is classified as such. These devices usually
> have a number of different compute engines, a fabric for scaling out,
> on-device memory, internal MMUs and RAS monitoring requirements. Those
> devices are usually operated via command queues, either through their
> kernel driver or directly from user-space. They have multiple APIs for
> memory management, RAS, scaling-out and command-submissions.

OK, I see.

>>
>> We've been using this succesfully for Mediatek SoCs (which have a
>> Cadence VP6 APU) and have submitted/published the code, including the
>> OpenAMP[7] and libmetal[8] parts in addition to the kernel parts already
>> mentioned.
> What's the difference between libmetal and other open-source low-level
> runtime drivers, such as oneAPI level-zero ?

TBH, I'd never heard of oneAPI before, so I'm assuming it's mainly
focused in the data center.  libmetal/openAMP are widely used
in the consumer, industrial embedded space, and heavily used by FPGAs in
many market segments.

> Currently we have our own runtime driver which is tightly coupled with
> our h/w. For example, the method the userspace "talks" to the
> data-plane firmware is very proprietary as it is hard-wired into the
> architecture of the entire ASIC and how it performs deep-learning
> training. Therefore, I don't see how this can be shared with other
> vendors. Not because of secrecy but because it is simply not relevant
> to any other ASIC.

OK, makes sense.

Thanks for clarifying your use case in more detail.

Kevin
