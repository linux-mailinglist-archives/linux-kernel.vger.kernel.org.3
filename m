Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF380592DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiHOLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbiHOLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:07:02 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F01A381;
        Mon, 15 Aug 2022 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660561599; x=1692097599;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lR4e/Yj+v+orzNhR6UdlTiIXidtC5q1zi9QQkSuY8HY=;
  b=brFxTKdozU4ZwKl1vkU4CM8f3SwsAK2meVcSc40IslPqn/RgUo95sOSD
   ZAH4P/x6qtE+bpqA5D1BgRU74B2E/EcgqY74IjcVC8pqBLHdcVZif4kvE
   ZJ0HjAL1uMRTgnnk+LtYEkWuYvGn9zOTWTlvit/F3hT0plHszP3PmWcEA
   2tmTHRZ71M2IUQqI+9obUQEgohI39LQ9O08VhObuyKqIbs1AOHpL1ziXx
   X1QWujnv7fdPWrLAPzK8urHzI/yfuYqxPDL/BF0F7+cWC4AMp8+M2Kcel
   VgOqytKSstXSQaxkfDhabdK1ffccJmpCu8tJfHsodsxOU8KDM5GYQC5uv
   w==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654552800"; 
   d="scan'208";a="25604415"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Aug 2022 13:06:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 15 Aug 2022 13:06:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 15 Aug 2022 13:06:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660561597; x=1692097597;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=lR4e/Yj+v+orzNhR6UdlTiIXidtC5q1zi9QQkSuY8HY=;
  b=MpSfJWTq+0O7BL6IclojsVsPcaVvdT8LKCxMtCZFiKalaZw73OABEqz7
   y3X2zOfCcdBOyrszIwAaw7k4JzmC2ezmyFPx2LAYd1EQKqcDRpl5n2APq
   r9bUMs7uv6ASXhc/NAmd17xRz+48qe82wSaKiRqdgPIZQrySWM5LB5QnF
   Ng3azSVcRKQoMaRxZLmIlO3LcWQVRSJhYxbL5JkRxeZCXGhUEM6+YRLNr
   2ykm8EkQM0/PB+0zkekfJTpwaf/2zjuSaH5Xhq7lQYs6iB2tbzHaoQL83
   UijQKC8oPjF/DvO3yKk8yILgYNtvhdFVYChSomUWy0cmPUPWSGhOTpR92
   w==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654552800"; 
   d="scan'208";a="25604414"
Subject: Re: [PATCH] spi: lpspi: Simplify some error message
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Aug 2022 13:06:37 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2501D280056;
        Mon, 15 Aug 2022 13:06:37 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Date:   Mon, 15 Aug 2022 13:06:34 +0200
Message-ID: <2796602.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <253543c462b765eca40ba54c66f4e3fdf4acdeb7.1659735546.git.christophe.jaillet@wanadoo.fr>
References: <253543c462b765eca40ba54c66f4e3fdf4acdeb7.1659735546.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. August 2022, 23:39:19 CEST schrieb Christophe JAILLET:
> dev_err_probe() already prints the error code in a human readable way, so
> there is no need to duplicate it as a numerical value at the end of the
> message.
> 
> Fixes: 12f62a857c83 ("spi: lpspi: Silence error message upon deferred
> probe") Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 19b1f3d881b0..cbbe8bbef90a 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -912,7 +912,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
> 
>  	ret = devm_spi_register_controller(&pdev->dev, controller);
>  	if (ret < 0) {
> -		dev_err_probe(&pdev->dev, ret, "spi_register_controller 
error: %i\n",
> ret); +		dev_err_probe(&pdev->dev, ret, "spi_register_controller 
error\n");
> goto free_dma;
>  	}

Acked-By: Alexander Stein <alexander.stein@ew.tq-group.com>


