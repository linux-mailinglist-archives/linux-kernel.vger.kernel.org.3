Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00FD526EA9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiENByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 21:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiENByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 21:54:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1523E9DD4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:56:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so9363591plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqXCGyPsp5ArB5dqL4pL5ev2vTjEI3622aS8uMXTUU8=;
        b=DwM4B8SfDuhyFXUnZbAL/ZY/DcRWWDHSvQn+FjKOPeOJaj4vRugCoD4Q6EyH8ejoNp
         c5GkcuheJ6uVTHxI1r/k46H944JxYU2cO8FvvYHaov0k/7zKxkRLm2uii1ka82lbkE8y
         kkXQkFIqfcn7EHZE9r+UQEnd7O8o/kzC45WvCZlcvIZwJlt2aFz0IOCOkx/EStnddHfo
         YbwZRpt1F/PeXQg5dgEPIDUOlrpBwRxdVdVZ9YtmBNphMaKKFfk/yqyGyQCTBbmZ69gL
         awkai/OcYtvaBdC4OJtVvUdk/yevN6l6nrdMuf+6SZD+pFqf3pm9Fq6lnjFqIUKmiTlx
         L6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YqXCGyPsp5ArB5dqL4pL5ev2vTjEI3622aS8uMXTUU8=;
        b=GIcSQHET03X1tWggkCGJrd4Fp+lMtJIrv1NQkzfhSeLqb53auOw//gcSpnagi+emJR
         ++AvqVtspSTOIj5Rqti6HA0CuKZmR3nlW8dMvwo1vY0KMaioZg9keeZ4tY215D/Gc37E
         6CZYRz4b0WVDQKOcTOhdFxp2kQg84/b+okMCrrIqkw9A65hL1gx6vbRBFgy0Wib3B34E
         /anvDjpSitIeFsZ3dMqnvA2YVVvruo3ZMnIp60FRj2I8Lev0hkgMnbFODTBu+LEqMXTc
         vbdOgvbq+j8t6ivBs7vRemvcEk/FJmjFXV65G8RZ/llQaVW/9goQ5DAEb58DEILPMCLB
         zfHg==
X-Gm-Message-State: AOAM533CtLxXHGfP9WkB6SvYDExnOUhXezE9Sx14NSQjRS4aWZuB/82/
        fCUgxqP3X+4sZOuY09i5Fe4=
X-Google-Smtp-Source: ABdhPJz+2AgJW+UNcOEnQyMmoDiDLnajAAFPWMpiflOrjAp91f9dxcR/08AkhNhPCCw2na7Tk8dLFQ==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id j6-20020a170903024600b0015387f0a93emr7165067plh.171.1652486048731;
        Fri, 13 May 2022 16:54:08 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:1969:9b8a:5056:897b])
        by smtp.gmail.com with ESMTPSA id z25-20020a62d119000000b0050dc762816fsm2326286pfg.73.2022.05.13.16.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:54:08 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 13 May 2022 16:54:06 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-ID: <Yn7vnpXwX50J3K+7@google.com>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 04:19:10PM -0700, Andrew Morton wrote:
> On Fri, 13 May 2022 15:48:15 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > On 5/13/22 11:09, Mike Kravetz wrote:
> > > On 5/13/22 10:26, Andrew Morton wrote:
> > >> On Fri, 13 May 2022 09:43:24 -0700 syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com> wrote:
> > >>
> > >>> syzbot has found a reproducer for the following issue on:
> > >>
> > >> Thanks.
> > >>
> > >>> HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
> > >>> git tree:       linux-next
> > >>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=174ae715f00000
> > >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
> > >>> dashboard link: https://syzkaller.appspot.com/bug?extid=acf65ca584991f3cc447
> > >>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11531766f00000
> > >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce5a9ef00000
> > >>>
> > >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >>> Reported-by: syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com
> > >>>
> > >>> ------------[ cut here ]------------
> > >>> WARNING: CPU: 1 PID: 3611 at mm/hugetlb.c:6250 follow_hugetlb_page+0x1326/0x1c80 mm/hugetlb.c:6250
> > >>
> > >> The try_grab_folio() added by 822951d84684d ("mm/hugetlb: Use
> > >> try_grab_folio() instead of try_grab_compound_head()").  That commit
> > >> has been there over a month so I guess it's something else.  Does
> > >> someone have the time to bisect?
> > > 
> > > I can recreate in my 'easy to debug' environment, so I can bisect in
> > > parallel with other things I need to do today.
> > > 
> > 
> > I isolated this to Minchan Kim's "mm: fix is_pinnable_page against on cma
> > page".  Yes, the fat finger fix is in next-20220513.
> > 
> > I don't have time to analyze right now, but can confirm that in the
> > reproducer is_pinnable_page is returning false after this change when it
> > previously returned true.
> 
> OK, thanks, I dropped mm-fix-is_pinnable_page-against-on-cma-page.patch

Seems like bug of the patch v5 due to change of this

    if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))

The migration type is not bit type so it shold be 

if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)

Ccing just in case if I miss other thing for HugeTLB
