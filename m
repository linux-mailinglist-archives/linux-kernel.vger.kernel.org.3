Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3850D658
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiDYAkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiDYAkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:40:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1ADF64
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:37:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j17so13359557pfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 17:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6WAtvklsUKA06wcIGSL+bg7XAfQhE1gnb2a05Si+7ow=;
        b=PYixxGcobOKST4trI3fsX1WFc0saiM1FlayMiR602AaecPGGhIOBsDHe16GslXv90e
         nyp2/IQXFVRyE1hbcVEo5D8bDFEtSY2YIjb5ITGqEWmhYIRLQUfE8jLK7H8Jy5gcgjAw
         1VwacoE8WQjbzaAuEFjmt+zWQOl0QCKYyKTLYDaF8FTkLWr8xcEQnEAl7z+7PDCRfX9r
         tnPsA+6zLvPuqGRygLlrI2jwno6A2xxBV80JFsjcWK1ruHdrcoYNTZorih+GP+UrolMV
         vIbjSLm9sf2a1B8oSoIXowchZQt3Etz3izbYteO4SzbeBRSbBKy5OsJe9Z4Yo8eLf4Bt
         1d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WAtvklsUKA06wcIGSL+bg7XAfQhE1gnb2a05Si+7ow=;
        b=P0iK4oYp9rgWMl1wEP8hvHnRs0FHq74Xt3KHWm2ObixzWQPV3aXABbXx/r6tZMMm+z
         XK7jP8IWbREDDjLBBempgGwbKREe4woQH+fngB+Jcn9NtYIg5+RAkajYs9yMTHDpBOs9
         xh/8T37Pihq9psT/XB2RpdrXdzf4gadbIXdEE93eVUKT4lY8hnKaHHDihdWnFDZKcZQP
         OdKFQ9MZZ87+dB31reKYmjKIgR0WidvxIdU9USzzfN2xc6kjz6UQ7QGvpbPNahKWzop3
         Qrg3kO3XOO2tOwGiXjPlWoPpsxiwck6RRh4tl4GD1XJuLVmKU8DAH6b8lDnHHAS4fRW0
         dILg==
X-Gm-Message-State: AOAM531bz9QE/yWto6ozYQL1NkUHqSdAzq3yvKb1Dcf1MVmZ5npqpssd
        9z3yCeHEvQoiEd+l3+6c6uE=
X-Google-Smtp-Source: ABdhPJzg4uTWT2VuhM5YxjZ1Teo1lBnOgjKQUGUsl4L9lLreTWuTMqAsFXXPXiX8QBW7v+VLlY38cw==
X-Received: by 2002:a05:6a00:e0b:b0:4fa:a167:5b35 with SMTP id bq11-20020a056a000e0b00b004faa1675b35mr16267283pfb.69.1650847057156;
        Sun, 24 Apr 2022 17:37:37 -0700 (PDT)
Received: from ArchDesktop ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090ae39700b001cd4989ff61sm8856969pjz.40.2022.04.24.17.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 17:37:36 -0700 (PDT)
Date:   Mon, 25 Apr 2022 08:37:33 +0800
From:   Solomon Tan <wjsota@gmail.com>
To:     straube.linux@gmail.com, paskripkin@gmail.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] staging: r8188eu: KASAN: slab-out-of-bounds in
 rtw_cmd_thread
Message-ID: <YmXtTeEGVDPrx9d7@ArchDesktop>
References: <67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com>
 <YmU+cqEZfrGz5XsT@ArchDesktop>
 <c2296090-2e9b-fafb-35da-e01b025b53b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2296090-2e9b-fafb-35da-e01b025b53b7@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It looks like
> > > commit 0afaa121813e ("staging: r8188eu: use in-kernel ieee channel")
> > > intoduced a. See KASAN output below.
> > > 
> > > That commit replaced the use of struct rtw_ieee80211_channel with struct
> > > ieee80211_channel.
> > > 
> > > There are several calls to memcpy that used sizeof(struct
> > > rtw_ieee80211_channel)
> > > and now use sizeof(struct ieee80211_channel) but the sizes of these two
> > > structures are not equal.
> > > 
> 
> drivers/staging/r8188eu/core/rtw_cmd.c:276: memcpy() call.
> 
> As Michael said the sizes of structures do not mach and the memcpy writes
> below allocated buffer.
> 
Thanks Pavel.

Hi Michael, I could not find the cause of this issue, and I am afraid I
might break even more stuff if I attempt to fix it, so I have submitted
a new patch to revert my changes. Sorry for the inconvenience.

Cheers,
Solomon
