Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AC56B9CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiGHMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiGHMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:35:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123879692;
        Fri,  8 Jul 2022 05:34:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a11so25762998ljb.5;
        Fri, 08 Jul 2022 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kvgTqdQjxH2uleYeYoM+LdF54XELxeDYcQEtIsJKsUo=;
        b=FZ1KJntd4lKxixBfrdLSiQrDjABP5gyyoB9X310uzRt/9Ev3GGHIyhqrdmWz0XNfX/
         FG7f7oad84IyjH9F0C9PR7YA3pm36FEzvdLgGh6z3lZ7NwC+MGrC+WxzcKvPLO+YrAE9
         Vk6aqeYreAiK+rVwd+/xFqDAk+vcC1dI9Ue45JBDD0A7h/cq05EitWicGjKm1BhJlc3O
         Ub667sk5b+QX0vU9Re0M+gcXyqNylkyBQdLpSJoKrlYV5rckffp8+eclfzWWxktgA509
         1M6v3ELrhZSFyyhiHRuV/qp5UUH+hL8pI+M6khHvWlxz3sx5h55t+UFbrzG9JeNYB6ke
         9vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kvgTqdQjxH2uleYeYoM+LdF54XELxeDYcQEtIsJKsUo=;
        b=7mjDRx2chpKJ0rsxrWISsB/1POOBFEy/rXgiIg0df6t/lSQoZFtUCDiv8cCPwnQ0WF
         qmDFffVS4mTz5WjMZncrarChGjd2w/Q00wmmGBCYFOecGnk1SSn2r2JbqxvKeTSOGMam
         VpwNnrXOZVkSOpSzFVdJDdgUZ2pZHgbbB9I34AePsEAgAN0120kSzNYNgz2QPOkil3l3
         4XN+rFPJJniFCWEsAgWKUZO2ZTbX8MSX4982tCSCT/q3Kb7Rb7AYbEOa/zMubtyp4pc4
         QOTDmcGjBVv7+9u9nK8XrCnNoyO6hV0PQY3QdFD2UsEWd/n8/qi8oBQPXlQX9xYeg24s
         hNuA==
X-Gm-Message-State: AJIora+wRIHkCUQ3xMrByXIxL96Wa/2l26wRPzoeJCKZFlXQw/+4OBih
        uvZm3/T6diOpyl+pzD14aWQ=
X-Google-Smtp-Source: AGRyM1tGe3lSnhDZc16pdwUzPBuYWe2//F/i/yPXT5QRFPbTSyTH/CKSzguYluqIngsyolqoYDjzzA==
X-Received: by 2002:a2e:95d3:0:b0:25d:543f:78d3 with SMTP id y19-20020a2e95d3000000b0025d543f78d3mr1809812ljh.344.1657283697449;
        Fri, 08 Jul 2022 05:34:57 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id p11-20020a056512234b00b0047f6b4a53cdsm7378222lfu.172.2022.07.08.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 05:34:56 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:34:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Make phys_to_virt utilize __va()
Message-ID: <20220708123454.mj7f3gdzk3ct6seb@mobilestation>
References: <20220707203743.1226302-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707203743.1226302-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:37:42PM -0700, Florian Fainelli wrote:
> The implementation is exactly the same, so avoid open-coding it in two
> different locations.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Seems reasonable. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

*Note it now looks exactly as the generic phys_to_virt().

-Sergey

> ---
>  arch/mips/include/asm/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 6f5c86d2bab4..880048a54362 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -131,7 +131,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
>   */
>  static inline void * phys_to_virt(unsigned long address)
>  {
> -	return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
> +	return __va(address);
>  }
>  
>  /*
> -- 
> 2.25.1
> 
