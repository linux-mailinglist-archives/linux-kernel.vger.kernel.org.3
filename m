Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF294F65BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbiDFQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiDFQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:40:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E128325FD70
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:59:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so4193774lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1+/9uGNU/c0SUbZVyjyQElYWMN/Sm+TEsoVZ+LA9Dwg=;
        b=sznZSgTKnvb3REJi+cKW4bbvW2SCuFJQeNMNdl1UK7abPOiMjmtBnyzm3jiH38FVML
         VSaVoJ5E6zEvkyXLndR+PxA6JfqZOwO6KtDnV3hez/Arx1Wtr4A25zH315UtaVoxDi5P
         qFcS703uo8+eCkYtqLlPLafWcmeP+ifwLeVAe03BNOLF4H9lxO5ZZe/Xf4Bpls+X/DMu
         SShkA7IapxBRcfJHuqFR9okeFEiN4BDX3egCL6iDe31BuBf0v17dtMD/P7kpjJ+Y20yR
         kJplnuy3A6Uz2FV4BzeDv41iVYc/oyvyhoZWTayKoXIDk9gF2f/VcI5GAXVJ06lwcs26
         fryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1+/9uGNU/c0SUbZVyjyQElYWMN/Sm+TEsoVZ+LA9Dwg=;
        b=2YLgubzTyNm7bHVtEirJCkuDVP6HuU+owaPw5uQr+vdRRCzSISo0fEvpB/4qHE8jHg
         b2kvzB7eVGSnMnSFJ7NY/0Tx3x58hW0ATrfoGw/q/P/Xpm3LmaQ3F9kl4HEzpWjPa+Pz
         HZSfgLs3MNV9gp5V6n+sqOzysfG8TMFAYGrB10ikzzg8etjrxNkQs7ReS0yw/trRHD8I
         mdOVHWhRAgCekIQaEb6fSo2KMggYrsHL8+T/fSU/kk3xoTWmdDXxsuhRVyYCz4mSr8kX
         1gzaOX55MuJWmW3TgGUvRHOqNigmlB1rylx6XCRvmPm/J92UqwCuAC5Kxkyydu+asp8S
         X9og==
X-Gm-Message-State: AOAM5326CChTVVed4V0OmA1ASCGE8qObv7tuEGuT/Ext5bpR63N/RVDq
        MdUd4Um/Fy3eRLONLb6Lk+K8U5eUV9g2nhqIbo/zNw==
X-Google-Smtp-Source: ABdhPJy+0n1cWazIOvM6G43K7umQC1gfmdgukS3y10rRQbQb5twaDBgVfSuwfuLHCtMeQCgHu4RbYXGpEVOB3q64a7Q=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr6407391lfr.233.1649253576150; Wed, 06
 Apr 2022 06:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
 <20220321115059.21803-9-wsa+renesas@sang-engineering.com> <CAPDyKFqwgxhRPBabxfUTC+8UVegWrTg3F0nRn3PoToiO2DWtvQ@mail.gmail.com>
 <Yk1JA4TWO9bTt0kb@ninjato>
In-Reply-To: <Yk1JA4TWO9bTt0kb@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 15:58:59 +0200
Message-ID: <CAPDyKFpMAE9mYXUBEsVSm-9EHAC-o5hTxgKNUjYYvo0dzqfEZg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] mmc: core: improve API to make clear hw_reset
 from bus_ops is for cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 at 10:02, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > To make it unambiguous that bus_ops->hw_reset() is for cards and not for
> > > controllers, we a) add 'card' to the function name and b) make the
> > > function argument mmc_card instead of mmc_host. All users are converted,
> > > too.
> >
> > Again b) is sufficient in my opinion. All bus_ops are for cards, while
> > host_ops are for hosts.
>
> Okay, this argument I buy right away.
>
> > Also, there may be some corner cases where b) can't be done, like the
> > ->remove() bus_ops for example. In that case, we either have to make
> > more re-structuring of the code of simply live with that there may be
> > some special cases.
>
> With the above argument, I could even imaging to simply drop this patch?
> That keeps 'host' consistently as the default argument? All given that
> 'bus_ops' are for cards anyway.

I have no strong opinion around this.

Perhaps one simply needs to make a patch to convert them (most of
them) to take a "card" as an in-parameter to really see if that
improves the understanding of code.

Kind regards
Uffe
