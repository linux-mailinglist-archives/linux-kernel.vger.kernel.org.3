Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71AE57536B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiGNQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiGNQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:51:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC55509E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:48:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so4479069ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qdwr0Ml6l65d9PvQ1N7Cqu7i3NgaLCCXJQKH4OW6snM=;
        b=WW+Mt5NH1K828fylJUZ5VelGkCH2HdmOWxOk4e94fwyd/+wD6pkJPQ2wgqMeaijwyX
         9F5ThYUcqjYGzIBAR/FBPjevBm+rlWZKPw3Cu3TCClKUF7wTKoSlc+IiG/GiuQ70+Q42
         UDBLmTfs8LaYePDB+3Pa5U3B3CGhy9airybE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qdwr0Ml6l65d9PvQ1N7Cqu7i3NgaLCCXJQKH4OW6snM=;
        b=CoPLl6J9YwwUIY52RNnE/iNzsEYOfHOWIUjXWUXSs7hFgh7ku+KewqlBigst3UADzH
         O9C9CYfVuP/f+olzN4wpdmKC5KkwZBOW54cxJ+ggX/NuXD4FO/CN8R5RZb7qYpR5uIoi
         YjExE8uAhlUQOXtTPmVLQ4oqkd3nWks7DxPVrrzIlOMdmo9ZjLYZ+uiQs99M0roxaMQW
         yUw3KKbUjuqKPGr7IgObkbqoHENjbd5jloUxRuyyZGJHm5l5FtFDqfHRj4bxiqhFpr0a
         1qInBdMuvtyskFj3fuX6fAzsmo8r3A02SeobpDWEjlbkE9bsDXCLUa7ev9iZc0AeQjLX
         Wx3g==
X-Gm-Message-State: AJIora++ZYWqHY+MzaFsTKbrzbNv+243ph3vuo7V9brdotIfAVfkjMIu
        JgKuVkrl9LCfB2jVxJOy3o0AiPKElnamKMokx1Y=
X-Google-Smtp-Source: AGRyM1v1T+C529+mQW3UpD3f+U1G8jVbDs2DCC8Io7wVgmPNMiDt4hIdiOwDDuS9MiD4mTEz1Pvg4A==
X-Received: by 2002:a17:907:eab:b0:72b:2dd5:c956 with SMTP id ho43-20020a1709070eab00b0072b2dd5c956mr9358431ejc.313.1657817335844;
        Thu, 14 Jul 2022 09:48:55 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id bc4-20020a056402204400b0043a78236cd2sm1334497edb.89.2022.07.14.09.48.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:48:53 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id h17so3405253wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:48:53 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr8939974wrv.281.1657817332916; Thu, 14
 Jul 2022 09:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com> <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
In-Reply-To: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 09:48:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
Message-ID: <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:23 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Oh, it's not just this one. The lists of build regressions between v5.18
> and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
>
> [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
> [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org

Hmm.

Some of them are because UM ends up defining and exposing helper
functions like "to_phys()", which it just shouldn't do. Very generic
name - so when some driver ends up using the same name, you get those
errors.

And some look positively strange. Like that

  drivers/mfd/asic3.c: error: unused variable 'asic'
[-Werror=unused-variable]:  => 941:23

which is clearly used three lines later by

        iounmap(asic->tmio_cnf);

and I can't find any case of 'iounmap()' having been defined to an
empty macro or anything like that to explain it. The error in
drivers/tty/serial/sh-sci.c looks to be exactly the same issue, just
with ioremap() instead of iounmap().

It would be good to have some way to find which build/architecture it
is, because right now it just looks bogus.

Do you perhaps use some broken compiler that complains when the empty
inline functions don't use their arguments? Because that's what those
ioremap/iounmap() ones look like to me, but there might be some
magical architecture / config that has issues that aren't obvious.

IOW, I'd love to get those fixed, but I would also want a little bit more info.

            Linus
