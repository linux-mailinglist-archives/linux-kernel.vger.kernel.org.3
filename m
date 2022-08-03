Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C85886B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiHCFOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiHCFOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:14:15 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD41D0D2;
        Tue,  2 Aug 2022 22:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659503622; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ereNJZG2TKcY8VEIiZ6G6l976YWYGMO3JS4bz9yBr7P7UPduBIxij0IjmWYS42QTVCg8SEbPcsnZYF9iXh/dQLx5RyoaXHoYk/drSvswFzGZ72r/TP032pTn/OxUHQ0YdmdWeDVIYCI5QxKqj3pFhK+jFk95TTqo3YH45wsNkHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659503622; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ankEwCNW2dYC4+n+miX8LYk427uSNCA75Yi5kRdEzXQ=; 
        b=S81e4BHRUI5TLzQMNay6MoN2XrtUEOVCkxXnJQhsn+L/y/7Wo5csOz8BYZ25cSFq2L67BNHtQPAB2CeSqGZRDuqPf6NMTVzyaA7FeYKs93eZKCZdSD/tiiG/K5WgqKAZYAmD/Qjlnk9zEdpCfb2T8m39MkimO5e0+ZYyExCIvGc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659503622;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ankEwCNW2dYC4+n+miX8LYk427uSNCA75Yi5kRdEzXQ=;
        b=seNAjkZMS25o+88HZF3N9XkiMwSuLx9JxVdk/iga/VX+CnOF2SdIwNDMFRJ8xSJj
        uqFqDHqxhMY2uh2TvuHDtU99CmH+uRHXr1Q0nrL0Nl3TuE/yAD85XDvqz4DLGMGFfGL
        KKv8QU94iLsS1Nk+Czwr0b2z6PQHA6p9VEnji614=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659503611368815.0380681354741; Wed, 3 Aug 2022 10:43:31 +0530 (IST)
Date:   Wed, 03 Aug 2022 10:43:31 +0530
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
Message-ID: <182621f8dca.1e0e6161130907.1470656861897824669@siddh.me>
In-Reply-To: <Yun1rC59USrgd0fu@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
 <YunKlJCDlmyn2hJ4@sol.localdomain>
 <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me> <Yun1rC59USrgd0fu@sol.localdomain>
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

On Wed, 03 Aug 2022 09:42:28 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> Under what circumstances is the pipe pointer still being dereferenced after the
> pipe has been freed?  I don't see how it can be; see my explanation above.

It really didn't fix the crash. It caused the same crash reported here, which
I was already locally getting:
https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca

(It's same because __post_watch_notification calls post_one_notification, and
this patch seems to stop that crash too, as was verified by Dipanjan here).

While it has been fixed by e64ab2dbd882 ("watch_queue: Fix missing locking in
add_watch_to_object()"), it just shows there can be paths leading to it. (Also,
I posted this patch (v1, v2, v3) before that even landed, so I had no way of
knowing about it).

There is a null check in post_one_notification for the pipe, most probably
because it *expects* the pointer to be NULL'd. Also, there is no reason to have
a dangling pointer stay, it's just a recipe for further bugs.

Thanks,
Siddh
