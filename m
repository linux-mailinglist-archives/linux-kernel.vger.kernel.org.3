Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E05B1676
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHIKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiIHIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549DE792FF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C7261BB6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F154C433C1;
        Thu,  8 Sep 2022 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662624609;
        bh=LMauM8SkFMkfOPkj98kj47U4j0tAP2vl9skTIW/vjGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDix0JGmh6nCZ3ji6fpKUFzAf3Mqje4BvBa8lqfIbB/GpbfoXI987MCp/+BWD82fK
         2L5zFQUb0mgCxq8dQfsU8Lq19JH1uvX1WvIDra0Do8ICB5ukgGClrjqHOie5ISLSoV
         SdkY9+IY37IQXBPMuTPfu9sqpTceX7LkEu50qdtfZEbymiorg6TsddQW89Tt3yICnd
         6/Z6NiBcATVxjP3/RhA/tB9qRStbNYkt7kRpimPPOTsF7oLOpJrEz5HB42hmKsdN4a
         cej6azOpbXkNE8xnlJ6XJeHA/XqPhdHXVgivKpequKSbBPXYdE72ZufZxJqXaBSZRu
         GL/939V1FPtqA==
Date:   Thu, 8 Sep 2022 10:10:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Alexey Izbyshev <izbyshev@ispras.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <20220908081003.sjuerd5wiyge4jos@wittgenstein>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
 <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
 <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru>
 <YxjRx3+MipdFOudw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxjRx3+MipdFOudw@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:15:51AM -0700, Andrei Vagin wrote:
> On Wed, Sep 07, 2022 at 08:33:20AM +0300, Alexey Izbyshev wrote:
> > > 
> > > That is something to be double checked.
> > > 
> > > I can't see where it would make sense to unshare a time namespace and
> > > then call exec, instead of calling exit.  So I suspect we can just
> > > change this behavior and no one will notice.
> > > 
> > One can imagine a helper binary that calls unshare, forks some children in
> > new namespaces, and then calls exec to hand off actual work to another
> > binary (which might not expect being in the new time namespace). I'm purely
> > theorizing here, however. Keeping a special case for vfork() based only on
> > FUD is likely a net negative, so it'd be nice to hear actual time namespace
> > users speak up, and switch to the solution you suggested if they don't care.
> 
> I can speak for one tool that uses time namespaces for the right
> reasons. It is CRIU.  When a process is restored, the monotonic and
> boottime clocks have to be adjusted to match old values. It is for what
> the timens was designed for. These changes doesn't affect CRIU.
> 
> Honestly, I haven't heard about other users of timens yet. I don't take
> into account tools like unshare.

LXC/LXD does

unshare(CLONE_NEWTIME)
// write offsets to /proc/self/timens_offsets
timens_fd = open("/proc/self/ns/time_for_children", O_RDONLY | O_CLOEXEC)
setns(timens_fd, CLONE_NEWTIME)
exec(payload)

so I agree don't change the uapi, please.

But as you can see what we do is basically emulating changing time
namespace during exec via the setns() prior to the exec call.
