Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356EB53A9E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351094AbiFAPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355341AbiFAPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:24:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2D95A04;
        Wed,  1 Jun 2022 08:24:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so2642461edm.13;
        Wed, 01 Jun 2022 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2s/uj8WC49ahrReqiF2/cgFexx1dmbjwYjSSVDIU/o=;
        b=DjueV5cqkCLDw2hnrUIX33XWBicHukWnlU8JpsVLUQV/zDlLzVQKBgbMNSS3+8xeOM
         T+iTK4xdP+7tuFtcpK6DOA67QPRsliVi5mURa/cM1Hzm4EdzPGQ/bFWGRfqJyE5NBLNW
         cnIHg9s1YehEYz2oiwdr3U9LAsy0aA+QM3y+opUMH3mwWpDIsDnPDNPv63yg4/zJx5qz
         T7TfUJ4OWBvAyJqWw0nG36keZ+u12AGDfSpAFYmozpdEDdlFSO93QFOvIe68iBNibIe3
         YexlIZ5Z3gBC8iLu1+RwCX+/0c2G4GLXnpsTy6ipBevt7rGKrvvGoeL1dPo5uZWBEmzj
         PvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2s/uj8WC49ahrReqiF2/cgFexx1dmbjwYjSSVDIU/o=;
        b=Wf5R+prjFvp/lFbc0RgeiI+XvXS3Jn9GmPtMIy9ffc86nDVV2CE48Jwboe5Pmfdw4K
         Dyj/Mfxlop4OnPbJ14xFv9aqo8tu6B2/928J9ECemFPayeoBaP9H7rRY1r5p2MpDr3bH
         MYuOH8eXd9JL21GwhXKCZgh9Ivaw1GJ3EG2q/YgI4mbdV9npbutMCNMiwNxzEgObWW0q
         1E4sfwCm8C7/Dvd+CwXZ/dlByEcKGTarnGSP/1WVUnItBwXrhfMr+rLGYgqNrMv1xPw8
         ns7dWrGMVF4AATRRj84cX7XvPwD2+S/ASlks2p0rNwxmxhN2MPoITkBaZuBqY6u/ENYE
         I4ew==
X-Gm-Message-State: AOAM533WPOuNGCyLpQ6zbQBO6T+zCzD73VfjqsMK5lzwQN154wQ//7Re
        CMrx7P3s0jxASVL7g7WJvfk=
X-Google-Smtp-Source: ABdhPJwDn4fYWychN9HWMd5ASr5v4eS7KmbuP60hlN+FSZkXniYTiTP0CoX3vAPP5IkPA4FBXuQgrg==
X-Received: by 2002:a05:6402:2548:b0:42d:dd95:5bfe with SMTP id l8-20020a056402254800b0042ddd955bfemr205534edb.285.1654097060744;
        Wed, 01 Jun 2022 08:24:20 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b006f4c4330c49sm846072ejb.57.2022.06.01.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:24:20 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH 0/3] pinctrl: sunxi: Remove non-existent reset line references
Date:   Wed, 01 Jun 2022 17:24:08 +0200
Message-ID: <2828716.e9J7NaK4W3@kista>
In-Reply-To: <48570ec3-8159-11ae-8069-7f001081fd56@sholland.org>
References: <20220531053623.43851-1-samuel@sholland.org> <4400164.LvFx2qVVIh@kista> <48570ec3-8159-11ae-8069-7f001081fd56@sholland.org>
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

Dne sreda, 01. junij 2022 ob 06:42:34 CEST je Samuel Holland napisal(a):
> Hi Jernej,
>=20
> On 5/31/22 10:22 AM, Jernej =C5=A0krabec wrote:
> > Dne torek, 31. maj 2022 ob 07:36:20 CEST je Samuel Holland napisal(a):
> >> I assume these properties came from a lack of documentation, and the
> >> very reasonable assumption that where there's a clock gate bit in the
> >> CCU, there's a reset bit. But the pin controllers are special and don't
> >> have a module reset line. The only way to reset the pin controller is =
to
> >> reset the whole VDD_SYS power domain.
> >>
> >> This series is preparation for converting the PRCM MFD and legacy clock
> >> drivers to a CCU clock/reset driver like all of the other Allwinner
> >> SoCs. I don't plan to add reset lines that don't actually exist to the
> >> new CCU driver. So we might as well get rid of the references now.
> >> Technically this breaks devicetree compatibility, since the old drivers
> >> expect the reset. But the CCU conversion will be a compatibility break
> >> anyway, so it's a bit of a moot point.
> >=20
> > If I understand correclty, this would cause only DT forward compatibili=
ty=20
> > issue, which happens now and then anyway. Kernel would still be compati=
ble=20
> > with older DTs, it would just ignore that reset, right?
>=20
> Right, this only prevents older kernels from working with newer devicetre=
es.=20
I
> brought it up because I'm generally trying to minimize how much we do tha=
t.

All good then, this series is:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


