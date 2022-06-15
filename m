Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26C54D154
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbiFOTGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFOTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:06:03 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011B24F3F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:06:01 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x9so12615920vsg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YPmuPkYl0+f4EwKvwkR94hcDDWbfroubDSxtV6XrJk=;
        b=FQ/qhlRv8hx6Bd4PeajepawLIblvaLISMFzjT4ybhPnGP1kq1WZDkl7g//j7cFtaWf
         z+fHgn2dCBibpgTPnIKawpFhRo5MpUTExvaCFdn7i61PuZyY6dMReJyQzsEPDKa5tx1X
         NjyfJgqqoPiBDTVVwGDAIjFSmOV0ZHEktmnpEsMlgRgJQEmVcuMFCCLDfRz/cERl4dRx
         /cHA5RHceTg7yG9ZDXEU2aosUg9rHI9bhbs5TEchEdp0zbUMqxPE0AkikVR22IQoTFHw
         BoM25WSNb85pdkvRsX4ZAiY6KGAyHWNlHbIqfpWeEZf6OpHl5wbXoi2tFyiTo0rYFXb5
         o8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YPmuPkYl0+f4EwKvwkR94hcDDWbfroubDSxtV6XrJk=;
        b=B2UPJ8rFEcYE/zYfbzP8fidHtBcsqdQPMXvcqFL+F7o1TTLp0jFKyYIKojdHXnrD5A
         ucg0KpU4o4bYEmpC8/hjK+1MhLovRs+Xqr/dELkdT8VkUcHafcBE3/g9j7Gvu9qmYEKe
         SLUKW408IAhlpu4NrsG667zNBLxivnjVcLXoALAEPl0XjsX9aGECxUd/Vpfw3by+rwyg
         8OKkie4bLCj7Cnkw4R3SoMCnte0sbtnOlIRi2eokMzGmETwEC4M0LOxh854WTZ5kfx5T
         XKukGDQVaaTpOClHdbX8m6SW3T71Yj8LfmBhmvAFoEQmJAkb9D+VG6ay726I2588ONWE
         tJYQ==
X-Gm-Message-State: AJIora+XGe0uMC/GuOb/flOmct+kvTP8OCD/HEOEYMtuVEyVXDZ20ZEX
        T4mcbHKX6YQY7XvSEjjO2ejAoiBwK/seHob1nCHsgg==
X-Google-Smtp-Source: AGRyM1sW7wy5Ynw5WCENE6luw/+uXXck3ZA3cA2NeorCJCJ7vUrrUjtOWQ0KeUgOQoRe9nCWFOapwMKRGgXNKBBBsko=
X-Received: by 2002:a05:6102:214c:b0:34b:b31d:1a50 with SMTP id
 h12-20020a056102214c00b0034bb31d1a50mr589718vsg.41.1655319960891; Wed, 15 Jun
 2022 12:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com> <20220504011345.662299-13-Liam.Howlett@oracle.com>
 <Yp3udPy0vuDK8khc@qian> <20220606161940.fh5edq5nyz4jru2u@revolver>
 <Yp4uD8uWB3rit/Ee@qian> <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver> <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver>
In-Reply-To: <20220615185500.i5bzt7srzm6q72na@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Jun 2022 13:05:24 -0600
Message-ID: <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Jun 15, 2022 at 12:55 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220615 14:08]:
> > On Wed, Jun 15, 2022 at 8:25 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > * Yu Zhao <yuzhao@google.com> [220611 17:50]:
> > > > On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > > > > > Does your syscall fuzzer create a reproducer?  This looks like arm64
> > > > > > > and says 5.18.0-next-20220603 again.  Was this bisected to the patch
> > > > > > > above?
> > > > > >
> > > > > > This was triggered by running the fuzzer over the weekend.
> > > > > >
> > > > > > $ trinity -C 160
> > > > > >
> > > > > > No bisection was done. It was only brought up here because the trace
> > > > > > pointed to do_mas_munmap() which was introduced here.
> > > > >
> > > > > Liam,
> > > > >
> > > > > I'm getting a similar crash on arm64 -- the allocator is madvise(),
> > > > > not mprotect(). Please take a look.
> > > >
> > > > Another crash on x86_64, which seems different:
> > >
> > > Thanks for this.  I was able to reproduce the other crashes that you and
> > > Qian reported.  I've sent out a patch set to Andrew to apply to the
> > > branch which includes the fix for them and an unrelated issue discovered
> > > when I wrote the testcases to cover what was going on here.
> >
> > Thanks. I'm restarting the test and will report the results in a few hours.
> >
> > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461
> >                                                        ^^^^^^^^^
> >
> > > As for this crash, I was unable to reproduce and the code I just sent
> > > out changes this code a lot.  Was this running with "trinity -c madvise"
> > > or another use case/fuzzer?
> >
> > This is also stress-ng (same as the one on arm64). The test stopped
> > before it could try syzkaller (fuzzer).
>
> Thanks.  What are the arguments to stress-ng you use?  I've run
> "stress-ng --class vm -a 20 -t 600s --temp-path /tmp" until it OOMs on
> my vm, but it only has 8GB of ram.

Yes, I used the same parameters with 512GB of RAM, and the kernel with
KASAN and other debug options.
