Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A859EEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiHWWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHWWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98928E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661292874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+NJ2Hn4EHPsGxqkc+OnT9mUgvIO8QK+rsUOgt/9jEE=;
        b=hEBBAAqq+gR5d+MmmWSPPCw+gL805Jm0z3TAwa7Sw/gxeJeO5CXuqK6cC7EDjsfdPrKuLS
        aBb+Ka7S7ONujPVSthTh/EaIq+3X/4IiumjQrYEmQ/UCXTYYRu//6hlrgtUSDu12r9oKlb
        QIg2BxCVbxL4JJ/ItID79bLpJAO8T7I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-aUD40wVjPOq58l8UlGYYMA-1; Tue, 23 Aug 2022 18:14:33 -0400
X-MC-Unique: aUD40wVjPOq58l8UlGYYMA-1
Received: by mail-qk1-f198.google.com with SMTP id x22-20020a05620a259600b006b552a69231so13175816qko.18
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=h+NJ2Hn4EHPsGxqkc+OnT9mUgvIO8QK+rsUOgt/9jEE=;
        b=TWILt9pdn6fLlKJqwmTqBlMybTQmQj/RDLgBBTX/+o6ufeGYmlQ04qBfBvZHkr1zSJ
         rOd/1gdC9kiA6DawyPaWtAMPNjCcVVK9lAarR72cnCr6gxgwA/J41gSC1dPmyXc0uWNp
         z5SdMJHN+b/P8FaidB2PQ57GdFOD2Z9ti/XtUhbGsuT5++uYlPQ9RPUdP6nPUiD+HB4S
         kLhK/plV9XFNkllEtbAIgT9hVlDsHqemtguyu/nbZL8QCk7atpe132H5u34WwLdTyF+0
         1/nKif8dntmDmt0hJjIvjI9uBLBNLvxWziWzqWgAPsKox+WJgmxbFZFOlKSVgHlfPCME
         6gMw==
X-Gm-Message-State: ACgBeo0t8nrt9D0+ywJKkBUmM//QnN0tTwPW47Rp+z9VxXEpEM7upxJM
        CwAnDwSyHDtYzClX45iUV6VWOf4stp00Q0RU13nB1d94w1hRTHEfoSrSo0HTQmqyH8dRz9b2VD2
        +NxwhRQQUce2BFW2XnZYGmNpH
X-Received: by 2002:ac8:7f47:0:b0:344:8d2b:14a9 with SMTP id g7-20020ac87f47000000b003448d2b14a9mr21144049qtk.442.1661292872761;
        Tue, 23 Aug 2022 15:14:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56jFp9MpBtG1bWXU6R4t6s5fxB48EvCpgH8hvO/jjd/TpimaBjiRSA8jWj1nwzZanaXMlGKQ==
X-Received: by 2002:ac8:7f47:0:b0:344:8d2b:14a9 with SMTP id g7-20020ac87f47000000b003448d2b14a9mr21144040qtk.442.1661292872507;
        Tue, 23 Aug 2022 15:14:32 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id t39-20020a05622a182700b00342f7beccd0sm12229744qtc.45.2022.08.23.15.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:14:31 -0700 (PDT)
Date:   Tue, 23 Aug 2022 17:14:29 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] regulator: core: Require regulator drivers to check
 uV for get_optimum_mode()
Message-ID: <20220823221429.3bte2tgtyniur4wb@halaneylaptop>
References: <20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Doug,

On Tue, Aug 23, 2022 at 01:16:34PM -0700, Douglas Anderson wrote:
> The get_optimum_mode() for regulator drivers is passed the input
> voltage and output voltage as well as the current. This is because, in
> theory, the optimum mode can depend on all three things.
> 
> It turns out that for all regulator drivers in mainline only the
> current is looked at when implementing get_optimum_mode(). None of the
> drivers take the input or output voltage into account. Despite the
> fact that none of the drivers take the input or output voltage into
> account, though, the regulator framework will error out before calling
> into get_optimum_mode() if it doesn't know the input or output
> voltage.
> 
> The above behavior turned out to be a probelm for some boards when we
> landed commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()"). Before that change we'd have no
> problems running drms_uA_update() for RPMH regulators even if a
> regulator's input or output voltage was unknown. After that change
> drms_uA_update() started to fail. This is because typically boards
> using RPMH regulators don't model the input supplies of RPMH
> regulators. Input supplies for RPMH regulators nearly always come from
> the output of other RPMH regulators (or always-on regulators) and RPMH
> firmware is initialized with this knowledge and handles enabling (and
> adjusting the voltage of) input supplies. While we could model the
> parent/child relationship of the regulators in Linux, many boards
> don't bother since it adds extra overhead.
> 
> Let's change the regulator core to make things work again. Now if we
> fail to get the input or output voltage we'll still call into
> get_optimum_mode() and we'll just pass error codes in for input_uV
> and/or output_uV parameters.
> 
> Since no existing regulator drivers even look at input_uV and
> output_uV we don't need to add this error handling anywhere right
> now. We'll add some comments in the core so that it's obvious that (if
> regulator drivers care) it's up to them to add the checks.
> 
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/regulator/core.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 5b5da14976c2..0bc4b9b0a885 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -979,10 +979,13 @@ static int drms_uA_update(struct regulator_dev *rdev)
>  	} else {
>  		/* get output voltage */
>  		output_uV = regulator_get_voltage_rdev(rdev);
> -		if (output_uV <= 0) {
> -			rdev_err(rdev, "invalid output voltage found\n");
> -			return -EINVAL;
> -		}
> +
> +		/*
> +		 * Don't return an error; if regulator driver cares about
> +		 * output_uV then it's up to the driver to validate.
> +		 */
> +		if (output_uV <= 0)
> +			rdev_dbg(rdev, "invalid output voltage found\n");
>  
>  		/* get input voltage */
>  		input_uV = 0;
> @@ -990,10 +993,13 @@ static int drms_uA_update(struct regulator_dev *rdev)
>  			input_uV = regulator_get_voltage(rdev->supply);
>  		if (input_uV <= 0)
>  			input_uV = rdev->constraints->input_uV;
> -		if (input_uV <= 0) {
> -			rdev_err(rdev, "invalid input voltage found\n");
> -			return -EINVAL;
> -		}
> +
> +		/*
> +		 * Don't return an error; if regulator driver cares about
> +		 * input_uV then it's up to the driver to validate.
> +		 */
> +		if (input_uV <= 0)
> +			rdev_dbg(rdev, "invalid input voltage found\n");
>  
>  		/* now get the optimum mode for our new total regulator load */
>  		mode = rdev->desc->ops->get_optimum_mode(rdev, input_uV,
> -- 
> 2.37.2.609.g9ff673ca1a-goog
> 

I think this makes sense, but unfortunately it doesn't entirely fix my
issue introduced by efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()"),
I'm seeing this now:

    [    1.240757] vreg_l17c: mode operation not allowed
    [    1.245586] vreg_l17c: failed to get optimum mode @ 800000 uA 0 -> 2504000 uV: -EPERM
    [    1.253631] ufshcd-qcom 1d84000.ufs: ufshcd_enable_vreg: vcc enable failed, err=-1

which if I understand correctly is because my devicetree isn't setting
regulator-allowed-modes. It appears most of the qcom one's don't set
that (and a good number set regulator-allow-set-load, which I think is
necessary for the RPMH regulator to get this far), so I think others
will be in the same boat as me.

Just for clarity, I'm running with this dtb right now:

    https://lore.kernel.org/all/20220812165453.11608-4-quic_ppareek@quicinc.com/

Thanks,
Andrew

