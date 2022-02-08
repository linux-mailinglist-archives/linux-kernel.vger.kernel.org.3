Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680734AE1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385773AbiBHTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385786AbiBHTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D6C0612C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:00:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2FA1612D5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BD9C340ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:00:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lriKX+ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644346845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qItYgzGLQqWUe3YJNT/D2E0Z+OeLqmM9peldaTXvS1k=;
        b=lriKX+ubgI6h7wSVBh+3XllxtNw5EbqDs54bE7fuZq0j9nf8ewZUEHC9+2gjDUf5D3535K
        fKnvudqiryFo/FYJ8CTI6LMLnmVH41pe6Z3tDyNjKmpZJJ5YNWSxJjFuztFWQ4ZsE+B3t6
        erZM0R77mBBjp0JBebKh+avzBh/Mvcc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ba68c41 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Feb 2022 19:00:44 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id y203so12132676yby.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:00:44 -0800 (PST)
X-Gm-Message-State: AOAM533jsAH1h+xgP3+jjiF4o1msBw3TE4cOqt/oQ8mbLkHIwgnAiyt4
        kh6QUBDHWhF5al2rDHfit39R7gzHdQYDVIpPEQM=
X-Google-Smtp-Source: ABdhPJzzpcJEJf9z8QNjvkQ4dnbXeXyBEIodWlvYtTgDbB62XXMIXbOpFltkpZca4WhcFxUNiG0kYT/zhXQF5Mw87LU=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr6000546ybj.32.1644346841959;
 Tue, 08 Feb 2022 11:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20220208150625.374191-1-Jason@zx2c4.com> <CAHk-=wi3fRiQXynJrLvaD5DDqF0MzgX1xSGFSJS_2frwXT1E5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi3fRiQXynJrLvaD5DDqF0MzgX1xSGFSJS_2frwXT1E5Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Feb 2022 20:00:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9oJe3QuNHeYeejQNT-22LC=RDpB+fsZ7ZLFJRTJNqkbDQ@mail.gmail.com>
Message-ID: <CAHmME9oJe3QuNHeYeejQNT-22LC=RDpB+fsZ7ZLFJRTJNqkbDQ@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.17-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

Hi Linus,

On Tue, Feb 8, 2022 at 7:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I think the changes look fine, but this definitely conceptually is a
> "new feature" to me, rather than some security fix.
> In contrast, as a 5.18 merge window pull request, this makes complete sense.

Okay, no problem. Coming your way for 5.18 then.

Regards,
Jason
