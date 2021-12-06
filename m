Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3881A46A5D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbhLFTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbhLFTpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:45:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CEC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:42:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so24622719wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=XoyDxWHFfkkShprB5fi0ZtCpkIroCq2M/CcUOnfbOhA=;
        b=w8sZ41kEdX4SRoPkzKCBKIOpzSsDrjyDTmuhgrbbcp5zpmFSvfGY7gNpZK0p0dMxAa
         uWrDVGdLjErc8kI0vHKRLdvR+xas3quAw8WLQmicLbCVcrujBGlSxKW5v4tNRzh5Rsld
         PbPH7ba+Ou0DcR+MLaSif954Gu9KWrAzQrbAJ9dnM20t0XW2ozYroSORAQOs3yEGfsWc
         0b8NifhWMgxwmzcAJ8vTR/83pq61hWtl1y1Me57+Y0zioTVaZzNksWyql3KdwajCCzjI
         pEOgp1cAfmONXrGWtiC6RzGuyMrHDMhZRencZZIde+pIeMZPjzNdS45FL5neth6TXFke
         HUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=XoyDxWHFfkkShprB5fi0ZtCpkIroCq2M/CcUOnfbOhA=;
        b=onSOE8+kHtWK5rL6dBV+pQzh11lhjWI4LTQL4M/kb4wLt/VzP6MgNX+Dk/uhGYauxr
         CXobPOICKG8hvRvFRzMbfpvS4sa7Opp+4DLInGDarJ6m/qY9z2WPSjR7C8ztsn0lJnxT
         /jWt5bnT9ALuZdfbKYBvrwKL+sdKuPSRLDh9t38IIbWNl3yFbuDGCvXLNbtiapieC12L
         qNXeV4hf4P8ibbUOdIOSaDkfUnGMhd0UwB821ulcOhb1Sh4iE3FQYG9mHEaJ/qk11rUB
         rX5AHdZvHwsNSyiO7bvDnMw4V4FPEJ9iczfFVQmhofbPVoKKUpYrX5Lded2erd4miQ4q
         D71w==
X-Gm-Message-State: AOAM531pwfHijGhwPHWBHSu2YtR87EhF+0AumYRqnDuib81xyw31Kp5E
        3uHbmWwsIb93hrHeWKR0eo7cMQ==
X-Google-Smtp-Source: ABdhPJx8pLA553HMWI1HuMsyxL4boJMISHN0MO4UL5wXFAniqnUsOICkxQ/hPb/2AWWD4Mll3NrfjA==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr44894938wrq.44.1638819726062;
        Mon, 06 Dec 2021 11:42:06 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o9sm12332737wrs.4.2021.12.06.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:42:05 -0800 (PST)
References: <20211205180816.2083864-1-martin.blumenstingl@googlemail.com>
 <20211205180816.2083864-3-martin.blumenstingl@googlemail.com>
 <1jfsr659v1.fsf@starbuckisacylon.baylibre.com>
 <CAFBinCAceRkO86bXfUYnDwup3At9MaN-PnOiLxa-1fYO5SwOQA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: Re: [PATCH RFC v1 2/2] ASoC: meson: aiu: Move AIU_I2S_MISC hold
 setting to aiu-fifo-i2s
Date:   Mon, 06 Dec 2021 20:36:45 +0100
In-reply-to: <CAFBinCAceRkO86bXfUYnDwup3At9MaN-PnOiLxa-1fYO5SwOQA@mail.gmail.com>
Message-ID: <1jpmq9ed0z.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Dec 2021 at 18:28, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Mon, Dec 6, 2021 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Sun 05 Dec 2021 at 19:08, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>
>> > The out-of-tree vendor driver uses the following approach to set the
>> > AIU_I2S_MISC register:
>> > 1) write AIU_MEM_I2S_START_PTR and AIU_MEM_I2S_RD_PTR
>> > 2) configure AIU_I2S_MUTE_SWAP[15:0]
>> > 3) write AIU_MEM_I2S_END_PTR
>> > 4) set AIU_I2S_MISC[2] to 1 (documented as: "put I2S interface in hold
>> >    mode")
>> > 5) set AIU_I2S_MISC[4] to 1 (depending on the driver revision it always
>> >    stays at 1 while for older drivers this bit is unset in step 4)
>> > 6) set AIU_I2S_MISC[2] to 0
>> > 7) write AIU_MEM_I2S_MASKS
>> > 8) toggle AIU_MEM_I2S_CONTROL[0]
>> > 9) toggle AIU_MEM_I2S_BUF_CNTL[0]
>> >
>> > Additional testing shows that when AIU_I2S_MISC[2] is set to 1 then no
>> > interrupts are generated anymore. The way this bit is managed by the
>> > vendor driver as well as not getting any interrupts can mean that it's
>> > related to the FIFO and not the encoder.
>>
>> Not necessarily. If the encoder stops pulling data, the FIFO will going
>> over the DDR. Since it generates an IRQ after reading N bytes, IRQ would
>> stop too. AFAIK, if the pipeline is stalled, the IRQ stops anyway
> ah, right. so I think you're right: it can be either way
>
>> ... but this is not really important
> I'll remove that section from the description in v2
>
>> >
>> > Move setting the AIU_I2S_MISC[2] bit to aiu_fifo_i2s_hw_params() so it
>> > closer resembles the flow in the vendor kernel. While here also
>> > configure AIU_I2S_MISC[4] (documented as: "force each audio data to
>> > left or right according to the bit attached with the audio data")
>> > similar to how the vendor driver does this.
>>
>> I understand the part of HOLD, not about FORCE_LR.
>> Is it necessary to fix the problem ? Have you tested without this change
>> ?
> On my Le Potato board (GXL / S905X) FORCE_LR is either enabled by the
> bootloader or being enabled is the default value.
> All versions of the vendor driver are also setting it in some way,

+1
Would you mind adding a comment in the code saying just that - so we
know why it's there ?

> including the latest one that I have access to [0].
> I prefer to keep this explicit write in for two reasons:
> - we're not hit by surprise if some SoC/bootloaders don't set this bit
> by default
> - the code in the mainline does not skip anything that the vendor
> driver does

You can bet I've skipped a fair share of what the vendor driver does, on
purpose.
>
> To specifically answer your question: I have not tried whether this
> bit needs to be set and if unsetting it manually breaks anything.
>
>> > This fixes the infamous and
>> > long-standing "machine gun noise" issue (a buffer underrun issue).
>>
>> Well done ! It took us a while to nail it, Thanks a lot !!
> Thanks - this took a while to figure out but it's great to finally
> have it solved!
>
>
> Best regards,
> Martin
>
>
> [0] https://github.com/khadas/linux/blob/khadas-vims-4.9.y/sound/soc/amlogic/meson/audio_hw.c#L194:L202

With this, feel free to repost without the RFC tag and with my

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
