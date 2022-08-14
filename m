Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D1591ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbiHNGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiHNGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:46:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700C6B147;
        Sat, 13 Aug 2022 23:46:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy5so8628541ejc.3;
        Sat, 13 Aug 2022 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RHfKLewiCmfaO7xL92FblVQuoV2hJPche3oawjnZYE0=;
        b=SfIOARkRKdqbh43SihXL3g1iqrt/NKkpis7l5JLJtmcZxp54LdwpAdXND7zPCW+NLX
         WqCdvPLjdVV+b+9Byix8rmAlG7QDoKApWtMBmMEGaUNVCfS72NBoLs2DFlkiNA6X+V99
         cHyLDQbmq/wp4OHVPhD8wz49V4wVaiZZdpaabP3sujpZ1tEdtESx/HpNZs/pIO0fm3dT
         5BQbb4EiSXyaIBUFNzTJCR6vZhnOMz16y4x91pYH6tl4s5ccNbSQQBIVA4nuPFRhvfBD
         ZCUBXD7nXFwf2UF0Pbw++BZ+RZR0LX+jBL48Kr2lyRSLUc0MBG3pWVYbCAfNxbiB3hOM
         c8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RHfKLewiCmfaO7xL92FblVQuoV2hJPche3oawjnZYE0=;
        b=PBrucuA9qYDhH9faioslZ4Sdmk1AHurbJXZD/Nw+uAujs/Thw2ju9ThlWGIaUat51W
         8I4p1PpLjAkolQsz/Sp5/i3vJeoNotRO8GCVrN/NjsWn9hAIBJp3jPOyOffiqXlx928P
         ZXVpKOP44kgVKyEML+hP3lCL8vS1sNyVOKNPNSCqKLzFGbclxGssv2b1sX4eAfeA/MH+
         6fIRXsQQNJVwYx7o0/bxrWsq/VlWEz4bVSgLsESI0+BxW7q24UQo6GpOpVPNNXmb+CN0
         UU2CSzmVPvGYq3zQMPCRzWGlFiB4DQOMCr71mGYETNgtYxbHYbmnco7Y7kgUAUmBaSSV
         /RuQ==
X-Gm-Message-State: ACgBeo3+AVOHRT4mnbMh7089sBCa7Jl9Hnj6ijwe5StgRq95Xv3kJyIG
        NuoFUcPOzZGQbsDFcECvf8y0ASpe+M8=
X-Google-Smtp-Source: AA6agR7t6L78m21I1kQ3RivP1OoGDtBwl7jBfRvIz0Z0V85VKMEnF9bfW9EaJZ19Be2eMGRU9EsORg==
X-Received: by 2002:a17:906:93ef:b0:731:1478:b774 with SMTP id yl15-20020a17090693ef00b007311478b774mr6748478ejb.531.1660459564169;
        Sat, 13 Aug 2022 23:46:04 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906504600b007306a4bc9b4sm2644920ejk.38.2022.08.13.23.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:46:03 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/6] media: sun8i-a83t-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Sun, 14 Aug 2022 08:46:02 +0200
Message-ID: <5847498.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20220812220045.800820-2-paul.kocialkowski@bootlin.com>
References: <20220812220045.800820-1-paul.kocialkowski@bootlin.com> <20220812220045.800820-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 13. avgust 2022 ob 00:00:41 CEST je Paul Kocialkowski napisal(a):
> The driver relies on the reset controller API to work, so add
> RESET_CONTROLLER as one of its Kconfig dependencies.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Please add fixes tag here and in the rest of the series.

Best regards,
Jernej


