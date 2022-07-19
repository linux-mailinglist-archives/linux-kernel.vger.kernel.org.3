Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DBD57A6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiGSSy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGSSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:54:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFB313E03
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:54:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m16so20853235edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jvlbyga+aybcQE2QVFUOWHDT9IYYpSQipByXARrXszA=;
        b=3LDvZ6cyfu+Hes5Js9bk/jI/uuaxOfOG2yT8IR7xG17AZgIjYp5kfoxWpzQui7qOG9
         8oVOymaa2FPZhm20prchBYNHvWneiuaMNWmmzeEjbVulMS+ecZ/w+8lMauhw3gTokdJw
         PE9/vyZzDTBU10RGvl8YQvSjsID0UifxGS3wky1F/sRoR/BAhFWPR9snwwYHo0bhoRzQ
         zlVEoRqpW+dx7vLaNy/2wU7LezxVvQBxK7D101Tus6hMFIz8L1CAgjo12A0zjwqNz0+F
         MmR5woIiEV1MHOILGws2oyQHx6OKtiZknjIEkvIfdfccH16qqgeBfSTQDiOjmRYGHd+9
         qgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jvlbyga+aybcQE2QVFUOWHDT9IYYpSQipByXARrXszA=;
        b=iWhEy8QjbV5/dLsAQhfmMn3gNrQbEdggJ+dqdLbpPtXF5O27+PXFE0Q2qKH0YXADCg
         qbXPlyLmCPb8vshlU+w60JQpFS/iYXKDd34P7UrDIqsokiVcQQ4FuHgkql7eJzlUYCaj
         q9Z5wfXXcuHw1+hfm6QzGZfB3ln9i6NhUsOFHjoamjK67uX0a2KRs6+YtSvZ/nvNkz/y
         7JhdZH/9L3izid1qjSSxyZ/mfmZCClLR98XkiT1FaEsLh4laB0iCdOlK3MJ/23UbIW+U
         MzwFgO6fStfy4HudV4iAhBGuhjDhNCP5y1Mu/8AmDFeXGPaDgSKKbQcqG+a3eHqLomfp
         dcXw==
X-Gm-Message-State: AJIora+1S7FlaqtgLHjWI8zLHXcYMLVF12xd0TP8HxOJLqCUP8rIenOd
        pfkfdf5fveriWTPmHpXIovwGdg==
X-Google-Smtp-Source: AGRyM1vM7GxtMIs06vDeXZOshNbmHR6ynLTDlSsuoCcSM6mw+Z1/vTTqNbsiydFVFLiE80jW3Y59hw==
X-Received: by 2002:a50:ee8d:0:b0:43b:b678:114c with SMTP id f13-20020a50ee8d000000b0043bb678114cmr1154292edr.12.1658256892927;
        Tue, 19 Jul 2022 11:54:52 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id k15-20020a05640212cf00b0043b92f805eesm1368235edx.70.2022.07.19.11.54.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:54:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <165825651232.448796.18429380716580437688.b4-ty@kernel.org>
Date:   Tue, 19 Jul 2022 20:54:51 +0200
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5208D84-9501-4ADD-9747-817E8ADE75E7@kohlschutter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
 <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
 <FAFD5B39-E9C4-47C7-ACF1-2A04CD59758D@kohlschutter.com>
 <165825651232.448796.18429380716580437688.b4-ty@kernel.org>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woohoo, my first patch =E2=80=94 thanks a lot, Mark!

> Am 19.07.2022 um 20:48 schrieb Mark Brown <broonie@kernel.org>:
>=20
> On Tue, 19 Jul 2022 16:02:00 +0200, Christian Kohlsch=C3=BCtter wrote:
>> Regulators marked with "regulator-always-on" or "regulator-boot-on"
>> as well as an "off-on-delay-us", may run into cycling issues that are
>> hard to detect.
>>=20
>> This is caused by the "last_off" state not being initialized in this
>> case.
>>=20
>> [...]
>=20
> Applied to
>=20
>   =
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git =
for-next
>=20
> Thanks!
>=20
> [1/1] regulator: core: Fix off-on-delay-us for always-on/boot-on =
regulators
>      commit: 218320fec29430438016f88dd4fbebfa1b95ad8d
>=20
> All being well this means that it will be integrated into the =
linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>=20
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems =
and
> send followup patches addressing any issues that are reported if =
needed.
>=20
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>=20
> Thanks,
> Mark

