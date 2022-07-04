Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52CB565F22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiGDVch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiGDVcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4615A63A3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656970353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CZe8Sqi7DtJlbJu8xa2TOlRoA4m6XJLDJlm9ljsZMU=;
        b=eoEQH1QW+GLlBWMmSlKVhJoSFBY3kaDBzBl0JzmQqXVQlxjgQJXLe7LG9yvFjS2d5rKGwu
        k2bx1qxV6rMgUSHKLa6e58ZugXXz3rsIu2psNECOS/ExCE1EkvxBYfubPhGZz+7RnlD2j1
        W+Q2nJYOR7P4MWh3d2OZPI/SDR3HosE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-f5ojg199OLOQdpxTsEjiyw-1; Mon, 04 Jul 2022 17:32:32 -0400
X-MC-Unique: f5ojg199OLOQdpxTsEjiyw-1
Received: by mail-qt1-f198.google.com with SMTP id k16-20020ac84790000000b0031d446a2d1eso5216249qtq.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+CZe8Sqi7DtJlbJu8xa2TOlRoA4m6XJLDJlm9ljsZMU=;
        b=Dvpe5wvC6Qrwf7SO3HyrYh9Vbt1xLc8tO+I4TuiRBKQcw/nUGKfk81HYWPxaQeYtjm
         ZdButUfZd7wBMZepHMOjOGkZvo7gPyyrWmW/rbvDgExDsR/EBZWzwkd8lgeY3/3u9dzx
         eURXzMPwOzTvNwqfEzDbWCTf6yMUtsKuWeA83Dhd40aBMVvSgl+sHcgb1V2OP6fNNxa4
         D7Xu/UzEpmpSoUBEmfco07V3HL6mJxmUq/sZkg4PVc3+LaIbsqZ8af08C+c4AiEH1tlg
         aE6YPr6UuhW5bRD8VhhXp9Ea6Z+uo+5iOGITi8pY2aLLK0JYfaWO5+NhgLbQTW/pfQrH
         nzrQ==
X-Gm-Message-State: AJIora+LasN4nvC7fhcbK2r0uT0JfaPNPCppTcGseQe4BjQnQVhavbdh
        eHyz4q+mi9wbzZUgYtXscakYRyo3X6QVAyxO1nC7zn5CqM8DagNDm6BsY/rg+12t2MUerw5Uycx
        mIH4zjat1fFgwApsRIcqWTKHg
X-Received: by 2002:a05:6214:2a8e:b0:470:911e:9565 with SMTP id jr14-20020a0562142a8e00b00470911e9565mr29602429qvb.37.1656970351712;
        Mon, 04 Jul 2022 14:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sYMDnzTOdu6YjQ9ZTKxQBwIiV3zh8YsFLMwenBFFfbrSK9BSxwAVULZ9blVHT+e6pMwUZk9Q==
X-Received: by 2002:a05:6214:2a8e:b0:470:911e:9565 with SMTP id jr14-20020a0562142a8e00b00470911e9565mr29602418qvb.37.1656970351439;
        Mon, 04 Jul 2022 14:32:31 -0700 (PDT)
Received: from [192.168.57.2] ([172.58.188.184])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006afd667535asm16029818qkp.83.2022.07.04.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:32:30 -0700 (PDT)
Message-ID: <91194b7190081545a8eeb10d20e24de864dfe259.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/bios: set info only when the return is not 0
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Mon, 04 Jul 2022 17:32:18 -0400
In-Reply-To: <20220702153904.1696595-1-trix@redhat.com>
References: <20220702153904.1696595-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Currently on flakey internet in the back of a car, so I probably won't be able
to push this until I get back tonight or early tomorrow

On Sat, 2022-07-02 at 11:39 -0400, Tom Rix wrote:
> clang static analysis reports
> drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c:68:17: warning: The right
> operand of '*' is a garbage value [core.UndefinedBinaryOperatorResult]
>         switch (!!data * *ver) {
>                        ^ ~~~~
> A switch statement with only a default should be reduced to an if.
> 
> If nvbios_pmuEp() returns 0, via the data variable, the output info
> parameter
> is not used.  So set info only when data is not 0.
> 
> The struct nvbios_pmuE only has the type and data elements.  Since both of
> these
> are explicitly set, memset is not needed.  So remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> index b4a308f3cf7b..49e2664a734c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> @@ -64,12 +64,9 @@ nvbios_pmuEp(struct nvkm_bios *bios, int idx, u8 *ver, u8
> *hdr,
>              struct nvbios_pmuE *info)
>  {
>         u32 data = nvbios_pmuEe(bios, idx, ver, hdr);
> -       memset(info, 0x00, sizeof(*info));
> -       switch (!!data * *ver) {
> -       default:
> +       if (data) {
>                 info->type = nvbios_rd08(bios, data + 0x00);
>                 info->data = nvbios_rd32(bios, data + 0x02);
> -               break;
>         }
>         return data;
>  }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

