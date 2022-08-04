Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716A658995D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiHDIkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:44 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257022B2C;
        Thu,  4 Aug 2022 01:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659602405; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=HRa3cgBUGDhLJOtXf2p82GY0rr1az36E7wc+47StGrLH24UiWFXG02fYWxBaIkRwq4b6HktX88yLGouzmORH98fcPv34XoxZSUkd9ALyKhkdMrO6IavL66N9GhRKAv9CeB+KaSf+fozh9nMccDG2w7ZB7oGgZar3TWS9XP8bbEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659602405; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=r2MuNRxKA7fyF0B0LyObbHN/r25kRQ6vAlitFSyZznY=; 
        b=M45y1dKNyTY6JZnb43I7pv82XRyC3YLpg0KUU3Z2jYxw4jUzWFL3SRIhgb1YgsCzgrEqGtum2r95MDP7DKrwTAXsGA2hMLk9Yil1KwgTRC7vfKSgk51gpve5kIJ8/hqq6eOqzK1kBfWKlkQGLz0Il1YEdPLhawnMXipl5Cj0pUo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659602405;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=r2MuNRxKA7fyF0B0LyObbHN/r25kRQ6vAlitFSyZznY=;
        b=T0BsybSAEPB/jwKl7nOSOJlUl9RcaSNLbHjm5I6vh4QRQfBm0T0UuTdRR9LJmJMt
        jtJKYRrEWjDEh0edLVRQFLlYfJySlysO818hkuy3jjbnaGZPjWFIsUtZeVTL805Txbj
        d57YVkn/WeDCN0HwAykHwjczjl1VaQ3Ln1wL5zdU=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659602376436867.9051997344565; Thu, 4 Aug 2022 14:09:36 +0530 (IST)
Date:   Thu, 04 Aug 2022 14:09:36 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <182680296de.8276ed8742454.8804921618540697946@siddh.me>
In-Reply-To: <Yuq7Q//SH/HjLsxH@gmail.com>
References: <20220728155121.12145-1-code@siddh.me>
 <YunKlJCDlmyn2hJ4@sol.localdomain>
 <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me>
 <Yun1rC59USrgd0fu@sol.localdomain>
 <182621f8dca.1e0e6161130907.1470656861897824669@siddh.me>
 <YuoKi0GigXm/Hcb+@sol.localdomain>
 <18262dcb20e.4bf31faa421018.1228982721921458740@siddh.me> <Yuq7Q//SH/HjLsxH@gmail.com>
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

On Wed, 03 Aug 2022 23:45:31 +0530  Eric Biggers  wrote:
> Well, you should try listening instead.  Because you are not listening.

Sorry for that, never meant to come across like that.

> Even if wqueue->pipe was set to NULL during free_pipe_info(), there would still
> have been a use-after-free, as the real bug was the lack of synchronization
> between post_one_notification() and free_pipe_info().  That is fixed now.

Okay, noted.

> To re-iterate, I encourage you to send a cleanup patch if you see an
> opportunity.  It looks like the state wqueue->defunct==true could be replaced
> with wqueue->pipe==NULL, which would be simpler, so how about doing that?  Just
> don't claim that it is "fixing" something, unless it is, as that makes things
> very confusing and difficult for everyone.

Okay, I will do that. That actually seems like a plausible thing to do, in
v2 convo, David Howells had also remarked similarly about `defunct` to a reply.

https://lore.kernel.org/linux-kernel/3565221.1658933355@warthog.procyon.org.uk/

> A reproducer can just be written as a normal program, in C or another language.
> The syzkaller reproducers are really hard to read as they are auto-generated, so
> don't read too much into them -- they're certainly not examples of good code.
> 
> - Eric

Okay, noted.

Thanks for your patience, I probably annoyed you.

Thanks,
Siddh
