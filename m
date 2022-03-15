Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DB4D9C10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348629AbiCONZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbiCONY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF00B3464B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647350625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEpiYhsMGlq2ReYke60gfIQZ2QzqWJpfRL9F+OcYAMY=;
        b=eTh/+BtUq8mkG3eLN+XzrwBClSIGZkA7ig53ycIRZfiDtSRDQzjBPWC7xbBnS7LfFbRFar
        o9tPJ3styOFDEd71BxS9nUnMEZobNGjjvLDosa2tbua8a10xmRmVvKSvFI5Fs5xBi4KOZu
        ciI++kvLZCTUSSzyxwrphkdbKJ3iFt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-WdtXJOYxPZeEYqL04rYo3g-1; Tue, 15 Mar 2022 09:23:43 -0400
X-MC-Unique: WdtXJOYxPZeEYqL04rYo3g-1
Received: by mail-wr1-f69.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so5280999wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IEpiYhsMGlq2ReYke60gfIQZ2QzqWJpfRL9F+OcYAMY=;
        b=AfN/ZJKmSyFerh+txNf+7fwVvs7xLPBPznBAYm+KQvQ0/99JtpUq2ck7AFCUNWt/cb
         vY8dsrTF4DltaJRCRH+fV0dPUP+ekk00uSVaHp493OlvpCpy5OGpYE7gTSowGhDDOMwE
         hGuZlzunkAzv3Y94y5usVzOhJKuePqEwhz5K6iUl34uAnnxJSL2dMvlojXZhnVkoAeO5
         xic+LlfC757WOKOSBHZ2EWmA1ApZZDLXgIZzFoSMhKTtOhLvwN4g9Huea+rp2wyNGMwX
         ztwjTgDtfp9S6nFOfPkiFUyd3s85er9P+ODvsh86HwSTtD57uOxDBY3xjXMQTIEQC9jB
         KLfw==
X-Gm-Message-State: AOAM5305O4QXnNbpC0f+7VZT6pjpCdSJrDtKvqF09Xp9UDG1Z4zaG4oX
        fYMB5IQasR+3xVN44ndaOly0Jyc3kCa23OoruQ4c9AIeWTXdfsU3TXI1lBH7NyGxXM1GnljKhp6
        8WM4KzIJB1pn8fy+qpV/jYa2U
X-Received: by 2002:a5d:47ac:0:b0:1fc:f09b:c258 with SMTP id 12-20020a5d47ac000000b001fcf09bc258mr20957692wrb.618.1647350622431;
        Tue, 15 Mar 2022 06:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhcNjWTrbaoqdRbx7Oloh29YUHJlQt1KnYFPeCC8VNb6iBtIWGW90Cdk830Tz31dWtDzSVEw==
X-Received: by 2002:a5d:47ac:0:b0:1fc:f09b:c258 with SMTP id 12-20020a5d47ac000000b001fcf09bc258mr20957671wrb.618.1647350622165;
        Tue, 15 Mar 2022 06:23:42 -0700 (PDT)
Received: from redhat.com ([2.53.2.35])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm16230818wrh.87.2022.03.15.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 06:23:41 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:23:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     trix@redhat.com
Cc:     jasowang@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        lingshan.zhu@intel.com, sgarzare@redhat.com,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Message-ID: <20220315092101-mutt-send-email-mst@kernel.org>
References: <20220315124130.1710030-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315124130.1710030-1-trix@redhat.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> ifcvf_main.c:49:4: warning: Called function
>   pointer is null (null dereference)
>   vf->vring->cb.callback(vring->cb.private);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The check
>   vring = &vf->vring[i];
>   if (vring->cb.callback)
> 
> Does not match the use.  Change dereference so they match.
> 
> Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 3b48e717e89f7..4366320fb68d3 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
>  	for (i = 0; i < vf->nr_vring; i++) {
>  		vring = &vf->vring[i];
>  		if (vring->cb.callback)
> -			vf->vring->cb.callback(vring->cb.private);
> +			vring->cb.callback(vring->cb.private);
>  	}
>  
>  	return IRQ_HANDLED;


Oh, absolutely. In fact vf->vring->cb.callback is just
vf->vring[0].cb.callback so it's wrong for any ring except 0. Does not
make sense.

So how did it work in testing then? No idea.
Zhu Lingshan, care to comment?


> -- 
> 2.26.3

