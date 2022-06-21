Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7C553B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354253AbiFUUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354237AbiFUUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2662E6A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655841756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyjZSjQZn3cKm/xWBINLzP0PpmZ5ysMHiqhpqzZXfWw=;
        b=NOXfa3TONmMTr1PGcNb+LEynd9yf3cyQisnsbaw9kGsBqqHWwVhrJ/GL+o+4vCXpmvMBBc
        I5nbz53opx36EcOyiCoB+zIRwdUY6sZj6mNTPBRAchCqf+INNG2qiFK9AozObBc8MgYk9H
        WwgtOIIl2IhS9u6oEmj8tjnX/J9HSas=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-_piqnVnXOUeP3S2DPQhkrQ-1; Tue, 21 Jun 2022 16:02:35 -0400
X-MC-Unique: _piqnVnXOUeP3S2DPQhkrQ-1
Received: by mail-qk1-f200.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so17569123qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZyjZSjQZn3cKm/xWBINLzP0PpmZ5ysMHiqhpqzZXfWw=;
        b=W5v8Y3iuhzd3uB/czKWZKxBcbOPHH9jhkvM5P6Brf42oipXwwGFVuqepvQ+l3AjypH
         UUDrmj0kJjX8PJGSmRrMW/1AoFTgdQVjrqQN+IjDOxNzEzmsDgiXZUq7e4VNBt3sUtv7
         wShlcU6K9en/KYIQZyZ3sZDytIR0GN09YDNOSTxMljO/Gp/c1ygEwsyHLjkGpyt28EHT
         VnBVcxjOIVSNxZIPfGV5zbFo7fwi1lgpTe1ORKiKWHVd859ECRLp6TxF8IYS9LHuY1UN
         jxAsF41306ocF5etlrHREFiMZfmJNKn5Fu7hEv+bPWEta7QWZqbXd7RNNYe1ihtkLYAf
         g4Lg==
X-Gm-Message-State: AJIora+SsMRz6w2M6bXc4c75PwEjd96dTX2mnAl04wiHnCn3Xet9gwI3
        l0pKv3so0C0ksED+ZnxaW/sTCSQcbOYMXTdcS4wbGR1OHNFvUUB3QuhmzLzgVg0zk8ggnH7vgG9
        oGFzzwCGoaRbEsUdKzHASgxwo
X-Received: by 2002:a05:6214:1c85:b0:443:8347:d7a5 with SMTP id ib5-20020a0562141c8500b004438347d7a5mr24823083qvb.11.1655841754748;
        Tue, 21 Jun 2022 13:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vM8IKeeTIvsIrRyl7KwkmjLpX2QVNqBVXs8SpNfFPLl/Lnzwb+9ION1EMSLPmdLICdu0qrNA==
X-Received: by 2002:a05:6214:1c85:b0:443:8347:d7a5 with SMTP id ib5-20020a0562141c8500b004438347d7a5mr24823049qvb.11.1655841754427;
        Tue, 21 Jun 2022 13:02:34 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id br6-20020a05620a460600b006a6d3fa430csm14472268qkb.58.2022.06.21.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:02:33 -0700 (PDT)
Message-ID: <512685d31ec05034f67c71d9ce91a427828919e2.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/mmu: drop unexpected word "the" in the
 comments
From:   Lyude Paul <lyude@redhat.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     bskeggs@redhat.com, kherbst@redhat.com, Julia.Lawall@inria.fr,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Jun 2022 16:02:32 -0400
In-Reply-To: <20220621133920.8112-1-jiangjian@cdjrlc.com>
References: <20220621133920.8112-1-jiangjian@cdjrlc.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a moment

On Tue, 2022-06-21 at 21:39 +0800, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> line: 1051
>  * have the the deepest nesting of page tables.
> changed to
>  * have the deepest nesting of page tables.
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> index ca74775834dd..ae793f400ba1 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -1048,7 +1048,7 @@ nvkm_vmm_ctor(const struct nvkm_vmm_func *func, struct
> nvkm_mmu *mmu,
>         __mutex_init(&vmm->mutex, "&vmm->mutex", key ? key : &_key);
>  
>         /* Locate the smallest page size supported by the backend, it will
> -        * have the the deepest nesting of page tables.
> +        * have the deepest nesting of page tables.
>          */
>         while (page[1].shift)
>                 page++;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

