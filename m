Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1956D35B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGKD2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:28:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1F17E33;
        Sun, 10 Jul 2022 20:28:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b8so2342908pjo.5;
        Sun, 10 Jul 2022 20:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvpJcRf6oUgX+QTmJOMTVRuB6ZpQWygO0uE6iOwv3EY=;
        b=OT22HNUXNQMXJ8QFqf2Ppbo9WsAw44UUVwPFI2ZRqLBMIsK+PxOfalK5+Yoesp7fA6
         btFqpIfbjtLE4kxZp62YiNkErFz+3OK6g2QbxcLEg7WN2BAT8heMUVIOp2HdMwuaLGkk
         qqMrQDjBtmaxs2uSpYOT58uJo3B/cUsJPw+sccWiIStcejXidcfYDHK0DM2sUpLOMSJR
         y6XQIKNSxmVWq45hI1hwzBdrINXzOEyf5Rm4m4WU1l05g26hxpuLivuyeApdG3zdQwuX
         3tEeabcjsfCmKXs5SfVpxX3nSM6j570wFc8cNSZ7XdXM6EN2tJ+ysPbyvk7qBoaHhG7j
         CUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvpJcRf6oUgX+QTmJOMTVRuB6ZpQWygO0uE6iOwv3EY=;
        b=2u+5P3SnsUAQ1Br9qhlFYOV8JxkNDav4IF3V6L/+N2+lxAmQX/jnrBPZ6uJMa9KuJm
         abjVTJdaCcO3BqQP/EOBS+R7FtFMRZTipNK0PCWcQrG/6jlXqw6C+ObsdO8Db/afFprW
         8hvvKsWI7iB4RUKT3Is3+jzn/R8ieoS0ebQk2mv5WyvHZrIpLBBUzk+4lr/Bu+asXKmD
         DyHeQ3dmPZeTDPMueLPu14BcVeNYHHmUwhOaWHFkkeYcpzjd4Hn0qEIiHMmajnlU4r80
         smUbx5FhVmGl7GYKnx8jDl/QlUAHWyQ1Hn31m86Wnecbf9p7lNSkU8jyaX1MpAmHmJNT
         L9Iw==
X-Gm-Message-State: AJIora8Dq3Cov7nl3oCDPjAwKQv8AYH9q2iFL7JAtF9+1tISo0U13o3K
        YA04VtNvqcnp2snebWS1eOI=
X-Google-Smtp-Source: AGRyM1toH/cAS/LDlQiylUhVdo5tejUnCGLAKWX1fMPdZ4XeRBtTApKS4ROZLiTcRHyu+7wY5gJtIw==
X-Received: by 2002:a17:903:2447:b0:16a:3b58:48c1 with SMTP id l7-20020a170903244700b0016a3b5848c1mr17049132pls.44.1657510094625;
        Sun, 10 Jul 2022 20:28:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fe1c:af2d:8734:b8ac])
        by smtp.gmail.com with ESMTPSA id 4-20020a620404000000b00528d880a32fsm3569832pfe.78.2022.07.10.20.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 20:28:13 -0700 (PDT)
Date:   Sun, 10 Jul 2022 20:28:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v1 28/33] input/drivers/touchscreen_sun4i: Switch to new
 of thermal API
Message-ID: <YsuYyxTY6Ils/snA@google.com>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-29-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710212423.681301-29-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sun, Jul 10, 2022 at 11:24:18PM +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
> 
> Use this new API.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

I assume you want to take this through thermal tree if you get everyone
to agree. I am OK with it, but please use "Input: <driver> - <subject>"
format for input patches, i.e.

	Input: sun4i-ts - switch to new OF thermal API

Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
