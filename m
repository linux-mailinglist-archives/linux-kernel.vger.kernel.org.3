Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC120471A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhLLNwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 08:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLNwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 08:52:50 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 05:52:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so10057367pjr.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AN57yfRVYbn6Lzc6ZdAzsQrsej0K9B98+reXazCxy5c=;
        b=Y5VN8pj75Sio58YFXY9wDr6KddQA4NcKbaAOI/8SwwHkHBRePJFh1fpdHubZvpIgPJ
         4Tj46HEk1H8GC3XBLhmbYrM2XIjaMmFLoblRW8fTQgM25qRZAFoAforx9+6lQf9rQiC8
         YLDGkQw3ey8d8vUZtkB+/niGbq3VHTjrI4IvepRtz37flZIbLB+1/8TWjwOgQ4+cv4ps
         +NsPKDHLGHnFpyur/SiIWqvO/+M/rDK7kPUUI6YScq++i3LykltOg2T3Sgx3Gl5wjacH
         QgwVLhvEDiKD/9NcE5EtSgT4eCuEm4+1yRj6fyJ4xb1E8t1RaKl0o6erw1GWrYOv4WLW
         ZwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AN57yfRVYbn6Lzc6ZdAzsQrsej0K9B98+reXazCxy5c=;
        b=ScYjCB66LFsAzdnXuECUdYncAzzqhUmC8UZSJPv7VJqnS5FVrGIOCVPN48wCi5Oh7J
         W6FU8tiAfqN+HtGqxXanrOaNF/sauwpqahQNLNgL0lIJlfRuNm8Ht85XctBJQGRi5Dzk
         ZVRq/1JFP3F4Rc3tKsb0Hn0kg1IvZABfbY36tuvttkklINoULjv02cwAWyhADB/iJn6z
         WTMsgGwxAdZpJbvT8S/EPqIWYh6/2eTpH0In6uGVq7zN4+SBO2Ybj18niWJK3D7tfg3p
         Bqma2ggx4RtIKYT+hRrDig3r5EUi0RGF/vdJ48ZZsfn8jqpzI+UKqLUtxfgjsRW2oEwv
         DlZQ==
X-Gm-Message-State: AOAM531rGN5DVsNj2wrQDkwMGCy/fsY4Z9mzFmOn2p/FAkuO/bqNMbJs
        W6cfKon1UKEk2n0JTPg9Amt7KG/KHDH0zVC210CQkHK5OEU=
X-Google-Smtp-Source: ABdhPJwo/k02x/A9d3zuwwdSUySUEP4Auo1JhiftB6J5yq6tzt+1l/t095peVUvJCVJcY71kbzRYfXZi3Nw7R6VSvF4=
X-Received: by 2002:a17:902:cecf:b0:141:e15d:4a2a with SMTP id
 d15-20020a170902cecf00b00141e15d4a2amr88356950plg.66.1639317169934; Sun, 12
 Dec 2021 05:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
In-Reply-To: <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 12 Dec 2021 05:52:14 -0800
Message-ID: <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 11:38 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On 12/11/21, H.J. Lu <hjl.tools@gmail.com> wrote:
> > According to gABI, the entry point address in the ELF header gives the
> > virtual address to which the system first transfers control, thus
> > starting the process.  If the file has no associated entry point, this
> > member holds zero.  Update the ELF loader to disallow an ELF binary
> > with zero entry point address.  This fixes:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=215303
> >
> > Tested by booting Fedora 35 and running a shared library with zero entry
> > point address:
> >
> > $ readelf -h load.so | grep "Entry point address:"
> >   Entry point address:               0x0
> > $ ./load.so
> > bash: ./load.so: cannot execute binary file: Exec format error
>
> Why not let it segfault?
>
> > +     if (elf_ex->e_entry == 0)
> > +             goto out;

Why let it segfault?

-- 
H.J.
