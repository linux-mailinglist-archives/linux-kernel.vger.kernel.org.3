Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E281A57EFB3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiGWOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiGWOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:30:06 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4187E17E04;
        Sat, 23 Jul 2022 07:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658586576; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Cdk5zB8spFUck32lES6ymvWOW49Nk2dX62Ga5BzHiEMuUVqsF+VOY0B6Xd8XbFfH5G56ExBvuWYOSsk5g+HWOyjIaF7xqmwNNTz6f/r3tUYOJlmBaxKm0LEEAbEAanSYrU8oskEZqNdQIv+UWUBlbPnq4V4G5ds0OGP7xcLRPgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658586576; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nrLqE1VQZTfewo+huIJiOECXb8Z/AkxV3GsY/VPoroA=; 
        b=TGXEGLyCPRw7jo2oPjtSaayeHmx0mwu5QPW9yhNoVwvYF6agE0ruM2srciLqk0aR+OB+ZFhst6wJutv1gI5Sg53KTnryGX+XS4/rPstaBIPgejnD4vPPbBdb484yXGuvgVctvF96UIyRpDFVacRDFbxnY+ePUhN89MD8h/32ck8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658586576;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=nrLqE1VQZTfewo+huIJiOECXb8Z/AkxV3GsY/VPoroA=;
        b=HAwK2u2fVT4U+qrBKk2SJpEACflR3vDhV78T1rrMbXVDqo/6SCTTmQFzR1+X6ppZ
        MUq22UDFeKpknOEywseYLkVEs53BkHwqtlfFE76BK8v0IWOkCjp4pqBO5H8TK8J8aZy
        ootDBrMvSQQuZ+LPAGFVwpYPC4KAhKwC/cwPXLx4=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658586563873727.0268161715809; Sat, 23 Jul 2022 19:59:23 +0530 (IST)
Date:   Sat, 23 Jul 2022 19:59:23 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
In-Reply-To: <Ytv/4Tljvlt0PJ2r@kroah.com>
References: <20220723135447.199557-1-code@siddh.me> <Ytv/4Tljvlt0PJ2r@kroah.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
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

On Sat, 23 Jul 2022 19:34:17 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> Also you now have a spinlock held when calling rcu_read_unlock(), are
> you sure that's ok?
> 
> 

We logically should not do write operations in a read critical section, so the
nulling of `wqueue->pipe->watch_queue` should happen after rcu_read_unlock().
Also, since we already have a spinlock, we can use it to ensure the nulling.
So I think it is okay.

Though, it is my first time encountering a spinlock and an rcu lock together,
so if I am wrong, please do correct me.

Thanks,
Siddh
