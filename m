Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8ED505E28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiDRS4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiDRS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA6BC2E688
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650308002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QL6AB1e58fXCCgMn67tELqsCerYiMJO8eo3KuBC5io=;
        b=DDJHy09Ap2sUGzABWMiUBXIfttlTUfPaWUjoBjmizvq0pVD4rA/rMuC4sIy2su/NYNd99M
        Q1JMR1vWdIQIibyhiNB+9xjiFbTyaxPudLQtnNEkNWD4rx8axbJcaz/SyZ5r5ZKihkwRKL
        LBNocb5sfhSj+dVXv0nTuATXXM2dZeg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-RLaa5PZdNm65rvnXwZLRXA-1; Mon, 18 Apr 2022 14:53:21 -0400
X-MC-Unique: RLaa5PZdNm65rvnXwZLRXA-1
Received: by mail-qv1-f70.google.com with SMTP id bt18-20020ad455d2000000b004465db1865dso2606931qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=3QL6AB1e58fXCCgMn67tELqsCerYiMJO8eo3KuBC5io=;
        b=TV6QZi9KK1Bj6xAVL8O6ZMC5SZCeh0vebfdxuvNgnc1yS1C0ealNdZlNmRaGG4V2Pf
         FJpZ500l+Tr/jYO1z2mrwntJncXS3l6Go6cAnbCEu97IATXOo/6tsihHNbFUbqWUrK6e
         eZOubB9Dy+tQ1Gny/rQF/JRWPHaVjRO53bjTubmvtohNO9s9+B/q6PDZWJdwJCDtLfmZ
         jC73yOfoXc5WEMuW670AqszPdim3JY4enUMBkfFcgsveNrnLXUHsTfGutTk+0IuyR5I0
         0fOOWqK4TG86pywZ773p4lJbgFous92ztx+4wxgT/c4ubgfnyD9P1l0uyFrXPRQpaH+4
         xjeA==
X-Gm-Message-State: AOAM532PXvvCGiogQvaRXO8fG5oykIq1jkRjUp7hWbPPfJGwT8FwZUsc
        Sjh7oV89/EIFt8LdvOrWdqdrfyDRuKlK9tQkd4dq+sTFGXA0iUaeP+170kOImGqM0ma9303oTgc
        lfadcXqwWn9OW6kmNarovFJj5
X-Received: by 2002:a05:622a:13c7:b0:2f2:4bf:b4ee with SMTP id p7-20020a05622a13c700b002f204bfb4eemr2382467qtk.676.1650308001221;
        Mon, 18 Apr 2022 11:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiJOMwM2cO+2EIYEAPFwkpbHHBWmZQjSPFW43xk7EoOaFdRaV6zdviqsvk9fEK/Ser1+Qycw==
X-Received: by 2002:a05:622a:13c7:b0:2f2:4bf:b4ee with SMTP id p7-20020a05622a13c700b002f204bfb4eemr2382456qtk.676.1650308001019;
        Mon, 18 Apr 2022 11:53:21 -0700 (PDT)
Received: from [192.168.8.138] (pool-71-126-244-162.bstnma.fios.verizon.net. [71.126.244.162])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b002f2017d5652sm1819917qtw.40.2022.04.18.11.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 11:53:20 -0700 (PDT)
Message-ID: <f5700e71bfee343dc2837d3348cada66406ce9fa.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/gr/gf100-: change gf108_gr_fwif from global
 to static
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 14:53:19 -0400
In-Reply-To: <20220418152810.3280502-1-trix@redhat.com>
References: <20220418152810.3280502-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a moment

On Mon, 2022-04-18 at 11:28 -0400, Tom Rix wrote:
> Smatch reports this issue
> gf108.c:147:1: warning: symbol 'gf108_gr_fwif'
>   was not declared. Should it be static?
> 
> gf108_gr_fwif is only used in gf108.c.  Single
> file variables should not be global so change
> gf108_gr_fwif's storage-class specifier to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
> index 030640bb3dca..ab3760e804b8 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c
> @@ -143,7 +143,7 @@ gf108_gr = {
>         }
>  };
>  
> -const struct gf100_gr_fwif
> +static const struct gf100_gr_fwif
>  gf108_gr_fwif[] = {
>         { -1, gf100_gr_load, &gf108_gr },
>         { -1, gf100_gr_nofw, &gf108_gr },

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

