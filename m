Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2A50D3DE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiDXRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiDXRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:21:21 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA86FF77;
        Sun, 24 Apr 2022 10:18:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z2so14756417oic.6;
        Sun, 24 Apr 2022 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gs5UTs020l+gW01sKQqLDKCl0tqBUVQZB/K/2Vj/X5s=;
        b=EcQN96BbT0hS27iiyZji+xL4168i1B2ZY2PpCuEMQkDB0gQxDREY48J/Csx5qOPI0q
         +LMRwMmYuW+4Ofa4NslwdbGoTzL7TAo2G7BMwoEv35MMkyw9Rm6QuOcpVbbicxvidV4e
         YziSWciHMsluN74SsmgeCb7gGKsNIwxejIG4UrZZbAHKkSF8WE1Y3plRhEImivL/f62F
         i6qmSM1wLX5GaaLZbJ4p4I2xToRC1gftU41CWFDxuv2YYry6NE1mvfNjo2SEokfkA6Sd
         TYhSqAwHiJ2Nmf+u7BXc5odEfdPS703igsrtAP7k49P0sVXMNQ0vcIS6PKaMJy36SwCm
         VQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Gs5UTs020l+gW01sKQqLDKCl0tqBUVQZB/K/2Vj/X5s=;
        b=iwUz/BuS7FXasV/1CjQ42rvesAdMOTnRXVlM/e8G2nVqqNqi9oQaLiHUDFMxGXz5bw
         e9OE2rZhsLuOU2N6eV84PkS8P6FuYEKNbLpiMIg7FDGHnmAyVqftwCkjjFcenoh8Ux3r
         5zVKZ4tfyUUSvxwdf9uK1+FkqU6bZ6IBcjVd04fowvBmCQ7FQp+8nD2XJpI0v5m/ou+n
         clXNMcXkEKwKOuGwUR+1EqvxYpe5felsPA01YIiHxbuSlknbwYlrIMxB2bpmW4OdBNjc
         KvRVk9KoOBD05qggL14qbEqYCihvssCi9vefT8yn9zCn5WHnbt3mRzeasEJJUIfZku+0
         GH3Q==
X-Gm-Message-State: AOAM531GOO1bzhi79wNEvoWLcRvrMESjodOuFv/LXBd+iWMwv30fNnBr
        uIY5zis4QRx8Lh+xFyUCgqNp7pFqxDI=
X-Google-Smtp-Source: ABdhPJxPYm6vNc7dijlvCZSMaFALq1sItV+Emb8KLA31LsAUUVnHhzlAb6urX4aS2wHnQfDIuM8ASw==
X-Received: by 2002:aca:df03:0:b0:2ef:895e:7373 with SMTP id w3-20020acadf03000000b002ef895e7373mr6531638oig.177.1650820697900;
        Sun, 24 Apr 2022 10:18:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d7312000000b006054dfa7eb6sm2907397otk.78.2022.04.24.10.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 10:18:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 10:18:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com, joel@jms.id.au,
        jk@ozlabs.org, alistair@popple.id.au
Subject: Re: [PATCH 2/2] hwmon (occ): Retry for checksum failure
Message-ID: <20220424171816.GA749761@roeck-us.net>
References: <20220321153112.12199-1-eajames@linux.ibm.com>
 <20220321153112.12199-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321153112.12199-3-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:31:12AM -0500, Eddie James wrote:
> Due to the OCC communication design with a shared SRAM area,
> checkum errors are expected due to corrupted buffer from OCC
> communications with other system components. Therefore, retry
> the command twice in the event of a checksum failure.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I assume this will be applied together with patch 1 of the series.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/hwmon/occ/p9_sbe.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 49b13cc01073..7f4c3f979c54 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -84,17 +84,25 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>  	size_t resp_len = sizeof(*resp);
>  	int rc;
> -
> -	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> -	if (rc < 0) {
> -		if (resp_len) {
> -			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
> -				sysfs_notify(&occ->bus_dev->kobj, NULL,
> -					     bin_attr_ffdc.attr.name);
> +	int tries = 0;
> +
> +	do {
> +		rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> +		if (rc < 0) {
> +			if (resp_len) {
> +				if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
> +					sysfs_notify(&occ->bus_dev->kobj, NULL,
> +						     bin_attr_ffdc.attr.name);
> +
> +				return rc;
> +			} else if (rc != -EBADE) {
> +				return rc;
> +			}
> +			/* retry twice for checksum failures */
> +		} else {
> +			break;
>  		}
> -
> -		return rc;
> -	}
> +	} while (++tries < 3);
>  
>  	switch (resp->return_status) {
>  	case OCC_RESP_CMD_IN_PRG:
