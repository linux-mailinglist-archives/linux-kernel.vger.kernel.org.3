Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B25125D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiD0WzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiD0Wyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:54:35 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C048CCCA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:50:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id m11so3575216oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uO1mjNT4t8QFE2H4UTWyMQ/O+XjoVk8wmcfJNXUjbrc=;
        b=SgqFgdXosM/ZYsAUz16MKVkJJBdinSAq5DNb8Wfpvs6H36XROkz/tVPkTu6r0qbWKC
         W3EMwHETOmhuJAJPXayfGbXzUYzGsQLRRP6gDoh6MdqvZmBtm3zYnfYLJatRV/pLeTPP
         +RzlgD1IS4LZAJR1eL5lkO4KHr1YxJ9pDDpK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uO1mjNT4t8QFE2H4UTWyMQ/O+XjoVk8wmcfJNXUjbrc=;
        b=segJ+/ZiHu4y2027Oq8U1Vslur8CndStCYwja7tcIeORYrA4o0HesN7+YHd+9PJmuk
         kNhTRlgk9+wuz2/ezjZdb/UhSvCoygqexgq23qIfVBq8T0r3Zq37t+SvoCZpYan/al2R
         yfhIU4oPsCqonaTA0Ka6I8KpAoe8heHucnCFs9UH9oRLqK74PsPiqzsNEQ/gtvzET5aJ
         NyntecQNZRQCYtoVKrZfZ/X3ownA45LbOEgOnHGQPDc0raik9pQ4TrxjJzGSwLyaPEOq
         IOHmCk1b7yoiyqiLi3l/EsdZbAD0OCUynSByDg3YyycUDt37SPEAm0u8osQTgQ3ERPKf
         97VA==
X-Gm-Message-State: AOAM5304CMqslLcwKbZdw0Z8UYQmUtSV28Nm5mXY4D6B4qr12t3FoJjT
        GHz15/zUJlzNYkR1DNtEuxVMh6RZCyGWZg==
X-Google-Smtp-Source: ABdhPJwGQsxcEYHsElbh2khGaacRxR9nbyIgxqzl06IrsWFZAjxk7PRRQAWnOisR1XouvQSGymxDbg==
X-Received: by 2002:a05:6808:114c:b0:322:a749:2d1b with SMTP id u12-20020a056808114c00b00322a7492d1bmr18616781oiu.64.1651099858023;
        Wed, 27 Apr 2022 15:50:58 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com. [209.85.160.41])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d7f8b000000b00605e7880924sm221559otp.58.2022.04.27.15.50.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:50:57 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e68392d626so3555012fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:50:57 -0700 (PDT)
X-Received: by 2002:a05:6870:4201:b0:e6:47c4:e104 with SMTP id
 u1-20020a056870420100b000e647c4e104mr16438606oac.257.1651096086895; Wed, 27
 Apr 2022 14:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220426014545.628100-1-briannorris@chromium.org>
 <20220426014545.628100-2-briannorris@chromium.org> <CAMdYzYqyDr1HFYB4p8NK8ssq60qfjR2jyoSJ=tcRn8CWsZr16g@mail.gmail.com>
 <d72eb7a7-f922-3270-422b-4e27505de530@arm.com>
In-Reply-To: <d72eb7a7-f922-3270-422b-4e27505de530@arm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Apr 2022 14:47:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNFPfp6J9bLpYh4uyZDtmhrbSb6Y3=T26_qxd4-YDMtcw@mail.gmail.com>
Message-ID: <CA+ASDXNFPfp6J9bLpYh4uyZDtmhrbSb6Y3=T26_qxd4-YDMtcw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] soc: rockchip: power-domain: Replace dsb() with smb()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 5:25 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-04-27 00:55, Peter Geis wrote:
> > On Mon, Apr 25, 2022 at 9:46 PM Brian Norris <briannorris@chromium.org> wrote:
> >>
> >> It's unclear if these are really needed at all, but seemingly their
> >> purpose is only as a write barrier. Use the general macro instead of the
> >> ARM-specific one.
...
> >> -       dsb(sy);
> >> +       wmb();
> >
> > Just curious, shouldn't this be mb() instead of wmb()?
> >  From the arm64 barrier.h:
> >
> > #define mb() dsb(sy)
> > #define wmb() dsb(st)
>
> As I mentioned on v2, that would be the literal translation, however
> there's no concurrency since this is happening under a mutex, so there's
> no other agent against whose accesses loads would need to be
> synchronised, therefore the only logical reason those DSBs were ever
> there at all must be to ensure that the prior store(s) have been issued
> to their destination before proceeding. The history implies that this
> dates all the way back to RK3288, where Armv7's argument-less DSB lacked
> that distinction anyway.

Thanks Robin. I already tried to capture part of this in the commit message:

"It's unclear if these are really needed at all, but seemingly their
purpose is only as a write barrier."

i.e., it's intentional that I'm making a change, not a literal translation.

I ran through a few tests on Rockchip RK3399, FWIW, although I suppose
some nasty memory ordering bugs are not exactly the kind of thing that
would fall out in smoke tests.

Brian
