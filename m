Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A34D9C39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348673AbiCONaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348665AbiCON36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CAC4A3E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647350923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPwMDqoeq62hMQvUW+d6m4fa4n/Ezhwwm7xT9axVhHI=;
        b=J0zWCN56MPLv4yWFJ6Ei4g1Kt1gC9VCRndxeP8ZLhCNT+s1R/vltZuKmYyK8xPKWdVS22s
        Vt0uUFIBScU2Qr/9z1L58jeond2sOy5a4iOMsXBnfAeWj6196jlgI8bnRhQLf+Rq7f2d/0
        IYF6vizxSZIDNzEWsUSSTFMqE2bJB60=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-uTBAkwlHMVu6neOQCyr5Kw-1; Tue, 15 Mar 2022 09:28:42 -0400
X-MC-Unique: uTBAkwlHMVu6neOQCyr5Kw-1
Received: by mail-wr1-f72.google.com with SMTP id q14-20020adfea0e000000b002036c16c6daso5272731wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPwMDqoeq62hMQvUW+d6m4fa4n/Ezhwwm7xT9axVhHI=;
        b=Dfiss7smGFVj216CxPAdKVOske1pkH4yXCAMBb39fajTxEtSYgfhs+/vLz2gZMQDd5
         gbc3UmZox6EQc+7Vmw7LDHjYANyBNOHzEe2yUWbmS4gRXYonSZx515Ewmc/jK5oMFLQR
         /3f52Yjeta1yLhz0YX5Vg423FbhsWfYdI2FmcePgkipFxBKmG2OfxQeqa61AsRgdUdnu
         vw9rbxNzsstnki1NuIK/hj0j67EfV3JFeJQYzXpInghPJqP1s+Yp8s8y31pgCMEncIKy
         v3QtcXwCQLq6gcsgwpk38ZmSFiKUbRv5NARw0VvaNu9zCD/C5JVz1mG8/PmNGqJVYuS+
         KiCw==
X-Gm-Message-State: AOAM5313q9eh6c409nADtBgoG+N7QhNxnF16rLOXEyy+UFnCCZC8+M2w
        J8O2PKp+ZRjHRMO6dlkHB12sHo1GFPa1fhLY2JnS1Op8Yu6k09AoazksiZN1WpAxzVtHTXSPgEX
        KEJ11lHfwTD0+EvyUBSd0eiv/
X-Received: by 2002:a05:6000:2c4:b0:203:72c9:ef37 with SMTP id o4-20020a05600002c400b0020372c9ef37mr19554485wry.387.1647350921394;
        Tue, 15 Mar 2022 06:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynwrsQrU6Igmjz50LudSk6gmIi09KRWpQylByny5QYQEzWyoMegsicYMO/z5ro86kUgXM4yw==
X-Received: by 2002:a05:6000:2c4:b0:203:72c9:ef37 with SMTP id o4-20020a05600002c400b0020372c9ef37mr19554472wry.387.1647350921151;
        Tue, 15 Mar 2022 06:28:41 -0700 (PDT)
Received: from redhat.com ([2.53.2.35])
        by smtp.gmail.com with ESMTPSA id s2-20020a1cf202000000b0038977146b28sm2283136wmc.18.2022.03.15.06.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 06:28:40 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:28:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     trix@redhat.com
Cc:     jasowang@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        lingshan.zhu@intel.com, sgarzare@redhat.com,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Message-ID: <20220315092656-mutt-send-email-mst@kernel.org>
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

Thanks a lot! I squashed this into the offending patch - no point in
breaking bisect. Pushed to linux. However I'm now
having second thoughts about applying that patchset - I'd like
soma analysis explaining how this got through testing.

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
> -- 
> 2.26.3

