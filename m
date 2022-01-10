Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982E54893DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiAJInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiAJIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:41:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71866C034004;
        Mon, 10 Jan 2022 00:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F95060E05;
        Mon, 10 Jan 2022 08:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7FBC36AED;
        Mon, 10 Jan 2022 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641804079;
        bh=KNimAm6MuVbpyyW31wUY2PPlfx4RNo0nOMAvzobEKR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=AjFan6HrUNrgJ6cAd9JQ7884OID1R1qA4QTtR7K7MMghvS0dj9OH5Htr68xchYkCB
         emmPc/5mU39acJFbsDLMSTShKov5GhTsRi7rvRBv2YdqNWSGiYcDaf/ekncxMwG+Ir
         pVOJI1ZKlO36kfYqMzxwlXWcnZjJn8PVlyarfwvvuHquGQiNOSBBqnNOBk+LRWOulU
         CAEVAieF2vworRw48+tssj5Gpr+X4fx8rEz9nT0sEQ7XtAsrFDneMSbtco51JRXcnB
         J6DqQF0mEg/as0ok9q+oDS5vFS0wjXyzRXArhdkYdLP83+gcS2wAZtfPpTyMEwj4jG
         RVdCcN5WBEKNA==
From:   SeongJae Park <sj@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] init/Kconfig: Specify the interpreter for rust-version.sh
Date:   Mon, 10 Jan 2022 08:41:16 +0000
Message-Id: <20220110084116.4589-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CANiq72muzMPVUNJQU7Vcx0uCSEZc7Y_67LuX7PB=xNkCJ+NX7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 21:38:40 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Thu, Jan 6, 2022 at 1:34 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Some common tools like 'diff' don't support permissions of the files.
> > Due to that, 'rust-version.sh' in some trees including '-mm' result in
> > having no execution permission, and therefore build fails like below:
> 
> Do you mean the Quilt workflow? From a quick look:
> 
> https://lists.nongnu.org/archive/html/quilt-dev/2008-01/msg00000.html
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=749069
> 
> Is that the issue? I am surprised it loses that information...

Right.  I once encountered similar issue with DAMON kselftest[1], and as a
result we made kselftest deals with such case[2].

[1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
[2] https://lore.kernel.org/linux-kselftest/20210810164534.25902-1-sj38.park@gmail.com/

> 
> > It's not a big deal, but not so fun.  This commit fixes the issue by
> > specifying the interpreter for 'rust-version.sh' in the Kconfig file.
> 
> Other script calls do not do that, so I would prefer to avoid it. But
> I can take it temporarily to help you (until we are in mainline, if I
> understand correctly the issue), but I would prefer to have a comment
> nearby it justifying the workaround and explaining when we can remove
> it.

Fully agreed.  I will send v2 with the comment.


Thanks,
SJ

> 
> Cheers,
> Miguel
> 
