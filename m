Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7D552C83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347977AbiFUIBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347878AbiFUIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:01:24 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2C323BDA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:01:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id o43so19221241qvo.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=58Y9+S8YUUcxxOlJT1UyYn0YwlJPcr5IqrrowcigrGk=;
        b=aVUVd/0dAqac7l58GTwqipnXWm185d9jayMBuFd/GL6zwCOFbeia0ZPqs3Mreoyhwm
         dF11N4YRNecFJsmUfXUOYMQh355M6vgCRqUTWBnM0nKQXy0i3/B1beJfAscA0RcPZixU
         Y6Mhim16vrZFCxo1bvhwOuG4QyCxrogTZu7cbgzbUC0l3v6xi0LxMtV3R3vhXUHJRBTx
         c5XS4g4i13ScRVEcN6KhHHVXsBnfPySA64ynH+Ci1MXbO++ryjzHaq0uP5KfJPEwSPtG
         3FxkNfWvH60NroWVpullEj8pV2cHdI9SLxSfIr6phpI0qf60Ji7IdgHKLF+CsoR9lOE4
         Mymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58Y9+S8YUUcxxOlJT1UyYn0YwlJPcr5IqrrowcigrGk=;
        b=O5q9cncvd5i8leEHu7+AYxIdFJHEPmffGkxzXgd1dzwudyem7z8mwgQOclAMCr5k+h
         1wVGfbXWmNCOrQezX1e7A397HqLE8UEJd333Ev5Vgu8mRF/laUqYjf1E2w5AaX3BUO6L
         Pt6sj1QYH4qzErH5f+Ino1lIEwDsFFiTNCaqDhv0yTJ+KTVSPREljx02hxVsJXQrAZfx
         XmmytgwGAajQIK2NMaVjocjAnShMFzqC+HD+jRXEzXnxquA3bVCgYaV/z6+xCqdXUn/m
         Bh/KJLF7qKwVoWWK7mCSciFIEdet+6GDT+d3/WWJBT+ZSPHi17BO9a1LSD9Ot4E0zfmw
         r9Bw==
X-Gm-Message-State: AJIora+KtRrq/8uWl2SmxXVcYKrnG6k3uuRX0k+KaSFGtFkG9uu5oem5
        J6EOntuW7Y0tMMlVfk+m5g==
X-Google-Smtp-Source: AGRyM1uuA3O9RLbK4blJ0GR1ecl+qHMuJsmHuHQvHlc+j/Tf/WlVycb7HPzLQ5Tj/0c8cHrIHgQAag==
X-Received: by 2002:a05:6214:f0d:b0:470:2d21:7a0f with SMTP id gw13-20020a0562140f0d00b004702d217a0fmr13967414qvb.44.1655798481839;
        Tue, 21 Jun 2022 01:01:21 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id e12-20020ac84e4c000000b00307cebe3e07sm9536006qtw.79.2022.06.21.01.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 01:01:21 -0700 (PDT)
Date:   Tue, 21 Jun 2022 04:01:20 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220621080120.bzms2aswvjld6nnp@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <46fcdf08-4646-afa0-c112-76d9335adb6c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fcdf08-4646-afa0-c112-76d9335adb6c@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 08:11:49AM +0200, Rasmus Villemoes wrote:
> On 20/06/2022 02.41, Kent Overstreet wrote:
> 
> >   Rasmus pointed out that -fno-strict-aliasing is going to cause gcc to generate
> >   nasty code, and indeed it unfortunately does but according to worst case
> >   scenario microbenchmarks it's not a problem for actual performance. 
> 
> Well, that's not how I interpreted those numbers, but, except if they
> showed an improvement, how much is acceptable is of course always a
> matter of judgment.
> 
> However, what's really annoying and somewhat dishonest is that you're
> not including those numbers, nor the methodology, in either the cover
> letter or commit itself.

There's nothing dishonest about it, and I wasn't claiming an improvement; merely
no regressions (some were a 5-10% percent up, some down by around the same
amount, overall it was a wash).

My priority simply isn't microoptimizing everything. I find that programmers who
chase optimizing every loop and are constantly trying to shave instructions
everywhere they can end up with code where the large scale structure is a mess,
and that's where you miss out on the _real_ performance opportunities.

My priority is clean, readable, simple, easy to work on code, because _that_ is
the code that becomes fast in the long run.

Premature optimization really is the root of all evil, and I am _absolutely_
going to try to drive the discussion away from shaving cycles when there's new
APIs to get right and messy refactorings to complete.
