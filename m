Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831DE4EEC22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbiDALS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345431AbiDALSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:18:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B518383A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:16:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cm17so2153083pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OEhuS+fxsVCDNNS1MKILSv4OXms02eQi0iGfBJLmlCc=;
        b=Mx/784l+9YYlEEqw3tkMkrhp/CWEf9Pyp7wfMbV9tAivm7X2pHJ+motN03vf5CHEIo
         4tR3Fa1ZoNDkpcv0q5wF9OdG17Btvg/OaIzlM088QYylOEyxgvL1IoYBJn/n0hgdoLrn
         z/cUGx8kEvx1/cGPJj025ci8+sYK8KIX1vSv5uca0rE8R/BdzgOWpk7fEt2Cwbn30bf+
         nQJ6t9nm7UUaTVlukBVuzDQyE3vB2l6ZJiL9NobmJo3E3AH5xcQxyLXhmVVRxZuu3yt/
         WgBWLtUV2KvCUChEuwNOwVxp7TeF/GLs0xxeZoTj/Vmeo623jZIFREAwE/AdjmqFevGw
         tWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OEhuS+fxsVCDNNS1MKILSv4OXms02eQi0iGfBJLmlCc=;
        b=p76SxToPXbfwQoFUrzsaFgwg1gKSh75v3/gcX1NQFEdeRusKX0f8M/6KRKKvWeMhrs
         jbJae/KO1//aPHIVO+DUp/uP84/yEfjcuMDHuc/U0hZqyDpWG4K3ojTH4zRLXncBatrD
         eyYntFsuFQAlH+LXk8PmXCdDojBNM0Irxg4JDVekHKyHiCingf1U8UCdYxdA+21OoTNd
         GrbFvHAN3sOd0iguAolCgBNHd4co3ifvcj2TKK116ZZoAqXz6tpOnbwGKAHhEmUgywRJ
         S11f7fiankSpf1xaN6DjpGg7nI/2II/9yDzet8AaXvHNiGm/sgXHt9CF/2AXDveYSgps
         PV+A==
X-Gm-Message-State: AOAM530ZitlTps0zPzKPhnVTqU09Nipdj9VNHOy8d9/h2yM/8oG/qN3y
        ZRk+bG4F+vp4aY3GIOMaBsI=
X-Google-Smtp-Source: ABdhPJwpyHXGvM/g750syQ26/sjrGpjqyb2Zau7YvEDNf2rjm603jlaKXSvvWieMHYcAR9JbF0mkAA==
X-Received: by 2002:a17:90b:4d08:b0:1c7:7567:9f6b with SMTP id mw8-20020a17090b4d0800b001c775679f6bmr11520261pjb.134.1648811770163;
        Fri, 01 Apr 2022 04:16:10 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id ij17-20020a17090af81100b001c67c964d93sm13383703pjb.2.2022.04.01.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 04:16:09 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, airlied@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xiam0nd.tong@gmail.com, yakui.zhao@intel.com
Subject: Re: [PATCH 5/5] gma500: fix a missing break in psb_driver_load
Date:   Fri,  1 Apr 2022 19:16:04 +0800
Message-Id: <20220401111604.8106-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMeQTsYcyk9vRO6OaBi-KsptBzJ1Jh-2bOa0UW1+F+JUnDwH=g@mail.gmail.com>
References: <CAMeQTsYcyk9vRO6OaBi-KsptBzJ1Jh-2bOa0UW1+F+JUnDwH=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 12:10:48 +0200, Patrik Jakobsson wrote:
> On Wed, Mar 30, 2022 at 2:03 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
> >
> > Instead of exiting the loop as expected when an entry is found, the
> > list_for_each_entry() continues until the traversal is complete. To
> > avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
> > add a break after the switch statement.
> >
> > Fixes: 5c49fd3aa0ab0 ("gma500: Add the core DRM files and headers")
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> 
> This is incorrect. If we always break on the first iteration we will
> only run gma_backlight_init() if the first connector is LVDS or MIPI.
> This might not be the case and gma_backlight_init() will never run.
> The other loops you have been looking at have an "if (xxx != yyy)
> continue;" statement at the top which skips all the unwanted entries
> but this loop does not.
> 

Yes, your are correct. But it still need to break the loop when found it.
So it is better to add if(!ret) break; after the switch statment.
I will resend another patch if it is necessary.

> > ---
> >  drivers/gpu/drm/gma500/psb_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> > index 65cf1c79dd7c..d65a68811bf7 100644
> > --- a/drivers/gpu/drm/gma500/psb_drv.c
> > +++ b/drivers/gpu/drm/gma500/psb_drv.c
> > @@ -398,6 +398,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
> >                         ret = gma_backlight_init(dev);
> >                         break;
> >                 }
> > +
> > +               break;
> >         }
> >
> >         if (ret)
> > --
> > 2.17.1
> >

--
Xiaomeng Tong
