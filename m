Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A075AD9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiIETjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiIETjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:39:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87113CD1;
        Mon,  5 Sep 2022 12:39:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 29so7404295edv.2;
        Mon, 05 Sep 2022 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=7sK3Pxg5lI33PaTu+416/SIw+tV3vaPUu4gPNzWPobI=;
        b=NH4qlg6QZbeqoZj2Tm2AcMxa8dQt6DIOCmBbcpO/afGOmdkHJcxG6jxB6WcHA2zgZr
         idzdlVtYYBmnO5OjykgPHGjqJguRfUJ8AJ6wuCKJwhP2kPNBb1vbriSXXdqvRGzgOK+x
         7QRwxQ2ZxFvWz+99M7MaMNy07R4c5Fk1fLBQ8J5h2tTPuIU5HkUIND5fT2SzEfFizdj0
         j1qedhwfOykL7oofHK38q0xsLgxlDMDSkanFA5SzEGZZX56RhDeE3JT8Cv1cMeoPxYbE
         wwtggQukF1Vi9dumdIfhYW5DEjfh+LWhGrMoQIBATY0KhSzp73lDSRCb714AKRbHeeMJ
         09+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7sK3Pxg5lI33PaTu+416/SIw+tV3vaPUu4gPNzWPobI=;
        b=Euq7NOmABQG3Az1rB+lBuC/8tE92NdTExf1rHik9aUsNxeiAsuuxbAutl8ZVgXrezq
         B6jyaABcVmiwg8pVzin4vSpn1q8LHov+6QiliwlwJEocCi2bHsCfoAU4bVO9D9UAhZo+
         H836OswkJapWZgb0B8Z/0iP3u+wMSiPeSrCdM+9u8wAHEuJc8EEPBVYilFQsN+45bKq6
         MWNNEtVbn/JWgchC3Ju0g2EUKKJFc9ch7gcXntpSiAGBo71Jpu1gj70JC7bc4aU1XsU4
         TnYmOvsCBT4XZAo0TSOYAu2ia+6aCy5QVdeTxVr69Eq5q+fq2YMIM58f6n7uRvSVoGtz
         5TMw==
X-Gm-Message-State: ACgBeo1o9nIZqpV4PsHa4yGY2jFtGVecxVqh4JVLM5eW+ox2qAbVT3Cv
        W1APIZwLNaHV1fwpX8CKe5M39yRD3/VpPDBbBaFiL4wHqshwQg==
X-Google-Smtp-Source: AA6agR6gCIxLGxghgPAj+EP0DXZOoyA9fExHCpxZBIF9zuDXx572eXiJijGmbmWkD3eqAnsSwuyri4I9kFJQughdEyU=
X-Received: by 2002:aa7:c610:0:b0:44e:9a0f:753a with SMTP id
 h16-20020aa7c610000000b0044e9a0f753amr3781906edq.140.1662406781082; Mon, 05
 Sep 2022 12:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220905171601.79284-1-peron.clem@gmail.com> <20220905171601.79284-5-peron.clem@gmail.com>
 <OS0PR01MB5922142861E78A1DD81AD1C9867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922142861E78A1DD81AD1C9867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 5 Sep 2022 21:39:29 +0200
Message-ID: <CAJiuCceGZJr24hVjpP0ptOkG8bMFKr=QLj0LcyDX4fUy7Rr2xA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the recommended
 one to configure and enable regulator
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Sept 2022 at 20:17, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi,
>
> Thanks for the patch.
>
> > Subject: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the recommend=
ed
> > one to configure and enable regulator
> >
> > devm_pm_opp_set_regulators() doesn't enable regulator, which make
> > regulator framework switching it off during regulator_late_cleanup().
>
> In that case, why not regulator_get()for
> Dynamic regulator(non fixed regulator)??

Sorry I don't understand, what do you mean?

>
> >
> > Call dev_pm_opp_set_opp() with the recommend OPP in
> > panfrost_devfreq_init() to enable the regulator and avoid any switch of=
f
> > by regulator_late_cleanup().
> >
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > index 5110cd9b2425..67b242407156 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -131,6 +131,14 @@ int panfrost_devfreq_init(struct panfrost_device
> > *pfdev)
> >               return PTR_ERR(opp);
> >
> >       panfrost_devfreq_profile.initial_freq =3D cur_freq;
> > +
> > +     /* Setup and enable regulator */
> > +     ret =3D dev_pm_opp_set_opp(dev, opp);
> > +     if (ret) {
> > +             DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
> > +             return ret;
> > +     }
>
>
> FYI,
> On RZ/G2L mali gpu, we have fixed regulator and
> I was able to do GPU OPP transition without any issues previously.

rzg2l-smarc-som.dtsi uses regulator reg_1p1v;
which is marked as regulator-always-on; that's why
regulator_late_cleanup() doesn't switch it off.

Regards,
Clement

>
> root@smarc-rzg2l:~# cat /sys/class/devfreq/11840000.gpu/trans_stat
>      From  :   To
>            :  50000000  62500000 100000000 125000000 200000000 250000000 =
400000000 500000000   time(ms)
> *  50000000:         0         0         0         0         0         0 =
        0         1       144
>    62500000:         0         0         0         0         0         0 =
        0         0         0
>   100000000:         0         0         0         0         0         0 =
        0         9       524
>   125000000:         0         0         9         0         0         0 =
        0         3      2544
>   200000000:         0         0         0        11         0         0 =
        0        46      3304
>   250000000:         1         0         0         0        33         0 =
        0         0      7496
>   400000000:         0         0         0         0        16        19 =
        0         0      2024
>   500000000:         1         0         0         1         8        15 =
       35         0      4032
> Total transition : 208
>
> Cheers,
> Biju
>
