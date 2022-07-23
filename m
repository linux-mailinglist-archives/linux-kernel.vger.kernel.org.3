Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237E57EFB0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiGWOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiGWOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:30:06 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83D1C138;
        Sat, 23 Jul 2022 07:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658586572; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OYq163lvA2Bqz3Yn4jatz3mbts9pw8Mo0ri4o5+iknE4WgtpLwGFwRrk138GGR29SrCrRgPY29+sl6+YRWivTJUNquN/MoLZpPSQllxdqLyeX0QK2zNOY4v3iOrrI3CHD7q6+PIpiHHVhOagmanPWMq2DfOk33ZgmiG/0+WMPlw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658586572; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=a/9usRWIfKTQJmjOCrdt/xVzLad7G/lItwk6BnowcDE=; 
        b=bb/Kj22EZ5tXuuv0BNBthqeUKbZsM3AFivbJlFn7yUkiHvxVMqM7unOFZgPAEfHJTt3VD/t0nnj4/1AebnYEqteIaXMRmgBf3sMk98FJSldaWHRsl5aOckmNUUkCR1y9YMquLH+r7oul9T49mAghXodRj9UBojPMgabbRekEdhk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658586572;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=a/9usRWIfKTQJmjOCrdt/xVzLad7G/lItwk6BnowcDE=;
        b=tDBA1sdg8MTEoxUTL9NLDKsUFJjHvaYYFZOKCPtKEMZ6jE4SDp5StnQnIPF6h5Cr
        qu4ZsClhibfg3Q+LpT0awGh8WffR6wu4WznGGvnmccX+oIM1XdAIL8ihFpVqTjHz/Zv
        XVfwg38ljifrVetqLVHN90zDhBri5l/VnqfuyHM8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658586560433935.6815882019292; Sat, 23 Jul 2022 19:59:20 +0530 (IST)
Date:   Sat, 23 Jul 2022 19:59:20 +0530
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
Message-ID: <1822b76775c.69c52873236056.4849193904753307696@siddh.me>
In-Reply-To: <Ytv/tUrdK1ZTn4Uk@kroah.com>
References: <20220723135447.199557-1-code@siddh.me> <Ytv/tUrdK1ZTn4Uk@kroah.com>
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

On Sat, 23 Jul 2022 19:33:33 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> You should not use #ifdef in .c files, it's unmaintainable over time.
> 
> thanks,
> 
> greg k-h
> 

I used it because it is used in the same way in fs/pipe.c too (please check the
stated line number).

That, in turn, is because `watch_queue` member in the `pipe_inode_info` struct
is defined that way (see line 80 of include/linux/pipe_fs_i.h), so I am forced
to use the ifdef guard.

Thanks,
Siddh
