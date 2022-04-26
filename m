Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5F5105E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiDZRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353666AbiDZRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 972341DC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650995216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=faLawbnhHW02EYrXGuASXIKJnZrxT+4fARzUkA4OZ1c=;
        b=HWiZ5bLqPLZDIkU2Xska28y0s29XViiVXmeFTaSOw3mSI3E7wIgKK6Etbf2KQ2Ierm5XZR
        RyR+ALaqE/QuXQa7uW03sgXBh3g+R9mjKWpmeoIpa97MpYtMxaKjPn43a9wCdTDwIpo+fD
        viKx7hbeeao4sWjgM7H1pd7HQzXwcf8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-elFO-EtrME2xqGummPUAIw-1; Tue, 26 Apr 2022 13:46:55 -0400
X-MC-Unique: elFO-EtrME2xqGummPUAIw-1
Received: by mail-qk1-f198.google.com with SMTP id j24-20020a37ef18000000b0069eafae30b1so12202426qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=faLawbnhHW02EYrXGuASXIKJnZrxT+4fARzUkA4OZ1c=;
        b=U110nNp5F9617IvSbRS+kTAagxfiSCvNSqLp5Xcfu4X+LAzwB+mYN/+INUqUHJjMA5
         38M8MBUPUO5UKtYNiutsqyZ+aSfeN09Y0wiZacbpC3eryINFJm/gxtTC/mBVGpHUcU68
         Asxpb/5rw3rrgq3E2BTulWSMHIdaPNQIJs/l2RsjnovmK03H0r9OkL7d/JSsCe7YtH5o
         p0dMkLVmQnsrZqWhv7juj200fqzYL+sBZttCgDVUILTcI4SwAHfMTkv2BJle3gnyfNVm
         IInMFErzrY7v5b6J0si2UeujPoe1NJwF8wG3HeMBy40QgOr8zNUbbAMnyvINQK0MC5un
         z0wg==
X-Gm-Message-State: AOAM531JgVLo8sZZPAZeIb8affEOWnPE2VTj2Xso5bw+lUqorE5a/Z1p
        0KBv1TBCaFmVtzNytds41t6ZBJaNsc4qWW0EV+1qbUweFJwJOgNzC4eoRxDIfzaUvtMII/SNZb+
        LgjFN+8DqE+Xqh+WvhEnIqlWD
X-Received: by 2002:a05:620a:108a:b0:69e:7d3c:7230 with SMTP id g10-20020a05620a108a00b0069e7d3c7230mr13769270qkk.616.1650995214745;
        Tue, 26 Apr 2022 10:46:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEOSHVXcCeNEv+IDmrQTu6C7S63JG6GilAnmFbTugdP8U7PQOfDNm67g0JW/sLepxLrIYkOg==
X-Received: by 2002:a05:620a:108a:b0:69e:7d3c:7230 with SMTP id g10-20020a05620a108a00b0069e7d3c7230mr13769257qkk.616.1650995214552;
        Tue, 26 Apr 2022 10:46:54 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id 76-20020a370c4f000000b0069f62e55f65sm2895549qkm.107.2022.04.26.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 10:46:53 -0700 (PDT)
Message-ID: <7f2ac9892b93d452a728d07a49a4446b81ce76be.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp/gv100: make gv100_disp_wndw and
 gv100_disp_wndw_mthd static
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 13:46:52 -0400
In-Reply-To: <20220425131308.158635-1-trix@redhat.com>
References: <20220425131308.158635-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Mon, 2022-04-25 at 09:13 -0400, Tom Rix wrote:
> Sparse reports these issues
> wndwgv100.c:120:1: warning: symbol 'gv100_disp_wndw_mthd' was not declared.
> Should it be static?
> wndwgv100.c:140:1: warning: symbol 'gv100_disp_wndw' was not declared.
> Should it be static?
> 
> These variable are only used in wndwgv100.c.  Single file variables should
> be static.
> So use static as their storage-class specifiers.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
> index 5d3b641dbb14..e635247d794f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
> @@ -116,7 +116,7 @@ gv100_disp_wndw_mthd_base = {
>         }
>  };
>  
> -const struct nv50_disp_chan_mthd
> +static const struct nv50_disp_chan_mthd
>  gv100_disp_wndw_mthd = {
>         .name = "Window",
>         .addr = 0x001000,
> @@ -136,7 +136,7 @@ gv100_disp_wndw_intr(struct nv50_disp_chan *chan, bool
> en)
>         nvkm_mask(device, 0x611da4, mask, data);
>  }
>  
> -const struct nv50_disp_chan_func
> +static const struct nv50_disp_chan_func
>  gv100_disp_wndw = {
>         .init = gv100_disp_dmac_init,
>         .fini = gv100_disp_dmac_fini,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

