Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9757C56A3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiGGN3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiGGN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:29:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59631906;
        Thu,  7 Jul 2022 06:29:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o7so1990328lfq.9;
        Thu, 07 Jul 2022 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4fH6kMVSj+qVVo/2VvoFlROqeMBn1ytSKbPmKBEfNYc=;
        b=lttpKU+Z/8EnpQyacCUZtbg5Mr5fjFYyK/H0QjJvmzRFVlXzi537TuqI+vO+iA8n2C
         nieNVUGziaBnxeGFEkhB59kjZnAkHIWv8xqcELeN3rl0CAk/4pOk/1R6rfOHRPBwO/J2
         VQh2QDpnOo7biwt2qTN3iiAskVdl3Z5q6QQY/w5BmYF0peLpyTiJXvU+0yVSLAMVOHwP
         XT97hak2KSb8c9D7VfqLtDnvNalGBr+4v4bS5z9ffK0xJeepuKGFDe44TCfhTRWsAufv
         DCAPiGVZW918h5j7MjUCQPdkzJt9uOus80edx4VEOyI4AfLFW/El811FB/62wQ1SRUub
         1zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fH6kMVSj+qVVo/2VvoFlROqeMBn1ytSKbPmKBEfNYc=;
        b=VRAmHWSEwNa9qEEFUp/vHLizwcyLFOStFmI2HHLQwAIkvY0tR4x3ACbMx4DureHeuX
         U3tBoG4g/IadZzU9a4mk1EQw9OuARwDBXncRpetyQ61igqzLXBQSFtntJaE/cyVcv3ga
         HPBXkinihwQtOTb8/+iy1VyTO4WwiNHRP0QcCa1k5WlJpDwLoljxfwxIW81G0xiq9PsA
         wMYYmW+jm94oc3c/aTJJsi7yxz7vEMpbXKZegiPh3ia+3x4ZEZPT3ipHjWp9K2JwKO1K
         xKMJEuHvfqFV+fIqp1VYAMucIO2mqplYgbxLPj9hKe+Wj35h3ixXhVlpo2gU2Zyrgn2z
         91Yg==
X-Gm-Message-State: AJIora8Y5cKy5lMw6VRovueMu9cIIp8zkikibo5/MN1SgQNVFeoQORBN
        oHi7ioKmewuj/MgJrhhslMrHrfS7DVnXvg==
X-Google-Smtp-Source: AGRyM1shyuVbz3i1zFPUSxzw7KF3w00dUQUUoHpc9n0+6RNjDIg52eEgYx6r1F+TP3HB9ZSlfcJdKg==
X-Received: by 2002:a05:6512:314e:b0:47f:8341:2099 with SMTP id s14-20020a056512314e00b0047f83412099mr28906592lfi.367.1657200556195;
        Thu, 07 Jul 2022 06:29:16 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y3-20020ac255a3000000b0047255d211b2sm6832722lfg.225.2022.07.07.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:29:14 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:29:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
Message-ID: <20220707132912.j26r4ziai4a5g2a4@mobilestation>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706042039.5763-2-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nandhini

On Wed, Jul 06, 2022 at 12:20:36PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interface")
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>

As Mark already noted each patch is supposed to have a changelog [1].
Please add a detailed explanation of the problem above the tags
block [1].

[1] "Patch formatting and changelogs" Documentation/process/5.Posting.rst

-Sergey

> ---
>  drivers/spi/spi-dw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index d5ee5130601e..79d853f6d192 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -23,7 +23,7 @@
>  	((_dws)->ip == DW_ ## _ip ## _ID)
>  
>  #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> -	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ## _ver)
>  
>  #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
>  
> -- 
> 2.17.1
> 
