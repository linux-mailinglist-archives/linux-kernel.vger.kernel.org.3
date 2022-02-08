Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6095F4AE4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387765AbiBHWbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386292AbiBHUCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:02:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A52AC0613CB;
        Tue,  8 Feb 2022 12:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D415A615A7;
        Tue,  8 Feb 2022 20:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B92FC004E1;
        Tue,  8 Feb 2022 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644350558;
        bh=76ABg2Dlvjl73zDQJvo3h1QYiJvQxOXAQJYzRa9Onu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=idEZsdqPKRmGaSIUSROU3HsIP0i6pXlrujkYqVPHdNRGJcX25aTFMNKx8/BPhMcob
         3d89OhmoK6r4wY/E2bu3bP2paFTMvXkU94MnkcH9POJH8b5tXPG9rkGJf5m0SgQOyE
         dYEsfSeNVgsY8LXZQn5HHarLWTq3twB6SZ+zEHKBNrm6bnG96q40z/qakROB3gFApC
         dp4LlOVL+u1Ng9ajbsg1ap4HpkiEZ3hNoiJYn+p3NZRsWt/dq57JC6Bf2vffsbRjDN
         vnJh/n+g+WIvUqSsqkrPFit5CbhC+FhVGAfKO2CUHny9QjqhhpUeun+7vxG6JxvZnP
         /KumfOOXbguaA==
Received: by mail-ej1-f46.google.com with SMTP id s21so771541ejx.12;
        Tue, 08 Feb 2022 12:02:38 -0800 (PST)
X-Gm-Message-State: AOAM530aBdHSIKhDe6sRdtK5Zfe7miqEF9fd+OUD44GFFH0xq57dsgWv
        NB+rcrEzUA0bisE7HUZXOfmc6mKsJxfkaeCpfA==
X-Google-Smtp-Source: ABdhPJwYJJZa+vnjfBK/WR+7SL6UFvywYM6EfsfWcrdXGMBkFX9fiAap0UJtx2BRAmtyBeG/7Drode5OumzOI+e5wUY=
X-Received: by 2002:a17:906:f0cb:: with SMTP id dk11mr4930847ejb.20.1644350556421;
 Tue, 08 Feb 2022 12:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20211207140334.10461-1-semen.protsenko@linaro.org> <CAPLW+4n-BjSHK4gdP=cGvAE+pZDfvYTO4yy09yNRJgSXt2VArg@mail.gmail.com>
In-Reply-To: <CAPLW+4n-BjSHK4gdP=cGvAE+pZDfvYTO4yy09yNRJgSXt2VArg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Feb 2022 14:02:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3CwT-iuf2NoM=sjPr-Qowzv61Gtv_zvSAoyj7qdZMNA@mail.gmail.com>
Message-ID: <CAL_JsqJ3CwT-iuf2NoM=sjPr-Qowzv61Gtv_zvSAoyj7qdZMNA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Report enabled nodes with duplicated address
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:11 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Tue, 7 Dec 2021 at 16:03, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >
> > Duplicated unit address is a normal case, as long as no more than one
> > node using that address is enabled. Having duplicated addresses is
> > already allowed by '-Wno-unique_unit_address' in DTC_FLAGS. But two
> > simultaneously enabled nodes sharing the same address is usually
> > incorrect. Add '-Wunique_unit_address_if_enabled' flag to report
> > warnings for such case when doing "make dtbs_check".
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Reported-by: Rob Herring <robh@kernel.org>
> > Suggested-by: Rob Herring <robh@kernel.org>
> > ---
> > NOTE: After applying this patch, a lot of warnings appear on "make
> > dtbs_check". I'm not completely sure if it's ok, so feel free to Nack.
> >
>
> Hi Rob,
>
> Do you think this patch is feasible? You asked me to send it before,
> though I now see it leads to a lot of errors being revealed when doing
> "make dtbs" and "make dtbs_check". Please let me know if it's Ack or
> Nack -- I'm fine with any resolution, just want to know if I should
> continue to carry it in my local branch or drop it.

Sorry, I'd missed this. Anyway, since there are lots of warnings, we
can't apply this.

Rob
