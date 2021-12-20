Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2C47B0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhLTQGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhLTQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:06:14 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266EC061574;
        Mon, 20 Dec 2021 08:06:14 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so13131544otj.7;
        Mon, 20 Dec 2021 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6xBKtmPlOjlH54Ve1Oha+c9eS3o5xXcGGVpSHaqBnVU=;
        b=KPHVZPLD0vNzzeDBThLmBXeYYahwrnF/qqQPTJl/pXd7B7ICn/91fMs/bJ6EM93/zk
         GHlNOvwpgbAojU6Zsk+I1kejeFea9WAXokLeXiaQVpv+IJ4rccXajwT9qa2oRUKY5T9S
         wX32yAA7QeXltWuQnWmmtzkO5DlQybEgxO+f0MXzg24bl9y16TzUI/1srwHu1QqLWBYB
         9V5VN2CDVxHDV3xu6gpTVctf/Kg38bdzs2L1Akrm8eEIF4dny6gzxqP4z2JMnCU0yCoO
         mZnufoKko9KTdc1qsMtRGhUne4CGhH6l+m0BDLDnNMnv9eNezNi7Z1h5fZ8qZJcFUMdC
         FgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6xBKtmPlOjlH54Ve1Oha+c9eS3o5xXcGGVpSHaqBnVU=;
        b=TBgr33R7VQrSfjj6a5c7zKHFeN6KatrWbPDk5lsdh77XGjzgRh/sU/0dB0fQC6M4sf
         q8mkUOmTna7S3V2flEJr0ibPuLhoUoWtSTSJ1Y0Ty8eIMnkNuy80WyIiZt9QAvgrs3Wg
         MkNs+P5yuU67MBstbmyhc11DRSsfC7jJASijQTuPMxi7RuzMrHQfRzO+xpLnmPpARksw
         9ArQTTbLQM3yuEtaupPk7gU9Ecg+KadSUsIMOpAQP9hab6ZVjcWVg1IqkIfrUoG25QHa
         ijbTlwYPxSCCRZnBd+Oodx2lgwlqqM0aGfEYZgDKlpcAijkS9i4lcvdOEyNF5ld3SU4T
         dpCg==
X-Gm-Message-State: AOAM531JF1Bc7zrR4Te8pCZtpU/L92eZqk3F+Z1XBfs0fPPYVgZj8Yei
        bWOKHPhI7IhjR7gwzX5hsw0CmRuVmBo=
X-Google-Smtp-Source: ABdhPJwTv979/Z1uY9ULHOO+6HlCKVISOPw3Wrirhggag9JKwWBiQDSh1ar902XkBQmovF5mMW6Y6w==
X-Received: by 2002:a9d:774a:: with SMTP id t10mr12331695otl.2.1640016372964;
        Mon, 20 Dec 2021 08:06:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v12sm3241800ote.9.2021.12.20.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 08:06:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Dec 2021 08:06:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        cniedermaier@dh-electronics.com
Subject: Re: [PATCH v5 4/5] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Message-ID: <20211220160609.GA1379130@roeck-us.net>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-4-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206064732.280375-4-andrej.picej@norik.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:47:31AM +0100, Andrej Picej wrote:
> Document the watchdog timeout mode property. If this property is used
> the user can select what happens on watchdog timeout. Set this property
> to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
> will go to POWERDOWN on watchdog timeout.
> 
> If this property is not set, don't touch the WATCHDOG_SD bit and leave
> the configuration to OTP. This way backward compatibility is not broken.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v5:
>  - no changes
> 
> Changes in v4:
>  - no changes
> 
> Changes in v3:
>  - add note about using the default OTP setting if this DT binding is
>    not specified
> 
> Changes in v2:
>  - new patch, document new DT binding
> ---
>  Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> index 950e4fba8dbc..354314d854ef 100644
> --- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
> @@ -10,6 +10,12 @@ Optional properties:
>  - dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
>  	Only use this option if you can't use the watchdog automatic suspend
>  	function during a suspend (see register CONTROL_B).
> +- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
> +	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
> +	POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
> +	default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
> +	set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
> +	chip's OTP settings.
>  
>  Example: DA9062
>  
