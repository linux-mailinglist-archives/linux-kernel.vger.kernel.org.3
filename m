Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62D958CE57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiHHTJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiHHTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:09:18 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D11C19C1C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:09:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10dc1b16c12so11582396fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc;
        bh=4l9i4XlbJ+5mmKTKFgWECtlXoLq4GTjM56DrApQ3zMc=;
        b=WXnldZ6iOBHOrddzUwoQRxgam/JBzwyx71/OjpN+S0nPQiCYjfVHsJak5hpqrKugdI
         sz6jv8KOXTrlq54eF2VH5UdV7Ril0q3866QyHAGP7YLmCKcZCn4etUrQKuvkYj3xEFbR
         IZrXnD+WpPDpLEeukyzKmLWA37sTIZb1PT660=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc;
        bh=4l9i4XlbJ+5mmKTKFgWECtlXoLq4GTjM56DrApQ3zMc=;
        b=qzM0/QiAMF2388zAJ71F8RdFbCn1cTxBuVLqCDAYVqNWxKhuS6Xy6j/NN5PTiPVe7l
         UoTziLKj0UB09oI/fAe6VIKhOakJvFSfH38VMo5QIMYgfHTiqYjRCVRtuH6trzxmWlWs
         pE5vRHeM9F2I9X4CI5C+EejzljTiwtM7OxUg7Drcoe2k9SDffiFIz8zOXzilqDFT9s5U
         shaFQbMDYW3wdOtDHnS0zMSGG59wQTfuF+bFAObHvcgzvYNCZ8m3wCL33aflKgKKQQid
         FhpKjHmS9zTXvKTSrbfmRNryhX9YWA2DPxGx/smDo+OM0CVRzlqI5mGVSL+OFv/WNMms
         sWoA==
X-Gm-Message-State: ACgBeo1Mv0Yda9B8yq+VJol7wMS2h44FgT2GaU7ZyYQEKcG3Ha4LVxhl
        CBsREaUtWoOASrHd30+w9ORPJ+rfJolyCYNRsAVInA==
X-Google-Smtp-Source: AA6agR5mBX/UZhs7o/pIA55lLsdbPNZPdEc7fmUEWwPyqYNUtxSkx623SBa9QmGpQH54M7wu3v9gLmG6aUnL+1cjbiU=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr9076366oab.44.1659985756290; Mon, 08
 Aug 2022 12:09:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Aug 2022 14:09:15 -0500
MIME-Version: 1.0
In-Reply-To: <Yuz2O+lZ5W7RviuA@google.com>
References: <Yr6oLlmfWRkiAZG7@google.com> <Yr66ZZqEnBApHYMA@google.com>
 <0481d3cc-4bb9-4969-0232-76ba57ff260d@quicinc.com> <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com> <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com> <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com> <Yuz2O+lZ5W7RviuA@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 8 Aug 2022 14:09:15 -0500
Message-ID: <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com,
        Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2022-08-05 03:51:39)
> On Tue, 02 Aug 2022, Satya Priya Kakitapalli (Temp) wrote:
>
> >
> > On 7/27/2022 6:49 AM, Stephen Boyd wrote:
> > > Quoting Satya Priya Kakitapalli (Temp) (2022-07-21 23:31:16)
> > > >   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 regulato=
r-name =3D "pm8008_l6";
> > > >   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > >
> > > >   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 pm8008_l7: ldo7@4600 {
> > > >   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D =
<0x4600>;
> > > >   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 regulato=
r-name =3D "pm8008_l7";
> > > >   =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > >   =C2=A0=C2=A0 =C2=A0};
> > > > };
> > > >
> > > >
> > > > Stephen/Mark, Please do let me know if you are OK with this design.
> > > >
> > > I was happy with the previous version of the DT node. That had one no=
de
> > > for the "pm8008 chip", which is important because it really is one
> > > package. Why isn't that possible to implement and also register i2c
> > > devices on the i2c bus for the second address?
>
> If devices have different addresses, they should have their own nodes, no=
?

There are nodes for the devices at different addresses in the design we
had settled on earlier.

        pm8008: pmic@8 {
                compatible =3D "qcom,pm8008";
                reg =3D <0x8>;
                #address-cells =3D <2>;
                #size-cells =3D <0>;
                #interrupt-cells =3D <2>;

                pm8008_l1: ldo1@1,4000 {
                        compatible =3D "qcom,pm8008-regulator";
                        reg =3D <0x1 0x4000>;
                        regulator-name =3D "pm8008_ldo1";
                };

		...

	};

pmic@8 is the i2c device at i2c address 8. ldo1@1,4000 is the i2c device
at address 9 (8 + 1) with control for ldo1 at register offset 0x4000.

I think your concern is more about the fact that the regulator sub-nodes
are platform device drivers instead of i2c device drivers. I'm not an
i2c expert but from what I can tell we only describe one i2c address in
DT and then do something like this to describe the other i2c addresses
when one physical chip responds to multiple addresses on the i2c bus.
See i2c_new_dummy_device() and i2c_new_ancillary_device() kerneldoc for
slightly more background.

It may need some modifications to the i2c core to make the regulator
nodes into i2c devices. I suspect the qcom,pm8008 i2c driver needs to
look at the 'reg' property and translate that to the parent node's reg
property (8) plus the first cell (1) to determine the i2c device's final
i2c address. Then the i2c core needs to register i2c devices that are
bound to the lifetime of the "primary" i2c device (pmic@8). The driver
for the regulator can parse the second cell of the reg property to
determine the register offset within that i2c address to use to control
the regulator. That would make it possible to create an i2c device for
each regulator node, but I don't think that is correct because the
second reg property isn't an i2c address, it's a register offset inside
the i2c address.

It sort of looks like we need to use i2c_new_ancillary_device() here. IF
we did that the DT would look like this:

        pm8008: pmic@8 {
                compatible =3D "qcom,pm8008";
                reg =3D <0x8>, <0x9>;
		reg-names =3D "core", "regulators";
                #address-cells =3D <2>;
                #size-cells =3D <0>;
                #interrupt-cells =3D <2>;

                pm8008_l1: ldo1@1,4000 {
                        compatible =3D "qcom,pm8008-regulator";
                        reg =3D <0x1 0x4000>;
                        regulator-name =3D "pm8008_ldo1";
                };

		...

	};

And a dummy i2c device would be created for i2c address 0x9 bound to the
dummy i2c driver when we called i2c_new_ancillary_device() with
"regulators" for the name. The binding of the dummy driver is preventing
us from binding another i2c driver to the i2c address. Why can't we call
i2c_new_client_device() but avoid binding a dummy driver to it like
i2c_new_ancillary_device() does? If that can be done, then the single
i2c device at 0x9 can be a pm8008-regulators (plural) device that probes
a single i2c driver that parses the subnodes looking for regulator
nodes.

Note: There is really one i2c device at address 0x9, that corresponds to
the regulators, but in DT we need to have one node per regulator so we
can configure constraints.
