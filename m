Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4553FE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbiFGMSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiFGMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B5ADF7483
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654604153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMK24xIGG6wu595QaPQlChtbwsTC3JSyEhFxYI/TvBY=;
        b=FjUq0gs+Ne4/F5RXNkuLGNYNE6i12mTLsGAi87Scneatkv3b+jCoueak5RcsCcD9GWntWJ
        4fWeAcZ3ClsPhLgSwzTEKmh3XBzzs9nOJ6frKpHjrUf9agnxC3lHxKYF1HHeOhe5kwvPNS
        bQefxyAbpAdI4a7HgWjzzy7ClINr3pA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-nspVzmDHM2ygZNySYXwj8g-1; Tue, 07 Jun 2022 08:15:52 -0400
X-MC-Unique: nspVzmDHM2ygZNySYXwj8g-1
Received: by mail-qv1-f72.google.com with SMTP id da12-20020a05621408cc00b0046448be0e98so10727993qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMK24xIGG6wu595QaPQlChtbwsTC3JSyEhFxYI/TvBY=;
        b=2O35HXG3csr99CVK8lS42oTn2PxwJ41vIW6yC+1Z+pyLZ77Y5ak4cTB61OyhvRzn9r
         8SnCQ1xar2fVHS68rE161+PfpCIrAhwp7wcXYPxbg5ijVijoYzlIGcwLFOz6a8NR02xs
         HZORmC+0WOhI4Wure78sxOCTroUgjD2t/3Nsh9NC5bKonwsnIuITOqZcQm9wdaS8Pxl1
         W4mMbq0Spl9DtqInMS+XgXFmFDE9svhkmecTwOv7IzgrM1xPIgcis0HQ/9hzwkWOyt9c
         EbH3Ne+OMyifR2uBXDaXJTgtuSEyNMyyfIvrMnO/6yrmed3WvC6VUCej3QXK4qK70nHu
         AtjQ==
X-Gm-Message-State: AOAM532XIWpWtKZj4bxyLZmUENvQ77audWYNf+AuNS9+RuK/PXAmy1Hj
        Dsbf/6JeOp5Fsr9PQkPU7wK922H67rI1B90Lu30X153/I2i4amSSpsyagsC0M13oIpi5oczODy9
        AutJh25pjTfr2D43a8yEHypxB
X-Received: by 2002:ae9:df87:0:b0:6a6:acfe:f1ed with SMTP id t129-20020ae9df87000000b006a6acfef1edmr10438248qkf.579.1654604152054;
        Tue, 07 Jun 2022 05:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0A1/Z3+7HGeA0k9MPhFMYSifjOBR8tuyrQVy1bAdH0gssRyCDYA3k9yt79LLbL7gI80w4HQ==
X-Received: by 2002:ae9:df87:0:b0:6a6:acfe:f1ed with SMTP id t129-20020ae9df87000000b006a6acfef1edmr10438233qkf.579.1654604151818;
        Tue, 07 Jun 2022 05:15:51 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id bl33-20020a05620a1aa100b006a6f1c30701sm353511qkb.115.2022.06.07.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:15:50 -0700 (PDT)
Date:   Tue, 7 Jun 2022 07:15:48 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: Bump parent usage count when GDSC is
 found enabled
Message-ID: <20220607121548.fhzpjcmoahlkue4t@halaneylaptop>
References: <20220606212112.3617731-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606212112.3617731-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 02:21:12PM -0700, Bjorn Andersson wrote:
> When a GDSC is found to be enabled at boot the pm_runtime state will
> be unbalanced as the GDSC is later turned off. Fix this by increasing
> the usage counter on the power-domain, in line with how we handled the
> regulator state.
> 
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 44520efc6c72..a1fa7c4cff60 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -420,6 +420,9 @@ static int gdsc_init(struct gdsc *sc)
>  				return ret;
>  		}
>  
> +		/* ...and the power-domain */
> +		gdsc_pm_runtime_get(sc);
> +
>  		/*
>  		 * Votable GDSCs can be ON due to Vote from other masters.
>  		 * If a Votable GDSC is ON, make sure we have a Vote.
> -- 
> 2.35.1
> 

Makes sense to me!

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

