Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7854CD88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345858AbiFOPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348811AbiFOPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:53:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730E1581F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:53:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so24112080ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5ShLIbJdbDjGlxDv7D9TUkds40P1/JB5xsD295mwPM=;
        b=ciqSZu6WTLDGRSjO54NxzovGpYsYhGGsOZARVTMj+y8DfMifPnFGkOH5KV7BbJhb5k
         8S640o47KmDM86S99aJ3cBi06365fmZ9hpTCErSvRw1adrK4oe/CZ+xYxayYFKNtdlKR
         dFtFRl6r9lxLLVnSVLYLcK6ObsYHx8f5RutGYsz3yibJprsZ6aUz04aJK4zk1wTT1TEm
         94O43RAdX62nAx4IKH6DCUAbUlQZub+z2wGDEz3B8q8hMf+7HTuIw6NOz/lAvaJLYJtC
         Uz6CfSMbi2lAv5EIA0u9QhuFkAze8QTPtBPM4acfgDLEt6vQw7ON+Z/p5nZ+195qpyoU
         Cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5ShLIbJdbDjGlxDv7D9TUkds40P1/JB5xsD295mwPM=;
        b=XgQzAVdSQztSCTM1AFyl/jVwbvkZZyQzYE5mzWiy4oNM0IDKCmJEC4J/M231XRoPey
         wYPmMFFqs7tVLiK0NGRTePOKhaOS0Bn2Vzt4HR5Uu09NOwRZ8C9G3b1dVDFolaYsjYCH
         9JkdpqO9cXOu/k5588cOlsWUsdk0rkj+hX7HSTD+kLYnt9zde6RqK+1lOxcGrB57BXh6
         X4QhvpJPRkv9mTP8NIC9baNw09lfdoKULfLvdZiZNXue1Mmhah8EX4CDhB2l9IJj3tb5
         AiW996dB+1Cy7hNdetess9uNJKEUbMSZX+8Zc/gKIXQs6oJ1kaYYrhsG3XvQ+XVP+EIU
         TH1g==
X-Gm-Message-State: AJIora/zWMxhADwMVsc8M73axG8FwydtTkKcDrY4EaQ7gGXZ0lKTVYfu
        oR1fuaEmy/b9zJ1gTXJDJOE=
X-Google-Smtp-Source: AGRyM1sVtnrDE7GtZbaoUeUmFFWPnp7cBVKqt8WzfkzPflwAbHdYxsZncOddT9V93wqNSiltwTbHlQ==
X-Received: by 2002:a17:906:519b:b0:711:fb34:16f4 with SMTP id y27-20020a170906519b00b00711fb3416f4mr431124ejk.275.1655308410430;
        Wed, 15 Jun 2022 08:53:30 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d9ce000000b0042bc97322desm9548790eds.43.2022.06.15.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:53:29 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm/sun4i: Fix crash during suspend after component bind failure
Date:   Wed, 15 Jun 2022 17:53:28 +0200
Message-ID: <3671441.kQq0lBPeGt@kista>
In-Reply-To: <20220615054254.16352-1-samuel@sholland.org>
References: <20220615054254.16352-1-samuel@sholland.org>
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

Dne sreda, 15. junij 2022 ob 07:42:53 CEST je Samuel Holland napisal(a):
> If the component driver fails to bind, or is unbound, the driver data
> for the top-level platform device points to a freed drm_device. If the
> system is then suspended, the driver passes this dangling pointer to
> drm_mode_config_helper_suspend(), which crashes.
> 
> Fix this by only setting the driver data while the platform driver holds
> a reference to the drm_device.
> 
> Fixes: 624b4b48d9d8 ("drm: sun4i: Add support for suspending the display 
driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


