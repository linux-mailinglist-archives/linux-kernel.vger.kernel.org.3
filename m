Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE656792B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiGEVFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:04:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82BE15FD6;
        Tue,  5 Jul 2022 14:04:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so23762339ejb.6;
        Tue, 05 Jul 2022 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsDCVa++41WRsgJcRaNP0nRk9zNglrTjlOIi6M6lplg=;
        b=XOF5A6dCni+ZyA8p8TlPz8MUPc21YfwPx7xJuMY/HpC52rpPnKWv5EfVyK67gYyt+u
         yNJPH8CxYcbiC4noI3S8MiQ6J77MlPanIhNHzSDssQDSHUWPdu+BgHPN8n6WRLDU4etu
         Y0djmPEhHSkr5zYGVcodvWy5zoGuM6AA2wKgQxZRJj+rqR3UK7DlXL6X1yXmlCiyCrJE
         AfPwBpZabBtwvofL+TBbsJxH2hsraxFAJqZwoNQOz32bInt8xNhNKHKcJW0cv2eCgwbH
         NLV0fGDkmslmL1e7sb6+U06pcPEjuL6fKlApKB7IWn+1qYj61feMosZ4nkDuswc8m4j/
         0pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsDCVa++41WRsgJcRaNP0nRk9zNglrTjlOIi6M6lplg=;
        b=7ylR4CPZk1EHYucqsdzdzrAObazPkTlooOcLRHooAO0qBFQI2NlNobh7Dr+MHKz9Tp
         0E1/swvbLTqNNSgDBuGT5PedrVqiWTnfZj5qYQIVcACvBV25H7/VtudTDgfDzM9mfY0G
         qkpTRofhd5dSwbwPNi1O2Kjp35HQiu+dGRWDctVk9HcL6ZsutpmHAZ4GpLb4f5PxHGO8
         b9tXIi6Ws5OiYJq2MLlpWMR88KfSR0QNlQQ0HcEHnPEXSHBKFpCWQUaAuiGobTD76TuG
         SXNnAqB+h3+OazAQWdOPpJbUWJrSVYZTAZi999r4EtO1AvhFBMFYzsYD0CLY3xmbx5Kd
         rmFw==
X-Gm-Message-State: AJIora+YXRRDI/JZpwyylyYlTyftaYr9WoayfWvt82p/G+AcKLpZNzL7
        PT/4UsBj5Ogtti1jEOK5L2k=
X-Google-Smtp-Source: AGRyM1vRC15LiW8FGGShUPVfcpOv23sewSq/KWTbXpNcQHbmwubioDrDq1AhZ5YHPF561xVHmSUzpQ==
X-Received: by 2002:a17:906:d54e:b0:726:3709:605a with SMTP id cr14-20020a170906d54e00b007263709605amr34558192ejc.424.1657055096474;
        Tue, 05 Jul 2022 14:04:56 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id d8-20020a056402000800b0043a71c376a2sm3617210edu.33.2022.07.05.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:04:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, samuel@sholland.org, wens@csie.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        perex@perex.cz, arnaud.ferraris@collabora.com,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH v2 0/3] ASoC: sun50i-codec-analog: Internal bias support
Date:   Tue, 05 Jul 2022 23:04:54 +0200
Message-ID: <1819721.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <YsSl+JOmMpGLK1Xc@sirena.org.uk>
References: <20220621035452.60272-1-samuel@sholland.org> <3139722.aV6nBDHxoP@kista> <YsSl+JOmMpGLK1Xc@sirena.org.uk>
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

Dne torek, 05. julij 2022 ob 22:58:32 CEST je Mark Brown napisal(a):
> On Tue, Jul 05, 2022 at 10:12:56PM +0200, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 27. junij 2022 ob 22:46:30 CEST je Mark Brown napisal(a=
):
> > > On Mon, 20 Jun 2022 22:54:49 -0500, Samuel Holland wrote:
> > >=20
> > > [1/3] ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
> > >=20
> > >       commit: 24e0b04dd42be34ec4b18dc1a1e139d66eb572a3
> > >=20
> > > [2/3] ASoC: sun50i-codec-analog: Add support for internal bias
> > >=20
> > >       commit: 25ae1a04da0d32c22db0b018e5668129b91fa104
> >=20
> > Can you also take patch 3? You picked bindings change, so it's easiest =
if
> > DT change goes through your tree too.
>=20
> I can if the sunxi maintainers like, but normally changes to the DTs go
> via the platform tree.

I am sunxi maintainer. Wouldn't my branch generate warnings, if I have only=
 DT=20
changes but not bindings?

Best regards,
Jernej


