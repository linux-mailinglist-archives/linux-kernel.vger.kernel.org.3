Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCB586B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiHAM4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiHAMzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:55:43 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C38E0E9;
        Mon,  1 Aug 2022 05:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659358334; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=dLCP1LRwIl1bWr8nAoLKsw1Rq7+h63BO/8yjOSVc6ZDf4CcNU138KdA9XBBeAiNcuTLphxxmkBuVD4VvOINKdQlY08JUgW9B71G++jML1beJJ0+8VeEFVnBWYr7rrXgdywf+ITQMynkrkEzaVGfNJgaD94zDC3OzfZ3vqf/LYYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659358334; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZucGc/xaWsMqpRuxte5cdZ6+7d5BRfDSRyYsk/WnebM=; 
        b=WTkJI9gGhmc2i7zlqK1rCijL1fEd63fgjmGv+CSCky/PpQOK2lDb7THdt51c0DH4DDkutb1V6PRfB3OIBZptJ5OksU7+NVkh/FuDNcijXc05nuj1LhP8JwMkkDkfrTuzONclPHwppoKmqsLtUr7kNGdprp/H3M7I2hdv4CsCsz4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659358334;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ZucGc/xaWsMqpRuxte5cdZ6+7d5BRfDSRyYsk/WnebM=;
        b=qzQZespJ/Q8jGtl1GDqJIF5aC+wrNQOdlAjDIZ1rQ+rFaF0kP9Jgya4nD+YWbST/
        7uJSeO1mAuzwfoGYwA1crDvg+m2MbKcSf3kDCrSWnz/FpbQ/JfDQR0JVXVy3O7hcROW
        yYoU2p3xKikOAq0SK9+/hKqakcM6fvJffR9VzMXE=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659358322294738.2309151863757; Mon, 1 Aug 2022 18:22:02 +0530 (IST)
Date:   Mon, 01 Aug 2022 18:22:02 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "hdanton" <hdanton@sina.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>,
        "Dipanjan Das" <mail.dipanjan.das@gmail.com>,
        "David Howells" <dhowells@redhat.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "Marius Fleischer" <fleischermarius@googlemail.com>,
        "Priyanka Bose" <its.priyanka.bose@gmail.com>
Message-ID: <18259769e5e.52eb2082293078.3991591702430862151@siddh.me>
In-Reply-To: <20220801121513.28E4B5204D1@webmail.sinamail.sina.com.cn>
References: <20220801121513.28E4B5204D1@webmail.sinamail.sina.com.cn>
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

On Mon, 01 Aug 2022 17:45:13 +0530  Hillf Danton <hdanton@sina.com> wrote:
> What is not clear is what you are fixing, with CVE-2022-1882 put aside,
> given the mainline tree survived the syzbot test [1] irrespective of
> other fixing efforts [2, 3].
> 
> Hillf
> 
> [1] https://lore.kernel.org/lkml/000000000000c7a83905e52bd127@google.com/
> 
> //	syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> //	
> //	Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
> //	
> //	Tested on:
> //	
> //	commit:         3d7cb6b0 Linux 5.19
> //	git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> //	console output: https://syzkaller.appspot.com/x/log.txt?x=14066d7a080000
> //	kernel config:  https://syzkaller.appspot.com/x/.config?x=70dd99d568a89e0
> //	dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
> //	compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> //	
> //	Note: no patches were applied.
> //	Note: testing is done by a robot and is best-effort only.
> 
> [2] https://lore.kernel.org/lkml/0000000000000dac0205e479ea39@google.com/
> 
> [3] https://lore.kernel.org/lkml/00000000000014c7ad05e4d535fc@google.com/
> 

(Fixed broken formatting)

This bug is about watch_queue still having a reference to a freed pipe,
which was being accessed by post_one_notification() at the time of when
I posted the v1 patch for fixing it on 23rd July, by removing the
reference to the freed pipe in the watch_queue.

Given ref. [3] by you leads to a bug about UAF in __post_watch_notification():
https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca

That bug is fixed by the following commit by David Howells on 28th July:
e64ab2dbd882 ("watch_queue: Fix missing locking in add_watch_to_object()")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e64ab2dbd882933b65cd82ff6235d705ad65dbb6

Given ref. [2] by you is of a patch tested by you, which can be found below:
https://groups.google.com/g/syzkaller-bugs/c/RbmAFTAIuyY/m/-vMjf-BXAQAJ

This had overlooked the existing serialization of wqueue->defunct, which
you had yourself pointed out in the reply to v2, which can be found below:
https://lore.kernel.org/linux-kernel-mentees/20220724071958.2557-1-hdanton@sina.com/

Given ref. [1] by you is about a syzbot test which was ran today, which no
longer triggers the issue. This probably happens due to the commit by David
Howells referenced earlier by me. While it does cause the reproducer to fail,
it doesn't really fix the particular issue concerned by this patch, which is
that the watch_queue has a reference to a freed pipe, which had caused a UAF.

Hope everything is clear.

Thanks,
Siddh
