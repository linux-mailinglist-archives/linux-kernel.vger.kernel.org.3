Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54940484775
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiADSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiADSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:07:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DFBC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:07:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g11so83605284lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvUSWM8asV7TSsVhKHo2Vs+mW55Ad8feWEmsL+BvlZ8=;
        b=aigDwNH/D4hq1zIuNcOSz5GkiJ793Ga58PlIhV9oJOu/smRupWwefivn90SeeTyrn5
         HThZyaTSyZXK5MzZDKpy48j6ZlAQR83l+Tkhh8Zicqlz/x+8G4jGKnIC8qFFhU+gHS6I
         Rej19czLxWFCpb0BpUTveO598tFaFOJ6J6numziVTtR+Y66LHLUcWjCW9t0UX/RXkNkp
         z9XtLHxbxkq3cPCKcZLZWth4fqXE+mZ8xTotlRoCf7jTVhbRtEwjW/De22leDXu7AyFl
         SWZQ58TiV9SydUjyXys4x2fiejxy7PFqEG6qykgxTSsUar5bxbiiKgfNXffq7zrSxX02
         4JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvUSWM8asV7TSsVhKHo2Vs+mW55Ad8feWEmsL+BvlZ8=;
        b=mPYzrUrySSWKjT3bTgjGMNDSXP+0cYTp2WyahqH4bmZAP4wOERCB8NVS0Tzkw0f1Dn
         OQC58tV/wOxmh1GwA12mD8cHac8zv6Egh4ImIiikzFmCpz04gZch9SufxBufxWfmZ9Mv
         YgRX2bPDuX9FjBNYaA2pJZiWpSQ5ziuFdziV8QqCjQR/hme2D5Fw4T8YSA1/AvQP0byY
         zr2Ru46UbPTxDfSfeuFJCiyDufgUKazbaTJc0PnH40yTUBze8jmeKoiCshJGQDchztqU
         jyzt69LR0UTqYaCaXtC4W4UBTIDeVBn5eoLHnfMpXVwY6egE/GcGqxX9o8D5GEr3Cl55
         x0VA==
X-Gm-Message-State: AOAM5335aPuXEuqJgHBheK8/EZoYye9MgjpvSpZyD2yEvtTEMjjyt9Da
        azRhSK4gFHu4PZWErJwqmgJUatijDD9SSZxTiNBn8w==
X-Google-Smtp-Source: ABdhPJyukNdwgdJqBBt/WWtYHebJllitoaPGkf9/oNlfFpRP3A9HkMVwXhZPZBRtCnsNgsgGbL0bk9WKi1Cl1b+qNSw=
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr44000557lfv.651.1641319637393;
 Tue, 04 Jan 2022 10:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20211231075551.589515-1-xu.xin16@zte.com.cn>
In-Reply-To: <20211231075551.589515-1-xu.xin16@zte.com.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 4 Jan 2022 10:07:05 -0800
Message-ID: <CAKwvOdmL8Lhew+=-7YB6J5a8LKKN2EDS5vGExeKET9ykwRH8oA@mail.gmail.com>
Subject: Re: [PATCH] Fix compilation errors when using special directory
To:     cgel.zte@gmail.com
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:55 PM <cgel.zte@gmail.com> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> When we compile the kernel with cross compilers, if CROSS_COMPILE is
> specified by the path containing special directory like '~', some
> compilation error will occurs.
>
> Here's an example:
>
> $ make ARCH=x86_64
> CROSS_COMPILE=~/x86_64_gcc9.2.0_glibc2.31.0/bin/x86_64-pc-linux-gnu- all

I guess you could replace ~ with `$(realpath ...)` in the above
command line invocation of make?
-- 
Thanks,
~Nick Desaulniers
