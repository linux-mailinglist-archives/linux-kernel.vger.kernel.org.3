Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31FB53C007
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiFBUoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbiFBUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98681DFA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654202636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jdx2BeYoZ4L4yU6iL09ElWE9/JdvCzMi4CPh9wjsFHM=;
        b=IL35pWVXpL2JC69K2dMQabHU5+1ho2yDGXHPe5FLxqHDqLCowlwx6HByaONosbkOCjPNo/
        RyLTeT87qG+UCwcTWHv8ptifXi+dga07M95AzfTKixNjLtdag7FJ7dDAT+pnKvZeD/HAG0
        jYGRxlS+irg18kPCnaLij3FFndhy4jU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-o0KrauM-PY2ATeY-kWFA9w-1; Thu, 02 Jun 2022 16:43:55 -0400
X-MC-Unique: o0KrauM-PY2ATeY-kWFA9w-1
Received: by mail-qv1-f69.google.com with SMTP id kk8-20020a056214508800b004645738eff6so972717qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 13:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Jdx2BeYoZ4L4yU6iL09ElWE9/JdvCzMi4CPh9wjsFHM=;
        b=aq45hJw1BlOPYC9PLqE3nDGp2eJw7OWuGJw628qOtRO6lsAb1tUs4ENPsD/itRRVbC
         kd4T20HXxyYprVmNdR5HnDyZSdVrFD2vPTsrcdVuhAZ204H7B6W3aSevN/yjEVEy+CkK
         8/pR7uF4SKBDMVo9g38Q/AIkOhSJujXFIUhDuVp3SCfEW7WaNOB4BH2x4xcKo70eVv0R
         aIZo0RNH4j5r5pN4ULtUVIU4utpD/tvIfNPZWloXvbhSjc+FDi8b3DKx8ofoMZbOSsTw
         jSImVKgOclBLJ5YlSByUna0g0b3ZXuBJiTwsaQiz9ScxvpSQf3KuuHftalDV9HBBqfRn
         bwwQ==
X-Gm-Message-State: AOAM5339xJ3ENGcVMYy3ZScY5kLRZsOWl+vdLZDWPO6bKt62Ik+he3qc
        X49lf94BItUryGDhjSd/dbwPago4bmXmbZt4qSTy2i6yZMmeLr1a/dsvw1aPx5ZEb8DGxkzGdh/
        1LgH1ZknZYqQYKgWvBi36F029
X-Received: by 2002:a05:622a:1988:b0:2f9:4132:6ee5 with SMTP id u8-20020a05622a198800b002f941326ee5mr5065852qtc.650.1654202635194;
        Thu, 02 Jun 2022 13:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3m7ceRXpKxC/3kNqPughdFceFaNLE9KRNYqPioRt90qJLaj1Cgb6AOKi9ic3Gtd8vUEfKzA==
X-Received: by 2002:a05:622a:1988:b0:2f9:4132:6ee5 with SMTP id u8-20020a05622a198800b002f941326ee5mr5065832qtc.650.1654202634961;
        Thu, 02 Jun 2022 13:43:54 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id ay16-20020a05620a179000b006a6991233a3sm287747qkb.126.2022.06.02.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 13:43:54 -0700 (PDT)
Message-ID: <4a970413b4150e28452be502a060f9011e4fce07.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/display/dp_mst: Fix
 drm_atomic_get_mst_topology_state()
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Jun 2022 16:43:53 -0400
In-Reply-To: <YpkgmvBeX6L7Bs5y@intel.com>
References: <20220602201757.30431-1-lyude@redhat.com>
         <20220602201757.30431-3-lyude@redhat.com> <YpkgmvBeX6L7Bs5y@intel.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 23:42 +0300, Ville Syrjälä wrote:
> On Thu, Jun 02, 2022 at 04:17:56PM -0400, Lyude Paul wrote:
> > I noticed a rather surprising issue here while working on removing all of
> > the non-atomic MST code: drm_atomic_get_mst_topology_state() doesn't check
> > the return value of drm_atomic_get_private_obj_state() and instead just
> > passes it directly to to_dp_mst_topology_state(). This means that if we
> > hit a deadlock or something else which would return an error code pointer,
> > we'll likely segfault the kernel.
> > 
> > This is definitely another one of those fixes where I'm astonished we
> > somehow managed never to discover this issue until now…
> 
> It has been discussed before.
> 
> struct drm_dp_mst_topology_state {
>         struct drm_private_state base;
>         ...
> }
> 
> so offsetof(base)==0.

fhjdffds yes you're right, I guess we can just drop this patch then

> 
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Fixes: a4370c777406 ("drm/atomic: Make private objs proper objects")
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: <stable@vger.kernel.org> # v4.14+
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
> >  include/drm/display/drm_dp_mst_helper.h       | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > index d84673b3294b..d6e595b95f07 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -5468,7 +5468,7 @@ EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
> >  struct drm_dp_mst_topology_state
> > *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
> >                                                                     struct
> > drm_dp_mst_topology_mgr *mgr)
> >  {
> > -       return
> > to_dp_mst_topology_state(drm_atomic_get_private_obj_state(state, &mgr-
> > >base));
> > +       return
> > to_dp_mst_topology_state_safe(drm_atomic_get_private_obj_state(state,
> > &mgr->base));
> >  }
> >  EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
> >  
> > diff --git a/include/drm/display/drm_dp_mst_helper.h
> > b/include/drm/display/drm_dp_mst_helper.h
> > index 10adec068b7f..fe7577e7f305 100644
> > --- a/include/drm/display/drm_dp_mst_helper.h
> > +++ b/include/drm/display/drm_dp_mst_helper.h
> > @@ -541,6 +541,8 @@ struct drm_dp_payload {
> >  };
> >  
> >  #define to_dp_mst_topology_state(x) container_of(x, struct
> > drm_dp_mst_topology_state, base)
> > +#define to_dp_mst_topology_state_safe(x) \
> > +       container_of_safe(x, struct drm_dp_mst_topology_state, base)
> 
> Wasn't aware of container_of_safe(). I suppose no real harm 
> in using it. Not sure why we'd even keep the non-safe version
> around?
> 
> Though the use of container_of_safe() everywhere won't help
> when "casting" the other way (&foo->base, when foo==NULL/errptr).
> In order to make that work for non-zero offsets we'd have to
> introduce a casting macro for that direction as well.
> 
> >  
> >  struct drm_dp_vcpi_allocation {
> >         struct drm_dp_mst_port *port;
> > -- 
> > 2.35.3
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

