Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409B539D47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349891AbiFAGd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349887AbiFAGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:33:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4693123B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:33:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u23so1123347lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0Xr/Fd9GfBK15ltB/N2CHCzT7+ewsuClkQQSJZqHtc=;
        b=aQ1r6OuBcEQh/Zfkd0fVtZoce3M2+shUJb2nsWPjY2p+p4SjwgYlan9v2jwSgDXlRU
         zwW1nZ880mcEhC7zy80rZwexRn2UjfCBjnoIxN65fJWUL7RfU4Q2Q3mBCkXRgxlR7T91
         U6l8RQZkED6r/nMMFPMpyiu6VtO77u/Jp+pSPiH7sFgIaFiP82hL9RKABNJ8R7FUhRYA
         YuBSKrQ4NzMXm2OvIId2q2j4L/yZvwnJBd4w11cBm6hzhcI9OMpMOIWgHxIW66wEbrf/
         6E6EqkOFNgnAxLhfq76YXAF4ZXYV/NqyallAKDLbxzc12ugTi0vMmsIpwLHacowHzNkT
         Rr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0Xr/Fd9GfBK15ltB/N2CHCzT7+ewsuClkQQSJZqHtc=;
        b=4B73lovm6rhSGgLKkeKfbJWkZYkIAjlf3EeXIjeP/s4sgaS43hJw/sN2Tg+OEcRe3+
         6MOqb/R6UfSLyh8Fp9jL8w47JdOyQeKUOS3OcE1laisfN4YDa+N7+SGZTpddXhxQJAx8
         ESqvv+l/DeDsy4w3WkknqT3ASRrOyXbhrf85w8etkpvqmVNbelwpcXAMDFEXxYZ0MUv9
         ArHuaHH63dOg51mCZ12vsvGPbFJhO6hf0XrWh/f9QtDKZUQq8/S/vdK78JHo5pV2r2I0
         sxvCp6N4tiOGrnB3oYaiB4cutDye6PgiXv7GQ6iC9RoE8AI8cAs0CuIh9smH5sZ+Ku+h
         Y9Aw==
X-Gm-Message-State: AOAM531reYACGajuIqKFIlAZXy3i2F1yebQ1Nj2IJLFmi1yGybxa4mFq
        TtF22p9W75Sd/A7t5JEXXRhCu16xYHsFcwIcnon+sxB3
X-Google-Smtp-Source: ABdhPJzFeAJJI/rILPyINLxIrgVGJYG5vV52I5qMzSpCUwxQ8GE2rhI9aguft4Ds5Q9rWmSIy6gfEsxhxnwBDeUGk30=
X-Received: by 2002:ac2:4c22:0:b0:478:7c35:a023 with SMTP id
 u2-20020ac24c22000000b004787c35a023mr32234471lfq.484.1654065203454; Tue, 31
 May 2022 23:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+gUpxzukjde1rMqRcPre8yMROBd3yQTCm89wMGb2zWriw@mail.gmail.com>
 <d136df0c-34fc-d21c-1353-fa82deb62975@infradead.org>
In-Reply-To: <d136df0c-34fc-d21c-1353-fa82deb62975@infradead.org>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 1 Jun 2022 12:03:11 +0530
Message-ID: <CAHhAz+iFHqaDZRZr9K80o9NY4SC+t2-BnngAnXxrhkPzw+FyWg@mail.gmail.com>
Subject: Re: Kconfig rules (depends, imply)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the clarification.

On Wed, Jun 1, 2022 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 5/31/22 05:14, Muni Sekhar wrote:
> > Hi all,
> >
> > menuconfig SOUNDWIRE
> >         tristate "SoundWire support"
> >         depends on ACPI || OF
> >
> > "depends on ACPI || OF" mean, SOUNDWIRE depends on both ACPI and OF modules?
> >
>
> "||" is logical OR, so SOUNDWIRE depends on either ACPI or OF (or both
> of them can be enabled).
>
>
> >
> > config SOUNDWIRE_QCOM
> >         tristate "Qualcomm SoundWire Master driver"
> >         imply SLIMBUS
> >
> > What does "imply SLIMBUS" mean?
>
> See Documentation/kbuild/kconfig-language.rst:
>
> - weak reverse dependencies: "imply" <symbol> ["if" <expr>]
>
>   This is similar to "select" as it enforces a lower limit on another
>   symbol except that the "implied" symbol's value may still be set to n
>   from a direct dependency or with a visible prompt.
>
> So (in your example) SLIMBUS is desired but not required.
> That means that the code that is built for SOUNDWIRE_QCOM
> probably needs to use IS_REACHABLE(CONFIG_SLIMBUS) to
> see if that SLIMBUS code is available at build time.
>
> HTH.
> --
> ~Randy



-- 
Thanks,
Sekhar
