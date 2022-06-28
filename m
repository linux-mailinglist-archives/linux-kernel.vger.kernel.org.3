Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE755F066
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiF1Vc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiF1Vcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 650CF3AA7B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656451972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLJSiS4iMX/nUV79ttiy0e8LOCrjE5iV4ITH0RqhCCY=;
        b=UEitnVaPLaXs8zDQCGM1p8WK9ML/dTRC/+2bBd/yNDWyaHkOoDGYXhfnHtdlAllqQBlvFP
        B2n2XIw0PPjrV88do3Gy6cfrfeFjwJxaJmMBiJ80MsC6xlradHVuvi2ZURVY46B34RPWdB
        cCv52wcbUSkCVW8FC0++PHvZF2xMN3o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-BbrhGFWDM2qOcB4eap6sNQ-1; Tue, 28 Jun 2022 17:32:50 -0400
X-MC-Unique: BbrhGFWDM2qOcB4eap6sNQ-1
Received: by mail-qk1-f198.google.com with SMTP id k190-20020a37bac7000000b006af6d953751so1665323qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=MLJSiS4iMX/nUV79ttiy0e8LOCrjE5iV4ITH0RqhCCY=;
        b=Z5jor4V97Ny38W8y2WguDmCIMVhVsBnnLnr6CI9KwOPS+Gk3pCiLwIQS/XBxZT9q0B
         pa/ZMrl2HlC0JH9eYU2ncAbdVnLJF1rK6mDuYTgQPmi8Bw7D2sYhkLQF4ToXBbhHSG0x
         zZfZ3AvOlihQ4vXLFfM2cvYHklBUyKZq9nnc4z562awdGnH9SM6m4fajpD7H1UhOlVwj
         lRADMg/Cnnwhp8V0CUiHyq+M0NYcH+KLEEwpeobnxw658rNPCnyiXGGIRLR0maJVfIp0
         SN79CUIe1eOWizhMkrXqxOmsg9ugF2Xct9Kd3Rin72nhpdw6NdavB81/ogqXEAcJz3x2
         RFlw==
X-Gm-Message-State: AJIora9arSFc/N8cLfWJMF3gwt4my9mk8CwI9d2tE7/WOZtvGZ/Hq4iM
        1HDsXXKORK6frA92HZKOuISa4rAKs7JczMaSf4lZrC+/ffPZqrOmFvKqw7x3NFmgDvaVKx893x/
        5L9YmolzL+A2BH+ssVPGkc0kS
X-Received: by 2002:a05:6214:202d:b0:470:3e7a:d183 with SMTP id 13-20020a056214202d00b004703e7ad183mr5415960qvf.4.1656451970304;
        Tue, 28 Jun 2022 14:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5rc5cVQf8GWfwbbgQCuqUtlFNDHPZN0QGJCwkqxa7sPpHwlF5PDoTYE5KX7xZVqJJw4ldTQ==
X-Received: by 2002:a05:6214:202d:b0:470:3e7a:d183 with SMTP id 13-20020a056214202d00b004703e7ad183mr5415949qvf.4.1656451970098;
        Tue, 28 Jun 2022 14:32:50 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id l13-20020a05620a28cd00b006a6bbc2725esm12406053qkp.118.2022.06.28.14.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:32:49 -0700 (PDT)
Message-ID: <1f196235b92e4123ce171980dd7bdbfe9bb0e055.camel@redhat.com>
Subject: Re: [PATCH] gpu: drm: selftests: drop unexpected word 'for' in
 comments
From:   Lyude Paul <lyude@redhat.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     javierm@redhat.com, alexander.deucher@amd.com,
        jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jun 2022 17:32:48 -0400
In-Reply-To: <20220623100632.27056-1-jiangjian@cdjrlc.com>
References: <20220623100632.27056-1-jiangjian@cdjrlc.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Going to change the name of the patch slightly so it's more obvious this is
just about the MST selftests

On Thu, 2022-06-23 at 18:06 +0800, Jiang Jian wrote:
> there is an unexpected word 'for' in the comments that need to be dropped
> 
> file - ./drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> line - 3
> 
> * Test cases for for the DRM DP MST helpers
> 
> changed to:
> 
> * Test cases for the DRM DP MST helpers
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> index 967c52150b67..4caa9be900ac 100644
> --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Test cases for for the DRM DP MST helpers
> + * Test cases for the DRM DP MST helpers
>   */
>  
>  #define PREFIX_STR "[drm_dp_mst_helper]"

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

