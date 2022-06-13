Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D637C5499EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiFMRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiFMRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:25:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641B5DA45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:41:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v81so9720175ybe.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24s+okEIr+8frZCp+e+0zEDsJWLbgNN42DapWqRqg/U=;
        b=wweaNRnfsA2aLMCcUoLybDHhyN8pjk5uBuWZyn3ywy90Ulvdc3wuhOClABcwdlFF0z
         CW8qwev/jsryJy9m++xp5XgFg4dJbIcACCx2E/dJNseQ9BIKiCfGcBgsXds1S/LvDuVR
         CjdvyY3jDG7RAnfF62ogRONES21Mr9v3o1pFX8D4DQ7r6kedTRnZJWAoPp/4WsnKSquZ
         3q9md4Ao0IT/zLgA5YUO+06rCbvAYkwV9fahSeFo+89Sk74cVLdtNJoM97FoT2oXemhR
         w2ZSsA2SSzZKWVHlp/ZuwBk5E+IGtIqDyda3+PVVO26p+1v8h3edex++teeGtp8fuxZR
         wSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24s+okEIr+8frZCp+e+0zEDsJWLbgNN42DapWqRqg/U=;
        b=V+OnJsdSiUP3o2/ehIATHOycKSXibyYfp6PBXbc8NTsE2iYomTtKM/8LsjJ6vVgqf1
         rZfpmDdnYKZJdfXJcOI8QyzWJv895z50I8afM7wHYF1MPJiOZdUwc+YlMpLSkUoKkflQ
         hy6XV9/hV2Kei0nqE0JFac1LckZ8ERvQEPhooJbTl8FiUJsq8xKIEc9fil55FMUvwcSn
         wFNVdiIsd/uZRrYn9eB7CVS64Q0ZYgDmVRgm79FCHG+w8SoAXfPFeNAjPBpyCPmlzkQR
         gWrnucctuNIOID8jeOVlbt+lnefeAdfVUdJhhVWt4/lbso0kfmBJBokTbjoYOjJ01svr
         HaNQ==
X-Gm-Message-State: AOAM533SsvYEZNWCl8V1rqWmuXay4mnckPE2xK4Rt9niHmzO2HutV9Ir
        DWBRzvev/wO52vqMf/zVB/s7yypMtK4I5/oKEAGrZg==
X-Google-Smtp-Source: ABdhPJzq8ObTdRvrg3KeDgeBHDlgX67xjddWEjh3SgADP1H43aepYKAtYgXrAh4O45qLJnKn9e/2eKeOF3/+RKb2m9o=
X-Received: by 2002:a25:cec6:0:b0:65c:98f5:a06a with SMTP id
 x189-20020a25cec6000000b0065c98f5a06amr58114814ybe.355.1655124092193; Mon, 13
 Jun 2022 05:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMSo37US03pKhPR=a1sJnWMF6L+WDvhWz469G=+0XY2WX-p=bg@mail.gmail.com> <CA+V-a8t2w14bJVCiiHQq8bwgetw5za1-t_OSfyr6Cwo4eZOt2Q@mail.gmail.com>
In-Reply-To: <CA+V-a8t2w14bJVCiiHQq8bwgetw5za1-t_OSfyr6Cwo4eZOt2Q@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Mon, 13 Jun 2022 20:41:21 +0800
Message-ID: <CAMSo37V4ye8wb_ctKQO0QE6QCJXUEaPC1-27911zCcXHN-+C2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lad

Thanks a lot for the links and suggestions!
Finally I resolved the problem with the call of
platform_get_irq_byname and irq_get_trigger_type.

Btw, I just have a question about  the of_irq_to_resource function.
At the beginning I tried to use platform_get_irq and of_irq_to_resource
to get the irq name and flags information, but it seems of_irq_to_resource
does not work as expected, maybe I called incorrectly somewhere,
here I just want to ask, do you think that if of_irq_to_resource still
could be used to
get the resource with the irq returned from platform_get_irq?


Thanks,
Yongqin Liu

On Sat, 11 Jun 2022 at 16:01, Lad, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> Hi Yongqin,
>
> On Sat, Jun 11, 2022 at 6:28 AM Yongqin Liu <yongqin.liu@linaro.org> wrote:
> >
> > Hi, Lad
> >
> > # sorry for the confusion if you have received it before with the
> > non-plain-text mode
> >
> > In this change you said "all the DT drivers have switched to
> > platform_get_irq()",
> > could you please help share with me one example about the above change
> > as reference?
> The change is we just switch to using platform_get_irq() [0] for
> fetching IRQ numbers.
>
> > We have one hikey960 android build with some out of tree changes,
> > which could not boot
> > successfully with some errors on surfaceflinger(I am not sure it's a
> > problem with the gpu or display),
> > but could boot if I have this change reverted.
> >
> > I guess it needs some changes on the gpu/display dts or driver side to
> > have it work
> Just the changes to the driver is needed.
>
> > with this change, not sure if you could give some suggestions on the fix.
> >
> > And here are two out of tree changes might be related listed here just
> > for reference in case:
> > https://android-review.linaro.org/c/kernel/common/+/21680
> > https://android-review.linaro.org/c/kernel/common/+/21682
> >
>
> [0] https://lore.kernel.org/lkml/20211221213547.1553-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar



-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
