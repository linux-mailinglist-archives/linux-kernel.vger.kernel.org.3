Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA748EC39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiANPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:08:02 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37741 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiANPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:08:01 -0500
Received: by mail-oi1-f181.google.com with SMTP id i9so12546768oih.4;
        Fri, 14 Jan 2022 07:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mELcxoCS2rGqtuIQqHLN1/ESK0gzux5v3TxcVcf+0NY=;
        b=Sjq5dVh276ILS2BMZmHOzlsSX3/R3wta4Quzx3bt1VyKnKO+D7lzc1F2uHVAdjGuvE
         Cd2TOg1iCScwbS6kfRNVOV6u8pDWF/57N8nWFxRtIGV0RWuQDnnNSmJmsXn/MQwHkOG8
         +7ivyAAU6Pkxgvl6aRBDcyr7hnVxr1KzmJnRPa9mzmL+fatxWRPwjzjVkWAav8kfzNLs
         ZDqxtxAWunZ5+fjAFOdFYE3n92EcTDeI1HUcLXdfbTwiSBr8Jv9dbT3J1pIR1SvRSavE
         9T2bNmoDulyiCHj2OwY/a6Ok2LJc5AQ1slv3ZT+fQNcMBT1FJGZ/gtH5kmFEXNsPb4Jh
         skFA==
X-Gm-Message-State: AOAM533+TNIpXowvAsokD64f1+zqGEbXJhNpiFuuiyEjdxNP0Yin6K7U
        xgBoHW6FxJXdpKfAbvDE8tXUjVRmZA==
X-Google-Smtp-Source: ABdhPJxHWKztI9xJhF9PWC2HI/gkFe+b9mkNYmIf0SuBeLj1ScA/QuakJAE+PHMNdecRvcNp+D7XzQ==
X-Received: by 2002:a05:6808:8c3:: with SMTP id k3mr85956oij.98.1642172880317;
        Fri, 14 Jan 2022 07:08:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c4sm1875869otu.39.2022.01.14.07.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:07:59 -0800 (PST)
Received: (nullmailer pid 1894656 invoked by uid 1000);
        Fri, 14 Jan 2022 15:07:56 -0000
Date:   Fri, 14 Jan 2022 09:07:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: gpio-restart: Correct default
 priority
Message-ID: <YeGRzIMsbSRTEId1@robh.at.kernel.org>
References: <20220110214456.67087-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110214456.67087-1-sander@svanheule.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 22:44:56 +0100, Sander Vanheule wrote:
> Commit bcd56fe1aa97 ("power: reset: gpio-restart: increase priority
> slightly") changed the default restart priority 129, but did not update
> the documentation. Correct this, so the driver and documentation have
> the same default value.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> This is a resubmission of RFC:
> https://lore.kernel.org/all/cfcd00257daba5aa30b8d20a62ba542be1a6914c.1640887456.git.sander@svanheule.net/
> 
> The commit message for bcd56fe1aa97 mentions that it is a workaround for
> rk3288-veryon boards. However, commit e28ea9dbc52d3 ("ARM: dts:
> rockchip: add shared rk3288-veyron files") later adds a gpio-restart
> node with a priority value of <200> for those boards, effectively
> rendering bcd56fe1aa97 obsolete (for their use case).
> 
> Perhaps bcd56fe1aa97 could just be reverted instead of updating the
> documentation.
> 
> An argument against reverting (a 6 year old patch) is that other boards
> may have come to depend on the default value of 129. I don't know about
> out-of-tree user of gpio-restart, but there are a few in-tree users of
> gpio-restart /without/ an explicit priority:
> 
> arch/arm/boot/dts/imx53-ppd.dts (commit 2952d67637716)
>   DTS submitted after changed default, but DTS copyright predates the
>   changed default.
> 
> arch/microblaze/boot/dts/system.dts (commit 7cca9b8b7c5bc)
>   The original DTS commit predates the changed default, but didn't use
>   gpio-restart. The commit adding gpio-restart appears to indicate no
>   other restart handlers are present on this platform, although it could
>   be these were just being shadowed by the custom restart code.
> 
> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts (commit 0a91330b2af9f)
>   Recently added board; couldn't find any obvious alternative restart
>   handlers.
> 
> Best,
> Sander
> 
>  .../devicetree/bindings/power/reset/gpio-restart.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
