Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD24BD180
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiBTUjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:39:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiBTUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:39:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6142C4504B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:39:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b9so15011529lfv.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKRB2WaBF2GQiP6qlxkilcBwOuI+2IkPQKIJsc3NqsQ=;
        b=SX6+NI65ZhEZjT0l+lz22ObM1ZRomNOXQVzcDjpB5YASTsnX4Uuq5t6Cet7vkOLXks
         aj3JuAWymCoQm7vmt2bwsxBatEGXFUsDHCXTKhDi7v5ho/LHIdE9nnZMOMw8fli5iDMi
         6FKTFvq4sD7aOtt89az18DgLMAcPVrsdyNxh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKRB2WaBF2GQiP6qlxkilcBwOuI+2IkPQKIJsc3NqsQ=;
        b=bY0jabPM7XGoIgf21jhiIKT/RiA7J6ttLzUwKXUarL3zmjDx9RKTOtER2EL2jWXjgF
         ByC5TEfvluitzoyec46VKQIrmciMdN4wG7T2N3Y9ONlyqYNLqMpt3bKXwuDaOyGNgtEB
         aRHNqhXmZk4C/nAVS6sztPqUabs2pgLWdRlP3rxzr//b6BZ7enOYtbo44+bmBpTBNdrG
         DJwsPLKLfdY7KExWcwGxaj9ttSdkMMq+c2pppOKBZwFlqvxzBJ40761/ODwmUgcKin4g
         h2bHFcqeqVdkx1xnUYtUc+8a/kf4B7v07o8AHbebMGnB+8ZALHw0PkZ03TMDNkFPGL/H
         WLTg==
X-Gm-Message-State: AOAM533sMYbmwqHYJPvUJo/773Juf9UjLdWViUk0abLvhjbgtClQa/Qw
        SDnFOmUGVR6uUHLq313GBVKmxp6PbzZXuYos
X-Google-Smtp-Source: ABdhPJyL1jrlNohak0kjM5ixte7RCBPyeT2spdN7/GiuSeDMNchNpHvnrW75vzrY/1hPuy6hPVs5lQ==
X-Received: by 2002:ac2:4146:0:b0:441:efd2:365d with SMTP id c6-20020ac24146000000b00441efd2365dmr12267151lfi.100.1645389568487;
        Sun, 20 Feb 2022 12:39:28 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u7sm907512lfr.282.2022.02.20.12.39.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:39:27 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b11so14962940lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:39:27 -0800 (PST)
X-Received: by 2002:ac2:4211:0:b0:438:2f1:83c4 with SMTP id
 y17-20020ac24211000000b0043802f183c4mr12074683lfh.435.1645389567567; Sun, 20
 Feb 2022 12:39:27 -0800 (PST)
MIME-Version: 1.0
References: <YhIq94B0MpYGrEm2@zn.tnic> <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
 <YhKj08BBnevqtbch@zn.tnic>
In-Reply-To: <YhKj08BBnevqtbch@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Feb 2022 12:39:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvy0h0WfT8g=6rfws75xB94+yuALtSY1Gpx0bvnOqTFg@mail.gmail.com>
Message-ID: <CAHk-=whvy0h0WfT8g=6rfws75xB94+yuALtSY1Gpx0bvnOqTFg@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC fix for 5.17
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 12:25 PM Borislav Petkov <bp@suse.de> wrote:
>
> Yah, where do I start... so, about this, I think I can simplify it by
> simply unconditionally aligning to 8.

Sounds good.

Then you could just do something like

        void *ptr = (void *)ALIGN_UP((unsigned long)*p, 8);
        *p = ptr + size*n_memb;
        return ptr;

and that would be a lot simpler.

> My gut feeling is telling me
> 8-bytes alignment should simply work on everything. Because if it does,
> all that crap becomes a lot simpler. But maybe I'm being too simplistic
> here and there might be a corner-case where 8-bytes alignment just
> doesn't work...

Well, if 8-byte alignment doesn't work, then the existing code (with
the fix) doesn't work either, so..

                 Linus
