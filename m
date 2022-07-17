Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E9577518
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiGQImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 04:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGQImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 04:42:09 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82C183AA;
        Sun, 17 Jul 2022 01:42:07 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 126981B00101;
        Sun, 17 Jul 2022 11:42:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1658047324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljpNRllBYzcmautrfzTavCMGgs6vk6O9O+uG2n9i8/M=;
        b=tBhMwHrPAR5xJYtlfw1Phj1uKwG96fw8sI6k+KHevOEihOvXNaKXJHsUgPTj7UBAFobY2R
        PhMsKwQovJsV35JSMjzi6g3KN94oMruxkDyttalrbzVx5jAs7YLT7sdJgFWxgXEvsYP1LU
        359zS+NBZmtarizIGM6ozpJ1aycODmOmuQXsBdSY2esxFQu6iWtJu/dP4dDbV3Q60CKjSb
        RMW7gEcEaXCmoaZGW1xDHWXF89mik85VejoHyhLF0MBmIEf08cTlekN+FWYa7kY0UouuRR
        OvhOpmUYybg5mYnqh5B3jdyRODkChSRIzGHDv1ZrwhMFYWbjcN3fTeUe05f/Kw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id AB051634D5F;
        Sun, 17 Jul 2022 11:42:03 +0300 (EEST)
Date:   Sun, 17 Jul 2022 11:42:03 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: atomisp_gmin_platform: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <YtPLW+utY/XuCnbl@valkosipuli.retiisi.eu>
References: <20220715160641.73526-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715160641.73526-1-andriy.shevchenko@linux.intel.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1658047324; a=rsa-sha256;
        cv=none;
        b=LQrKe+1OIBdSoYRLtLmtaGPw6dALDUXYan0o/OmwNHrpH+Q7FKzLDcjzxVRo3qjPA03L+f
        HmXRQYt2/UAfl/FxoEBuap+fJx//FTaW1Gngd/7O4iIbm6umDFB2BSZFGJH0oyTl2adYKx
        wAgu3XoQpxtesbt6WjiXdvoyv8l/f8I/pM2gNludkzlMxHnzgdYdgyWP61pwyhLDmSrgza
        hlrISc+G2kKeRVwMTva4ntuUaPkoCC5B5LISn5bvTWKmdAXRW6Mu/eONUP3RU72B8tN8Y3
        gWv5gM+06qzQIWMjo44TOM2OyleIRijVhmEIQNwyMqHSWOg59TbLPD/hUfy5gg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1658047324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljpNRllBYzcmautrfzTavCMGgs6vk6O9O+uG2n9i8/M=;
        b=IA3BDP1+vwx8bP7hFa6ZzNPhkuD1bgimg8IGdRrBAsxk17akX3XbZHhPOUv81CpTosav2s
        3Xe3BZVGywB6lOkpfpcZ5mVLtbZKTQ4mzDGQxVrv5kVQMlChOU9EOE1A2RY/xuWMZgOkm1
        1kk/Q4ESM/lOUshMr9Vzh9zBiMzybVpW6msqyHV0/qX6db71ruztbs4t1NQiiqA10KfdFZ
        Yr5oP737kGZwhg0tprX0+x4osxvTROPeChoHRIF88PCyTBeVRl5nTxkaA0wNPA1yeweEcW
        Xm8Tdt8unsN7oF5VMSaUMeBBmWV3N6Pqi5vpgbG/naexmM1RSebY8+wwryMy2g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jul 15, 2022 at 07:06:41PM +0300, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> index bf527b366ab3..d4cfda07f7fb 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> @@ -1207,16 +1207,13 @@ static int gmin_get_config_dsm_var(struct device *dev,
>  	if (!strcmp(var, "CamClk"))
>  		return -EINVAL;
>  
> -	obj = acpi_evaluate_dsm(handle, &atomisp_dsm_guid, 0, 0, NULL);
> +	/* Return on unexpected object type */
> +	obj = acpi_evaluate_dsm_typed(handle, &atomisp_dsm_guid, 0, 0, NULL, ACPI_TYPE_PACKAGE);

Can you please run:

	$ ./scripts/checkpatch.pl --strict --max-line-length=80

I.e. the preferred line length is 80 or less, unless there are other
reasons to keep it longer.

>  	if (!obj) {
>  		dev_info_once(dev, "Didn't find ACPI _DSM table.\n");
>  		return -EINVAL;
>  	}
>  
> -	/* Return on unexpected object type */
> -	if (obj->type != ACPI_TYPE_PACKAGE)
> -		return -EINVAL;
> -
>  #if 0 /* Just for debugging purposes */
>  	for (i = 0; i < obj->package.count; i++) {
>  		union acpi_object *cur = &obj->package.elements[i];

-- 
Kind regards,

Sakari Ailus
