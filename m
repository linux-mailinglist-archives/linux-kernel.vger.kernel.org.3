Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14958854E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiHCBQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70422532;
        Tue,  2 Aug 2022 18:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 210896110F;
        Wed,  3 Aug 2022 01:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4DC433C1;
        Wed,  3 Aug 2022 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659489375;
        bh=4hAj5swXgHDnxb10vMlloiSdI7KbG9hPid+FRMnvni0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDfEfES8aloL6MhzNoaLmD/6xw+dBsC76ivGrEX2iOS4wC6IWL/XE7TAqZsl+tcPw
         1J4a/46fyM8PgCNDGrWneKJAxSIEZ5ashF9zae9ubl4hScsscij5RfwDeCjmW5QKku
         DvCXlAIYn5jfRHa3T71RxkLMQQjsND8JBBhs7mWq5tZBALDzadOP3y26DolIIF2Ynn
         4H3HYkl9Dn+dgvo9nXhkyl2GCv0wXxcYP8yNoO2FWE7sZqUrDxt6yhzeZq9Jfwutzr
         YL0niMjFVCm0969OT04TeYC9IgiQRFLBSBO5o7m+3U6ow1JNLrGtN1qNvZgfIeNTlA
         eDut7lRBbwIDA==
Date:   Tue, 2 Aug 2022 18:16:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Dipanjan Das <mail.dipanjan.das@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <YunMXRhAM5g3tNnJ@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
 <Yuepw21SyLbWt9F+@kroah.com>
 <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
 <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me>
 <20220801161642.GA1932489@berlinger>
 <1825abd83c7.2fc2819e194605.6286442523651645797@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1825abd83c7.2fc2819e194605.6286442523651645797@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 12:19:05AM +0530, Siddh Raman Pant wrote:
> On Mon, 01 Aug 2022 21:46:42 +0530  Dipanjan Das <mail.dipanjan.das@gmail.com> wrote:
> > Are you referring to the reproducer attached to our original report?
> > https://lore.kernel.org/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com/
>  
> Yes, I meant the reproducer you gave.
> 
> I suspect I must have missed CONFIG_WATCH_QUEUE=y while setting the kernel
> up, extremely sorry for it.
> 
> I now tried 5.10.y with it (using a modification of syzkaller's dashboard
> config I had been using[1]), and I'm getting a __post_watch_notification()
> crash (which is a related crash, as the fix[2][3] for that causes the
> reproducer to not reproduce the post_one_notification crash on mainline),
> but not the post_one_notification() crash you had reported. It seems if I
> apply my patch, it doesn't trigger this related crash, so these bugs are
> seem to be very related maybe due to racing? I haven't looked at that yet.
> 
> I then tried on v5.10.131 since that was the exact version you had
> reproduced on, and it reproduces the post_one_notification() error
> successfully. Applying 353f7988dd84 causes __post_watch_notification()
> crash, and then applying this v3 patch does not trigger the issue, but
> the patch to fix __post_watch_notification() crash is [2], which does
> not really address the issue of post_one_notification() crash which
> is due to the dangling reference to a freed pipe.
> 
> Can you please try reproducer at your end?
> 
> Thanks,
> Siddh

There were several watch_queue fixes that got merged in v5.10.134, so there's no
point in testing v5.10.131.  If you're still seeing a bug in the *latest*
5.10.y, then please check whether it's also present upstream.  If yes, then send
out a fix for it.  If no, then tell stable@vger.kernel.org what commit(s) need
to be backported.  Please provide *full* details in each case, including any
KASAN reports or other information that would help people understand the bug.

- Eric
