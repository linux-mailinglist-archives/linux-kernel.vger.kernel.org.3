Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C25821B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiG0IFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0IFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:05:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE3A1B9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:05:18 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF7893F137
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658909115;
        bh=2EHnKuERdz3YH5WWDKnExQUdg0Om9iiL0qfm7ITCKY4=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=YQN5j37lE042thqnQzQGTkruxVhaPrChXdrSCB8YFR+FknCWVukSQzfeatzmXgCsM
         7Rg2qtIwzWn8zcc5XqlZjaxpy2X8a7cGLRgum7b7dA6rki9QvMBcs3bcbc+s/2hw4a
         Ju6XZouSDDYD2VLCAfumTvIQPu8C2jWfwNvTGmD5uT96VAEeaKCFrfd17W9RI6wLog
         dGoZ/Q48CqTnAD6MWj3NJu8hDABqFHoXkYClqEleMNrKuxYosFZUsXedVIB6uE1jlE
         ABNdCDPCUSYX04puEnJEuE1VYjqrpj4RKCouGqB7ZK906TtSdb3qQP67zxyJ8EKsdf
         bLFWm2IbMxHNQ==
Received: by mail-ed1-f70.google.com with SMTP id h15-20020a056402280f00b0043bd8412fe0so7404471ede.16
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2EHnKuERdz3YH5WWDKnExQUdg0Om9iiL0qfm7ITCKY4=;
        b=2B08XlquTNwJh/pGK2j3i8O9D6laR/2KUS0DMiVnFkfPIi1CZQgtqY7fSWeZjsSJ8g
         GEHUAwuWnDXaTOLK8OSAG1tP5234XqsH72qElBZYkW1aMt1RPV1yecMqkFO3pvpn+1dn
         9WiZC8KNfIrcpQh/Fn55Wa9DiQPbkw4YFB4bit+Q32MrJEd+crdGk/o+zgChpWN0lDBG
         9Ns+JAWWXW8iV2nQYFueAtUVckGlCFvBuMlenxh3cAgQ9sk7DX35YONduimROHBaFvzj
         pQ9GzCzUNz2zhbXNIlmgVdBf6ToWklf4jMe0aYBYy8lL9aIFXQi2EN37HIIAH/BsnJ4Y
         +47Q==
X-Gm-Message-State: AJIora9CIdPGc1orqAHAp3Dq/92/fyKKH3I1VC5F6GJ5hby25Kt7WRf3
        QlZJxEL8q0j02KCJZRuZR19X9R8o2DMsDFyxbNXtaA4RELEcYGEyFVflHhFDZHNUE1fv7TWdC62
        shZZhiLdisNkjiX5BpHSL9TnOxDUatd9S91qDAoYUtw==
X-Received: by 2002:a17:906:9be4:b0:72b:cf9:99d8 with SMTP id de36-20020a1709069be400b0072b0cf999d8mr16665563ejc.747.1658909113988;
        Wed, 27 Jul 2022 01:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uT5/cEpFvJBgf7GeDy4LxPJIYxT29suI1ax4YpuqsYKhij4wMPXgSBBQxVrDJ/TFkSg9N7CA==
X-Received: by 2002:a17:906:9be4:b0:72b:cf9:99d8 with SMTP id de36-20020a1709069be400b0072b0cf999d8mr16665532ejc.747.1658909113594;
        Wed, 27 Jul 2022 01:05:13 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id kx20-20020a170907775400b0072aa014e852sm7235198ejc.87.2022.07.27.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 01:05:12 -0700 (PDT)
Date:   Wed, 27 Jul 2022 10:05:10 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>, stefan.wahren@i2se.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous
 SError Interrupt
Message-ID: <20220727100510.4723ec84@smeagol>
In-Reply-To: <6612b35f-86bb-bb1e-bae8-188366495dbe@gmail.com>
References: <20210210114829.2915de78@gollum>
        <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
        <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
        <c6774af169854dc1d4efa272b439e80cea8cd8ff.camel@suse.de>
        <6612b35f-86bb-bb1e-bae8-188366495dbe@gmail.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eZoo3NCjbX5UO/=hScJI=Qk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eZoo3NCjbX5UO/=hScJI=Qk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Feb 2021 14:59:45 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 2/10/2021 8:55 AM, Nicolas Saenz Julienne wrote:
> > Hi Robin,
> >=20
> > On Wed, 2021-02-10 at 16:25 +0000, Robin Murphy wrote: =20
> >> On 2021-02-10 13:15, Nicolas Saenz Julienne wrote: =20
> >>> [ Add Robin, Catalin and Florian in case they want to chime in ]
> >>>
> >>> Hi Juerg, thanks for the report!
> >>>
> >>> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote: =20
> >>>> Trying to dump the BCM2711 registers kills the kernel:
> >>>>
> >>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
> >>>> 0-efc
> >>>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers
> >>>>
> >>>> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError =
=20
> >>>
> >>> So ESR's IDS (bit 24) is set, which means it's an 'Implementation Def=
ined
> >>> SError,' hence IIUC the rest of the error code is meaningless to anyo=
ne outside
> >>> of Broadcom/RPi. =20
> >>
> >> It's imp-def from the architecture's PoV, but the implementation in th=
is=20
> >> case is Cortex-A72, where 0x000002 means an attributable, containable=
=20
> >> Slave Error:
> >>
> >> https://developer.arm.com/documentation/100095/0003/system-control/aar=
ch64-register-descriptions/exception-syndrome-register--el1-and-el3?lang=3D=
en
> >>
> >> In other words, the thing at the other end of an interconnect=20
> >> transaction said "no" :)
> >>
> >> (The fact that Cortex-A72 gets too far ahead of itself to take it as a=
=20
> >> synchronous external abort is a mild annoyance, but hey...) =20
> >=20
> > Thanks for both your clarifications! Reading arm documentation is a ski=
ll on
> > its own. =20
>=20
> Yes it is.
>=20
> >  =20
> >>> The regmap is created through the following syscon device:
> >>>
> >>> 	avs_monitor: avs-monitor@7d5d2000 {
> >>> 		compatible =3D "brcm,bcm2711-avs-monitor",
> >>> 			     "syscon", "simple-mfd";
> >>> 		reg =3D <0x7d5d2000 0xf00>;
> >>>
> >>> 		thermal: thermal {
> >>> 			compatible =3D "brcm,bcm2711-thermal";
> >>> 			#thermal-sensor-cells =3D <0>;
> >>> 		};
> >>> 	};
> >>>
> >>> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> ra=
nge is
> >>> full of addresses that trigger this same error. Also note that as per=
 Florian's
> >>> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from =
what I can
> >>> tell, at least 0x7d5d22b0 seems to be faulty too.
> >>>
> >>> Any ideas/comments? My guess is that those addresses are marked someh=
ow as
> >>> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ulti=
mately,
> >>> the solution is to narrow the register range exposed by avs-monitor t=
o whatever
> >>> bcm2711-thermal needs (which is ATM a single 32bit register). =20
> >>
> >> When a peripheral decodes a region of address space, nobody says it ha=
s=20
> >> to accept accesses to *every* address in that space; registers may be=
=20
> >> sparsely populated, and although some devices might be "nice" and make=
=20
> >> unused areas behave as RAZ/WI, others may throw slave errors if you po=
ke=20
> >> at the wrong places. As you note, in a TrustZone-aware device some=20
> >> registers may only exist in one or other of the Secure/Non-Secure=20
> >> address spaces.
> >>
> >> Even when there is a defined register at a given address, it still=20
> >> doesn't necessarily accept all possible types of access; it wouldn't b=
e=20
> >> particularly friendly, but a device *could* have, say, some registers=
=20
> >> that support 32-bit accesses and others that only support 16-bit=20
> >> accesses, and thus throw slave errors if you do the wrong thing in the=
=20
> >> wrong place.
> >>
> >> It really all depends on the device itself. =20
> >=20
> > All in all, assuming there is no special device quirk to apply, the fee=
ling I'm
> > getting is to just let the error be. As you hint, firmware has no blame=
 here,
> > and debugfs is a 'best effort, zero guarantees' interface after all. =20
>=20
> We should probably fill a regmap_access_table to deny reading registers
> for which there is no address decoding and possibly another one to deny
> writing to the read-only registers.


Below is a patch that adds a read access table but it seems wrong to include
'internal.h' and add the table in the thermal driver. Shouldn't this happen
in a higher layer, somehow between syscon and the thermal node?

...Juerg


diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/b=
roadcom/bcm2711_thermal.c
index 6e2ff710b2ec..a831c33f6d9a 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -21,6 +21,7 @@
 #include <linux/thermal.h>
=20
 #include "../thermal_hwmon.h"
+#include "../../base/regmap/internal.h"
=20
 #define AVS_RO_TEMP_STATUS             0x200
 #define AVS_RO_TEMP_STATUS_VALID_MSK   (BIT(16) | BIT(10))
@@ -67,6 +68,32 @@ static const struct of_device_id bcm2711_thermal_id_tabl=
e[] =3D {
 };
 MODULE_DEVICE_TABLE(of, bcm2711_thermal_id_table);
=20
+/* Readable register ranges.
+ * Ranges determined experimentally by reading every register. Non-readable
+ * register reads cause SError exceptions. */
+static const struct regmap_range bcm2711_thermal_rd_ranges[] =3D {
+       regmap_reg_range(0x000, 0x010),
+       regmap_reg_range(0x034, 0x044),
+       regmap_reg_range(0x068, 0x098),
+       regmap_reg_range(0x0ac, 0x0c8),
+       regmap_reg_range(0x100, 0x100),
+       regmap_reg_range(0x108, 0x108),
+       regmap_reg_range(0x110, 0x124),
+       regmap_reg_range(0x200, 0x2ac),
+       regmap_reg_range(0x2e0, 0x2e0),
+       regmap_reg_range(0x800, 0x810),
+       regmap_reg_range(0xd00, 0xd8c),
+       regmap_reg_range(0xdd0, 0xdd4),
+       regmap_reg_range(0xdf8, 0xe8c),
+       regmap_reg_range(0xed0, 0xed4),
+       regmap_reg_range(0xef8, 0xefc),
+};
+
+static const struct regmap_access_table bcm2711_thermal_rd_table =3D {
+       .yes_ranges     =3D bcm2711_thermal_rd_ranges,
+       .n_yes_ranges   =3D ARRAY_SIZE(bcm2711_thermal_rd_ranges),
+};
+
 static int bcm2711_thermal_probe(struct platform_device *pdev)
 {
        struct thermal_zone_device *thermal;
@@ -90,6 +117,7 @@ static int bcm2711_thermal_probe(struct platform_device =
*pdev)
                return ret;
        }
        priv->regmap =3D regmap;
+       priv->regmap->rd_table =3D &bcm2711_thermal_rd_table;
=20
        thermal =3D devm_thermal_zone_of_sensor_register(dev, 0, priv,
                                                       &bcm2711_thermal_of_=
ops);


--Sig_/eZoo3NCjbX5UO/=hScJI=Qk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmLg8bYACgkQD9OLCQum
QrfV1g/+IHJo7txKoZL+J3czDpgvPEqgT5a7JWATbFaR9NWzo6ASHMjvvPepTsB8
CMA/BxmYSmPQmdL4PfnzdrcEnedNSkpmeSdxRPdCn0rr4AxErAI/Y6/nOnCD2tzr
zgeFikcz/3moru4/H9tJNUojtzwk+Jelm2CNrZsU9myktF6S8bKlsPR6PNoRNVtB
YMmassJpaEGL1HjqvrScpaUU7jhftpHkLPuITBV064SiMekVd7eMW+BnObl8nnmH
+D1LB5BfIFj48hR3sVWuKvWOO1xG3eIuvG33ijBiBGLiAjEQ1r9ZG9XvoODOJXUP
TN/SGnwKQNNFOKl0/1rgvPjJsQh34xdf6/N3nJD6Hf1jGf9JUb0BqGM4pYD9cWu0
7Nfww3UimzY/o9mgHOiGsVAKqJMk+uH89LPguL8pNeQq8kED6snrWPfic8bnRUMM
ykU73T4Jv9tyGAZ87kJ25BZRFWOqyCy8oZyRHoiLBrmSU0/Xxp8sUZhp/AxoCWwN
nQk+HyNmIusJLQweewNhL9upUTaQj/iq+YqofnTMgQDO4XZquc5rJxwjRADIza7H
606fz4Y7aeNHzd/zcQJ4IsR6NtT1LaJoTGdNmoG/RfMamcWfTO1wmOZI75cz+XDb
/ZIVldO794a6UiIVQpCR6gUAPN/FxSHl5VczO9SNyNEAhRO6IiA=
=a0Oy
-----END PGP SIGNATURE-----

--Sig_/eZoo3NCjbX5UO/=hScJI=Qk--
