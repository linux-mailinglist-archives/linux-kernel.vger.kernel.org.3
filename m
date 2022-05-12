Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE452514C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbiELP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbiELP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:29:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D125C286
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:29:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x18so5206444plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7epJTdRtz8ytdA7Utn31+NXZs2HtBeeNX7bVpN/MwEE=;
        b=oWkmUWIotuY3hw15NeyY9Iex85NSglOKVVENUxyQGPOnp57jSo5srkPr4aU6mbpkWf
         DcAWK5xOtDlW4eMge2b973h+I1jrO6V+pb9OfrFZNYYyXG8z84ABGR/1WSk53GQIXPwe
         eycIHWO9FOGJAKvbTgOdAzXYycrb5p80pAw1xoB8sG/eR0uQQi9vsNpMyA3s5Wil8RJp
         sOXCRd77QMt7vDFYUyqYjMlyXs/isHjjauLFVMhTamXymvbXVdqQ9WL/eMYExZtrQ3a2
         h19wBTT5sjs4pCGEDH0duAI18i8/oVI1dTpELovthJ8HenFpcjJL0oQ31jEYTcQKO1cw
         K6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7epJTdRtz8ytdA7Utn31+NXZs2HtBeeNX7bVpN/MwEE=;
        b=1d8LR7L1ECsWk4URsCUqlY0OIJ+MbROSQ7SEoSTW0PC7liy7MLK6yeQ2KGCV5yu7vv
         HNE4FwoZLEUIMltRDxZXBjil/la44F2UK591umx23uOKZcuMP9v5i5JUt7AU57lgVCao
         huTiHtXGUltLW4TlK4gzRgvmVAWYcDAxgV50EX1V1KtStZCWw4mPxi9EShL93++R/ITD
         nEmuOTtRR75KwuaIhxGK/OIXlfcRUxaD0UZOC0xBtbvYJ/g2lt2vWSSKWmIsNQPOgzok
         Xn4+f8xy3ULnve4i3UZdRrBQtUJ9rGkZlBgisAkdwwDRl7Q4zOwRc+5+rzI+OkBenPur
         U68A==
X-Gm-Message-State: AOAM532l8GsykERPY/aJ4CRmkrPwsAObcKpzJYIuosbqe2uIkWupChLO
        qhY8Kqc0zocwoe+BpxBFGNypF3BtjoKBLw==
X-Google-Smtp-Source: ABdhPJywV11QbxqEEIqi2h3e/6mR0N+JCgW5XA1dNaSgjidm8KmEaVToTsNTUo844tIGd0Z1A2GNMA==
X-Received: by 2002:a17:902:a988:b0:158:9877:6c2c with SMTP id bh8-20020a170902a98800b0015898776c2cmr485723plb.80.1652369384675;
        Thu, 12 May 2022 08:29:44 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l20-20020a056a00141400b0050dc76281a1sm3992770pfu.123.2022.05.12.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:29:44 -0700 (PDT)
Date:   Thu, 12 May 2022 23:29:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     liqiong <liqiong@nfschina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change "char *bdi_unknown_name" to "char
 bdi_unknown_name[]"
Message-ID: <Yn0n23MRQ+wD1ZWN@FVFYT0MHHV2J.usts.net>
References: <20220512082637.24649-1-liqiong@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512082637.24649-1-liqiong@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 04:26:37PM +0800, liqiong wrote:
> "char bdi_unknown_nam[]" string form declares a single variable.
> It is better then "char *bdi_unknown_name" which creates two
> variables.
>

Sorry, I do not understand what you are saying here.  Creating
two variables means what?

Thanks.
 
> Signed-off-by: liqiong <liqiong@nfschina.com>
> ---
>  mm/backing-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 7176af65b103..4982ccc63536 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>  
>  static struct class *bdi_class;
> -static const char *bdi_unknown_name = "(unknown)";
> +static const char bdi_unknown_name[] = "(unknown)";
>  
>  /*
>   * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
> -- 
> 2.11.0
> 
> 
