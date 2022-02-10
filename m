Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFDF4B1502
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbiBJSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:11:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiBJSLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:11:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1871167
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:11:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ft32so1525340ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tlc50y2zvWkDNDR0F+Hwlo/MK2qUQWeFkSFZIhsrGgA=;
        b=iJ8wAdxK3aVPvQadvP2kQORWpqM1MwHhKRoQhinm5nXPKgnbRB25C9NdtTZR9ceJIE
         SBtJXEjBFGQckKrACPJtdyxbGmTclNdJbEJSeV7V7WDPuPoqREzUn2VBLtsxA4qSs5wS
         cyllBj95re5mmkwQjGIgS42OyNeC+S8X3neeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tlc50y2zvWkDNDR0F+Hwlo/MK2qUQWeFkSFZIhsrGgA=;
        b=ejqXTXJrEKWsgUt/yCO9VRqUDcmzlBFtJ7fhlrm3MXA2IyWRyeDrHFSrpsNfgLlKXC
         B/IK/Sv443ifIShuN5Wlcnl6+aAt02E327bwCm8rFEOmtUplkQO4o6xNBrsQFLLJ2OwO
         EqA05y2+oQygMDHpOXXQsV6PQaLTRw55YRlCdjUBXJIHqrV2VJdmzmL6p5HiegU+K0RY
         Olb8+3jJnqCnEErrTHNAnnJxabvNoRFJm0j6Dj7wRMoqeVj9e7oCYNqZ91Blg4gVEU6H
         0aE9wHUHHaEY/12REHaiCxqTYaa59iN6nCffHeNSKKXVKUz7/5Bog/tNwOaMbBVHoD+G
         qMoA==
X-Gm-Message-State: AOAM533MHpTKt7l8XcxTN8i8xgtZSVLBTcSKNXFhHOvN6SvXkB6U5Nrf
        ynOJuxGipaZkNaV9JN3HyPZtWDC4E8bYqtJV3Yg=
X-Google-Smtp-Source: ABdhPJxY09lPuy5iS/04B894SXLPPH3T8mkHnMwg0OMtgFRuTFyepus7nxo+8aZU3M4zurUMuc01Lg==
X-Received: by 2002:a17:907:c0d:: with SMTP id ga13mr7479450ejc.576.1644516666756;
        Thu, 10 Feb 2022 10:11:06 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id m25sm1277373ejn.118.2022.02.10.10.11.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:11:06 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so5720115wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:11:06 -0800 (PST)
X-Received: by 2002:a1c:f702:: with SMTP id v2mr3105904wmh.155.1644516283317;
 Thu, 10 Feb 2022 10:04:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a3571605d27817b5@google.com> <0000000000001f60ef05d7a3c6ad@google.com>
 <20220210081125.GA4616@1wt.eu> <359ee592-747f-8610-4180-5e1d2aba1b77@iogearbox.net>
 <CAJ+HfNjeapa=2Ue19L3EWF8z5vxFB0k2QO_LuBu4Meqs0=AE4Q@mail.gmail.com>
 <20220210174507.GK1951@kadam> <20220210175603.GL1951@kadam>
In-Reply-To: <20220210175603.GL1951@kadam>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Feb 2022 10:04:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRq+_jd_O1gz3J6-ANtXMY7iLpi8XFUcmtB3rBixvUXQ@mail.gmail.com>
Message-ID: <CAHk-=wiRq+_jd_O1gz3J6-ANtXMY7iLpi8XFUcmtB3rBixvUXQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in xdp_umem_create (2)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willy Tarreau <w@1wt.eu>,
        syzbot <syzbot+11421fbbff99b989670e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        fgheet255t@gmail.com, Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        mudongliangabcd@gmail.com, Netdev <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
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

On Thu, Feb 10, 2022 at 9:57 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Wait that would make the allocation succeed...  We don't want that.
> That was a dumb idea.  Forget I said that.

Well, sometimes that _can_ be the right model.

That said, pretty much every time this has come up, the kernel warning
has shown that yes, the code was broken and there really wasn't a
reason for doing allocations that big.

Of course, some people would be perfectly fine with the allocation
failing, they just don't want the warning. I didn't want __GFP_NOWARN
to shut it up originally because I wanted people to see all those
cases, but these days I think we can just say "yeah, people can shut
it up explicitly by saying 'go ahead and fail this allocation, don't
warn about it'".

So enough time has passed that by now I'd certainly be ok with something like

  --- a/mm/util.c
  +++ b/mm/util.c
  @@ -587,8 +587,10 @@ void *kvmalloc_node(size_t size,
                  return ret;

          /* Don't even allow crazy sizes */
  -       if (WARN_ON_ONCE(size > INT_MAX))
  +       if (unlikely(size > INT_MAX)) {
  +               WARN_ON_ONCE(!(flags & __GFP_NOWARN));
                  return NULL;
  +       }

          return __vmalloc_node(size, 1, flags, node,
                           __builtin_return_address(0));

(which is obviously COMPLETELY UNTESTED as well as being
whitespace-damaged, but you get the idea).

If somebody tests that patch and verifies it works, and writes a
little commit blurb for it, I'll apply it.

            Linus
