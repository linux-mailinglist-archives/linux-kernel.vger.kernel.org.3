Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4051B552C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbiFUIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347996AbiFUIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:06:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1C248FD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:05:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so2672192wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GsCQyeSS9WqgWVTSCSRei8+jKy0pNjIeX7QnW7mozH8=;
        b=jibc9DU08V3+hmlKpMeuFBDRViUNOmAqhLv6bBMBvot6Y1y5fIwWhHP50ijPfYjSkP
         dofNHKktUMXyQWgFL3kXgkNcCMI2EyGV7jpxsE895xWHEcXseYPy3ALYyk3QO/N0mUp0
         vdtIIlaM3jdF4mNnqhGbeiMjdwIE1RoqzlR0jkpN01OXtm8YiT2z6tDuzLLchasFD2w2
         Mkh6LtyCFJWejhKMxgykZsEQj/x8fiEINVD1qJbJOxZgN2YH/UWuZMuMZW32iBeGtvQq
         /lW7BLRvhMJx91EGYj8g/3IgB34BAKrk4wE5Qh21ccOj72gocm1+GPBZgzZ2TTnx2Dna
         r2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GsCQyeSS9WqgWVTSCSRei8+jKy0pNjIeX7QnW7mozH8=;
        b=Cnkt48lQ/PnbkhyCiqhuQSyEFb0xinSkfxvDSUCHGMdSVpPSyMKl3mfgUa3GQ/9M37
         2HZUU7HQYj+Z6mCvtT8+DvMfaLMS5Cx/EoMK0b3eobKVmylJB0IHEDDI3dMyMJ40k/pm
         8D70cIG3va/NvH25yBjjCTDuOd4J5KZJVyiM44sU1h0YlFpfrhDM4MKsIeV5VJPhE5uJ
         Iyx9Vgm70vtU4HrJHSyijDq9c+Ch8BZYzNS6tbEguqL06irZ+jdoR0HEzhh3IY3T+S17
         CYzwHq9Jqw2nLWToXbTEnfvrU148YJz77Xw6TkW6lbmOMoq29N8fRTVxuZOQut021d1w
         ZRaA==
X-Gm-Message-State: AJIora/EzLDGJgS83p7VrYq4nI0rKUHDlsWSHQiCtavR/RwDkjewRcAq
        m6hoHejG2UvXydcf+Mh3p5Kv5g==
X-Google-Smtp-Source: AGRyM1uyuBI4yQO8I87mv5kU872kiOSXmbKPq5Tg/yiYqqbU8VShLy0QcRaY062PjM90XL8FvpDVSQ==
X-Received: by 2002:a05:600c:1c10:b0:39c:4708:648d with SMTP id j16-20020a05600c1c1000b0039c4708648dmr28938957wms.85.1655798758346;
        Tue, 21 Jun 2022 01:05:58 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id t5-20020a05600001c500b0020d106c0386sm7043231wrx.89.2022.06.21.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 01:05:57 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:05:54 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     John Keeping <john@metanate.com>
Cc:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 14/33] crypto: rockchip: handle reset also in PM
Message-ID: <YrF74tmA9qc+I3JF@Red>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
 <20220508185957.3629088-15-clabbe@baylibre.com>
 <YrBUODGF51oUsF1f@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrBUODGF51oUsF1f@donbot>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Jun 20, 2022 at 12:04:24PM +0100, John Keeping a écrit :
> On Sun, May 08, 2022 at 06:59:38PM +0000, Corentin Labbe wrote:
> > reset could be handled by PM functions.
> 
> Is there any further rationale for this?
> 
> After this change there is no longer a guaranteed reset pulse on probe
> since the reset control may already be de-asserted.  This is normally
> the most important case for a reset as it's the only time when the state
> of the hardware is unknown.
> 
> The original use of devm_add_action_or_reset() seems a bit weird already
> since there doesn't seem to be any need to assert reset when the driver
> is unloaded.
> 

I am not an hw engineer, so my knowledge on reset is low.
So why not having a reset pulse on probe is a problem ?

Do you mean I must put reset asserted on probe ?

