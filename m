Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA8E5A1572
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiHYPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHYPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:18:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9220B8F01
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:18:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q2so24417291edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=LR+ftCEuqGGlJGbieRZTMPUW+OKd3Cv5TGWT0UDVsQ0=;
        b=mSY8/kwQjbQefRboOZq1NtBa7P5KH4ZGMTal7wYL2jkcCwAPEfHe1lt7A5DiR+8slj
         SOKJPNvtuvJzJu1cJjkCsvHMDNZZef7aeTqnhdOOx6ZvAujEDz824afBM/YR33JoY2QO
         VqasciQAY217h3hXMDN52Vv4W8jGtTFR2D6/BCIFZD0jDn2v8eRLdHUBi6ApCuN0CbyN
         7VNXJoN0ip2rGviSReV7ikqQT8snVw+AK8+5OSgz+r9/U4Q+OOP7dygSyRVD5n8Kq4EM
         Aiu3F737lTWTz+C8ezaOXkFjIgpDbbLBXMtYgFAR8nrKdEBU9vAO47tYTiM1SmdnxBVW
         9XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=LR+ftCEuqGGlJGbieRZTMPUW+OKd3Cv5TGWT0UDVsQ0=;
        b=lN63ZmEzTMcUI9ZwE+O1xD/vch/2Fj9SNYCVtr8hRYw03p3jtl+5kflc0z09u47Z5c
         iQQA48p98oIcwj+9CBuGTvqdzW+ubXw8nYHwjiips64WB/FdbpCX3FCdEFidSalps/lE
         vL/9h2QP5cC53EUVwJmdqteHuSazBNIjeW3lkjQwVbxnsmCktwGCbxr4/Xj2ggwqKGQI
         Ql7z9bs1wvV4+z75oX/ud3IAmxsBhMBU3wy6jwxZjaA7QOJBWWdS/VJ6J36m4B5SgqJR
         rxE3yhurpEIz5EjLwWuwfEZQTYkFFI/H9irRH1mkBpCmcfH8ucyW+//Z57Pr7vPpSwG6
         fkHA==
X-Gm-Message-State: ACgBeo2BV8jgUzcqSqTEHmjoueZ82+1qTo9XOitIVF8sMSBIzZlndkte
        vqqbk+ek0SkepAKo89hxGgcWHg==
X-Google-Smtp-Source: AA6agR6rXtjTOoklgiguMLmicVUBp31e6BzGWHAVb2e5NQ7FaAnGL6R1cn29JpOEB3X37ujNdkRkAg==
X-Received: by 2002:a05:6402:134e:b0:445:d389:266e with SMTP id y14-20020a056402134e00b00445d389266emr3702755edw.97.1661440702387;
        Thu, 25 Aug 2022 08:18:22 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id cx26-20020a05640222ba00b0043e35ae2610sm4987369edb.27.2022.08.25.08.18.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2022 08:18:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4] regulator: core: Resolve supply name earlier to
 prevent double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <a78822d5-f0a1-6c42-8269-e8168ea5cd5b@samsung.com>
Date:   Thu, 25 Aug 2022 17:18:20 +0200
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>, wens@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
References: <YvorNPDQQr2SH/NF@sirena.org.uk>
 <20220818124646.6005-1-christian@kohlschutter.com>
 <CGME20220825113251eucas1p247c3d57de823da148ca4790975a4aba8@eucas1p2.samsung.com>
 <58b92e75-f373-dae7-7031-8abd465bb874@samsung.com>
 <YwdpOX0xCzYwhjmx@sirena.org.uk>
 <a78822d5-f0a1-6c42-8269-e8168ea5cd5b@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 25. Aug 2022, at 16:23, Marek Szyprowski <m.szyprowski@samsung.com> =
wrote:
>=20
> Hi Mark,
>=20
> On 25.08.2022 14:21, Mark Brown wrote:
>> On Thu, Aug 25, 2022 at 01:32:50PM +0200, Marek Szyprowski wrote:
>>=20
>>> This patch landed recently in linux next as commit 8a866d527ac0
>>> ("regulator: core: Resolve supply name earlier to prevent =
double-init").
>>> Unfortunately it breaks booting of Samsung Exynos 5800 based =
Peach-Pi
>>> (arch/arm/boot/dts/exynos5800-peach-pi.dts) and Peach-Pit
>>> (arch/arm/boot/dts/exynos5420-peach-pit.dts) Chromebooks. The last
>>> message in the kernel log is a message about disabling 'vdd_1v2'
>>> regulator. This regulator is not used directly, however it is a =
supply
>>> for other critical regulators.
>> This suggests that supplies are ending up not getting bound.  Could =
you
>> perhaps add logging to check that we're attempting to resolve the =
supply
>> (in the
>>=20
>>=20
>> +       if ((rdev->supply_name && !rdev->supply) &&
>> +                       (rdev->constraints->always_on ||
>> +                        rdev->constraints->boot_on)) {
>>=20
>> block)?
>=20
>=20
> I've spent a little time debugging this issue and here are my =
findings.=20
> The problem is during the 'vdd_mif' regulator registration. It has one=20=

> supply called 'inb1' and provided by 'vdd_1v2' regulator. Both =
'vdd_mif'=20
> and 'vdd_1v2' regulators are provided by the same PMIC.
>=20
> The problem is that 'inb1' supply is being routed to dummy regulator=20=

> after this change. The regulator_resolve_supply(), which is just after=20=

> the above mentioned check, returns 0 and bounds 'vdd_mif' supply to=20
> dummy-regulator. This happens because regulator_dev_lookup() called in=20=

> regulator_resolve_supply() returns -19, what in turn lets the code to=20=

> use dummy-regulator. I didn't check why it doesn't return =
-EPROBE_DEFER=20
> in that case yet.
>=20
>> I'd also note that it's useful to paste the actual error
>> messages you're seeing rather than just a description of them.
>=20
> There is really nothing more that I can paste here:
>=20
> [   32.306264] systemd-logind[1375]: New seat seat0.
> [   32.331790] systemd-logind[1375]: Watching system buttons on=20
> /dev/input/event1 (gpio-keys)
> [   32.550686] systemd-logind[1375]: Watching system buttons on=20
> /dev/input/event0 (cros_ec)
> [   32.570493] systemd-logind[1375]: Failed to start user service,=20
> ignoring: Unknown unit: user@0.service
> [   32.750913] systemd-logind[1375]: New session c1 of user root.
> [   35.070357] vdd_1v2:
>=20
> --- EOF ---
>=20

I can reproduce these findings (also see the difference in "cat =
/sys/kernel/debug/regulator/regulator_summary")

The check "if (have_full_constraints())" in "regulator_resolve_supply" =
is called even though regulator_dev_lookup returned -ENODEV (-19).
Since my patch now calls "regulator_resolve_supply" twice, the first =
round should really treat ENODEV as "defer".

I propose adding a boolean defer argument to regulator_resolve_supply =
(with defer=3Dtrue in the first, opportunistic run, and false in any =
other situation). I'll have a patch ready later tonight.

Thanks!
Christian

