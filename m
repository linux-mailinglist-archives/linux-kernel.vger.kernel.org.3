Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8657C2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGUDqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiGUDqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:46:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8811CE089;
        Wed, 20 Jul 2022 20:46:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w7so612166ply.12;
        Wed, 20 Jul 2022 20:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PK3ox6a2SQfZxjp5w6QUUVlDtnG7KstXWQ/yrz9Y12o=;
        b=I+jJtG4t6ilX1lif5EfjWFMSucSEGogByMVLR8H5t20FNKitQz7Dwbtkd+0cj1UDia
         Yr8hShCE70DpnKh/sAwt+mX1U7Xau/zu6KEHcxxwiTCrv8amVnrVd6/yVWciNLo8ebap
         dlclF8BU5/lLJ81qcn0q5R6gdzaPUrmDDphIUdIMw7PXQKZoycnTNuybDHxaxgWAWHs4
         moobKX0sNxnsM39O9b57u8eKFnBPmQB02MQ2nf8RWfVX6eSXSSKVM5LTBIgcEiAP3/Jd
         WYEuGRz6dHLjvqdOcV8vDqB+tOo8sCnpbKBPoj4XJR/bPUNv+FLGKZqoOywGVpUAHhLS
         20uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PK3ox6a2SQfZxjp5w6QUUVlDtnG7KstXWQ/yrz9Y12o=;
        b=qaZeu07/U0vUvHwUxtVI0nXxQzWYx03+DtmSIuggsovOV6/sXvBnFmwtZiwIx0vRUI
         8u2Sh2F4xrEhXMxUtHdKC7aBDfVfsj1mytJJSPc7mMb5Vj1UdLGSz/MsEgjYtcc8hzlQ
         zir6IpF2jfL8uErxEtDtZZIEXfWMZTOEjmlFp8ZDvcvxgKO42USOYQd8GJzaRdub332b
         0fOyjNKzH0bjHNKK779MMlzqZ9FWkTIprPTUN8jEJI6xpwu2+Eb6vW96aeEaSYXybR07
         4SslWNG6zHOvVUh2YMQ5hFPJfpIOR7bKxYp6gd2ULi+RVT+SnfWdmvQbt9GhOw6S++pH
         SobA==
X-Gm-Message-State: AJIora99sDPxXIGFoZq/Lzl/N0yrRTj4/UO+A7e+BsJv39o6SbElP63M
        +OlBE7tm2qFSLFU3N+1VQRfebFSrkF0KAA==
X-Google-Smtp-Source: AGRyM1uids/sNn17x2CBlHiW5m1SWpRc+251pmsiTzxzmMi9z+jLht3qaVJh9L/1rFAQrGvKO4U3dA==
X-Received: by 2002:a17:902:a3cc:b0:16d:1af4:6359 with SMTP id q12-20020a170902a3cc00b0016d1af46359mr8691696plb.56.1658375163053;
        Wed, 20 Jul 2022 20:46:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b0016be5f24aaesm352874plh.163.2022.07.20.20.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:46:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 20 Jul 2022 20:46:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH] hwmon (occ): Fix response length in checksum retry
Message-ID: <20220721034601.GA1643258@roeck-us.net>
References: <20220720193036.8743-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720193036.8743-1-eajames@linux.ibm.com>
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

On Wed, Jul 20, 2022 at 02:30:36PM -0500, Eddie James wrote:
> Retrying for checksum failure doesn't work since the response length
> gets zeroed out in the submit function. Fix this by resetting the
> response length to its original value before the retry.
> 
> Fixes: c27b98ca0edb ("hwmon (occ): Retry for checksum failure")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this patch will be applied with the patch introducing the problem.
If not, I'll apply it after the next commit window closes.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/p9_sbe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 4a1fe4ee8e2c..f3791a589b01 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -82,6 +82,7 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
>  static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
>  			       void *resp, size_t resp_len)
>  {
> +	size_t original_resp_len = resp_len;
>  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>  	int rc, i;
>  
> @@ -97,6 +98,7 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len,
>  		}
>  		if (rc != -EBADE)
>  			return rc;
> +		resp_len = original_resp_len;
>  	}
>  
>  	switch (((struct occ_response *)resp)->return_status) {
