Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B34FB662
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbiDKIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiDKIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:54:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5EF3886;
        Mon, 11 Apr 2022 01:52:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u15so10739779ejf.11;
        Mon, 11 Apr 2022 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=/SgmTjMqwtpk9caKkdwZC1qgaJ93uCKltxtYXdsY3Zk=;
        b=hy2lG+uIpqMnLHr5GnQAr3ZpIZ07xlSJn20AQ8Fyj2ofzgW/4jYO+I7vyAy1klX6AE
         8jn26V3p3UyhHi9/fApNZ+l+OoZUfnBTbO7+17bFKkQvlbwSjncB9R4+5DzkdGoejDas
         QkW7Kb+d67Je+tfroWqlRZERA2hLJa0YuOXQjB0KplUqqjEJXqb+4OMNo4eDx2JX0GNs
         +/MRwPXyqMkynn5J0g2KAmHWqHqrh2tc3NGXL6xL3am/M3QsNcjyqAcoTgrydvgakwO+
         uxc4e9tQ7CljBytSt4t4JpcZD9Atj1DcmDAfW8dpVEEDMA86MCkaz+yq2Y3d7ozpvVlS
         NzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=/SgmTjMqwtpk9caKkdwZC1qgaJ93uCKltxtYXdsY3Zk=;
        b=B1jOCNEOd/KT9i7vxN/E5zuEVu4OLunFmM3EaM9zXxc1+5U+fktI7FIG5KhDv8Nc/N
         aQtqwzTzJcLiZOKLVneCscmvaRayk01b+iHzgnqC92iaFVVYNZW7LIjt2besCXrRYb71
         eThdOpNeeI+9xIzD3FpHIPU2bWMGHfERwTfnfDOkkAUcWYdd6+M8+cB9eE85H4xMkFv/
         QWUQlMNh1D5PuSaXtncOOuzPNeSZObHArvSrVz6JZFBd1cj3OTQeolCLwlAAGdySsba0
         kTT3MmtmQ0W02awLDAJ5C/TYkFWBHZMJ2G1SxyJVLSN8nwe1SMqOFh9ELKdtesXFRF9/
         1TdA==
X-Gm-Message-State: AOAM530nk5vIiqzBsjIrO5q78CWIcUIEtrFQcfQrUeeoGGA9X2fWhGMX
        q10lixsqSx66kAnK2kmNM84hgQwlC/cv1Q==
X-Google-Smtp-Source: ABdhPJxtEH7X77p4Qu0gHE8RrBYJRq3oWHQTGANgRa6aJ3uym9t9+HWTRWe/qHBwPHLki6yw/nYYgg==
X-Received: by 2002:a17:907:6095:b0:6e7:cc3f:c33d with SMTP id ht21-20020a170907609500b006e7cc3fc33dmr22587785ejc.570.1649667148711;
        Mon, 11 Apr 2022 01:52:28 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id x4-20020a170906b08400b006e493cb583esm11598540ejy.47.2022.04.11.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:52:28 -0700 (PDT)
Message-ID: <9ac83fe9bc33cce4b8691d49bdd155587196a62a.camel@gmail.com>
Subject: Re: [PATCH v1] mmc-utils: Add General command CMD56 read support
From:   Bean Huo <huobean@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "sperson@micron.com" <sperson@micron.com>,
        Bean Huo <beanhuo@micron.com>
Date:   Mon, 11 Apr 2022 10:52:27 +0200
In-Reply-To: <DM6PR04MB6575816F943FB2F0D4099CDFFCE89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220408174832.303915-1-huobean@gmail.com>
         <DM6PR04MB6575816F943FB2F0D4099CDFFCE89@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 09:03 +0000, Avri Altman wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&idata, 0, sizeof(idata));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idata.write_flag =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idata.opcode =3D MMC_GEN_CMD;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idata.arg =3D arg;
> Practically arg is not needed, because bits[1..31] are meaningless.
> Maybe just set: idata.arg =3D 1;
>=20
> Thanks,
> Avri
Thanks for your review.

you are right arg is not needed according to eMMC spec.  But as I
mentioned in the commit message, for the universal use. we need it for
the vendor-specific arg. I will change it that its arg will be 1 by
default if the user doesn't specific arg.

Kind regards,
Bean


 =20
