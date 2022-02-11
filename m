Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35A04B1EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiBKGuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:50:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiBKGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:50:42 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636C1120;
        Thu, 10 Feb 2022 22:50:41 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id v6so9132414vsp.11;
        Thu, 10 Feb 2022 22:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSROPkIHqOIfi3Mx6GPXtGKkcEJ0TQ6U5/02TvsWVjs=;
        b=aI6iirQLDE79NFBohp4tGvHl9CuJHutPPj78yxbu89pb2Pwy6FzthqI52TCGsqnVsi
         nPByOczGUEQLxLF7f1hvq3IXINsb2d9nh0ou1Wta6vGgRAtOfLEzuANmnWkMTOreMtzB
         2c4wtjp2fBfGXIrnZXEJvVtxF8EVqhIj2sM5OgI0b8diZIHQQIyv3wtxvu8+DYJ+UuIK
         r3nQlVWV1kLAAX9S28hNVCmp0jo6g0YdYBkL/Yu79JCSUKNVlGiCKQY1aLtSD9n+jgMo
         mQYD1lmQXYKOeApQjSEv1ygK0HRmSDt6YnYU1IvD4AO0i4+wlymSHKeYyK9EtZ/XFvwZ
         jH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSROPkIHqOIfi3Mx6GPXtGKkcEJ0TQ6U5/02TvsWVjs=;
        b=HRdyqYp98Tl3wVr9JmKHhxmWr7qUqL8BkRw2RlEVlPHNDp0LycOUmw17E8LoqQJQ8N
         e3TapNegMYreMRLVm07NZgSbvFg7TD2gPot9hFyZ9p83hVNSUz9cvFqv844aGz4nQubf
         eYHfPqLYODJcZlshxZny/0RZygza0WAcFW5t/LroGi+5cUafutPaO36eMkFsNw8kMGNB
         hsRsHf+/zgB3q/DRboEkGWqwdwmRTG9uiMzSDh7aN0UabmvQC0IS/++Qn1tSdSZoixjN
         TltnzEe/5f+yAd/qUZLfuw613yoFyBsq0mydHbOIJRB+abOolocSyOvhjidMQ5pWosf3
         cP/Q==
X-Gm-Message-State: AOAM530RLc1+13tXUgqElxby1sbkrvs4lQNJaPONDhm3Y0jkk7lh0Ey3
        w1RKEpWFXu06bamRQ6mzn53h6ybypboLUAX9SUo=
X-Google-Smtp-Source: ABdhPJzCPF1tTpcQ1FWpqWN/gHplGyCbU2hVnrJ2gUBllwLUgLp6iZnR43b4mmVnWetix67HkzQhNADYz8Oi3+nNfFE=
X-Received: by 2002:a67:10c4:: with SMTP id 187mr85908vsq.1.1644562240863;
 Thu, 10 Feb 2022 22:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20220211001345.3429572-1-gch981213@gmail.com>
In-Reply-To: <20220211001345.3429572-1-gch981213@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 11 Feb 2022 07:50:29 +0100
Message-ID: <CAMhs-H9O=EagT-6296-CMQFBYFfekj2agrH9a8JpHzeC36EiUg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Guo,

On Fri, Feb 11, 2022 at 4:56 AM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> It's reported that current memory detection code occasionally detects
> larger memory under some bootloaders.
> Current memory detection code tests whether address space wraps around
> on KSEG0, which is unreliable because it's cached.
>
> Rewrite memory size detection to perform the same test on KSEG1 instead.
> While at it, this patch also does the following two things:
> 1. use a fixed pattern instead of a random function pointer as the magic
>    value.
> 2. add an additional memory write and a second comparison as part of the
>    test to prevent possible smaller memory detection result due to
>    leftover values in memory.
>
> Fixes: 139c949f7f0a MIPS: ("ralink: mt7621: add memory detection support")
> Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)

Thanks! Nothing seems to be broken after these changes, at least for
my boards :)

Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
