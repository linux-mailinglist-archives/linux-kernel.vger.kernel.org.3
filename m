Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD67466894
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359728AbhLBQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbhLBQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:49:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79CDC06174A;
        Thu,  2 Dec 2021 08:45:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso2787151wmr.4;
        Thu, 02 Dec 2021 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d00HfC2LuL3eqH7QRBDblitkpEVvyUj0s9L0tyziXIU=;
        b=Wm7lnVEoUEiY7Ss4nG9mMLaNx3/3ce06ypFZStI8wxwzMPnsb+fOwbovpTo+HK/WTq
         CGp0H1cMuiFTzC+16c9LVHhAjLJ8fddwRmGlYbIsv7CW1S6JUOf/afsUR2lE1aRe/W2A
         2K0WagPgIJPOKhJCMfAejAfnhfXlLvj3ToGe+0aM87HHBOgrVnsM7iEIx6naG1LeVmPw
         FlRA8QAhnNnN+uniFIme0Wbdyp7spcdbVc3uyFDT81sIy0C4v/y26vl5R7efvXlpmU+g
         ToWuGGKBm/zFGd3Y3r9/mRKzUNeIwW9ags3lzpeUhvQVJM+MC1xXt9kf9iuJsjm2qfxB
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d00HfC2LuL3eqH7QRBDblitkpEVvyUj0s9L0tyziXIU=;
        b=Kc3iepValDL7H8OkDCRlcyzb7qkBE74kVKIgbMFsF+jJ3qZlExdnc2esbsVJVpYcB6
         H79KHNdT6NPCKNLYek8CFGwxIgS4sWrKbQRTWuBPVR4tX7cjEl+OxrrBfeUHRL0unAcy
         +knQ0u3oAxFlsDtudBqRxSGh3IXh2z2Ojy/Vnoz1u38ttF4/YLDHCUPCrNQ8HDASth4I
         mPqzouF60AnzIj2pAWmqhFehTr1hKCYUJmWbOmAh9gm7D+L20vb51kHDgseOhC8/FmZH
         s0r9fqIufarJG3B8MjB9CoLNPgztqLimqoiBpF+T+icBuZ4X5HxGZaWQfGlIkz5cEfcH
         Z/kQ==
X-Gm-Message-State: AOAM531y/APAGAN2e+qvCU3LyPulQHUVZmfT8IRlc4lqfqzjW6HLAcIh
        AJPp64Ow0nXz/1gACasFLP6B+xNbtNI=
X-Google-Smtp-Source: ABdhPJw549cjukoD5hOYyqCBWLw4SEvxL5SSsJaaSXbEOlQUUAGGfkpzh/u4BL/eTYmBUmx+Mc2Tmg==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr7520904wma.30.1638463551408;
        Thu, 02 Dec 2021 08:45:51 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id q24sm2512096wmj.21.2021.12.02.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:45:50 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     John Keeping <john@metanate.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>
Subject: Re: [PATCH] gpio/rockchip: lock GPIOs used as interrupts
Date:   Thu, 02 Dec 2021 17:45:49 +0100
Message-ID: <9812574.z3kqYUtTCC@archbook>
In-Reply-To: <20211202155022.2972779-1-john@metanate.com>
References: <20211202155022.2972779-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 2. Dezember 2021 16:50:21 CET John Keeping wrote:
> Use the standard gpiochip request/release resource functions so that any
> GPIOs used as interrupts are properly locked.  This allows libgpiod to
> correctly show these GPIOs as in-use.
> 
> Signed-off-by: John Keeping <john@metanate.com>

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Applied this on my Quartz64 Model A (RK3566) where I currently am
having a play with some SPI devices. Now gpioinfo correctly shows
the interrupt pin as being in use.

Before:
         line   3:      unnamed       unused   input  active-high 

After:
         line   3:      unnamed  "interrupt"   input  active-high [used]

Regards,
Nicolas Frattaroli



