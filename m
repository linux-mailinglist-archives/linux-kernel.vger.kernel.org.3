Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5A54258C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiFHD1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiFHD0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:26:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAEF1F536E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A5B3B8246B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840AC34114;
        Wed,  8 Jun 2022 00:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654648859;
        bh=lQ1oxOogJV3mO2l/yqgP5RWN7ruy5FFG3aGblg+w28c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLM9C8Jb3AENgRjRIN4//UovtkvAMWRGz4J47MHryMbzyC00d0u9EZyfEoIdf0TjO
         vzvbGGnyNQWzfavBWtWlR8WgwkGBKXhS4MP0zBNHMO+IgZvMdPbmzV7NtsRiYwaLOo
         B10huDxXsA7WlMoovy2JYqsYFmjQRl4ZqQ699sE8EpkSlTrUIU4qyPK+n4WHcK9pVx
         aS2UWuBpydgzT2htSn49TOcBzIjqenqpQ86LsXuvb805eeBNXHA4evVYnoY9Shb1Ve
         GpkMi1p3ZMfBeKpkIvi2zxHEwhSkkCE7gHQFMzRjdtUiNwVRQj1ZFeUV0XYXNJWEOW
         XaxDAhOFpn+Hg==
Date:   Tue, 7 Jun 2022 17:40:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Auto-invalidating old syzbot reports?
Message-ID: <Yp/wGYVsKR8M9eXI@sol.localdomain>
References: <Yp59WCODvEDbpxOY@sol.localdomain>
 <CANp29Y7yEocOnLMhE_hc37L8wAzpvON9hwpjvuBLoMdQzhw+xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y7yEocOnLMhE_hc37L8wAzpvON9hwpjvuBLoMdQzhw+xA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:37:42PM +0200, 'Aleksandr Nogikh' via syzkaller wrote:
> Hi Eric,
> 
> Thanks for contacting us!
> These are very interesting points.
> 
> Syzbot indeed only closes old bugs without a reproducer, because if we
> have a repro, then we can periodically do a fix bisection. And yes,
> this mechanism unfortunately does not always work perfectly.
> 
> I think we could split the problem you described into two parts.
> 1) Some bugs that are "open" on the dashboard are actually no longer
> relevant and should be closed.
> 
> If you know some old opened bugs with repro, which are actually
> already fixed, could you please share them? It would be helpful to
> figure out the exact reason why they are still open.
> There are some cases when we can close bugs with a repro without
> losing too much -- e.g. for bugs from -next there was a discussion in
> https://github.com/google/syzkaller/issues/1957.
> Also, if the fix bisection fails, but the repro no longer triggers the
> crash on the HEAD, then we could probably "cancel" the repro and let
> the bug be auto-closed (actually, auto-invalidated) later?
> 

Just to give the first definitive example I could find,
https://syzkaller.appspot.com/bug?id=06c43cd0a71aec08de8ea55ca5cda816c45ab4e0
("KMSAN: uninit-value in _mix_pool_bytes") is a 3-year old bug that is still
open even though it was fixed by commit f45a4248ea4c ("net: usb: rtl8150: set
random MAC address when set_ethernet_addr() fails").

From working on syzbot reports in the past, I can say that the "already fixed"
case for old reports is very common.  It is hard and time-consuming to actually
identify them as such though, since it requires root-causing the bug.  If it was
quick and easy to do so, there wouldn't be hundreds of such open reports...

> 2) Some bugs were reported to the mailing lists, but became forgotten.
> 
> We could periodically take maintainers as per the latest commit and
> send a reminder email to them. What do you think, would people go mad
> if we did that for each bug e.g. every 6 months? :) Only if the bug
> still happens on syzbot, of course.

That is greatly needed, but to get there we first need to get past the
assumption that every syzbot report will get properly handled by humans and thus
should never be automatically closed.  That assumption has been tried for the
last 5 years, and unfortunately it isn't working.  (If responding to syzbot
reports was being properly funded, it would be possible, but it's not.)  It
looks like you agree, as per your suggestion that only crashes that still happen
in syzbot should be reminded about.  I think syzbot actually needs to go further
and close the old bug reports, not merely suppress reminders about them...

In any case, reminders *must* include the latest crash details in a way that
clearly shows that the bug is still relevant.

> At some point we were also considering sending aggregated reminders
> (e.g. sth like "we still have X open bugs for the subsystem you
> maintain/have actively contributed to, here they are:"), but to do
> that, we first need to learn how to more or less reliably classify the
> bugs into the subsystems.

Well syzbot already identifies subsystems via the stack trace; it's just not as
good as a human expert, and probably never will be since the correct subsystem
can be very non-obvious.  For a short time, I was actually manually classifying
the subsystems for syzbot reports and sending out reminders --- see
https://lore.kernel.org/linux-kernel/?q=%22open+syzbot+bugs%22 --- but I gave up
due to lack of support from my job for doing that work, combined with receiving
somewhat less engagement than I had hoped.

Perhaps the best solution would be to crowdsource by providing a self-service
"#syz subsystem $FOO" command.

- Eric
