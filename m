Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7F51B401
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiEEAFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383727AbiEDX7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:59:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD8D522DA
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:56:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so3977004wrn.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKdTjovqsCdX72d9roGYbZa4UTuliACzSNBJY8i+zFk=;
        b=EA5zOF2CgBRM3KEnU1EvIVrVSK8lAaSe1mJheFenRg/fxUSAdgPxWJPZ260gEnWjKZ
         ga9zu0kWaYJdhmnW5NcahZvlB3K9cUqIJBxrZUMnHORXjCFp4+DxOmpSBv8kw1tD+qFI
         TsHcVzj6NygsHPQ70CeCqnZBqiDGgbyb+Q4Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKdTjovqsCdX72d9roGYbZa4UTuliACzSNBJY8i+zFk=;
        b=kI6EsmyK4yRypVbGvpoYVIVPDdNONO3H8KfiJWxMQeAMT7069ojwwogIfKYvo9xN4D
         IIBQ+h0y9gahfcuOI1FdkvrOOWODhq4vG47JeUlSmhzDKMKpBQ//HojRPFRHmi8FC/TN
         OtCp1jB8dSwvFkNZ1SN8R9PoGGH5hldUem1+uT3ZPzTHjT14dy4AF9EbdTWm/CNNKdKh
         g+ZoXOJp+Ne56eN1EIwGRDzfwX/O3czm7kTpbRQObnNNqjlU3yQp9M64hyCbsmGoOwKy
         mY/ex8hQlqLIFsCZIyO5mJ60xpf65koDQdjyizYvFter1ULKT73LU721zBq4qDRNDhdf
         blrA==
X-Gm-Message-State: AOAM533SFiViSmSfrhvabUin5vUmXGytz3V1k06MJS76gzCAXKD/y/Nc
        WbeSlmtHT5jUAg07/aQH64MYmZtLn+HOYnH3XG6+eetJYU1N/foG
X-Google-Smtp-Source: ABdhPJyy6isOT7IY1zukIUAQclCqJeMt+peKPjxTLWrRh+Oi9q1PWYXtgZwYoMvGpfavLyv6J0lLTj/7IawTpAuezyQ=
X-Received: by 2002:adf:fb03:0:b0:20a:e253:b8c7 with SMTP id
 c3-20020adffb03000000b0020ae253b8c7mr17853079wrr.119.1651708573697; Wed, 04
 May 2022 16:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org> <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org> <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org> <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
 <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
 <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com> <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org>
In-Reply-To: <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 4 May 2022 16:56:01 -0700
Message-ID: <CAODwPW-0O16AkkYORovPHSESNfOe46639Wu2-QSsKxdx3fJs7A@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to chime in here from the firmware development side of this
issue to help clarify what Doug is asking for. We have the fundamental
problem that we have several different board revisions that we _think_
should be 100% compatible for kernel and userspace, so for various
practical reasons (easier to maintain in the source, limiting kernel
image size by not having to bundle the same DTB multiple times under a
different name), we want to use the same DTB for all of them. Just
saying "well, you should treat each revision as incompatible to all
the others from the start then" doesn't scale (we have a lot of
revisions, and in the vast majority of cases they are just as
compatible as we initially expect them to be).

However, we also can't just exhaustively enumerate all revision
numbers that are compatible with this DTB, because we don't know in
advance how many we'll build. For again various practical reasons
(bundling, signing, testing), it would cost a lot of extra effort and
friction to rebuild a new kernel image just to add a new compatible
string to the list every time the factory updates the revision number.
An earlier hacky solution we had for this is to just define a bunch of
extra revision compatible strings in advance even though they don't
exist yet (e.g. you can still see this in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/tegra124-nyan-blaze.dts
-- I believe there were only actually ever 3 or 4 Blaze revisions, the
other compatible strings defined there never existed as physical
boards). This is cumbersome and hacky and also doesn't really scale
(particularly when we need to add SKU as another dimension into the
string), so we needed to come up with something more manageable.

Our solution is to use "google,lazor" as the stand-in compatible
string for "all Lazor boards compatible with the latest revision".
When a compatibility break happens at some point in the Lazor series
(say between rev3 and rev4), we'll change the compatible string in the
old rev3 DTB to no longer include "google,lazor" but to instead list
all specific revision numbers ("google,lazor-rev0", ...,
"google-lazor-rev3") exhaustively (at this point we can do it, because
at this point we know we're not going to build any new boards
compatible with that old layout in the future). The new rev4 DTB will
then list "google,lazor" and again remain valid for all future
revisions we build, until the next compatibility break.

You are correct that this ends up changing the meaning of
"google,lazor" at some point, but it's really the only good way I can
see how to solve this within our practical constraints. I also don't
really see a practical concern with that, since our firmware matching
algorithm (and I believe this is the standard other bootloaders like
U-Boot also follow) will look for the more specific string with the
explicit revision number first, before falling back to the generic
one. So whenever we decide to change the meaning of the latter in the
kernel, we also make sure to provide matches for all the specific
revisions that previously used the generic match, so that they will
pick up those instead and there's no chance of them getting confused
by the change in meaning. While it is perhaps a bit unorthodox, I
think it is practical, safe, and I don't really see a practical
alternative for our use case.
