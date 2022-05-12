Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D35254E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357712AbiELSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357581AbiELSdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:33:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428366C93;
        Thu, 12 May 2022 11:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14E63B82AD2;
        Thu, 12 May 2022 18:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E02FC34100;
        Thu, 12 May 2022 18:32:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aqUMb18b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652380373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7L3jRaEE24CnmSnfnYX9QsrDcQ/7q3vvEzMqLeZ5bw=;
        b=aqUMb18bSC8gARPE928AF57G1ouW5sq16pr9+RhFRMMh/PVm6wrzqcR8jrA4jKQRXr7cMO
        b0u0mLtcBHeOSqq8cm5sTeyc4qJpUThC4lsmJLlhU3YhZ43d5v/LzFbX6wUjUsETWFYBQ+
        +gWngA/nF0VaGD2JWEHCABWPgOgYw7o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cdcf0445 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 18:32:53 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7b815ac06so66900377b3.3;
        Thu, 12 May 2022 11:32:53 -0700 (PDT)
X-Gm-Message-State: AOAM531k+q51/sdzILOQLP19txc92NF7e8QUUgvIbgXYEnniVi74jrKf
        wEj6KTOB2pNZONkUgF9/ZXf2Hr/pUfiyP60zCBc=
X-Google-Smtp-Source: ABdhPJyXiV1OZyKsWVqUB6Bpq4PbzfC2ZtM7crKN2JIm8eqSbMDWlna2R8rfUBqbOpTwHpix1NvHEHveHZpEyvdzsfo=
X-Received: by 2002:a0d:ef03:0:b0:2fa:245:adf3 with SMTP id
 y3-20020a0def03000000b002fa0245adf3mr1585638ywe.100.1652380372103; Thu, 12
 May 2022 11:32:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6406:b0:179:6742:1e2c with HTTP; Thu, 12 May 2022
 11:32:51 -0700 (PDT)
In-Reply-To: <87bkw2hafj.fsf@email.froward.int.ebiederm.org>
References: <20220502140602.130373-1-Jason@zx2c4.com> <Ym/5EEYHbk56hV1H@zx2c4.com>
 <Ym/8GTW2RfhnbqiF@gardel-login> <YnERsPIsiOCa8cty@zx2c4.com>
 <Yn1GmlWKIvuoJJby@bombadil.infradead.org> <87bkw2hafj.fsf@email.froward.int.ebiederm.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 12 May 2022 20:32:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9o5n6TLfB3GsXz4KOt9iwxbT0e4ut65AFMsJsAm7ayNRg@mail.gmail.com>
Message-ID: <CAHmME9o5n6TLfB3GsXz4KOt9iwxbT0e4ut65AFMsJsAm7ayNRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 5/12/22, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
>
>> On Tue, May 03, 2022 at 01:27:44PM +0200, Jason A. Donenfeld wrote:
>>> On Mon, May 02, 2022 at 05:43:21PM +0200, Lennart Poettering wrote:
>>> > On Mo, 02.05.22 17:30, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
>>> >
>>> > > Just wanted to double check with you that this change wouldn't break
>>> > > how
>>> > > you're using it in systemd for /proc/sys/kernel/hostname:
>>> > >
>>> > > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/journal/journald-server.c#L1832
>>> > > https://github.com/systemd/systemd/blob/39cd62c30c2e6bb5ec13ebc1ecf0d37ed015b1b8/src/resolve/resolved-manager.c#L465
>>> > >
>>> > > I couldn't find anybody else actually polling on it. Interestingly,
>>> > > it
>>> > > looks like sd_event_add_io uses epoll() inside, but you're not
>>> > > hitting
>>> > > the bug that Jann pointed out (because I suppose you're not poll()ing
>>> > > on
>>> > > an epoll fd).
>>> >
>>> > Well, if you made sure this still works, I am fine either way ;-)
>>>
>>> Actually... ugh. It doesn't work. systemd uses uname() to read the host
>>> name, and doesn't actually read() the file descriptor after receiving
>>> the poll event on it. So I guess I'll forget this, and maybe we'll have
>>> to live with sysctl's poll() being broken. :(
>
> We should be able to modify calling uname() to act the same as reading
> the file descriptor.

How? That sounds like madness. read() takes a fd. uname() doesn't. Are
you proposing we walk through the fds of the process calling uname()
til we find a matching one and then twiddle it's private context
state? I mean I guess that'd work, but...

Jason
