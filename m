Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318714AD897
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiBHNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiBHM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:28:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8CEC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:28:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eg42so21333213edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NoHwUXlnI/2+4GtIY3B1wFAlk61LjWDTsV6HYfSmeLw=;
        b=jStChDdMyGG/3ayUzbTzNYlnwxLMllmGeEpkJs6CGf6RRNXXrXPhGDRdHajcPbEmqE
         H2DdMc34jqTdSGv+yO9e+d1+mcAZAwF0dv23gQg7pAlGRBFhHcNaiq4ABOqAXmmsuiqc
         zqjXzEnlHvvLUC1fv4wlOHsvBg14LJ1hMK0Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NoHwUXlnI/2+4GtIY3B1wFAlk61LjWDTsV6HYfSmeLw=;
        b=oeGoQwBfym5nrKhM2fdEsJEPVhu1trDG35IKZf+ZkP0vtgToJuAIURclHUDBHd93PW
         QlPaTcuGMBStlIWwjBl4V3rDZb/vZyoI1k+PQRmD8RwPB5f6eJnAKek1rHj55bUw0TB0
         bNA8Zt+NM0SfSha7bruwseFHlcveo3LMmendil8cmEs/vYdiMXyyyor+t+rITPCtdw9o
         rIiaVA86jBhgfUETBtsKzg+NjRVr+DPI9eXT9iiW92KQFutX7uPKGbvesQzMLKghfptW
         80p3kr1oI5Fx4HnZzVSSgoBoPXzv2dI7rv1fWKsPGMK6rmSTeB7SdsswKtJio5zdKxvF
         /Bkg==
X-Gm-Message-State: AOAM533+CQ2LgV57bMcawqDGMwCE+x9bcevtVYnUAWphcZuyFsKhAt7h
        8Gnq4L+joalM1WVFkGRFEpUsp9G/yR0nlA==
X-Google-Smtp-Source: ABdhPJz8CNq0yQJBtVXBnnXD7f1N+EwgFfAJSauIO2DyR45BhacerVDpgbvWItlXedF2YCVy901D6A==
X-Received: by 2002:a05:6402:1601:: with SMTP id f1mr4223183edv.165.1644323316920;
        Tue, 08 Feb 2022 04:28:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ee23sm4753981edb.19.2022.02.08.04.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:28:36 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:28:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, gregkh@linuxfoundation.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        jenatali@microsoft.com
Subject: Re: [PATCH v1 9/9] drivers: hv: dxgkrnl: Implement DXGSYNCFILE
Message-ID: <YgJh8kdz47wmZJxH@phenom.ffwll.local>
Mail-Followup-To: Iouri Tarassov <iourit@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        jenatali@microsoft.com
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <e04c8e820bc166d9d4fe8e388aace731bb3255b0.1641937420.git.iourit@linux.microsoft.com>
 <YeG6+Crv/Bg4h3u1@phenom.ffwll.local>
 <e472cbe8-44ec-110a-1ad7-bc561cd0be88@linux.microsoft.com>
 <CAKMK7uFkVvfXM7QsgSfP4OLk9b_cSwNsi3s3_7EFuL+Pa1s7eQ@mail.gmail.com>
 <deb33dd6-06c8-13c1-8d37-4c4f36248d96@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb33dd6-06c8-13c1-8d37-4c4f36248d96@linux.microsoft.com>
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

On Fri, Feb 04, 2022 at 04:35:55PM -0800, Iouri Tarassov wrote:
> 
> On 1/17/2022 1:35 AM, Daniel Vetter wrote:
> > On Mon, Jan 17, 2022 at 9:34 AM Iouri Tarassov
> > <iourit@linux.microsoft.com> wrote:
> > >
> > >
> > btw another idea I had over the w/e: Another option might be to allow
> > different backends for sync_file, and then making sure that you cannot
> > ever mix dma_fence and hv_dxg_fence type sync_file up (in e.g. the
> > merge ioctl).
> > 
> > The issue is that fundamentally dma_fence and memory fences (or umf
> > for userspace memory fences as we tend to call them) aren't
> > compatible, but some of the interop plans we have is to allow stuffing
> > either of them into fence container objects like sync_file. So going
> > that route for wddm monitored fence support too could be a really
> > future-proof approach, plus it'd allow you to still share the
> > sync_file interface code. Not that it's going to be much code sharing,
> > since all the implementation code needs to be distinct.
> > -Daniel
> 
> Thanks Daniel!
> 
> I will remove the patch for dxgsyncfile from the next set of upstream
> patches.
> 
> It will be added later after a re-design.

Yeah sounds like a good plan forward to not hold up everything else
meanwhile.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
