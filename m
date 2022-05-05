Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299AC51C008
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378413AbiEENCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbiEENCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:02:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF054186
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:59:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id be20so5077655edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdtdiuvZ8kL/hgc8dFK7GV8wDG6uaaKHXPWtyIXxhtg=;
        b=hXZ/pDovQSXNRx0IAnf+JAJh1h4umCs0GjzgB8qyT2sucQ6vbTH2Q+39inblU4gakn
         IzvRFdCufYweWPtGblHPsek8a2h/hJTuIlz34KfTJdFe6mtty2eOqXZb6oapAx2/iphd
         ChywpfpQhtj6kqglK59hJ6BWcHDmZSTO170x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TdtdiuvZ8kL/hgc8dFK7GV8wDG6uaaKHXPWtyIXxhtg=;
        b=VvV+VnIcu+OE3c0yezpVBvf7O+I/Wwb4dHSLeu92g1jkQ+BDUJSU+MVlcICpgAzEzS
         B2GMDsBAJwTUN107Kj3Jm4ulj04fUi1PVTLQyX81YK5LjmNrJ9DMkt28wSeCGbLZg+eo
         klAcUKrbZ035srkQmGhxK1FBSt+wn2dy6NL9YD47i74/SfkgsEivno3W9Cb/fCaXZpGk
         tgQraTyj+Fut+KzW6Bo/WjNdw2dftYmkuw9ZGntKdc3j/64cBTDBmkv5j2Ets3g8tydQ
         X+768dPcuJSki/o1JbI3EHRymZudIwkzGvQw2HYvju/mA1aH/7ND83dIedZ5KAWzJUn+
         em/A==
X-Gm-Message-State: AOAM531ShGMUXtqaq+71lcle7auTghCwITjkhK/jWIU9t50acTEreehB
        lmPcvzjw4xWL3axPzbeNj9sZlA==
X-Google-Smtp-Source: ABdhPJyBYRoJ02j5Poqwbjoj0TCy918qe43XGFiHPEv1dUFaRY/4oF+mvaYj1nSndvSIV9S23+tVog==
X-Received: by 2002:a05:6402:4396:b0:427:f2dc:b11 with SMTP id o22-20020a056402439600b00427f2dc0b11mr13167491edc.298.1651755542198;
        Thu, 05 May 2022 05:59:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j1-20020aa7de81000000b0042617ba63b3sm774202edv.61.2022.05.05.05.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:59:01 -0700 (PDT)
Date:   Thu, 5 May 2022 14:58:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Message-ID: <YnPKE+6DE12IsOj4@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
References: <20220503071540.471667-1-javierm@redhat.com>
 <20220503071540.471667-4-javierm@redhat.com>
 <YnJcaaDcIsJKhSwQ@phenom.ffwll.local>
 <bfb03d40-a023-12a9-9554-1b6e6c474134@redhat.com>
 <YnO+8hZ0ozPaZUEj@phenom.ffwll.local>
 <47d3a7f6-24f9-7d54-48bf-09ab9e40e2de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d3a7f6-24f9-7d54-48bf-09ab9e40e2de@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 02:45:27PM +0200, Javier Martinez Canillas wrote:
> Hello Daniel,
> 
> On 5/5/22 14:11, Daniel Vetter wrote:
> 
> [snip]
> 
> >>
> >> And while I agree with you that these midlayer flags are horrible, that is
> >> what any other fbdev that makes use of a firmware-provided framebuffer set,
> >> so simpledrm emulated fbdev shouldn't be the exception IMO.
> > 
> > So we discussed this a pile more on irc, and at least my take is that
> > people who run simpledrm but want to combine that with fbdev drivers and
> > expect it to all work nicely we can probably ignore. At least until all
> > this sysfb stuff is nicely unified, and at that point we shouldn't need
> > special flags anymore.
> 
> I'm OK with this take and happy to just drop this patch-set then. My worry
> was just that someone could complain that we broke their uncommon setup [0].
> 
> [0]: https://xkcd.com/1172/.

Since you have to explicitly enable simpledrm and that combo never
worked, we did not actually break anything.

Me, who has over a decade experience legalesing around the "no regression"
rule :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
