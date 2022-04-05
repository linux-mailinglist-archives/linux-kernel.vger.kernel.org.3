Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4914F51F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848958AbiDFCbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386454AbiDEVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:50:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E910C531
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:54:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w4so256649wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NHEHnuZ3EwIt6oRfVHzwUDeTZ1Be9ZvXyD0BUY2xlM=;
        b=dMIxaOA+PwGmGbUBgSF+BtNgTUc4RKGxiEJxcOGGW41WPS35KSWlB4hv7i4DbpxOGC
         ZH1S+U4+vSggXY1XAGmMMGqiGDAAFbM1TiIfR+O950jkhP22hrN5zpqEUFn8ZJUif7W1
         UT9mutnETTYpsxdjQi923ezsNRj0CTq+AgkAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9NHEHnuZ3EwIt6oRfVHzwUDeTZ1Be9ZvXyD0BUY2xlM=;
        b=OWMvk60gBmzPIhQzdeNDQ0khF8GvvxrWUfyowoXwkkz00Ze75Lr3my4O524lu+9Xxz
         vlX4f9E3hKbdSBG2eWSC65oaiMY6jzkht1fmXI5nfLeWfX/vItQkTMC5SSpInYW23x1D
         Wo43CgWD1q1oQk1GA+GTUwY8SdSB0c19tcg78AOke1g1fybj8jXmPtjp/YDDIp4C1F0B
         ve15jYVQjhDNhYhjpKq1PPHrUoeG8Axclo0td204pITLPSyMol9Ub9S4L8CReiO2kZEO
         6boMZZtBaxjgs1j7IMPFPZOn93UrkjdVLngi6D1POf1131GUeNXFYYFt1lEp6tlHRk/V
         31bg==
X-Gm-Message-State: AOAM531EFLZzeF5IAsMw3tdSU3yhiCMTmrRYXh/8aqEkjCKqoiU74i9G
        bO6mqK8seWCF73IDGWDT82PmAg==
X-Google-Smtp-Source: ABdhPJyhXpgIjQQcv0SKxB4ADopYBn4Ma33nCG5hGhtlwq04P9w9qJQ0mEskhuSP+q2j89By5mUeGg==
X-Received: by 2002:adf:f24d:0:b0:206:96b:4ea1 with SMTP id b13-20020adff24d000000b00206096b4ea1mr4059467wrp.694.1649192093853;
        Tue, 05 Apr 2022 13:54:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s1-20020adfb781000000b002060d4a8bd9sm8008923wre.17.2022.04.05.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 13:54:53 -0700 (PDT)
Date:   Tue, 5 Apr 2022 22:54:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 06/19] fbcon: Use delayed work for cursor
Message-ID: <Ykysm3EJd3XLrzyr@phenom.ffwll.local>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
 <7f6d61f4-042f-8c9d-23ed-da6f1dcb20d0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6d61f4-042f-8c9d-23ed-da6f1dcb20d0@I-love.SAKURA.ne.jp>
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

On Thu, Feb 10, 2022 at 08:43:36PM +0900, Tetsuo Handa wrote:
> On 2022/02/09 6:08, Daniel Vetter wrote:
> > @@ -714,6 +700,8 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> >  		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> >  		if (!ops)
> >  			err = -ENOMEM;
> > +
> > +		INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
> >  	}
> >  
> >  	if (!err) {
> 
> Memory allocation fault injection will hit NULL pointer dereference.

The error handling here is convoluted and I got this wrong, but a later
patch to extract an fbcon_open() helper fixes it. I'll fix this small
bisect issue for v3 anyway, thanks for taking a look at the patches.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
