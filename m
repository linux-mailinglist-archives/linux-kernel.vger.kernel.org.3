Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F56566A4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiGELxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiGELwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6017A86;
        Tue,  5 Jul 2022 04:52:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0979EB817CD;
        Tue,  5 Jul 2022 11:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D85C341CF;
        Tue,  5 Jul 2022 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021954;
        bh=GYJpMv4Qk89/Srmvf9HLQazSk3cXF+hryGZt901MQCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4pViUO84HnzTJhHsqJN6cnIJ2v4n4S6B2NmGEHOtEWyYOFHHnAMLMUqaoK0tydMl
         U0ZJ/gn6k3yE2MyMeo+WptLsb26rp5LwE6/q87pIuuU3zVScGrC3f5COuBQMrKmkrc
         DJRvaf8SEXQo1dKL83ZYwZj8CpzdhIUlYZwpol8Y4g6SgqIaItoR0q49bfIxbdfbrJ
         NSrIxkxT1/WxZ1nO1geX5yZMRgZr7Dcy+pjYpbUb9jY9P6mpqc5UCMBGW16xSbWyh+
         HXx2RCGa5Nf2yUYuu3QIgPpZXInbIL72Ybdh0x2ln80nk2fY5yb+wbe40jmRP26h+d
         pz2TPED7SOlUA==
Date:   Tue, 5 Jul 2022 13:52:27 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add support for Turris 1.x LEDs
Message-ID: <20220705135227.6380d6d5@thinkpad>
In-Reply-To: <20220705105609.cpabhrwozyeejwqe@pali>
References: <20220705000448.14337-1-pali@kernel.org>
        <20220705000448.14337-2-pali@kernel.org>
        <20220705123705.0a9caead@thinkpad>
        <20220705105609.cpabhrwozyeejwqe@pali>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 12:56:09 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> >=20
> > I don't consider this a problem =20
>=20
> I think it is a problem, to ensure that 'cat multi_intensity' for every

Misunderstanding. I meant that I don't consider the eventual
inconsistency a problem, i.e. I agree with your code.

> > Or maybe just write the value?
> > Is the register write expensive on the CPLD or why are you trying to
> > avoid it if unnecessary? =20
>=20
> I just do not see any reason to do unnecessary writes.

But now you do an unnecessary check. Unless the writeb() is slower than
that check. Since this isn't i2c, I am wondering how fast that writeb()
is... But this is just me wondering, we can keep it the way you wrote
it...

> >=20
> > Hmm. Wouldn't it make more sense to simply have the global brightness
> > accept values from 0 to 7, instead of mapping it to 256 values? And
> > call it something like selected_brightness_index? =20
>=20
> All other drivers have brightness entry which operates on monotone
> brightness property.
> Brightness levels do not have to be monotone and by default are
> decreasing: 0 =3D brightness with higher intensity; 7 =3D no intensity (o=
ff)

What do you mean all other drivers? AFAIK only one driver does this
global brightness thing, and that is Omnia. The global brightness is
something different from LED cdev brightness property, the same names
are just coincidental (in fact it caused confusion when Pavel was
first reviewing Turris Omnia driver). Maybe it should have been called
global_intensity, to avoid the confusion...

> I cannot image who would like or prefer usage of such API.

One file that represents the index of the selected global intensity (as
is stored internally in the CPLD) and another file that represents the
configured intensities between which the button switches makes sense,
IMO.

> Just stick with existing APIs. "brightness" entry takes intensity value
> which is monotone, 0 the lowest, MAX (=3D255) the highest.

Again, the name "brightness" does not imply that it is the same thing
as "brightness" of a LED cdev. And since it even doesn't live in
/sys/class/<led>/ directory, we are proposing new API and can use
whatever makes sense.

I am not saying that the way you did it doesn't make sense. I am just
wondering if it wouldn't make more sense to be able to read the index
of what the user selected by button pressing.

Marek
