Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44A755E9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiF1QfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiF1QeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD32AC75
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:31:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c4so11531101plc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cF+v3xaxVEy+SunxyV5FbyGgHqR8srXqFsaqFoR1tTU=;
        b=Tb/AbhsmkTF7L1MJTGV0JTBgTb/yNK3WWoLZ7cxqxeX0H40RWvO2doFYqpmty5HW4c
         ahFhGrzB5cEduL5dW4ye6mnhLsns5ytFNgb5mJTII1gAaHg/bUzoYdiw1q/f2/stV8DS
         AnA2CQaXiTGHZoZ91WwVazQfM95SbI0OsdBROcUoo14G3RU4bMRLKbm8WGm7pVYS5y4a
         09vrVF3mPTahGEch3yZc4GmUV9uUdlcMzms0cFgRGPmDRvfXvXwf2yym96KH10VNb7NY
         Dto0Z66BEsEsaRc6+vT+XP+yNbN0QUD5yNkMC6ft09AL7sc+M5BEhoDa8em5isayK9GU
         0jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cF+v3xaxVEy+SunxyV5FbyGgHqR8srXqFsaqFoR1tTU=;
        b=7X+Jde15OHpFwvyc/X0y8rJoGSrokMI5HvTAAEBq9++pC8x1gWNSwyWmZqoX+0eOSC
         2UxMiVBKx3qg0uh+Y8HA/Bih32fAp5hE/moC8A+v5OxDJAW82rJN8zYSePgHaxx+K5J1
         avn/qnApir0jj5XY22yKCG8y6IbQW0pKtzAp5tWWim1oCUkc2UXEM+80xyfD7+D4eOjM
         kXLo6BnYTl8mTYSjqUOvbnwyA0uJnCJkleO2rfEYBs6LZd4pX0f+m5ReUXf5nIZ6to6P
         3SLyXdi43Jjo9QwJ5vegIsYQenl6s7B75RRSYMRlX+pfSeolr4aORYN+FRpjVIf5aEul
         QFmQ==
X-Gm-Message-State: AJIora/FtXRMFBKC4gZSP+myApBvmyfLuP3Xtnt3QU88j49NmlAHmrDg
        glhq1DtVox780BSzmeuzn8AhjBwd0HBkaQ==
X-Google-Smtp-Source: AGRyM1vjZ+5N/f77O5qPXoiVUX4pJGxwAQyaaZJRH8JaYvnupRlQYS0vdL1n6f3pazJlx6c2NeH+PA==
X-Received: by 2002:a17:903:1c4:b0:16b:7928:95ce with SMTP id e4-20020a17090301c400b0016b792895cemr4459758plh.158.1656433870761;
        Tue, 28 Jun 2022 09:31:10 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902cf0300b0016a0ac06424sm9576140plg.51.2022.06.28.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:31:09 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:31:07 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Message-ID: <20220628163107.GA1942439@p14s>
References: <20220624024120.11576-1-hbh25y@gmail.com>
 <20220624173621.GC1736477@p14s>
 <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
 <CANLsYkzT5ZROReZNQ_eYL-r49ijaZYZ5TzdMpqy1RK0_hvW3_Q@mail.gmail.com>
 <0bbee169-6fdc-b50e-87f7-1551dac821e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bbee169-6fdc-b50e-87f7-1551dac821e2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 09:40:36PM +0200, Krzysztof Kozlowski wrote:
> On 24/06/2022 20:43, Mathieu Poirier wrote:
> > On Fri, 24 Jun 2022 at 11:45, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/06/2022 19:36, Mathieu Poirier wrote:
> >>> On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
> >>>> rpmsg_register_device_override need to call put_device to free vch when
> >>>> driver_set_override fails.
> >>>>
> >>>> Fix this by adding a put_device() to the error path.
> >>>>
> >>>> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
> >>>
> >>> This is funny... Neither Bjorn nor I have reviewed this patch...
> >>
> >> It was a fix for commit in Greg's tree and Greg's pick it up after a
> >> week or something. I am not sure if that's actually funny that Greg has
> >> to pick it up without review :(
> >>
> > 
> > The patch was sent out on April 19th and committed 3 days later on
> > April 22nd.  Is 3 days the new patch review time standard?
> 
> Neither 19th, nor 22nd are correct. The patch which you set you never
> reviewed, so commit bb17d110cbf2 was sent on 29th of April:
> https://lore.kernel.org/all/20220429195946.1061725-1-krzysztof.kozlowski@linaro.org/
>

Twitchy fingers... Those dates are for commit 42cd402b8fd4, which is referenced
by bb17d110cbf2.

The end result is the same, that is patches related to the remoteproc/rpmsg
subsystems (or any subsystem) should not be committed before their maintainers
have the opportunity to review them.

> And committed on 6 of May, which gives some time for review. Where did
> you see the other dates?
> 
> 
> Best regards,
> Krzysztof
