Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05A57E60F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiGVRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:55:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA3812627
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:55:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id u20so4176111iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gULf0JdF4EwTcvIBHd+ZJRIXMVlWI/0SvCta4rj+NzQ=;
        b=Kcmz/jeQZjMgKau9sFwMRtbG91c/92RNy+LYNH5xGvTw+a2mKAFvlIslfDbB3wn9M0
         ohSl8G1tSVgsE3lEon90WfIpK917we7YqMgM/oonhaRI6LS6hER0K2VXRSIx9Se/4Rfz
         Ms/mdHLDhcNPzLHCTzZx14PDIzPz13q8+UJ8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gULf0JdF4EwTcvIBHd+ZJRIXMVlWI/0SvCta4rj+NzQ=;
        b=BpCGmZ34dYm1lR7zr1f7iBT5CGbxM3PXh9Bny+j3D/i3wHS7oV2r33VUIXq7ipAkMh
         +qhN/NcQ0lHAYRKxWHszfWQ5BqPQcTZSkUroZZ0cNqBaDdQNU3FR3Q4X2LiyRWeo9c1w
         weIh4ADEdzJXXdY66ybWvBrTqDKOG8/SUhxCe8cgNZQRJoW9E75jetbAO1yzH3+eGt4J
         Pfn7uWRabLHoSn0MYKepu7WizxP/q6zxucrOnaFEkJeOb6o4uEviNdYoLg8D45SEdj4n
         vTLOq4VC1w7yT6JqmuFQMXz9P+C1OgSMn32nviNCfUDv3fnQ5i32euZ6FLfP30Cn7TV5
         oM6Q==
X-Gm-Message-State: AJIora+znLTjUF83g1pVku+GETGIHhN5xJA8qyIfHvCwQ31EZ/LzYl52
        L66keLmejXbKc5rvIIE8Luv+UYT6rFW5o22X
X-Google-Smtp-Source: AGRyM1uADQz/Oog7/FEN0V/x7f/VepHTuFcNOoYfZHKw62lN7yzJhKIH/m/T00qA89qebpmkY3ZY4Q==
X-Received: by 2002:a6b:5d1d:0:b0:67b:e426:78a2 with SMTP id r29-20020a6b5d1d000000b0067be42678a2mr342999iob.42.1658512534463;
        Fri, 22 Jul 2022 10:55:34 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id k13-20020a02660d000000b00335c0e07abdsm2229074jac.14.2022.07.22.10.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:55:32 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id h145so4178292iof.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:55:32 -0700 (PDT)
X-Received: by 2002:a05:6638:1a1a:b0:33f:405d:b1ed with SMTP id
 cd26-20020a0566381a1a00b0033f405db1edmr559102jab.164.1658512531715; Fri, 22
 Jul 2022 10:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <CAD=FV=Uuv0rGg1+8_b=R7SM-g87U_4TipwbNgVTXDd6T=X3qEQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Uuv0rGg1+8_b=R7SM-g87U_4TipwbNgVTXDd6T=X3qEQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 10:55:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VmKBjvDqxhrJfh72wZpBMVA1nA=JLVwnx-i92ijZt_bA@mail.gmail.com>
Message-ID: <CAD=FV=VmKBjvDqxhrJfh72wZpBMVA1nA=JLVwnx-i92ijZt_bA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 21, 2022 at 6:36 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jul 20, 2022 at 8:59 PM Yunlong Jia
> <yunlong.jia@ecs.corp-partner.google.com> wrote:
> >
> > SKU6 is LTE(w/o eSIM)+WIFI+Parade
> >
> > Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> > ---
> >
> > Changes in v3:
> > - Bindings and dts in the same series.
> >
> > Changes in v2:
> > - Put sku6 before sku4.
> >
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

We're at a point now where this won't be able to land for at least 2.5
weeks. As an experiment, I created a staging tree atop the current
arm64 dts tree and put this there. I'll try to put only things that I
believe are truly ready to land there, but git hashes won't be stable
since it's just a staging tree:

https://github.com/dianders/kernel-staging/commits/qcom/arm64-staging

I reversed the order of patch #1 and patch #2 when applying as per
discussion in patch #2.

-Doug
