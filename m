Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04E255E007
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiF0HjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiF0HjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:39:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B88D62
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:39:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m14so7431106plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=84vnIVuBqL0L/KhL8ipRi5YoW8T44EFGau2fZe7lDYk=;
        b=CR/V6XamEcp4AysM+5uSYwPtEEVAnfzAP1WEyrROMMF/OxFkPytNejVdT/tRIbqUOQ
         cPMwXL+8unmxZ/OaykahbtP2Pjx9VmlFmAn3a24zwEKFYjrHuC5c8EvGeK79TU4m2q3U
         5TFseuEJx24N6shyWULlNx2uoRGt4UAzAQFS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84vnIVuBqL0L/KhL8ipRi5YoW8T44EFGau2fZe7lDYk=;
        b=QXrMDSg8PxuNaU5YfK6WIV6kmWlDegqtv9iJpnS7kN7QAADxjqa3KyqxdEB0zKUF+Z
         heGuqVfVimrdSAZpF+nx8XW5XupqrL18PYBrULOf7C+Q8vQ5CbteAF+YU0FZtvTRoUi1
         2h3GKDew6tY21/DwX2WTe3js2ch85NjFEK+rvFn3gcgiFam6rJz3G8pC2Jp47J3BKmw6
         BlstrXL9qTa/AsrUsunmZUFe0uQ5fdOb4jwvK6Xd4NvVBIkV5SjMh+9IciXzOcikky/x
         XwgplDFgWNLHQXMuiIcn4dnsH5fCWG9wCibIzOc19acNQpwK4prbhWbBfJfOJlkQM8wl
         gUCA==
X-Gm-Message-State: AJIora8e49vHxhAwHMAxs70P5i4QtgpM/Ph6eiO7SIaTUjgWinBjW7e6
        1iAsOTvcjUcv5j3fn+3nbe6Lvw==
X-Google-Smtp-Source: AGRyM1s2mJD4A0ufT2RCu0F7qPDwL3ap1UgQJSr3ShtTgfGexhtlWxJMyoFHbHEZ1/ooqmo1CQSr2Q==
X-Received: by 2002:a17:902:f151:b0:16a:466a:4ae4 with SMTP id d17-20020a170902f15100b0016a466a4ae4mr13910802plb.61.1656315550312;
        Mon, 27 Jun 2022 00:39:10 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:52a:ee1f:c89c:ee78])
        by smtp.gmail.com with ESMTPSA id a4-20020a62bd04000000b00525714c3e07sm6480649pff.48.2022.06.27.00.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:39:09 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:39:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, elver@google.com, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in console_unlock (2)
Message-ID: <YrlelmgGpTtBva/0@google.com>
References: <000000000000dab76c05d0bc284c@google.com>
 <00000000000095e3d105e2553f0a@google.com>
 <CACT4Y+Yf4ckOJjGkkFh_HYEKDjQo34wN=q18ADbP3=vhd5eQJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yf4ckOJjGkkFh_HYEKDjQo34wN=q18ADbP3=vhd5eQJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/27 09:11), Dmitry Vyukov wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit faebd693c59387b7b765fab64b543855e15a91b4
> > Author: John Ogness <john.ogness@linutronix.de>
> > Date:   Thu Apr 21 21:22:36 2022 +0000
> >
> >     printk: rename cpulock functions
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ed359bf00000
> > start commit:   aa051d36ce4a Merge tag 'for-linus-2022052401' of git://git..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6c31e1555a4c59f3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0b7c8bfd17c00d016fb4
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a5aad6f00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d697c3f00000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: printk: rename cpulock functions
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> 
> I guess this is also:
> 
> #syz fix: printk: add kthread console printers

Dmirty, we have reverted console kthreads for the time being.
