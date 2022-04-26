Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DB51071B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351905AbiDZSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351841AbiDZSh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:37:27 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADBF483AA;
        Tue, 26 Apr 2022 11:34:18 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 23QIXmP9029461;
        Wed, 27 Apr 2022 03:33:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 23QIXmP9029461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650998028;
        bh=MU07d+AY262zmGtq+SAVA7lALUspXSeSWe02H3uj1Xs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lguVaRuEX3+hSS8983Stao2YuzU83B4mWLci+q6evrHIVLDEnaspCIFhTFyjlNBt4
         ogjs1QjTWN2sJx57hXaCQZcKe2Qtg07GE4kCNg5wm2cPzDQrQY2RZ/ZffKpKhpRYG/
         BE7O9Sva9p7379jrfRbt3rYHsCOXBmNq/jTxkrrvtHUKyj1e3x/AX2AHkwUdoakg5t
         8wbCp7wNM53R3yaIVEQ0SsQHrewmCuyMsDefoxsPihScj9tvQ3y6iAqnNuES1+1hI5
         2XBMezd4GbfkTfcstdT7KamsdbOegqk8RWDCodwGF59bDGWgO6dQterjWMvBDVAgGD
         bJul1FngcXvoA==
X-Nifty-SrcIP: [209.85.214.182]
Received: by mail-pl1-f182.google.com with SMTP id u7so15679921plg.13;
        Tue, 26 Apr 2022 11:33:48 -0700 (PDT)
X-Gm-Message-State: AOAM533T5AKJlZAapqzcV2M+we6IFFYG65pgjH6gDqtEuXzCrcE43jTr
        po/f+a/PaKmW8K18bJKNT0IlM8gdDeBOMXqvT50=
X-Google-Smtp-Source: ABdhPJyZ9MX01nIu6mjkQna2NHamZuUGcHbEm8Gxa5aJQzqyZeFUAtdhz+cCf+uq33d0JOiUSGbOfW2CVOxOByuqjV4=
X-Received: by 2002:a17:90a:e7d2:b0:1d7:4f8d:3ca6 with SMTP id
 kb18-20020a17090ae7d200b001d74f8d3ca6mr28395475pjb.144.1650998027682; Tue, 26
 Apr 2022 11:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-17-masahiroy@kernel.org> <CAKwvOdk1nt4b9am=_BP=U3igkSRBN14nx+5oS8iaaw9zhbH5JA@mail.gmail.com>
 <CAK7LNAR-u=EVzPL+iJHoBW62AK2ViD3nVnL79EdxNS03UxmkBA@mail.gmail.com> <CAKwvOd=9ffHMynzCPXPAAdz90BcW0JhihjqnRNneFqMq3u+59Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=9ffHMynzCPXPAAdz90BcW0JhihjqnRNneFqMq3u+59Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 27 Apr 2022 03:33:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnQ2QXV9=CyTLq+3rzJ-n8hEhgtuRmj8hBHmX8-8n_cg@mail.gmail.com>
Message-ID: <CAK7LNASnQ2QXV9=CyTLq+3rzJ-n8hEhgtuRmj8hBHmX8-8n_cg@mail.gmail.com>
Subject: Re: [PATCH 16/27] modpost: make multiple export error
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 1:40 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Apr 25, 2022 at 9:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Tue, Apr 26, 2022 at 3:48 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > This is currently a warning, but I think modpost should stop building
> > > > in this case.
> > > >
> > > > If the same symbol is exported multiple times and we let it keep going,
> > > > the sanity check becomes difficult.
> > > >
> > > > Only the legitimate case is that an external module overrides the
> > > > corresponding in-tree module to provide a different implementation
> > > > with the same interface.
> > >
> > > Could the same module export a weak version of a symbol, and a strong one?
> >
> > No.  There is no concept like   EXPORT_SYMBOL_WEAK.
> >
> > I am talking about kmod things.
> > You can modprobe an external module instead of the in-kernel one.
>
> Ok, this patch seems fine to me.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> Thanks,
> ~Nick Desaulniers


Nick,


If useful, I can add more commits to the commit description.


I know one example in the tree that exploits this feature.

$ make allmodconfig all
   You will get drivers/nvdimm/libnvdimm.ko, then

$ make M=tools/testing/nvdimm
   You will get tools/testing/nvdimm/libnvdimm.ko

The latter is a mocked one that exported the same symbols
as drivers/nvdimm/libnvdimm.ko









-- 
Best Regards
Masahiro Yamada
