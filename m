Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883558708A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiHASt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHAStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:49:55 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800EF25293;
        Mon,  1 Aug 2022 11:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659379756; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=VmVDKppyY7mmW+pbZdDKKYx7d8inNu18GL1SuTG6bWf6Mb2GZ6jUK+NwfCmN9iveCzC/s9pPwEgTw+Cq6HRsqodMT+Y9/1XaQ33cKAcxRPVFBJR9eZUwVdUlPubhw1y8fTqEovi7Ia2zWLu5mYA/M+gvat4YzUfbmLmUd1Iapp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659379756; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XfAboZjbyugwzY0E4/UI5wpejzMLWhKLhGXS45Aib6k=; 
        b=Uh7vOJmtrvZuqJdWhfbOh7Rc7ovurEER0Bm4UbhBLbRgjFvSNDy6CILk34RQlJw5vVNZ77hmD0ha3LgiBlNzTlnw4tlDSFeMQ/pekxdMubUi2DRvYqbK0MP0JNRmGzMyvOlBRcL83Nr2AmadhUGrNKb+/Xx6DW58mMofq9Z9ID4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659379756;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=XfAboZjbyugwzY0E4/UI5wpejzMLWhKLhGXS45Aib6k=;
        b=UGFQNQwF3RXxXWKpZU6KeS4TkAcf2lKDF94AHa8TWQ448Rq6SvMgJtRf2sxNKEPb
        3e51obacAN7fMBRtHHtp6i8BlYvY/nWZgJcX6ywqZ7HjRO8N+XT01AXEHUU6v46kkw3
        cl64VJFjVfhNKnXdnoLe9/DU2c8h8o+DYZcryE3c=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659379745755991.9064464551104; Tue, 2 Aug 2022 00:19:05 +0530 (IST)
Date:   Tue, 02 Aug 2022 00:19:05 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Message-ID: <1825abd83c7.2fc2819e194605.6286442523651645797@siddh.me>
In-Reply-To: <20220801161642.GA1932489@berlinger>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
 <Yuepw21SyLbWt9F+@kroah.com>
 <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
 <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me> <20220801161642.GA1932489@berlinger>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022 21:46:42 +0530  Dipanjan Das <mail.dipanjan.das@gmail.com> wrote:
> Are you referring to the reproducer attached to our original report?
> https://lore.kernel.org/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com/
 
Yes, I meant the reproducer you gave.

I suspect I must have missed CONFIG_WATCH_QUEUE=y while setting the kernel
up, extremely sorry for it.

I now tried 5.10.y with it (using a modification of syzkaller's dashboard
config I had been using[1]), and I'm getting a __post_watch_notification()
crash (which is a related crash, as the fix[2][3] for that causes the
reproducer to not reproduce the post_one_notification crash on mainline),
but not the post_one_notification() crash you had reported. It seems if I
apply my patch, it doesn't trigger this related crash, so these bugs are
seem to be very related maybe due to racing? I haven't looked at that yet.

I then tried on v5.10.131 since that was the exact version you had
reproduced on, and it reproduces the post_one_notification() error
successfully. Applying 353f7988dd84 causes __post_watch_notification()
crash, and then applying this v3 patch does not trigger the issue, but
the patch to fix __post_watch_notification() crash is [2], which does
not really address the issue of post_one_notification() crash which
is due to the dangling reference to a freed pipe.

Can you please try reproducer at your end?

Thanks,
Siddh

[1] https://gist.github.com/siddhpant/06c7d64ca83273f0fd6604e4677f7c0d
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e64ab2dbd882933b65cd82ff6235d705ad65dbb6
[3] https://lore.kernel.org/linux-mm/18259769e5e.52eb2082293078.3991591702430862151@siddh.me/
