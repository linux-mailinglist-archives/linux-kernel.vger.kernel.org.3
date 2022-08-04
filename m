Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39042589F50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiHDQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:21:37 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B53F66120;
        Thu,  4 Aug 2022 09:21:35 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6BFCA1C000D; Thu,  4 Aug 2022 18:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659630093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWEuEGyWD5cuZYPsK0JtmnKau5dObaXccnxnYn2McBc=;
        b=SGsbS4acDy67iFtBrlo9VdHE2Zothsst7u8IpJjobkSnRzYB/xHfRkAY2RkGfOk63GnGb5
        WchCTs4DNvdpnsxcRaM7w48BuJDV39s97MjMHK7bH8+/VmwXgzuzraso4iTbMbd2L2Tdi5
        fXEQOqeFLChxY5RutWFG8SQDmCiQvQI=
Date:   Thu, 4 Aug 2022 18:21:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Joel Selvaraj <jo@jsfamily.in>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add support for Xiaomi Poco F1 EBBG variant
Message-ID: <20220804162104.GA1189@bug>
References: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
 <bb78f8fb-d6ea-5c37-0531-8d7584bc897b@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bb78f8fb-d6ea-5c37-0531-8d7584bc897b@somainline.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - Tianma variant with NOVATEK NT36672A panel + touchscreen manufactured
> >   by Tianma
> > - EBBG variant with Focaltech FT8719 panel + touchscreen manufactured
> >   by EBBG
> >=20
> > The current sdm845-xiaomi-beryllium.dts represents tianma panel variant.
> >=20
> > To add support for the EBBG variant, let's split this into 3 files,
> > - sdm845-xiaomi-beryllium-common.dtsi which contains all the common nod=
es
> > - sdm845-xiaomi-beryllium-tianma.dts for the tianma variant
> > - sdm845-xiaomi-beryllium-ebbg.dts for the ebbg variant
> >=20
> > Note:
> > -----
> > Both the panels are already upstreamed and the split is based on them.
> > There were patches earlier for both the touchscreens, but they are not
> > accepted upstream yet. Once they are accepted, we will add them to
> > respective variants.
> Hi,
>=20
> I believe this is not the correct approach. This may work short-term, but
> you will have to prepare 2 separate images for the device and mistaking t=
hem
> may cause irreversible hw damage at worst, or lots of user complaining at=
 best.
> Instead, I think it's about time we should look into implementing dynamic=
 panel
> detection.

It is certainly better than current state. Now user will need to decide what
panel he has.

> Qualcomm devices do this by parsing the command line [1], as LK/XBL
> gives you a nice-ish string to work with that you can simply match
> against a label. Other vendors may use custom mechanisms, such as
> a resistor / GPIO to determine which panel (or generally hw config),
> but implementing this mechanism would make upstreaming of lots of other
> devices easier..

I believe ideal solution would be bootloader passing the correct dtb to the
kernel...

Best regards,								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
