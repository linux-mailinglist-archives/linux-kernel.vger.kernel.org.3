Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EED47B9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhLUFoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhLUFoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:44:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF447C061574;
        Mon, 20 Dec 2021 21:44:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o20so47352852eds.10;
        Mon, 20 Dec 2021 21:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfyePfmL/6PbMkdAx5m1eRPoPiYBO22Uo7YSKjpNtg0=;
        b=DN4ocdvcqRWfd4BtTStwvsWXV1Ef+YaOqc2YBW94VIXnsawllCyZN16fLuA2dYRML6
         yo+IjiDON2TkCiH3v+dEtoigb5JZYQZ7Ra7PLuC5+8I9Zc0hRUQYVLARj7vSDFbIbZeJ
         ibVMkr+1q7tlYr6HqLb4XKHw1VrgBAVsAJIVI+J+l/9QS6h/ItC/jlTZl4HC248+mGRo
         Eny/irrpyc3gunkiZjdvHullxPFrEVIOD2WuJ4FKlXSmWdlIOqGOHSdNkMk+jBEQTsy8
         GIGbUYef564QFgLFxnCwACj3QjvYSDPudwWpfn5ZxPF8D2v/v/7EV2yKBbJnHB/3c82O
         dJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfyePfmL/6PbMkdAx5m1eRPoPiYBO22Uo7YSKjpNtg0=;
        b=2VN/RtPLPvKBGojPK6UjsRpn6bJYpn9kZtbfKF8acOrq2Cv6O9thTOf7kHb/jxCpLr
         iIyhH+W+Lit5RrM7zC0RKbQY1b13ZVuSXI+oV1I7Xx3SPKTrOMQOehgfm5uqC3+0efub
         jvIdUP3gsfWkhqW5escUaAsg4RSv8qlwDR+8oxXT9/0mYB4BcYyuryb20gz6YEh28kw3
         p7IvAN5HNjKiWkPIWYsbP0DcEOX1SPX+afx7Sj2TeNNV9ML0cwxii9EnH1yGYJN+YRdg
         9Ji0FG5QMd2bC/PtaDDSqfpxE74DXLr+xsU2sRuMIu0wtJYMNj6DXz5iNwyPFXAK1284
         tCVQ==
X-Gm-Message-State: AOAM532LoCBrvBvBN1jtnfCN+chvU0XlxnEgpgfhZvtAog8a64znUerz
        xY3z2Pyh0ZkKXKiNzer8yvWSgX+XBXWpmKZM3uw=
X-Google-Smtp-Source: ABdhPJx01YuM+vDoRrnr94fj7HEejrUTqnANmRsQyM0CMN6f/DIpqDqckGRVXJERLi+UTYsC8AfscSN8xsIyewd3hsc=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr1293197ejj.636.1640065468348;
 Mon, 20 Dec 2021 21:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20211219223953.16074-1-liambeguin@gmail.com> <20211219223953.16074-5-liambeguin@gmail.com>
 <CAHp75VdfPf6FMvkGqhhQg5e5XE1cgE-K8seobe5n0yGarnPGtQ@mail.gmail.com>
In-Reply-To: <CAHp75VdfPf6FMvkGqhhQg5e5XE1cgE-K8seobe5n0yGarnPGtQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Dec 2021 07:43:52 +0200
Message-ID: <CAHp75VcRH9ZGYuXteT2WQWqr8sch3EsSYu_AYtNx2jEJY76tow@mail.gmail.com>
Subject: Re: [PATCH v10 04/14] iio: afe: rescale: expose scale processing function
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     "peda@axentia.se" <peda@axentia.se>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 7:20 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Monday, December 20, 2021, Liam Beguin <liambeguin@gmail.com> wrote:

...

>> +               tmp = *val * 1000000000LL;
>
> I see this is the original code, but perhaps use proper SI multipliers here and there?

I mean in a separate change.

>> +               do_div(tmp, 1000000000LL);

-- 
With Best Regards,
Andy Shevchenko
