Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70856B211
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiGHExt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiGHExq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:53:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7276B246;
        Thu,  7 Jul 2022 21:53:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x10so18185644edd.13;
        Thu, 07 Jul 2022 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ifd6YvR971sQbkTDoi8ioWcjmTS4ihpj6psKjLvOgsg=;
        b=lfYE5tzh2TowBWRFhQcIuCLeYjkDlkpzZ2FtOaAaopdYJWsvkxVeyl+Q6TGRYOuyml
         7stejPBh/SbFwt6MxCf1WtdOuMCBlry6XBrfGPqpP9vka5bgU/GzUnL33CTZUENla7zp
         vNexaOxkdZG1rSJvrvigLC5E6ositJqzUo1EcdYnp5rR1D3i+N7eRDEAJhK4scna2wAZ
         l+LMeEnGMM7YGMFyN1QDqM4AqI91F54CDZQJtf0gboXW/GdSihXAL7RkjlpCl3YyzBB8
         ybJafvwIu9btRqoJkCQCtHgBVDwQDSA8ZOcCUF4wgsZnvoqINPUSWVJc+xsY0jUi3yMH
         UQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ifd6YvR971sQbkTDoi8ioWcjmTS4ihpj6psKjLvOgsg=;
        b=L0M7BbuIBT8xbvabvXOD5oMlpb80YoZeIOIQb5dcaXU5vbvOc6PV2WY6DpUpqiNE3p
         ADVbrvuZ9+VbHUjFp3nugY3I64TsJZBb+DWcwqkuJOqeK3cfhTxAML5dm4u4FvKreuHw
         Uh0LRus7eo1MIZ8CYNy5slaO/+pX0L1133w/Gx15VIRml8zukKLRHab0LPi6Z6CJf6/p
         Wka82W+ksclGhftjyN4z85l9/xtNCtJujmu6anHLJ65hcmgPb4ZvBg6q/eNeWG330sIu
         gj6czqk87YcN3KbS64bFuOiHXIYO9GXmqfxHDtdvlK9UiNDOkxPrclByKgB2tncUS8kN
         KByA==
X-Gm-Message-State: AJIora/t5Al1DK4gvrViTjnkETFrRX/ZT5xiGnJjRITIscqQFuUjALAy
        QxIrqYD9RT7e5bpcONhM1ek=
X-Google-Smtp-Source: AGRyM1sdjA51qCoZ7NUFs/lENCEIWfFIXxbWT341U/bvcvuvoTdMakI0TtWwRJh+P8OquJViwHo9hA==
X-Received: by 2002:a05:6402:328f:b0:43a:8488:1000 with SMTP id f15-20020a056402328f00b0043a84881000mr2198862eda.105.1657256023794;
        Thu, 07 Jul 2022 21:53:43 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b00722e52d043dsm19778844ejf.114.2022.07.07.21.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:53:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@lists.linux.dev, Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sunxi: dts: Fix SPI NOR campatible on Orange Pi Zero
Date:   Fri, 08 Jul 2022 06:53:41 +0200
Message-ID: <5580737.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20220707170721.20225-1-msuchanek@suse.de>
References: <20220707174801.36e010da@donnerap.cambridge.arm.com> <20220707170721.20225-1-msuchanek@suse.de>
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

Hi Michal,

Dne =C4=8Detrtek, 07. julij 2022 ob 19:07:20 CEST je Michal Suchanek napisa=
l(a):
> Without "jedec,spi-nor" compatible the flash memory cannot be probed by
> u-boot. The macronix part is what is shipped on the boards that come
> with a flash chip.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Next time, please add changelog below --- line.

Best regards,
Jernej


