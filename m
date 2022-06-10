Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704C6546FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbiFJXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347922AbiFJXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:20:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24118F5048
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:19:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fu3so739446ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFUZ/4X/JukFzJtRWCj5IwVqnR0commkjm8Ld9IJoQA=;
        b=AoxxrgfmaiG7fB01rWVX7//fR7hc8pfPaO6KuFkmEJpDpFR/HpqhwLdFQM6dVgzan3
         DB7+Ryy9LWRyARZSjDc1y62fbB3v6E3HNwslaXd4JIbxny9dkIOf8ftYNIIBC41esAeu
         4Gv6sMSeEfJjJ4Ad3imZr/QdI/L/mCWsQLeaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFUZ/4X/JukFzJtRWCj5IwVqnR0commkjm8Ld9IJoQA=;
        b=ei1pgwPfI5ZEwjQORz6A4Lxwpkwrkamf/IQLLCeoTxuHNwMklpsqhqBUaAyyMzl/Rk
         Hvy3aVtdTJhLr6IfxIfewyBJMYLZ1v0mddupkvwv8nMwpYFxOloIS81bYCnY0swICRdf
         N1VFCKVS+XbpbLp6s/s1Kcm7qPigCxMkhqdq9eQOI/5zofg5Q7B57yXu/R0ymrTE3YvB
         Wu/D7HH7rR0aG4ld1T7p+AwAKAlz/bewihrkZ1hERuwRtF5VQ3SB4iPqY/HLIsjPEz3c
         mlw6iAR9UlGTY6iIkkPeQQCPZ2QenZqPBsJz5zmfUI7NQdf10CTJfD3ODu+10icFf58K
         ZY2Q==
X-Gm-Message-State: AOAM5308x1TZbbZkQXHt2Op4owpTnYT+rD+CEzEO13hp5g2RQhh+47mQ
        zbStPvn6VohZoEm7b0z8G8KNzGfN+HeZFZbQ
X-Google-Smtp-Source: ABdhPJyVKuFAQw5L/toM5VivlghziQl3M/O9Q/f3a49hQ3sHrMOkWE2FvbXKd1L5maiTn4FwvF7w8Q==
X-Received: by 2002:a17:906:9d01:b0:711:dc5d:c8a5 with SMTP id fn1-20020a1709069d0100b00711dc5dc8a5mr20389887ejc.432.1654903197123;
        Fri, 10 Jun 2022 16:19:57 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7d78b000000b0042bca34bd15sm300851edq.95.2022.06.10.16.19.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 16:19:55 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so342327wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:19:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr2015707wmq.8.1654903194928; Fri, 10 Jun
 2022 16:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
In-Reply-To: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 16:19:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeW2nF5MZzmx6cPmS8mbq0kjP+VF5V76LNDLDjJ64hUA@mail.gmail.com>
Message-ID: <CAHk-=wgeW2nF5MZzmx6cPmS8mbq0kjP+VF5V76LNDLDjJ64hUA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] netfs, afs: Cleanups
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:56 PM David Howells <dhowells@redhat.com> wrote:
>
> Here are some cleanups, one for afs and a couple for netfs:

Pulled,

               Linus
