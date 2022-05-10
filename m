Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7660520A20
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiEJAcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiEJAb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:31:57 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3A33A15;
        Mon,  9 May 2022 17:28:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id m25so16975892oih.2;
        Mon, 09 May 2022 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NSUcuQgRbbYsO5310TC1TyD9wvXR9MGQ8QWcKSAbP+o=;
        b=iVuAUBXbRURTgVcpGygVVDbQ/oZyInhhAKqkizfPh/Dgzw5h40ZL7qGLlBqndx8qIo
         yY0erBQLgCXce0VgMpqbtPYPDFnUMcMikIUGtiP/Ia7JYjGVjMcfAcVOZgwmggiYgbOn
         MP9ohOR0T31YqI/6QXiJHE4mn9sWBVobBtbJzMAa9UC+vOG5Wvp65EHy89Sf1PXFcmTX
         a5g1ZhxH8n5Uoad/AhkesQV9dmljFSI1M9UoYmtvpf5PszAiQxi4cAmCiQtC76QRMmWz
         eW06XKSwYHVga1HD2cjTpd4Uck9gepaXoSDZSeeTFWtLiLghoJ0YsX7RbCOaJNlIEZyb
         Eplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NSUcuQgRbbYsO5310TC1TyD9wvXR9MGQ8QWcKSAbP+o=;
        b=FIm+UIhDyLw90dTMTamUkmzX8mXA26lT+0T66M2FIvY2ef1H4ZL+NcZWWNmL5r6+jC
         2QrWpg0JxVYZKL9CPn37MobESa89ZUvdYpXeSpqKFxbrA8UZ9+wZcj2lvXJ3N/U3/Ad0
         bLIaVcPFINDgEJ81uaKIex+1+aMBb1Ug8b7Q/yt6CYcOKnDnPbakvytupnhFvbSlRztn
         NKUzRiG3FHK04L22BgB17oXofQoujA31kxz5B/a2TtHNZUZZ6XKYkmguBjigqzyoHjiU
         ef6J+ikPdKEmgohNNiZMV934kGrh/IiuQeieaicVOhi7AmKbLc+Aw8J4sBdZzg0f5Nop
         aGUA==
X-Gm-Message-State: AOAM531Lgy+249ECDYSC4PPWnDGcU6DKkfatWyIm+fx86jy/SO/g/oTa
        8SsxLn4s+goWYAnpbw0fLUpgt2nIYdC4Rg==
X-Google-Smtp-Source: ABdhPJz9rlYxOqLehK3dGXFVKBx2FmvXm2KhS5Mtdl6rsKzZnYcTFAtzt5W3QX/CuzMw3inViXtwCQ==
X-Received: by 2002:a05:6808:e83:b0:322:3344:13c with SMTP id k3-20020a0568080e8300b003223344013cmr11599612oil.233.1652142481996;
        Mon, 09 May 2022 17:28:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a4adbc4000000b0035e9f149b90sm5496184oou.3.2022.05.09.17.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 17:28:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 17:27:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Florian Eckert <fe@dev.tdt.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: ltq-cputemp: restrict it to SOC_XWAY
Message-ID: <20220510002759.GA1561062@roeck-us.net>
References: <20220509234740.26841-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509234740.26841-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:47:40PM -0700, Randy Dunlap wrote:
> Building with SENSORS_LTQ_CPUTEMP=y with SOC_FALCON=y causes build
> errors since FALCON does not support the same features as XWAY.
> 
> Change this symbol to depend on SOC_XWAY since that provides the
> necessary interfaces.
> 
> Repairs these build errors:
> 
> ../drivers/hwmon/ltq-cputemp.c: In function 'ltq_cputemp_enable':
> ../drivers/hwmon/ltq-cputemp.c:23:9: error: implicit declaration of function 'ltq_cgu_w32'; did you mean 'ltq_ebu_w32'? [-Werror=implicit-function-declaration]
>    23 |         ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
> ../drivers/hwmon/ltq-cputemp.c:23:21: error: implicit declaration of function 'ltq_cgu_r32'; did you mean 'ltq_ebu_r32'? [-Werror=implicit-function-declaration]
>    23 |         ltq_cgu_w32(ltq_cgu_r32(CGU_GPHY1_CR) | CGU_TEMP_PD, CGU_GPHY1_CR);
> ../drivers/hwmon/ltq-cputemp.c: In function 'ltq_cputemp_probe':
> ../drivers/hwmon/ltq-cputemp.c:92:31: error: 'SOC_TYPE_VR9_2' undeclared (first use in this function)
>    92 |         if (ltq_soc_type() != SOC_TYPE_VR9_2)
> 
> Fixes: 7074d0a92758 ("hwmon: (ltq-cputemp) add cpu temp sensor driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Florian Eckert <fe@dev.tdt.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org

Applied, thanks!

Guenter

> ---
>  drivers/hwmon/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -977,7 +977,7 @@ config SENSORS_LTC4261
>  
>  config SENSORS_LTQ_CPUTEMP
>  	bool "Lantiq cpu temperature sensor driver"
> -	depends on LANTIQ
> +	depends on SOC_XWAY
>  	help
>  	  If you say yes here you get support for the temperature
>  	  sensor inside your CPU.
