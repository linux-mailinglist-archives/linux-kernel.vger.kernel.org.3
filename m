Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFC4FFDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiDMSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiDMSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:25:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024E39B93
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:23:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c64so3421601edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jwfqri3KYR4KhSj3ppbAhDfkxtboXA/usiuYiLnlD6g=;
        b=D2D4Krghpjip+XspQgjlS2wkMhhGg0rUren1SgkRWH79tcMehCPK6+vlkk/RaUg1qU
         w/Yb0zCT5A7/prxIZ7Yl6eLzqFhHObVC931r0aqbWNF9ErBW90nsyv7gIleYFZJxeFLK
         lDbW4CbdUGkB92NbMCI3JdM9A1IB1Xd561N1bUmW63yVxxytIHaA7O+gg09CWuarso6a
         uVDJ1Tj14bpbwMw1LIhpJNWDBdteofc2c3z7IUosL56R2NHjl2RPTzkIW4G/gzuLRnlS
         iCTWXRPTf10NlDrEzFsuuYQIEGWBYE/ZRpC1WmDOK1Xd9AHZAj5PajCQwEkLnEuoi4D6
         eEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jwfqri3KYR4KhSj3ppbAhDfkxtboXA/usiuYiLnlD6g=;
        b=tW1x2KuCMjQwa7DFwG9cFg338IS1DkTvmsC2CsHncxSgQATgECfJLMf5ZKu9J3hQKa
         CwtGjOq8wgbI1D8ebMAz1/5vvJGCwcK+gM4uNq7EWCjGM4gn6wLlMVEH0uvDWMOSCf0J
         kZEnits29wHGuS0j8UfHA+uqV+bfQ3XM+/s3dEft5zBpBxKJITpZWSkvcI6nEG13MUN2
         WOfYpETT6aC1p85+MC1Bt5MDECDaKcq78ViIkxfJanCcI6Zc8gHu+ZsaWU9IS+z0soa6
         2u/a8FGYGBBx4jjjJArkjtsRu6LCHRLcUEIKEPbSy19tL2GmriACTudOspwc3NpgOQvD
         MiAQ==
X-Gm-Message-State: AOAM530Lw6szOlJyIIVDrahIeWEIQ3TRTKahsecGCSlVN93641zvvjai
        CKnwFh2sZkT6kiSlqILrnY0=
X-Google-Smtp-Source: ABdhPJxEUOQH41I8enMptU7PNcgxCcXlVuE68KqFVvcYAxghoUFXlh5kC+kMTBKhx0WOHuKjEJcIXA==
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id ec12-20020a0564020d4c00b00410a415fd95mr45126762edb.288.1649874208883;
        Wed, 13 Apr 2022 11:23:28 -0700 (PDT)
Received: from skbuf ([188.26.57.45])
        by smtp.gmail.com with ESMTPSA id lo15-20020a170906fa0f00b006e8a81cb623sm215227ejb.224.2022.04.13.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:23:28 -0700 (PDT)
Date:   Wed, 13 Apr 2022 21:23:27 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
Message-ID: <20220413182327.lbemqze46eq7ulfn@skbuf>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-4-leoyang.li@nxp.com>
 <20220413163306.hp5qyxxgdlekczet@skbuf>
 <DU2PR04MB894984A336667EF01DF709988FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB894984A336667EF01DF709988FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:07:20PM +0000, Leo Li wrote:
> > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5: Warning
> > (unique_unit_address): /soc/pwm@2800000: duplicate unit-address (also
> > used in node /soc/timer@2800000)
> > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5: Warning
> > (unique_unit_address): /soc/pwm@2810000: duplicate unit-address (also
> > used in node /soc/timer@2810000)
> 
> Well, this is similar situation as pcie.  The flextimer controller can
> be used as timer, PWM or alarm.  We have separate drivers and bindings
> for these modes which resulted in different nodes for the same
> controller.

I think the mfd framework can address the situation where multiple
drivers, with multiple functionalities, want access to the same memory
region?
