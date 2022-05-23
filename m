Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03D1531A90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiEWTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiEWTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:00:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995232AEE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:43:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gi33so22185701ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rqd+dwf+o28j9cD1SOa4++fQoDxaCVHWSd5lq6Ofpw=;
        b=NDrlZn2n1LAZsCQDcjGtRbSKEQfx4gC1f0GlNC/UNJfuFHlCVqjpfoArT81uoCTJs4
         uD6/3GH9fzt4yFyc+/MrDu2na+cSJ4Lk8D1W2ruCxOgWuJWBdCr1f5O/C13iaxn7KbUH
         whUAxZvwxOnGwZSnZrVD0mBDR2mOEnyMnLPks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rqd+dwf+o28j9cD1SOa4++fQoDxaCVHWSd5lq6Ofpw=;
        b=iJAKlGCH9IK+IcrCjJkrrvDhV6iJvtkln0iADTmGRu7B5nDQrd3rYM8v54ENiNfVwA
         QC/eni/5s8PQNk1NS4YQK2n3NVEnYzNRfJzwZ7hwrRZe7qHM/byQd5cziwm8W9g0WPS6
         17aorfT4ffD6/OGL8W1Tqkw8jt8DqcdlQksNqOTJl5Qz1ZwzQvTaDnmrIR04h4pZ7GEg
         X5P9bk97oLiWvX8KneCve/Sps7jDyAalsKhzOvS3ePjUrmiRQ4WieOUb2EeZZ+b/lk7L
         zPhDM5Ya/vrNiHfeGdnTZp83QxD19tbUzyvfhp9yF9z9rubBcENS+9hYKQugwPSyl6ya
         sZrw==
X-Gm-Message-State: AOAM533tZ4m4GkAQt2heSulkJj6f4X7mzhpCAucfpDdecmjICJScZmPL
        L381uae2NKAAsFu8YFLH+XzAAHKkAbPYRrT2A04=
X-Google-Smtp-Source: ABdhPJytwUhcwxzFmXf5yU2L5hKJYQT7TRo+5vfNzIe8bCV7csnB3ccp8aK38brTR2U2d4gXOsOOOA==
X-Received: by 2002:a17:907:9725:b0:6fe:fce4:e08d with SMTP id jg37-20020a170907972500b006fefce4e08dmr2126444ejc.657.1653331386052;
        Mon, 23 May 2022 11:43:06 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b0042aaacd4edasm8598619edt.26.2022.05.23.11.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:43:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id p10so3990266wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:43:04 -0700 (PDT)
X-Received: by 2002:a5d:5484:0:b0:20f:bf64:cae1 with SMTP id
 h4-20020a5d5484000000b0020fbf64cae1mr13120993wrv.281.1653331384569; Mon, 23
 May 2022 11:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 11:42:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
Message-ID: <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Willy Tarreau <w@1wt.eu>
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

On Fri, May 20, 2022 at 11:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> This pull request adds a number of library functions and splits this
> library into multiple files.

Well, this is annoying.

You add the rule to test and install this, and "make help" will list
"nolibc" as a target, but that is not actually true at all.

So what's the appropriate way to actually test this pull somehow?

I'm guessing it's along the lines of

    make ARCH=x86 nolibc_headers

in the tools directory, but then I got bored and decided I need to
just continue the merge window.

I've pulled this, but it all makes me go "Hmm, I'd have liked to maybe
even build test it".

                Linus
