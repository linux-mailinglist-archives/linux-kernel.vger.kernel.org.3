Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC5471598
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhLKTTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhLKTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:18:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27AC061714;
        Sat, 11 Dec 2021 11:18:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so20328237wrd.9;
        Sat, 11 Dec 2021 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOlTCB5g4Ul64JkhSPK2Bym/NyU9CnIoy/twmv8/VQM=;
        b=fUqpRaZgBf7CEd3z2zVOe6jdnR/v8TZ2zI28oI+Jlz9SA22NR1gOn9jMaiJDtm3bEV
         jZd077h7yeY1eNxjd7HU8UU9K/kTvPNtZulCXWxAS5efH3p/+NQ2oDeTfvmSHyScyv8L
         a15EkJH3Rbn+ayd5Dzn9w7ZxClS7+WudFy1fgChiz94+PE6cRZ+gIvGhrpPOBnPOQc/9
         3w2O0X1Mk9Hsjswuo4jLg92CpWUX0czhIvGUkR99LFenrkC+2EzEmB0itf83/eACQJpC
         moTwP67Km7CGyNjJMXGQt4QjvsfTF2WedRTaxaXT15RlqMv8ip0TqL0BNu9TrRpgHR0O
         QMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOlTCB5g4Ul64JkhSPK2Bym/NyU9CnIoy/twmv8/VQM=;
        b=IL6Eup17CfgWHRUKhczqr8aTSP52S7HoCUlNqc5ovXbWtrEVZxUhGlrW9x8TYKaikW
         Dx1ECIiQY61IB4JGBZTBVHLYbP54hXvarJamNu+7yT9Cvn5oTS9hguEmZJVCi9L1KCF6
         80ufWhJ1w4aa4uZATFzUiuN4N90tMrghPUaJbp+xRpIuPM3J7P5Txsw3w504PZhekgy4
         9/D9sixF8CXowXSs7Y/2ZIfH6sDrDNUFzJcZz2xKz4wzWOcd5hz+onTC/wJB2p/Hzi/+
         KvLZMPGcJ8O/W05kwqXZuLowShIak5YSkC3vIE4NATxgQky6+crBCHRJHqUITM0gt3Tn
         l9Ig==
X-Gm-Message-State: AOAM530ajXWm7jzzEMcz3+06QNH94LH3d2bggMWHk21qIOHlDKacq9p6
        Hp+OcJYA2QTJct4gYzPk1PU=
X-Google-Smtp-Source: ABdhPJzIhDx8ABRVZ0FCBxAK7JVUsBsAzr623bRju7te8XUPwtOqsjQL6wl7EZJAH5iXBIwoDCdt1w==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr21539594wrt.320.1639250329686;
        Sat, 11 Dec 2021 11:18:49 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id a3sm3116524wri.98.2021.12.11.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:18:49 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [RFC PATCH v4 0/4] Add Naneng combo PHY support for RK3568
Date:   Sat, 11 Dec 2021 20:18:47 +0100
Message-ID: <2461932.fyNAqVaUXx@archbook>
In-Reply-To: <20211208185449.16763-1-jbx6244@gmail.com>
References: <20211208185449.16763-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 8. Dezember 2021 19:54:45 CET Johan Jonker wrote:
> This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.
> 
> =============================================
> 
> Changed V4 by Johan Jonker:
>   TEST COMPILED ONLY!
>   Driver not verified with hardware!
>   Produced in the hope that we can get some review progress
>   with this serie for the documents and driver.
>   Use at your own risk!
> 
>   restyle
>   add devm_reset_control_array_get()
>   remove clk structure
>   change refclk DT parse
>   change dev_err message
>   add dot to phrase
>   add ext_refclk variable
>   add enable_ssc variable
>   rename rockchip_combphy_param_write
>   remove param_read
>   replace rockchip-naneng-combphy driver name
> 
>   rename node name
>   remove reset-names
>   move #phy-cells
>   add rockchip,rk3568-pipe-grf
>   add rockchip,rk3568-pipe-phy-grf
> 
> =============================================
> 

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Applied this on top of 5.16-rc4, added the necessary device tree
changes to rk356x.dtsi and rk3566-quartz64-a.dts and ran it on
my Quartz64. I tested PCIe2x1 on the one combphy and SATA on the
other, simultaneously. Devices were detected correctly (with some
hiccups on SATA due to a Quartz64 Model A design issue, but it
was detected eventually) and some transfers were done to ensure
it's stable. It is stable.

Regards,
Nicolas Frattaroli


