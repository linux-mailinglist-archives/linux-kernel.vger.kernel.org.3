Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A715956E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiHPJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiHPJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:44:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B35C2F9F;
        Tue, 16 Aug 2022 02:25:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so12685122edc.11;
        Tue, 16 Aug 2022 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=p2IAoMXBFUx3gxWp+4ICwtPEKeo+wvYA575xG1H6jVI=;
        b=WLvFZu2KS+q7THGZo9rHUDk4wDTyZ4zqLbQUR0lnef4x6El+rrsbBeFOSf0fg+5FFE
         +5KdbCM9VHFcQlUrRnxbKlpfmYyKz1NSKx0uwDunbyOdRi1iQbIFtzIQx5C+zT4g8oe4
         Yg6ejIKdWFY/BoB1cv2pfomkAO2W41Ansn4cb7c85y/kRaZOVFPLpA46gMhtn3LG387u
         0+mUg9xYw/8DxVT+zo3hhsZucpjCEKyWvEbSDqyxdYRRSvwv2tvkTjZ0cmSYo2bxxCOh
         7pCETWJ02xnPN8vxu19rPFljUNDiBOkHY5o/3K4N5Wz6qJGdYIZP5+ApBVBYt/8TefxM
         pF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p2IAoMXBFUx3gxWp+4ICwtPEKeo+wvYA575xG1H6jVI=;
        b=LuTlxnCbUZe8hMO09Q5EpPTRWjRiBjrSzeIECLYco4eINoI8k/yDOCfMQQvUg/rFDX
         K34UUxt9r7+3a3yXtAm+R4zRw/21GrwnKiq0xb2lljXLzHqBkOS7qZeP7AB+nfDRGYFN
         PfTvuDWHd0FYI6hyo/XQ5/7cY9vvnvL90zqLb3b1IM5ic6X/4CHHNpaYDGukL5KjBlKE
         U/Fc7zj6OfuqRxG1HxjG2PXFwuwYib5QxRfqBQzOzmpfhYw1lW6CG6uHsEoAxPO6Y66v
         TUhj9w2b8djbKQ0T7mPoG/feszaBtzl3UpNWqNssqOFrs5bIJKHzixLxBeIgeU60g866
         djcw==
X-Gm-Message-State: ACgBeo26n/JNtybh/Us6CVfssR7TbAXoovctyzHW8US56YuKQNxRDnde
        E1uRmHLI81PVxo6cRH58mHY=
X-Google-Smtp-Source: AA6agR41CmKxbTEYoP/DOpTKRPVPg8STgzbCPzshr17hiEzC27VkjvA7+xRqBIA+VNOKDchJNuruHw==
X-Received: by 2002:a05:6402:1f87:b0:43b:b88d:1d93 with SMTP id c7-20020a0564021f8700b0043bb88d1d93mr17792300edc.314.1660641955004;
        Tue, 16 Aug 2022 02:25:55 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id cn19-20020a0564020cb300b0043bdc47803csm8142604edb.30.2022.08.16.02.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:25:54 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
Date:   Tue, 16 Aug 2022 11:25:53 +0200
Message-ID: <2249129.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <3881930.ZaRXLXkqSa@diego>
References: <20220815050815.22340-1-samuel@sholland.org> <5593349.DvuYhMxLoT@jernej-laptop> <3881930.ZaRXLXkqSa@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne torek, 16. avgust 2022 ob 11:12:05 CEST je Heiko St=C3=BCbner napisal(a=
):
> Am Dienstag, 16. August 2022, 09:49:58 CEST schrieb Jernej =C5=A0krabec:
> > Dne torek, 16. avgust 2022 ob 09:41:45 CEST je Krzysztof Kozlowski=20
napisal(a):
> > > On 15/08/2022 08:08, Samuel Holland wrote:
> > > > +
> > > > +	de: display-engine {
> > > > +		compatible =3D "allwinner,sun20i-d1-display-engine";
> > > > +		allwinner,pipelines =3D <&mixer0>, <&mixer1>;
> > > > +		status =3D "disabled";
> > > > +	};
> > > > +
> > > > +	osc24M: osc24M-clk {
> > >=20
> > > lowercase
> > >=20
> > > > +		compatible =3D "fixed-clock";
> > > > +		clock-frequency =3D <24000000>;
> > >=20
> > > This is a property of the board, not SoC.
> >=20
> > SoC needs 24 MHz oscillator for correct operation, so each and every bo=
ard
> > has it. Having it here simplifies board DT files.
>=20
> I guess the oscillator is a separate component on each board, right?

Correct.

> And DT obvious is meant to describe the hardware - independently from
> implementation-specific choices.

There is no choice in this case. 24 MHz crystal has to be present.

=46WIW, including crystal node in SoC specific DTSI is already common patte=
rn in=20
Allwinner ARM SoC DTSI files.

>=20
> Starting to discuss which exceptions to allow then might lead to even more
> exceptions.
>=20
> Also having to look for a board-component in the soc dtsi also is surpris=
ing
> if one gets to the party later on :-) .

As I said, if one is accustomed to Allwinner ARM DT development, it would b=
e=20
more surprising to include 24 MHz crystal node in each and every board DT.

Best regards,
Jernej


