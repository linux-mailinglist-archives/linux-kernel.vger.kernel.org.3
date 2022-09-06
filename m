Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7965AF251
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiIFRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiIFRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:21:11 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DA83BCA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:10:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127a0d798bdso9284642fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RzrA7ZBqVYMtFibz+PW8VCdXaj2t3XdsPwt06YL85hI=;
        b=UTjgO6GvV4ki/VbfOVVNw+OD38IBtEz+scRoNXxg6ENaDmVLP3vZfH3zrGpDwMTEIu
         0bv1+umxmtvjSnBXt0EdHZFt0HmjdceNXvwcPXIlqw1fkEQdfyc/76126TBXM9xIcMu9
         jg41E2FJzPGWvYAp8eumaYKQxMEW/E9GAOOy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RzrA7ZBqVYMtFibz+PW8VCdXaj2t3XdsPwt06YL85hI=;
        b=CVVymlSpwcWLr7jwQYr8+PTJJZMjOqsSj/Kw97nUTyAjkASuVlxf84JOWEZXcSP00C
         XBeiQGynCFSbd+dw1a65BymE3SNjfvuqB7MdUgY1RaZltvnkCICc2S5P1vJjAn312ynW
         sa+WcCNyO8h3QO0z9DQJbdDlC648pWaCqSTLez3o71todHKiLBeEjVEjhVPeghszH4La
         rqz8uVGgfTJ4GFDJOwWNo65ESanYoq3SDN9MoiHOzrNqOeEO3qdu7PgBo+EWmyauC3uk
         P9CI3XtyaWznKFFWWx0KD3C9QTAoNamrXnHPVPPECNDTBBXfhviOfNRtN5YKSQ9MiNPm
         7dYg==
X-Gm-Message-State: ACgBeo3sCOsikjV1lmr+mZkHhmtg/l++XTFO7CHomh8jo7htpdssbYB7
        wtYS0enpGbWf1mJo4/974dMzZllx+FQhyQ==
X-Google-Smtp-Source: AA6agR4QRyOljOvclqghhoYyTdj9mmrpOXlDbc6EWL/vse5jeChi9XKGx++XBRHP+ndcANrMtiVDRg==
X-Received: by 2002:a05:6808:1183:b0:345:d23f:9276 with SMTP id j3-20020a056808118300b00345d23f9276mr10438645oil.43.1662484201243;
        Tue, 06 Sep 2022 10:10:01 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id b11-20020a9d754b000000b0061d31170573sm6193613otl.20.2022.09.06.10.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 10:10:00 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1279948d93dso9942338fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:10:00 -0700 (PDT)
X-Received: by 2002:a05:6871:7a4:b0:11e:b321:c396 with SMTP id
 o36-20020a05687107a400b0011eb321c396mr11686290oap.241.1662484200169; Tue, 06
 Sep 2022 10:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220819155059.451674-1-gpiccoli@igalia.com> <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com> <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com> <YxDhiSDs4YcUrqV5@kroah.com>
 <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com> <YxD56RTI9v/P2QOL@kroah.com>
 <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com> <YxEBCVRgWE8VTZaf@kroah.com>
 <794efe45-2fef-0d3f-b6d0-f2f451be850c@igalia.com> <20220901151320.3cff1767f88cfb33f394e9cb@linux-foundation.org>
In-Reply-To: <20220901151320.3cff1767f88cfb33f394e9cb@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 6 Sep 2022 10:09:24 -0700
X-Gmail-Original-Message-ID: <CAE=gft7bZ0DaX3YuVq4BgruC3JFSBvO=NQsak=K1cM3qh1qJww@mail.gmail.com>
Message-ID: <CAE=gft7bZ0DaX3YuVq4BgruC3JFSBvO=NQsak=K1cM3qh1qJww@mail.gmail.com>
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to avoid lockups
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel@gpiccoli.net, Ard Biesheuvel <ardb@kernel.org>,
        David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 3:13 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 1 Sep 2022 16:02:08 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
>
> > On 01/09/2022 15:59, Greg KH wrote:
> > > [...]
> > > Ick, I don't know, this all feels odd.  I want someone else to review
> > > this and give their ack on the patch before I'll take it so someone else
> > > can share in the blame :)
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > LOL, that's OK for me! Evan seems to be fine with it BTW.
> >
> > Let's see if Petr can jump in, also adding Andrew here since he's
> > usually merging stuff for panic.
>
> Are the usual gsmi developers not operational?

I'm unsure who that is, I sort of Mr. Beaned my way in here having
touched the file recently. A lot of the people who historically
touched this file have gone.

>
> Patch seems sensible to me, although the deadlock sounds pretty
> theoretical.  A better code comment might be simply
>
>         /*
>          * Panic callbacks are executed with all other CPUs stopped, so we must
>          * not attempt to spin waiting for gsmi_dev.lock to be released.
>          */
>
> ?

I basically came to the same conclusion as Andrew. It seems like this
patch does fix a problem, which is a panic coming in on another CPU
and NMIing on top of a CPU doing a normal operation holding this lock.
The problem seems pretty theoretical, but I suppose I don't have
numbers one way or another since any attempt to gather numbers would
be reliant on this very mechanism. My Reviewed-by tag is already on
there.
-Evan
