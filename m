Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B935051C8B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384862AbiEETN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359647AbiEETNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:13:25 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF00A4A3CC
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651777784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxnXTkpEEA0ypiQkB3eztb9h9bG9xl88+4zCoT7tsso=;
        b=BJ9yoi+nRcg14IJxTPZvVIfvVPvpW92mMqUNFWpOdzt06t6D+MSGlyJhYl/ALEbQC/npc9
        sVIVfSXp6t3Xe+lqQ/YFeZspphR6AWgKQJ9sovw9Ur4d247f2maqKTmyN+vZvcgcq37kUG
        3mY6cNIK/0P8/IVxC3ozT1BWjnQHMlU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-Cuo0fmAbPsObRm3hWpERqw-1; Thu, 05 May 2022 15:09:43 -0400
X-MC-Unique: Cuo0fmAbPsObRm3hWpERqw-1
Received: by mail-qt1-f200.google.com with SMTP id d15-20020ac85d8f000000b002f3b3b7e0adso4055762qtx.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZxnXTkpEEA0ypiQkB3eztb9h9bG9xl88+4zCoT7tsso=;
        b=AEsjNhFSlg/wiEtIhPMhXM0mdJO+MFMW0x5aSrFZhPnQbIzcbUG4kMyTSkV4GjuIp+
         ogAlenFaXaKFRIXBRFLajbvZdOEqsNgIV3gN+mkKneo3yBJPTEIx0As/L42HAif3Zef+
         wW+yOxS8rxh/3dBfo7j8COD1bRwPkinuz0yu15elCsVRuED93xOIhQZ/c38BOud8xTj9
         V09ypoIz8LzqBvimlO1GffFMg5s41g7hEuD8myAwHvJcdhQYm/U0tDg/j9+lHW8Zln00
         7HPj7ZvVq5zIfeHM+FSFg9apmaWkGJTxKzvIw620GsQDJinVnCp+wr6XA9ILoQDnHPKc
         rgtw==
X-Gm-Message-State: AOAM533J/AQA5nCQ1M1kSEQV/m04hihb8SvuE1UvbbOO2jidouRm6dT2
        46LxqRyQVAJz0jecTSsTEJ9NmenXaKzeHvueB0m+t+RvR8XpfyCcqr4EZ7Poq+Lwd39xkR12jAQ
        Fgogslry1mBLXItN/AXP2Yf2n
X-Received: by 2002:ac8:5cc6:0:b0:2f1:ffa3:ef2b with SMTP id s6-20020ac85cc6000000b002f1ffa3ef2bmr25381841qta.518.1651777782900;
        Thu, 05 May 2022 12:09:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb4sWIQkHXnwic3TWdV/eR5dZuyWfn9dc3NOluXljfI9qtqzg5cTFanA9fkQON5k6aPQx0Hg==
X-Received: by 2002:ac8:5cc6:0:b0:2f1:ffa3:ef2b with SMTP id s6-20020ac85cc6000000b002f1ffa3ef2bmr25381817qta.518.1651777782697;
        Thu, 05 May 2022 12:09:42 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id u12-20020ac8750c000000b002f39b99f69csm1243350qtq.54.2022.05.05.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:09:42 -0700 (PDT)
Message-ID: <2b71f1e318af9819707de1aa61727f02a7e0a79f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/gr/gf100-: Clean up some inconsistent
 indenting
From:   Lyude Paul <lyude@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, bskeggs@redhat.com
Cc:     kherbst@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Thu, 05 May 2022 15:09:40 -0400
In-Reply-To: <20220505081345.89762-1-jiapeng.chong@linux.alibaba.com>
References: <20220505081345.89762-1-jiapeng.chong@linux.alibaba.com>
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

Thanks!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Thu, 2022-05-05 at 16:13 +0800, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:1925
> gf100_gr_oneinit_tiles() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> index 397ff4fe9df8..f16eabf4f642 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -1922,8 +1922,8 @@ gf100_gr_oneinit_tiles(struct gf100_gr *gr)
>  
>         for (i = 0; i < gr->gpc_nr; i++) {
>                 init_frac[i] = gr->tpc_nr[gpc_map[i]] * gr->gpc_nr *
> mul_factor;
> -                init_err[i] = i * gr->tpc_max * mul_factor - comm_denom/2;
> -                 run_err[i] = init_frac[i] + init_err[i];
> +               init_err[i] = i * gr->tpc_max * mul_factor - comm_denom/2;
> +               run_err[i] = init_frac[i] + init_err[i];
>         }
>  
>         for (i = 0; i < gr->tpc_total;) {

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

