Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B553CDF8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiFCRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiFCRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999952536;
        Fri,  3 Jun 2022 10:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5336861A7F;
        Fri,  3 Jun 2022 17:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C5CC385B8;
        Fri,  3 Jun 2022 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654276783;
        bh=yZaP5JwNf7HCqFEG529ib9QFmep3oDKSCc6iCmQJhj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fguOluzXlQQFZcg2tjsK3W1T8Txt+PLLyICgZn5MfU+mqerRyRvS/d7L9bEGOpJKl
         upWNZGJxXZTtz4MPl2uSgmPFDP/UGYb3iVXF3w8UWdfLb3rIcQV/1Tmt1CNd2CyzRB
         lqXShkJlMs/58+2Rg0O49hwaJb/mE/FuhquuIKh1Kz9cytrMhU98eOrzNCivnssEZ7
         CXVpyYC+JTlRjYH29wRiUqkVOnFsk/m4lUZxhG/iW1fEne4UQI6m5JD6SyDxEhbFx7
         /9kmjzJGzLX+HVZ5p8sfJ5gIn/89xVXYvlyCMAWVPE/HAf/AuMzCtmaAsD024TyD43
         eyc8Upe2M0cXA==
Date:   Fri, 3 Jun 2022 18:28:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 1/1] iio: dac: ad5592r: Get rid of OF specifics
Message-ID: <20220603182844.23da48f2@jic23-huawei>
In-Reply-To: <20220531135320.63096-1-andriy.shevchenko@linux.intel.com>
References: <20220531135320.63096-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 16:53:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use dev_fwnode() instead of direct OF node dereference when checking
> for regulator API error code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied
> ---
>  drivers/iio/dac/ad5592r-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 4434c1b2a322..7a9b5fc1e579 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -603,7 +603,7 @@ int ad5592r_probe(struct device *dev, const char *name,
>  
>  	st->reg = devm_regulator_get_optional(dev, "vref");
>  	if (IS_ERR(st->reg)) {
> -		if ((PTR_ERR(st->reg) != -ENODEV) && dev->of_node)
> +		if ((PTR_ERR(st->reg) != -ENODEV) && dev_fwnode(dev))
>  			return PTR_ERR(st->reg);
>  
>  		st->reg = NULL;

