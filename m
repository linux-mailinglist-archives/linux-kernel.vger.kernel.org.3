Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0638489DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiAJQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiAJQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:48:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197A7C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:48:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o6so56057743edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1as2ORVFGAUPz82GACIBpegMjn+JCuCyTRlbW8CfXN8=;
        b=QFtyR/r9smMnqiKzjW9tRSQpEdzB65FWrdr0jE+xD+pxb0PYYJhdBEot8djPPLnEtn
         Axgwkc+vukNyahS9U3cmNi8OJhE+ZSddUqFMIpBIFpPv5v0ZhZhI+skhCfH5Mqsf0bLN
         WxiqSn1daWffv/HhOKs+KLh8svAYUWUBYXP6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1as2ORVFGAUPz82GACIBpegMjn+JCuCyTRlbW8CfXN8=;
        b=tQO7Za6utiI5GBKhS9KV7uz5xzxLIzxVm5XqUtW+AZ7QkSekJVRyYJduML1kU5U9Op
         lgPv8NoQgzk+kmAQlIpSxOIdwsr4a9GLRm+KuXhFDr1cXQW6guOdQnhu4B+OCdjuBeMr
         8PwNaC9w/D9VLwggf+qVfh1aW2ajEDzDLNIsCR3IAnSd0Yfv76nRKPnFEbJLMRWhNBaj
         Uk/GCN8ATuFl2CmvEPiDJsRg1TzH5dbAVebEYo0RfcEOMJPRXDiy+fPcCLthziFtmY00
         QUl2zKJNNf2k+hGlH9KhFigLn3loR+1cE9zF+GIaY9UDaMjVO2E3FyCDUpqDD4b2fn//
         U4ZA==
X-Gm-Message-State: AOAM532dCIGYOZ5cJIICUkxT8Aq/bcEAVfX1N/oDvBlQPdncju2kwocd
        BQS/ff9LaGfOgwXuhtQbDRDePtY1NId6A1TmYcY=
X-Google-Smtp-Source: ABdhPJzJ9IYRlYqeXur+7/+4M6StSRKT59aI5HpQ6jPsoIKZg9N/tKv5RfbXJa6LKONefOBVlD1CcA==
X-Received: by 2002:a05:6402:35d6:: with SMTP id z22mr510129edc.334.1641833284455;
        Mon, 10 Jan 2022 08:48:04 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id o3sm2612876ejm.77.2022.01.10.08.48.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 08:48:04 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id v123so9196308wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:48:03 -0800 (PST)
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr19704237wmz.155.1641833283772;
 Mon, 10 Jan 2022 08:48:03 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twJOj8+cfEPArF7N_TZpVM8vN+S4s2mMM7phsS-ZOgmJA@mail.gmail.com>
 <163789349650.12632.8523698126811716771.pr-tracker-bot@kernel.org> <CAMuHMdXEKbc9ovGPqtO8v-xRCoSKF=KZ-53g+7vRKnDZMCmeGA@mail.gmail.com>
In-Reply-To: <CAMuHMdXEKbc9ovGPqtO8v-xRCoSKF=KZ-53g+7vRKnDZMCmeGA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 08:47:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgWQ0mYz_yt9cn3KDr+6eQ5F3wvJ_cGp-E3A5PW+aeuuw@mail.gmail.com>
Message-ID: <CAHk-=wgWQ0mYz_yt9cn3KDr+6eQ5F3wvJ_cGp-E3A5PW+aeuuw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.16-rc3
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 11:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The commit that merged this branch made a seemingly innocent change to
> the top Makefile:

"Seemingly" innocent?

Or something darker and more sinister, related to the unrelenting
slaughter of flightless fowl?

You be the judge.

             Linus
