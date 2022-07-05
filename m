Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732DD56782E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiGEUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGEUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:08:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786FB17E24
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:08:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dn9so18247156ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIq36v8wbs/crdsFluPW/o6PUn4dC6+CyT1Mue/r6HA=;
        b=Re0vVY2AKXjk6ch8pHfO7eao4ier7bJy84tNV8N6GCRRrhgwN/x20kkMDp1IpXTbGO
         F+RJhCcSc1d3eOGS545ZeziJ2RGUB5rYLZHkptxK9NukD1lfjc5Gd8z8TGYt+G4fmWGJ
         gHaDvuaMxe/wjwXO6MJ+ReoVMw7dW+YY2+szBr/8t+Tr371rYaAYtyCvLoRp8r1R8Vk7
         j88rOH/wz5+/PbJ1eMXVTjIks/Ej0zFYJTR54Xfhr/gB4mcvukIwUhp/rJwQfXK71y3W
         n+HffrFmF6Ey+8EXBIqBcFWCwgdDI/3gmb0ub6Yp2u2vPn2euVcrcRfs+fKDMrdAURbC
         j/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIq36v8wbs/crdsFluPW/o6PUn4dC6+CyT1Mue/r6HA=;
        b=NmqAwXjPwCippT/5urm5cZ8B+yHXqpb//sdUdWkVmYOuS63CZ8iYhbZIX3vAXtXyea
         /9B+qbe1uFtEOlrle/CosNL1wHH7KmdMNWq8LxTifnnbQB86tnRAmJHXjEGVyI540NQK
         tUBJUGV4rX8/e5oBEO2eQye4iPYMjBPx74W8R0du1tvEhSxRG4posaXFkkzqaTQOmlFr
         m4QHylCHbZWvw1P6dJcvpxIr0P+Lpcrgl588/6WmMSDG3sNZoUsM6nF+27mVNxQ7cCXS
         YzKujoInKBgFYcqvg9X06Ed3KN05Ac1Gz4+J9rPKZ2XyV1sBM3ev7TBbv2ff2Er7wr9u
         QZiA==
X-Gm-Message-State: AJIora/wFuc9PO5jLFC+saQl1AvNbrSFtpbO7Z2Im/BVqzjnAsLi3rTk
        D3wo1BSxHHvUqo+Mnjwp7Du2/qSWZTS8QQ==
X-Google-Smtp-Source: AGRyM1tlIP9NshOHw7mRD90hBXUoaOn6/U4K+d/MSfl75EZRSgK1+016xvOMN3dBGdMuomvHtlViEQ==
X-Received: by 2002:a17:907:7fa5:b0:726:935b:2faa with SMTP id qk37-20020a1709077fa500b00726935b2faamr36914434ejc.17.1657051717095;
        Tue, 05 Jul 2022 13:08:37 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00437d3e6c4c7sm13944635edb.53.2022.07.05.13.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:08:36 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH] soc: sunxi: mbus: Only build the driver on ARM/ARM64
Date:   Tue, 05 Jul 2022 22:08:35 +0200
Message-ID: <2156179.72vocr9iq0@kista>
In-Reply-To: <8122293.NyiUUSuA9g@jernej-laptop>
References: <20220702032520.22129-1-samuel@sholland.org> <8122293.NyiUUSuA9g@jernej-laptop>
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

Dne sobota, 02. julij 2022 ob 21:12:04 CEST je Jernej =C5=A0krabec napisal(=
a):
> Dne sobota, 02. julij 2022 ob 05:25:20 CEST je Samuel Holland napisal(a):
> > This driver exists as a workaround for old devicetrees which are missing
> > interconnects properties, so it is only useful for those specific
> > platforms, which all happen to be ARM or ARM64.
> >=20
> > This solves the issue that the driver fails to build on RISC-V, where
> > PHYS_OFFSET is not defined.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!
=20
Best regards,
Jernej


