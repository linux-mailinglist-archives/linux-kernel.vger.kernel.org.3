Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23D4E52C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiCWNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiCWNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:09:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DAA7CDD4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:07:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a1so2031247wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/7GPfWTScrdUPxYCfpF4p4gmdocaWvB3DedYIkySiRQ=;
        b=7EDiYHM0/mHUHNh2nAcUtV8Mo87BBMJDjh2R3QaAEXuxurVdInHyGhkLnwH6gL3bPY
         ftLMYfyygow8mzkD5Dev2Iq+3cB/DbsVL3VVzYv3NYkRy77gO07thxxfnDuE/5vvFwiB
         SnNZc9jBzd7JxXBaPe5MmyMhQ/dZvf5IJrjHbztF2VDxy+YSXfGCFsGy91bzu0dpwUVD
         vLLzZ2UR7OCpthmgXf0+rBDgwrScxpIXhhh0aF66G9+NvYfooCnN6Ac965njTsu7vX7H
         5rK015KemhcLQmxFbNnPmlRfVnVllLsShyU6SyQvhK65gIf9XVzlSMG1ZoK1rbNLFDgk
         2K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/7GPfWTScrdUPxYCfpF4p4gmdocaWvB3DedYIkySiRQ=;
        b=TOaZakTZsY9JhwjyaBodiMiTeDo4o3HnQsPhJmjyENqkg8X0xpHVWtmADXTGl4+rEs
         xlTN4AGoiu5buy0EorNqh5fa2C3J1ZRN1JXh0UTBHLi5QbP+bw/sxMtelm4dHGHrYgnw
         jpugWRPeCI4sX9WhXUwTuJEOgqkSPWPNSHWVixyiTyPRBMwkWit4ZtS7Dzr1n811zjd/
         sPp6NtZ1dh6/buZjLP3oykiy0mw9SrdofWEItp4wi9P9R+Sd/Ifl8fvHddbxIEIHZilD
         /+iei5JJWT5e7+rSZxZhdCAqFG02KvXier4D7Z6ErM5GY6/TxMArf1tW6YHnFqzQVJPH
         q2Xw==
X-Gm-Message-State: AOAM530IwHcmnm9hyVqraMAw8Ou+MmpDA30HxNaNSW66Uo9SEQqaYw8H
        vARDT4W2clEinDraNNsHWxxsOg==
X-Google-Smtp-Source: ABdhPJwlHTs/jXded6YR+bEyG9ABUfL/AlSP0pBeJMmhWDxUYvyYfFnDLfkgPcSrNXyLqFblB0f+cw==
X-Received: by 2002:a5d:5509:0:b0:204:f77:c2d with SMTP id b9-20020a5d5509000000b002040f770c2dmr13533390wrv.432.1648040848448;
        Wed, 23 Mar 2022 06:07:28 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n20-20020a05600c4f9400b0038cbd13e06esm2794951wmq.2.2022.03.23.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:07:27 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:07:25 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 06/26] crypto: rockchip: add fallback for cipher
Message-ID: <YjsbjaQrj2Y+cLmL@Red>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
 <20220321200739.3572792-7-clabbe@baylibre.com>
 <c643c8a0-3ebc-519b-bc6e-f95362d43a69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c643c8a0-3ebc-519b-bc6e-f95362d43a69@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 22, 2022 at 11:25:25AM +0000, Robin Murphy a écrit :
> On 2022-03-21 20:07, Corentin Labbe wrote:
> > The hardware does not handle 0 size length request, let's add a
> > fallback.
> > Furthermore fallback will be used for all unaligned case the hardware
> > cannot handle.
> > 
> > Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   drivers/crypto/Kconfig                        |   4 +
> >   drivers/crypto/rockchip/rk3288_crypto.h       |   2 +
> >   .../crypto/rockchip/rk3288_crypto_skcipher.c  | 105 +++++++++++++++---
> >   3 files changed, 98 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index 7b2d138bc83e..84ab14afcbd9 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -784,6 +784,10 @@ config CRYPTO_DEV_IMGTEC_HASH
> >   config CRYPTO_DEV_ROCKCHIP
> >   	tristate "Rockchip's Cryptographic Engine driver"
> >   	depends on OF && ARCH_ROCKCHIP
> > +	depends on PM
> 
> This appears to belong to patch #13 rather than this one.
> 

Hello

Yes this is an error, I will move it this line on the right patch.

> My initial thought was that it probably shouldn't be something for 
> random consumers to care about at all, but there do seem to be a handful 
> of other drivers relying on pm_runtime_resume to enable their clocks, so 
> I guess maybe it's an acceptable idiom :/
> 

Depending on PM made the driver easier to understand (no more if PM/if not PM).
And anyway, since it's embedded device, PM should be always enabled.

Thanks
