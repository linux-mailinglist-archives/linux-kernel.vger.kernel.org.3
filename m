Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B94CB0B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiCBVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiCBVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:11:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9755B6D01
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:10:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y5so2002286wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dQsFhF1/hV1naVDlbcCm3YVz6Er9ziLGvWW482VtK3Q=;
        b=K/eASSZiHGsNk3WKGGcy7BgI65UgOtLPWPoWEFkbEMo59l5HNvPWcYR35FHdrlShr4
         5xFuug7BnHoGw67glt0a72xAbnihBvVm6v+CuFacgR2DF6phuBwCBp8u2pN830W67Jhw
         3Wpt24zx6BQWyRtJWnXmuKtir+/oesk7s9JaRJkv0KH4bkO8kf2AexzLLYUKRHrZUlNE
         6l6MffU3UWBbLsCVN3VLYsUSHIJoUe/FAJ4k9riNqikL1KcZw4EXoSHKM54vc/0sZQ7B
         Phh2Aks98ecZihS5NKjdgM+5BtRC0PggapwU7Y91IhVOOp0euvhRplyo8KdN5EFph8+d
         kHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dQsFhF1/hV1naVDlbcCm3YVz6Er9ziLGvWW482VtK3Q=;
        b=RsyMvx/IRYTIit4oOdt2LlDl39IQGc5M2ur33LkIjQD93gsBUBJOpWfq9DCHZKVHhZ
         KznR1sHoWLUJ5TvWGRMeds+oTMrL1TNsnirWWNjhX11TIrbVowUBnYHnHTGYhZ94xFcC
         FIHWDZ3W5McKo0aOVVpthVMtQ6FPcd0T2Zxo9pdPFiv/qtvOv6zlNiEKNhjgb7dSeCIg
         hm9UwFqYnV1i5fmaymTey5iMT9d1yrjaloP7+Kx5L6RtrGtuV92hsfcXqi5M5/k0SAjE
         RNAZEWKR+tpo3g6jYeckYNhIo/mhtD33ydRv3g5GsPmXsdUEwgCfekULrRxsHqP1zEQ1
         iT1A==
X-Gm-Message-State: AOAM530qqdQxfSJNy3X/XvT0AL/wry9CcAWBxSRnTlPJcvPP5ZtHpjIO
        M/1ddNTu5MHgBoIP+bogyc/H2A==
X-Google-Smtp-Source: ABdhPJz3l7hSdXw5FPBP4h5QrTtNeUrO/cpc7nHx9qcYgH+e/DxuEe7f9waYf+ZJ40PnOn5vzrIFQA==
X-Received: by 2002:a05:600c:5118:b0:381:71f6:bb93 with SMTP id o24-20020a05600c511800b0038171f6bb93mr1342536wms.169.1646255437350;
        Wed, 02 Mar 2022 13:10:37 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id b13-20020a05600c4e0d00b003816cb4892csm12624945wmq.0.2022.03.02.13.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:10:36 -0800 (PST)
Date:   Wed, 2 Mar 2022 22:10:35 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     John Keeping <john@metanate.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 00/16] crypto: rockchip: permit to pass self-tests
Message-ID: <Yh/dS1LBmUlM2zPD@Red>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
 <Yh4Y99KCi+1lbrve@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh4Y99KCi+1lbrve@donbot>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Mar 01, 2022 at 01:00:39PM +0000, John Keeping a écrit :
> On Mon, Feb 28, 2022 at 07:40:21PM +0000, Corentin Labbe wrote:
> > The rockchip crypto driver is broken and do not pass self-tests.
> > This serie's goal is to permit to become usable and pass self-tests.
> > 
> > This whole serie is tested on a rk3328-rock64 with selftests (with
> > CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)
> 
> I previously noticed this breakage on rk3288 but never got time to
> investigate (disabling the driver was quicker).
> 
> This series fixes everything on rk3288 as well, thanks!
> 
> I hit the same warnings as the kernel test robot as well as a missing
> new kconfig dependency (see separate reply to patch 10), but this is
> 
> Tested-by: John Keeping <john@metanate.com>
> 

Thanks for the test, but since I have added some code in v2, could you re-test it ?

Regards
