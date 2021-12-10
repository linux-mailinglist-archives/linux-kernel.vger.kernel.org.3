Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9347075D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhLJRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbhLJRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B3C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:34:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r25so31736228edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QIa6rww9jro5nDJeWJFjVScPd67gpaO9LJRBQi9fOg=;
        b=M3iMr1TySf2JhF71PNm9vqUmHaN3ndNQHG/JvqEwurXQFVAc3WLPhhZJWkmxcv/iii
         e3cwFXBPK/cCe5z8o6p2trgcoV9h7Txs5HiF7R/U4M4BIEHcWNhyWg+ifoYKoycIB0+H
         5wF+CXd7RhgARAEG0l0SAd8Fi9xRrg4j8P6mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QIa6rww9jro5nDJeWJFjVScPd67gpaO9LJRBQi9fOg=;
        b=R6RUYlo5TVcuAFX0VYVgNZESYWtGshrRN3BA/b/nSKCMGFeNZfY8+118jAfRgVgOfQ
         eoNCRaFHViT2sdhoPz373vtjj1V4g9xSTHgUxnRo8qTFy8mr6y8MAQrVwS/aWQvlUHqG
         v5hTL/VLEwpcxBO80iUfDCDI0DCXwClGGTgiAEpG+zMB89ih04FFDpKXFmM2Due32TFE
         Ke723kGNPg9D1YUJZl+cX7eU3Jk9TP5ULAAoFAVzqSkobkH1FLcCghC/WKO9ZPqPZfDw
         PkvNTRVJWGTuRxnW12G53+UY5BQNiRZbWSlw6359jLYnb2HN+zSIMLL9OB5oHo7MgYH2
         WMmA==
X-Gm-Message-State: AOAM530LzkY2//c3Vnd5hu99cnAz1QBVggLanY4+JhWvwvq4V4WQI91f
        aReLrNyBor8HiJSJ4Cf7I2SFinqkJxQk5FZMIlI=
X-Google-Smtp-Source: ABdhPJxFgotdyR98+BfUwsIyzrv5RrSwFmYzsAAIfqxMwq1nRxo3YhaUxAlV6V+6Ku8+HaqMwA4puQ==
X-Received: by 2002:a05:6402:2751:: with SMTP id z17mr40886434edd.296.1639157653707;
        Fri, 10 Dec 2021 09:34:13 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id go10sm1741889ejc.115.2021.12.10.09.34.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:34:12 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id q3so16139082wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:34:11 -0800 (PST)
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr15464416wrv.442.1639157651522;
 Fri, 10 Dec 2021 09:34:11 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
 <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
 <159180.1639087053@warthog.procyon.org.uk> <CAHk-=whtkzB446+hX0zdLsdcUJsJ=8_-0S1mE_R+YurThfUbLA@mail.gmail.com>
 <288398.1639147280@warthog.procyon.org.uk>
In-Reply-To: <288398.1639147280@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 09:33:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHm-rNkeLXcOt4oV_BMzC5DeZ5FYt+yjbA_GjN2wcd5w@mail.gmail.com>
Message-ID: <CAHk-=wiHm-rNkeLXcOt4oV_BMzC5DeZ5FYt+yjbA_GjN2wcd5w@mail.gmail.com>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 6:41 AM David Howells <dhowells@redhat.com> wrote:
>
> However, since the comparator functions are only used to see if they're the
> same or different, the attached change makes them return bool instead, no
> cast or subtraction required.

Ok, thanks, that resolves my worries.

Which is not to say it all works - I obviously only scanned the
patches rather than testing anything.

                Linus
