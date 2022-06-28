Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED1455F19D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiF1Wvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiF1Wvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F309F3A735
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656456701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyl/HZb3SI8HFuQLBD60pevZNI/Uhf0WHtxfzC/4dus=;
        b=RW/8D/AwKM6KpiCwyg2vht2Gu+z7nuH4XybF53RZ4fuOSo5I+ejlPyNvQnl9O5XHFJ/G2W
        vq/Za6WF1KiScqfqYHyQ/jA5i1qK2VqnjgmSx6SjgOHXV0rm7v2zhLmDVU8i4P4zxXhmR0
        PpXCD4NdXPIwOANXJ1nHAqTtWr5MvSo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-ZeFsa-KzO_S2iYVdnEkkDA-1; Tue, 28 Jun 2022 18:51:39 -0400
X-MC-Unique: ZeFsa-KzO_S2iYVdnEkkDA-1
Received: by mail-qv1-f71.google.com with SMTP id mz4-20020a0562142d0400b004726d99aa49so6445097qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=oyl/HZb3SI8HFuQLBD60pevZNI/Uhf0WHtxfzC/4dus=;
        b=hz/cOVSBd3aHOgXISzjToZBmo1RGUweNvbvpoqbk7SP0TG+g29nZY32GV741suzCdk
         mHOBtdb01Hf+0AJtnSg56hJ5jHqgDMzmiCeuw6p0AJJzN/w4PzjU46u5G3/NZh0hHAAY
         mXHXLYaiRd3EHZzIA1EF+jtZCImBEj3OCd2Bcz01JL64dqI5emD5q7lgJlNMY277Mi2i
         NlAzLtQW8JpSOqd7lqRPsG8s1wiNNreVDJ77q2qczm3oRR6SyfpmCeASisBjObmKLmlk
         pAMvuviKSeVxjfO4hs4h9jQ6Sm52lybRs8BogcC8xffUPR9JQdMlDcQ7LK4ianvwBNnV
         761g==
X-Gm-Message-State: AJIora80tuyzJ0tUxObWeUr8wBhC0Ma05VQ0toW922ImFWwgdCMmdB4A
        slEdpIe9u6Vq8rj3DpDoW8d4YYPkKFafLLT8k+bW0p648+zLOjPK/cnBbgxZQXQkQQIXTfe8kH9
        9MaPFYOhu1qTFkamJcTjelC5A
X-Received: by 2002:a05:6214:1c83:b0:46b:a79a:2f0b with SMTP id ib3-20020a0562141c8300b0046ba79a2f0bmr5547800qvb.103.1656456699044;
        Tue, 28 Jun 2022 15:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1udyDEQwXavpJIYVRyrsdyEvotjuTUkOt6UvxlkbJ5gGTgtNxqyAFCyPEfK8HrsRHYsZtNJUg==
X-Received: by 2002:a05:6214:1c83:b0:46b:a79a:2f0b with SMTP id ib3-20020a0562141c8300b0046ba79a2f0bmr5547782qvb.103.1656456698661;
        Tue, 28 Jun 2022 15:51:38 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id y18-20020a05622a121200b002f90a33c78csm10673903qtx.67.2022.06.28.15.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:51:38 -0700 (PDT)
Message-ID: <a9b1cc1bdc9830a6fd368c87fd514c7e560139f0.camel@redhat.com>
Subject: Re: [PATCH] gpu: drm: selftests: drop unexpected word 'for' in
 comments
From:   Lyude Paul <lyude@redhat.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     javierm@redhat.com, alexander.deucher@amd.com,
        jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jun 2022 18:51:36 -0400
In-Reply-To: <1bce93a46a6ff3ec5b228ea390ba7257f4512480.camel@redhat.com>
References: <20220623100632.27056-1-jiangjian@cdjrlc.com>
         <1f196235b92e4123ce171980dd7bdbfe9bb0e055.camel@redhat.com>
         <1bce93a46a6ff3ec5b228ea390ba7257f4512480.camel@redhat.com>
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

Oh-it's back up now! will push now :)

On Tue, 2022-06-28 at 17:35 -0400, Lyude Paul wrote:
> …ah, I totally forgot that gitlab happens to be down right now which part of
> the DRM maintainer scripts rely on - so I can't actually push this patch
> upstream right away. I will set this email as unread so hopefully I don't
> lose
> track of this, but please feel free to ping me if I do end up forgetting.
> 
> On Tue, 2022-06-28 at 17:32 -0400, Lyude Paul wrote:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > Going to change the name of the patch slightly so it's more obvious this
> > is
> > just about the MST selftests
> > 
> > On Thu, 2022-06-23 at 18:06 +0800, Jiang Jian wrote:
> > > there is an unexpected word 'for' in the comments that need to be
> > > dropped
> > > 
> > > file - ./drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > line - 3
> > > 
> > > * Test cases for for the DRM DP MST helpers
> > > 
> > > changed to:
> > > 
> > > * Test cases for the DRM DP MST helpers
> > > 
> > > Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> > > ---
> > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > index 967c52150b67..4caa9be900ac 100644
> > > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > @@ -1,6 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /*
> > > - * Test cases for for the DRM DP MST helpers
> > > + * Test cases for the DRM DP MST helpers
> > >   */
> > >  
> > >  #define PREFIX_STR "[drm_dp_mst_helper]"
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

