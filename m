Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C24E798C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358673AbiCYQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345009AbiCYQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:59:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D303ED0F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:57:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so11078463ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZX8culL+JDO4Nc+K2yxFStMUus86MuvCh6ZDifZHuY=;
        b=bE5YQfo7x1YUkEwmvW7edsZltdmQNA9wxygDXSGMDVRtbypb4mwIAuitcyECnMP/5b
         fhF8W+gIIIVnZRVx+s2MD3p4PJSJji9VjCI632PESuQjr259PVC/2Jtr7BR/ixQBCd9r
         Si8TVHAN6MaKgSRz4NBNP+arKbtUAbXSlFSws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZX8culL+JDO4Nc+K2yxFStMUus86MuvCh6ZDifZHuY=;
        b=ouKh/iLEz44au60BQdK/ZKKz22AagIcVMfTOCBtUIt98bbnSvmVTovoT7Q6FCBcL2P
         HNhkZTl/PXGg0Oaq8ianfDn2D0gB7aOKroWU6avdqhPGJWqfNKEPM/kk0tEG7MStmybs
         H2rErONSgU9XUwHbQ3fFTIWuzhKrzRez33wYqfJCnPx3BFCQnKGs3wQv9T3I2Ogzac1f
         E8+ylaTOseETw7aF0XwDbqV7ygCopRzk/OTjTRH0R8crASa2Jw2SexCnijVUdXPYImqv
         clwPDXkQxmU/obrgUAnMRGzcmWb7U2dSW4qDEn2bMZ9MKLsL+FjuBUuK2GK6Nr/hyvj0
         fEbw==
X-Gm-Message-State: AOAM5325hSfZbnSWNatkoxgHD0ar20AX4MqTN7IILH5jkBvs+yRpD9MY
        BUUL4CyEokgT47BI02FKDIW5MUGTZyVBgMrqvy8=
X-Google-Smtp-Source: ABdhPJzMrCICuabeOhfyc1FF02uYWeZpG45iw/uFXZ2rhoSvIs+GdUSIgC5FmPXdz0Aued8xWqPQ5w==
X-Received: by 2002:a2e:9c04:0:b0:249:3cc7:48a1 with SMTP id s4-20020a2e9c04000000b002493cc748a1mr8787014lji.413.1648227443330;
        Fri, 25 Mar 2022 09:57:23 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a25-20020a196619000000b00449f4894887sm760506lfc.288.2022.03.25.09.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:57:22 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id t25so14380816lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:57:22 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr8385952lfh.687.1648227441988; Fri, 25
 Mar 2022 09:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220325154848.107863-1-jcmvbkbc@gmail.com>
In-Reply-To: <20220325154848.107863-1-jcmvbkbc@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 09:57:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJH3dgztETpQ4CaseA+j9rgbk0XP_yXDGshmQxAh3RKw@mail.gmail.com>
Message-ID: <CAHk-=wgJH3dgztETpQ4CaseA+j9rgbk0XP_yXDGshmQxAh3RKw@mail.gmail.com>
Subject: Re: [PULL 00/18] xtensa updates for v5.18
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>
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

On Fri, Mar 25, 2022 at 8:49 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> (btw, I've noticed that github removed support for the unauthenticated
>  git:// protocol. Should I send pull request URLs using ssh or https?)

I suspect for consistency, using https:// is the way to go.

I'm a bit sad to see "git:" go, since that was visually such a good
marker that it's about a _git_ server, not some random web page (and I
rely on the signed tag, not on some https thing).

But from a technical angle, I guess it was inevitable. And git is
everywhere, and 'github' certainly makes that "it's a git repo" part
obvious anyway, so.

                    Linus
