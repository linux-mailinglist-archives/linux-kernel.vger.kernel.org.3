Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE67591EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbiHNGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHNGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:42:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE205E31E;
        Sat, 13 Aug 2022 23:42:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j8so8602002ejx.9;
        Sat, 13 Aug 2022 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lJ8gBapU+3I/Fz9LZ5favwJM0YfdvqXAjWYrlqgEVg8=;
        b=oFcN1jtJrAWrkrsYs75dkC5rJMcPYnYciSlrMdc1Rey/o0vE7d5G//ei161GnZSXul
         k9M+DS7107ymze/izgVzWbnS+7ahP4B66YoZch0Baq0kaEw6DIVmiDKHthUPGCXdb5Na
         3GtKHI/411yTNFHU3O14PEzhz5MBPvqSXvUAMWieKFLZtx1s7lxDs59uoRJzetPDnzmc
         6wucQnaX50Vpzkp5ruDqNadnmh3jzfR/9yyspCMh4N9Ueju1ZXEEXNBMgNY0lULHmqER
         OHC6dkRzZ7EhIuNDIQxR4LZvTk+23OrzNHOJQa+UlE26dbTwHEBAOoM8DgXkV/1G1ZC+
         zQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lJ8gBapU+3I/Fz9LZ5favwJM0YfdvqXAjWYrlqgEVg8=;
        b=BMOpWxio3BvVy47qne46z6V+ue20YGvM2lgI540IR8zX7PSqa5WjOXPkz6pOVv+Q/q
         2f5AMDKC3rf8fyFM1BTMhYCQrvViGcpUfxRsMHEcmkQ6zsM9BYnocHcwMBA9PSvJEZov
         wuchqW94RIvSnDGHRt62OAvORuo0boNP6VMX4Knr0lCgZ+bsqYwI4USqhpoi6y9CovUQ
         qGC7feuYvEDMf86JzR7eiELjUd0U4L+5RFIUqLN33f2gYa/HtgiRxw12/MnMy354Mrkh
         Ep+bjbmrJKJIIMwzVX29+4szOc3EfZ7OwJhJH27BExcaFwlVqlm0l+VID3MfX5RpqZhx
         ihUA==
X-Gm-Message-State: ACgBeo0wiXODeQ1Z7bEFzHOFRQZpyXicZL5zlS9dFIkEBhG4W4/9DO48
        1kpD3V9dSBp4/CHpH+w3wh4QkcHg1Q0e0g==
X-Google-Smtp-Source: AA6agR5um22tR+AS4GkxN7UJD+cDeqE1juTpQYbU/f5aBXd87Mexe2YSMRmH3Y3s/wv4uZBA9Cn7Lg==
X-Received: by 2002:a17:906:8a6c:b0:730:a322:6f69 with SMTP id hy12-20020a1709068a6c00b00730a3226f69mr7027005ejc.585.1660459361130;
        Sat, 13 Aug 2022 23:42:41 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id kw11-20020a170907770b00b00730b5a35288sm2602982ejc.214.2022.08.13.23.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:42:40 -0700 (PDT)
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/6] media: sun6i-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Sun, 14 Aug 2022 08:42:39 +0200
Message-ID: <2640649.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220812220045.800820-1-paul.kocialkowski@bootlin.com>
References: <20220812220045.800820-1-paul.kocialkowski@bootlin.com>
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

Dne sobota, 13. avgust 2022 ob 00:00:40 CEST je Paul Kocialkowski napisal(a):
> The driver relies on the reset controller API to work, so add
> RESET_CONTROLLER as one of its Kconfig dependencies.
> 
> It also selects PHY_SUN6I_MIPI_DPHY, which depends on RESET_CONTROLLER.
> 
> Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2
> controller") Signed-off-by: Paul Kocialkowski
> <paul.kocialkowski@bootlin.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


