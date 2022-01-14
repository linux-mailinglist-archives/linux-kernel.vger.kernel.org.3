Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB64148EC12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbiANO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbiANO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:58:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D59C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:58:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e9so16103705wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=6vf0U5q3YvBeFSP6ko6F5Omy2TYNCgDxRvUcHVhEYQ0=;
        b=pd/Sc/ymoFhHtUDJbKUIFmJbTZs7ISdAwc/Z/4CtN3v9WiV8GkRuofTlTWTc4KHk2f
         RsnhyOCpwHcLsYotx9lqgV3q8OoB+Q9ycRNBt4VSUGccMCFGDv0z9G+We8al2dwQQDLY
         wAkC6KTN26MeXtT+8vldnrpnHKJjalrGcvh0SVSZFT6Qj3vFeyDyI1bNW+0QfxKRhXKy
         XYWQvHxG3sTil6A5HJqTC6d8DaycxwcfNWzvReiJj+0yHWD3hnLJjCcvtdA8LuZcJxG/
         BrN7DiuqrBCe2HqxYg8lDDPbJJ/6Kkpfey2aWeXcJ6YUTbftXFpgTG5OUMaAT+nMiTxZ
         mykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=6vf0U5q3YvBeFSP6ko6F5Omy2TYNCgDxRvUcHVhEYQ0=;
        b=DEPq892Lnv7My35UAHnvDw+gNv0G1Z70CGGViLWxOI0TDURtH85yQYTGcdoSh2SkBi
         /vjNePH8kMFH2XZCC/uLiwHHh2IHsCbLkv+JJezyXyRxq8kJcCI7XFMnsG+GuMT8xyXg
         +azaYT/yt7RTGnXnGxuUGJ/Ebssmq0rf4UyPc75fotEa+aE/DNBBcxpFhUcqH+GvZPoV
         wq6IGpzmQTrEKLPZ5iRN4db8o8LEvibFFjpQWdNJaM40dQia1RLof+uKsm2Rz2sUfmTw
         uD56n7Mg32AGhZivd4yvDShrX3f8IUWVv2L2p57iNDBFeNc69R/Fh7FSrZemtYaESR9v
         72Pg==
X-Gm-Message-State: AOAM5336JXkwiyvXqO4a8wWNYK4aGFIr7tr14eis4Clit+Glmrd5NOTJ
        x5zlqQZ33KiN3Up9gR4qTQW8qQ==
X-Google-Smtp-Source: ABdhPJwaCzxyfoZDVfCEAjJ6QGAdsVMhSBHArLgqdn2cWeUg0VmXCTSfPWbGVZ4NDt21+LmaYPHROg==
X-Received: by 2002:a05:6000:1686:: with SMTP id y6mr2609775wrd.320.1642172283314;
        Fri, 14 Jan 2022 06:58:03 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 9sm2380504wrb.77.2022.01.14.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 06:58:02 -0800 (PST)
References: <20220114090753.34873-1-Jiayi.Zhou@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jiayi.Zhou@amlogic.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: meson: external clock configuration for s4
Date:   Fri, 14 Jan 2022 15:53:58 +0100
In-reply-to: <20220114090753.34873-1-Jiayi.Zhou@amlogic.com>
Message-ID: <1jmtjybc05.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 14 Jan 2022 at 17:07, <Jiayi.Zhou@amlogic.com> wrote:

> From: "Jiayi.zhou" <jiayi.zhou@amlogic.com>
>
> For PWM controller in the Meson-S4 SoC,
> PWM needs to obtain an external clock source.
> This patch tries to describe them in the DT compatible data.
>

I'm sorry but I have already commented on v1 that all the mess in here
don't seem necessary. For Reference:

"""
 You trying to bypass the input selection mux. There is no reason to do
 so.

 Your input clocks should be
 * OSC
 * vid_pll
 * fdiv3
 * fdiv4

 While the pwm driver could welcome a rework around how it deal with DT
 and the clocks, this S4 chip does not warrant any change compared to
 previous generation (AFAICT)

 All the stuff around "extern_clk" should go away IMO.
"""

Unless you can *really* justify why this approach is required, it is
firm Nack.
