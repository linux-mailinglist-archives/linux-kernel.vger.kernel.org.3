Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E668E589643
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiHDCrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHDCrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:47:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E4E1EC7D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:47:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so589781ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AFsuAxQD3kY3e2hZMQh6bloiosEfd3dqKuiGbM7QIm8=;
        b=f+phZFfTIwMKL/IFWOnR/OTTG+wxA0xw2dAc9Vmb1VJjgeYiySb7lvFELkbBfAHlif
         7RbMBhfR8b50qDD8Zds8rEXg5g9NF4OgjjrGN7Ld8yaEBzgvTVadM+yi7xjf7kLK6q83
         YwvKK2eYOSOclBXICyjCVTL+j0wA+UO3Vi5X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AFsuAxQD3kY3e2hZMQh6bloiosEfd3dqKuiGbM7QIm8=;
        b=4xF0/O2abpZ15biMF47JxQ7uJ6Sg403/9q01Vt41aNqEzqTiScbk1Xj5+D0qMEA7AA
         RMXaraFixEocnKBYv7Y56T1PbGbhWVyx3rTc359n18ojAD0pdtTgknVIENdcJRzGhT4M
         Xz+I0LWg60JpWycM/sNFQdlbtx/lbN7ibp71naEUWgzOxK8MdAgImX4GPyRMmtn1XKDt
         gJtKPt2zq+AjfH4GLLxbmqt11ney/1CkRC3Audg9iM9AsMo77BD51JX71hiVlfNyVeGA
         1e1Igs8KPIoOOjOvqGngOKjj1bGtge+m6jq9iv792oGczbmkUsqFlpOLhWW0TlAtRJxQ
         +6JQ==
X-Gm-Message-State: ACgBeo2mKTQgACObSqdmz+e47aHnxZ/tHQGS00q0NKMKTmI8ao7CHzg4
        /N+3fOSvnvcZl3lQSwKcGEe1cVoilqZSVYE4
X-Google-Smtp-Source: AA6agR6AFODuQAXTgCXxCdFtsIktpN66ZKN+Wwq09LM2GVTPMgY6ZkIGmS1BwVfQuj8+hI9X3f651A==
X-Received: by 2002:a17:907:2707:b0:730:af0b:3572 with SMTP id w7-20020a170907270700b00730af0b3572mr4485021ejk.411.1659581235482;
        Wed, 03 Aug 2022 19:47:15 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ku26-20020a170907789a00b00730979f568fsm3053389ejc.150.2022.08.03.19.47.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 19:47:15 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id l22so23683318wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 19:47:14 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr17821619wro.274.1659581234519; Wed, 03
 Aug 2022 19:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
In-Reply-To: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 19:46:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
Message-ID: <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 10:38 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is a conflicty one. The late revert in 5.19 of the amdgpu buddy
> allocator causes major conflict fallout. The buddy allocator code in
> this one works, so the resolutions are usually just to take stuff from
> this. It might actually be cleaner if you revert
> 925b6e59138cefa47275c67891c65d48d3266d57 (Revert "drm/amdgpu: add drm
> buddy support to amdgpu") first in your tree then merge this.

Ugh, what a pain. The other conflicts are also due to just randomly
duplicated commits, with *usually* your drm tree having the superset
(so "just take yours" is the easy resolution), but not always (ie the
Intel firmware-69 mess was apparently not dealt with in the
development tree).

Nasty.

I think I have it resolved, am still doing a full build test, and will
then compare against what your suggested merge is.

              Linus
