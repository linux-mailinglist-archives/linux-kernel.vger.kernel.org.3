Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2926054A12E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351769AbiFMVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbiFMVRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:17:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458A4666C;
        Mon, 13 Jun 2022 14:00:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id s12so13442011ejx.3;
        Mon, 13 Jun 2022 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CJMCg82C9CA+VF6EtDbiVLWnCE+gcyYEDGZtnWDX8I=;
        b=cJc/SprZOfokSgWwnzvuGuRwPp1zab3QO7Q9DUSxb6DYSiH8EGH3aR8DOm3dcA9B7l
         GjDO0NbkAF2WQW/sB26wXSNDG/PQsezHS9Sy3haCeZizj7fwKU12mhzRtLLFDmEiu/hp
         dlHvkvfXMG7Fl99OAPbv0f+ufocMcSZyjnoKeqK341x16Cgcv1X9zl7i5AP9aThKe9bY
         IZMJYxoTArAncCcTCMjPw5JyRmrVUAQizo6neNGAPII7SBuHvcAvwtjxvW6e3mhPQLrT
         dpZI1OZO3WsL9PmsWGp3FGnrSd4NyGXdmNxtFsfVL37/QmqoEv8E9IxiwBvVS/IrPskC
         WxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CJMCg82C9CA+VF6EtDbiVLWnCE+gcyYEDGZtnWDX8I=;
        b=uyyYFL62uedzN2gc7gVsrEn2ah/D0CEyFBpJpd1nH89kvmA1r8oYDx4Xr+TqCtyCDf
         jowTmTd9GhfudqR09SBLUDdj4s67FuGK21cvAa+AGpVpRPoY7RfDbfGTOR+HZ6NqaXUh
         mOxG9AvBsrOXtTXX+pDTOR5ghL6mTeXxQpse9pGEv8I7x51IFKAry9YUJLJnQZrhb/Mp
         SLrr60Npk3kWo06Wo7e67c5oOH6lHj+gBqsUnCSKCYHkR4eUTC89VhouW+YHziNMiLHn
         dgQqVMhX7r+o0OCy71Typ7Ps+eCxR60FvGkJEivGqMCMuv+lbfhbqMgTy8+sbO+bes+Q
         ZSoA==
X-Gm-Message-State: AJIora99+xkLG9zjK43uBfodakOnF4CQ4DJYpsGUAs7fuKa//i4NlCQL
        sGMeAwzFYbuQLMxNgFPfEaU=
X-Google-Smtp-Source: ABdhPJy/yfR5haJgk6lB/FbMqG7w8FPgqDK3la1oweXRWZE+kcsnyfKXjsR13vgEm01lVEVNEX/dFA==
X-Received: by 2002:a17:906:7a13:b0:711:ff9c:f4bb with SMTP id d19-20020a1709067a1300b00711ff9cf4bbmr1415216ejo.642.1655154004124;
        Mon, 13 Jun 2022 14:00:04 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id h18-20020a05640250d200b0042e15364d14sm5671325edb.8.2022.06.13.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:00:03 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 05/48] arm64: dts: allwinner: align gpio-key node names with dtschema
Date:   Mon, 13 Jun 2022 23:00:02 +0200
Message-ID: <5574044.DvuYhMxLoT@kista>
In-Reply-To: <20220609113911.380368-4-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113911.380368-4-krzysztof.kozlowski@linaro.org>
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

Dne =C4=8Detrtek, 09. junij 2022 ob 13:39:07 CEST je Krzysztof Kozlowski=20
napisal(a):
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


