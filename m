Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FBD55F068
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiF1Vf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF1Vfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27A3A2E0B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656452154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAz+Ersm/fEoXHVd+3Jugkc8TnaRByQcUpDjv1kspq4=;
        b=FO5XjPQxDdOoWUXVA4Hr5+2DtyFlG1a9ZZXDkRJ8MUtWmGqRY6ZomgIPNfFL/cWsMlurYG
        PdC9NL78bajl1FRmBnWxQGh4QFA8fkZf/MV/U5vwWSf4vLT9AH11DVWbq1ApzZ/AmWaH7A
        bLoSKC6FUATI+3Ji497ZcR5QKAY4wIA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-gfwydBQdPjCHlxgUuO4Pag-1; Tue, 28 Jun 2022 17:35:53 -0400
X-MC-Unique: gfwydBQdPjCHlxgUuO4Pag-1
Received: by mail-qk1-f197.google.com with SMTP id z9-20020a376509000000b006af1048e0caso10238718qkb.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=FAz+Ersm/fEoXHVd+3Jugkc8TnaRByQcUpDjv1kspq4=;
        b=KEaM1pWZ7QyL3woem01tuZNqGYOcbuCWWYXSrT1nddP9/zTC4cczjNvxJhAX0b8PjQ
         WDpAsuJJj4rrXrrJkGniSgdXndIyHxVh8W32R/tUqJ7ivM3+2ag63omhUAuQsypQNm6E
         l5XcHxiwjJ+wiG5f/hnmIdXJBFtnwlqaavcXovXot6vJJHU2yPISxAbvy2omzokOmN6j
         mG8wJhKo8yep14+z9+eQE3R6RFLsCNOb8Rkrr/Ym5oEGNn8IUk5Q0XeNMtT6/mYHG+x7
         3kLsVi/y7e36wGlB0smKhvXPKTgroDAXnG+IdpqTT4j5IQoTIvNRzqiMlDbqm1R4wvVa
         xfRw==
X-Gm-Message-State: AJIora/5Ih9KsYs0rCQQivq9ZQnSeJfxbOrA6awtRonF7qteFRxyD6Bk
        zbWUA70xBJSBrGrK+nfRhur0X3VGPeMbBW/KR+zzIuuTWIXb+GQ8YwnOwzTreA/yGj0rx+NO9+S
        4Tgrb7TyQCYTlhpZs+guYR/7N
X-Received: by 2002:a05:620a:2807:b0:6a6:6ef1:fb9d with SMTP id f7-20020a05620a280700b006a66ef1fb9dmr4348qkp.146.1656452152648;
        Tue, 28 Jun 2022 14:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZoHh3YsNnPzx9FM3hTwLmyU9VU2X0ooJ/Q2yDYQ/e4IXAyqy8coVeXXF6BSXLjLjgmeSHEg==
X-Received: by 2002:a05:620a:2807:b0:6a6:6ef1:fb9d with SMTP id f7-20020a05620a280700b006a66ef1fb9dmr4324qkp.146.1656452152234;
        Tue, 28 Jun 2022 14:35:52 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a245400b006a75e8d920bsm12794082qkn.88.2022.06.28.14.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:35:51 -0700 (PDT)
Message-ID: <1bce93a46a6ff3ec5b228ea390ba7257f4512480.camel@redhat.com>
Subject: Re: [PATCH] gpu: drm: selftests: drop unexpected word 'for' in
 comments
From:   Lyude Paul <lyude@redhat.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     javierm@redhat.com, alexander.deucher@amd.com,
        jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jun 2022 17:35:50 -0400
In-Reply-To: <1f196235b92e4123ce171980dd7bdbfe9bb0e055.camel@redhat.com>
References: <20220623100632.27056-1-jiangjian@cdjrlc.com>
         <1f196235b92e4123ce171980dd7bdbfe9bb0e055.camel@redhat.com>
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

…ah, I totally forgot that gitlab happens to be down right now which part of
the DRM maintainer scripts rely on - so I can't actually push this patch
upstream right away. I will set this email as unread so hopefully I don't lose
track of this, but please feel free to ping me if I do end up forgetting.

On Tue, 2022-06-28 at 17:32 -0400, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Going to change the name of the patch slightly so it's more obvious this is
> just about the MST selftests
> 
> On Thu, 2022-06-23 at 18:06 +0800, Jiang Jian wrote:
> > there is an unexpected word 'for' in the comments that need to be dropped
> > 
> > file - ./drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > line - 3
> > 
> > * Test cases for for the DRM DP MST helpers
> > 
> > changed to:
> > 
> > * Test cases for the DRM DP MST helpers
> > 
> > Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> > ---
> >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > index 967c52150b67..4caa9be900ac 100644
> > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Test cases for for the DRM DP MST helpers
> > + * Test cases for the DRM DP MST helpers
> >   */
> >  
> >  #define PREFIX_STR "[drm_dp_mst_helper]"
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

