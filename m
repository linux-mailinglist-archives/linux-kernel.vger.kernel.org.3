Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC48586B79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiHAM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiHAM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:59:13 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93288E;
        Mon,  1 Aug 2022 05:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659358717; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=SpgIT+u0ciSNpFpvsl8bfy86f8eiatGHZ0VCBxSC9rz7xqBjwJpE5mdRoEokHhASezWRr5WjRbdsDm/6K5hMAdlA43RWO5ZCBsMXQyI+KaFgsXZzbjwyvOu9ZsCXrnw95Mq5mtWY4H6a+iUvSqDd4douveZ3KUddV9JA4Eg3czc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659358717; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7d8/VXWIL9kZoRLYBc/HuPEUPqfjdq8sxW9WzxOKpTo=; 
        b=UoSmkfVRWDIqbz1U2gpMYT7YCT8Vx+xcs/vlnikEoo5ox1LIB4WuMID2zM+NOtSSFXUuhob65oTIHPl37qxJfPSXEIx+k/pCKJ9wLSVDr4b6Xh2oAWZB9JniJz+/8fiYB2bnlT5yX45vA0/eM5m3pO5T8gNcDaHzIWQF8uXmMPI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659358717;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=7d8/VXWIL9kZoRLYBc/HuPEUPqfjdq8sxW9WzxOKpTo=;
        b=pncPOQ1dxoDMKbA+s7DlqsRvGXY2P6tXdGWN32RFuyVud/cs6qQQORpJGLoTf8/a
        HMQJ/US1pYBf5lr0X8AbsM5qG0BqxcM8YX7cSsJeq0QPN/YEgm7xtQ4oUhp7PaXnGm0
        2BmbSxBS1KBvOYnuUeRUjf8Xud1JcH9f2PBWnha8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 165935870593423.691156058112256; Mon, 1 Aug 2022 18:28:25 +0530 (IST)
Date:   Mon, 01 Aug 2022 18:28:25 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>,
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
Message-ID: <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
In-Reply-To: <Yuepw21SyLbWt9F+@kroah.com>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me> <Yuepw21SyLbWt9F+@kroah.com>
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

On Mon, 01 Aug 2022 15:54:03 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 

Oops, sorry.

> Trying anything on tag v5.10 is not a good test as that kernel is very
> old and obsolete and over 15000 changes behind what the latest 5.10.y
> kernel release has in it.
> 
> So trying it on v5.10.134 would be best.
> 
> thanks,
> 
> greg k-h
> 

Noted.

I now tried the 5.10.y branch of stable (which has v5.10.134), but the
reproducer isn't triggering the bug for me. 

Thanks,
Siddh
