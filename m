Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9B4BE04D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379378AbiBUPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:42:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379364AbiBUPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:42:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF22253B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FD1FB811C6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B89C340F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:42:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XzWDfBGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645458138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hoNJGSdkbTUtcMcqPhqnr5+5hOIuKFhZky4sBAyMkg0=;
        b=XzWDfBGKC5QoMouTTirfXjOd+Ck5EDGpLZRNSCdTpl3PA0iUUgbyLgbK9xGSvQndbTUnUU
        VNnbbguNTr30hrdsICVTnDffqFKz+D/psecFqWQPH36a3UnN+5Ad/6Y7s2zBg3bIbKaVfi
        hMkl61O0ofLC3VMghn7sJetFaQ4X3qw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 57cd2fae (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:42:18 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id j12so35169397ybh.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:42:18 -0800 (PST)
X-Gm-Message-State: AOAM531+8tezsk/2C50+TElhFCc1iKJvoPZCf6Fx66ufwRDB0vMYT7Zu
        1r23XR/aznquibHIe+szx+3Sb95qUNk4N0UMpZo=
X-Google-Smtp-Source: ABdhPJwo3rwwOJznxY66d0fIEweV+4xxDowOJINc0vzilXajWL3CTGNRMpIlblepAzOwq8vmauf5LE0p8H/Fp4BHgb8=
X-Received: by 2002:a5b:6cf:0:b0:61e:1371:3cda with SMTP id
 r15-20020a5b06cf000000b0061e13713cdamr19338354ybq.235.1645458137357; Mon, 21
 Feb 2022 07:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20220210155012.136485-1-Jason@zx2c4.com> <20220210155012.136485-2-Jason@zx2c4.com>
 <YhMUkwfdI/GbxCT2@sol.localdomain> <YhMgtVaw3OjJ/u2w@sol.localdomain>
In-Reply-To: <YhMgtVaw3OjJ/u2w@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:42:06 +0100
X-Gmail-Original-Message-ID: <CAHmME9pAf_ZJjkn4jqDwgwAMBxXjkAZb3BdznJi2AvSCAsSUaw@mail.gmail.com>
Message-ID: <CAHmME9pAf_ZJjkn4jqDwgwAMBxXjkAZb3BdznJi2AvSCAsSUaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] random: remove ifdef'd out interrupt bench
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

On Mon, Feb 21, 2022 at 6:18 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Feb 20, 2022 at 08:27:00PM -0800, Eric Biggers wrote:
> > On Thu, Feb 10, 2022 at 04:50:10PM +0100, Jason A. Donenfeld wrote:
> > > With tools like kbench9000 giving more finegrained responses, and this
> > > basically never having been used ever since it was initially added,
> > > let's just get rid of this. There *is* still work to be done on the
> > > interrupt handler, but this really isn't the way it's being developed.
> > >
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > ---
> > >  drivers/char/random.c | 40 ----------------------------------------
> > >  1 file changed, 40 deletions(-)
> >
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> >
> > - Eric
>
> Actually one comment: there is a reference to ADD_INTERRUPT_BENCH in
> Documentation/admin-guide/sysctl/kernel.rst that needs to be removed.

Thanks, will do.
