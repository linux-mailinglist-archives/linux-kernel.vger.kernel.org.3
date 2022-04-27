Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141E5122B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiD0TaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiD0T2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:28:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88A3A5C4;
        Wed, 27 Apr 2022 12:25:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i19so5313161eja.11;
        Wed, 27 Apr 2022 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buJ+jfJhRXPQlaWZ59Jo560LZoPvnSVUNx60uZMSOHo=;
        b=JG4PSgWjutOAQp2rj3JZBRZFqpJvIty0sfKwfjNVfjpMXCVhnBWB1JcTs68If+hHW9
         firSR4VdhGgO/ehcbq3dXPJ4RTF89TwPXvLUK30mBybxi18h1L8tlZMrSEt05y5EO3Y7
         UdMYH6ea3ff6ZVvyuGcoavf24bfW8egImkL/3zA6JeL267CYL+oNYHRq47UVr+8XFhYm
         jiVqhKaiEyEJ47ptmHNBT+jv/ta2QNXJEPxUsE9eKCHiVzjgmX+R+eMTz6lZ+P9YaduF
         F9zeRJ2wH3iLFc59u+NINe/MxaPe5qQLhpi3hZVt2gmYSKFRc+Dm0gmaoiMZcY8dCjGy
         Sc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buJ+jfJhRXPQlaWZ59Jo560LZoPvnSVUNx60uZMSOHo=;
        b=54gDHok8QIbR6XtmARylZ6QTf3Mzgv9VRjrLY6yLb3xAH0coVW4c8pQaaTPptIfqqh
         WIU6LDaSH2EncZpMrfESQUoqNwz6gWvghb9LDsAH7wjNswjuaRc118RrzQUZ2XNJOMM+
         XDX19C9/c9pcUX2XCI97q3mu6FB4Sav15vqOypJk4S72uupIO2eO+yJzsoYz8u+Sp4DT
         O9Rn8FkXeCFDVw1wkfenlokRAnO54cT/T3zMbA9lTRO0vqs2qef4pWwCbrbByOswFZEG
         nyE41IAhel4GwHg+eoS1RO/G3Gwxgg/ZuQTihptF6Bj5V8iAxl+rf0wcdSiEdgoNiu+1
         NEnA==
X-Gm-Message-State: AOAM532ld2MP95uS77nnpJb2Ud6hvcmI3IJv835FISw8UGtdBnewzYhV
        FOivakvzm36A/nfx9/u5LKfSD9rgqXaolg==
X-Google-Smtp-Source: ABdhPJwe5F7BYMvqJm8UMirY3IaMe1ry6Su/8cXc2pHmRhgjZ+7fLOCgd4sgDPOK+90vEllB+cIAsg==
X-Received: by 2002:a17:906:4985:b0:6ef:b344:2a56 with SMTP id p5-20020a170906498500b006efb3442a56mr28761989eju.625.1651087506360;
        Wed, 27 Apr 2022 12:25:06 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id hf3-20020a1709072c4300b006f392c2bf71sm4700495ejc.175.2022.04.27.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:25:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 24/45] media: sun6i-csi: Move register configuration to capture
Date:   Wed, 27 Apr 2022 21:25:04 +0200
Message-ID: <5713918.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20220415152811.636419-25-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-25-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. april 2022 ob 17:27:50 CEST je Paul Kocialkowski napisal(a):
> Continue moving things over to capture in tidy helpers.
> Also take the occasion to remove the config struct, which is
> unwelcome redundancy and use the capture helpers instead.
> 
> The code is only adapted to reflect the removal of the config
> structure. No functional change intended.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


