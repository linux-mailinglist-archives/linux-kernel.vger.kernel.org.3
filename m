Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F705AF594
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiIFUMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIFULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:11:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4CB81ED
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:06:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s11so16587713edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ck2CZ63xlROKRuum+VYM3RwNiQt6GcNFVn5yjUBlhbU=;
        b=ga9QR8QkKm4EnEDibK+a4UuClq5Nes777nVtiyAuRinh0/Ie7mM1tSBVCLqEH1ugiO
         IlouNRGGlGMh8PAy0X4s9054Xim8TCwe/VTCAwjrlTZXNA3deVSy1W+0kPuHUKF5mEwa
         VTWo3H/ib5eNxXgdPa14jDUVTGHJ2tK67OXVAXeaI/dAT1e8V0IliyVBcbFMyNqRUK8J
         Nl9Ll59iDrM4I1zhPVWBkq3EN3RcA+ihfnEWg5akxMCg2CZM9H0H54FiZ+VU7vHQEVyq
         o1TomSxBabXQ1G2qK6IA+bOsodqiGTNWSOoMkVt0Vubj6i/Ya4sZOl9R2Aq5jCViRSCd
         ZuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ck2CZ63xlROKRuum+VYM3RwNiQt6GcNFVn5yjUBlhbU=;
        b=cO9whWfMiWiGSwxXpqw/Zfutha2NN6up42RvyQxyD3nZw4h6J+wBi793CeiH3MIe0A
         yF7yWJSIrtkDvd5zRjrZq3pW2HoIfZhHCG/Mwl6UxuMFJMa96quwQ1rIKlo0tFFSYlN/
         WIdHH0W5evMLz3Y0uoDYsy1SRQy2bUjng9tc6yZdL7qsjdSJYfGQPBL1Be9cEswoarfe
         wzP28Gp/G6YI89s698aiOloocxln/8R1WPVEEU35gHPsx+xCxpY7Y/uPRXeOPvKpx0PA
         ER4Spjc7rrGvAsxxlaX639jwNZ78atM6UtiZgjFYuegimO8ojTvYlNqLxkGHU0o75iJN
         8ThA==
X-Gm-Message-State: ACgBeo0nSu408cMVphuD46fMd8HFz7qnYHV+6ipbm/Cxrw5sxlGntrhT
        Z5WCrAqCwcu3XDpHzwDW5eA=
X-Google-Smtp-Source: AA6agR7CUAhPy+9MFPuH6DzgDy2S60+/E2h57c49ihYMLFNyPbmAh/8ehJuHA/jwsSZISEkVJfO+GA==
X-Received: by 2002:aa7:d803:0:b0:44e:af34:e47e with SMTP id v3-20020aa7d803000000b0044eaf34e47emr233791edq.310.1662494773089;
        Tue, 06 Sep 2022 13:06:13 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id wl23-20020a170907311700b0073d645e6dd8sm7123443ejb.223.2022.09.06.13.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:06:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 37/41] drm/sun4i: tv: Remove useless function
Date:   Tue, 06 Sep 2022 22:06:10 +0200
Message-ID: <1903427.PYKUYFuaPT@kista>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-37-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-37-459522d653a7@cerno.tech>
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

Dne ponedeljek, 29. avgust 2022 ob 15:11:51 CEST je Maxime Ripard napisal(a):
> The drm_connector_to_sun4i_tv() function isn't used anywhere in the driver,
> so let's remove it.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


