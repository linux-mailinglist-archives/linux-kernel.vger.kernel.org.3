Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46B84E452C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiCVRci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiCVRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:32:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF823BDF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:31:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bn33so24935988ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgcgyCIbWUTOoVOlIFHHmtoodCzEMkbLy9TNN/VAosg=;
        b=naptp6Dpy+85YfyC34kaFusYQmU1UYYJb1v0QokmAZ/OC156PjQKVkMdUdnZTFP3pI
         9BLeqi/l8Szf7/x+NC+k5zOh+OaHrPK7DQVvX7j1X0ddioyzwX172ho1EW4NU6uncyhz
         6hpurP0vHYti9dft5+IoDbp9NQlUEAYI2/a39CHcgLqA1RcSjTKP9PVz+JaUxurX1o/i
         dQcF73IPVJJzlJNzFBqx6dgxQ1rdRuNZpa95I9GNHyCn5URu2yNMY5c3IULf0R4b7K+L
         z/d9txrBGCP43dBC1XnY0T22CnvkA+y2QQlGIZczuT0NmwRQnJAl9O15bUplsLBFEHSZ
         QB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgcgyCIbWUTOoVOlIFHHmtoodCzEMkbLy9TNN/VAosg=;
        b=TLVzASgMDCxzqFuSRH4KlQyw2foBx9oAkzNnMkeN0M0meQUE/zWf/cCIidroFDNfFX
         VpBfmJSg0HJJsPph6NALJwKGYP7MuW0l3K0mirapYQFAKgaRKWEbgHXgkA+H63cr4Jar
         x2J5JCBw0iZ/DC6tcMCH8lCTrGL5E34Kk6ewB4VW7bsJNUHOfpB3UJVLDu0Hf2WFIr4g
         X6t7oA0sxspriKEm4rbkUltgjhoU8vmA3aDWp0dtO7J77GgBMYx9daJzkESPbcoucY/9
         SVI7+TYQEwAMGGdEhs4ecAo27knt9hzUqC0Pcnd+HzscuONuWZnYinT3VXbwz3FjM5e2
         /0vw==
X-Gm-Message-State: AOAM530RYomd9WU1DLEQ5kg2awJwSHOo7atqmXB6UCYo6kYXnZXofNIK
        SLH+LEJL/1BupnHvD1JrDMENsQHyIz27YneRTLIlUQ==
X-Google-Smtp-Source: ABdhPJz+tT+vwRLT/un0YR41TNqqDOomNEbU0yM8lSArWPNncnylHvc5h3OSavrgElwizaqHJQOJc6w3u9B9x4FLPeg=
X-Received: by 2002:a2e:8692:0:b0:249:a0b1:3c77 with SMTP id
 l18-20020a2e8692000000b00249a0b13c77mr93511lji.235.1647970265022; Tue, 22 Mar
 2022 10:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-3-ammarfaizi2@gnuweeb.org> <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
 <20220322172550.GL10306@1wt.eu>
In-Reply-To: <20220322172550.GL10306@1wt.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Mar 2022 10:30:53 -0700
Message-ID: <CAKwvOdmr6u-zNynUDAg4pmwerQFUkG+eD0QhpzDED9eg+U2pfA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/8] tools/nolibc: Remove .global _start from the
 entry point code
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Moving folks to bcc; check the lists if you're interested)

On Tue, Mar 22, 2022 at 10:25 AM Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Nick,
>
> On Tue, Mar 22, 2022 at 10:09:18AM -0700, Nick Desaulniers wrote:
> > Then again, I'm not familiar with nolibc.
>
> No problem. The purpose is clearly *not* to implement a libc, but to have
> something very lightweight that allows to compile trivial programs. A good
> example of this is tools/testing/selftests/rcutorture/bin/mkinitrd.sh. I'm
> personally using a tiny pre-init shell that I always package with my
> kernels and that builds with them [1]. It will never do big things but
> the balance between ease of use and coding effort is pretty good in my
> experience. And I'm also careful not to make it complicated to use nor
> to maintain, pragmatism is important and the effort should remain on the
> program developer if some arbitration is needed.

Neat, I bet that helps generate very small initrd! Got any quick size
measurements?
-- 
Thanks,
~Nick Desaulniers
