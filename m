Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81223588628
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiHCEEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHCEEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:04:50 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101A51A1A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659499461; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ZQ8uHKFD78VJDGV93MK75H2bg8okI5afJMf3xZ2btBiHc4tv4FDZSXB3PAmRQPVL4DHU6yp7bXBcoVW5wTYmKeK6KRIGP6vAV8fjqub2gwcBJzkftxvoR8DMJN8RvmfE8dobihsLHMusR64FPfYwpAUmIYdaMtB8RsiHrCWWZaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659499461; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=T9lJ7JKs3VnUQqeKqNXZ8T3X73Himj0XV/S1wfqdT/c=; 
        b=EPNVCmS+18GA5FYwQAsSAbPulrZqlv9pYoW+fy13tezSV2oNDfwbKK3jLzFXGGvE+V9oqPv4EPh/sLXCDVVZjW5AhHFCshPek7RDP2QMdRQYjE6xAPuSRp5Qoc8bkn35Gfeq9kNiWsOBrqHh7OjfYkskzIWgDUDvSFO2s3rU2vE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659499461;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=T9lJ7JKs3VnUQqeKqNXZ8T3X73Himj0XV/S1wfqdT/c=;
        b=td+f+UDvf+629k7FEeQtTKw7ge8hWldLu7MiwX2IUI2cZcfIXVkfkPUex4wHYI81
        sQougPO6A/5Scfls49SfN7uOz+1yE6P5aAiZ5S4H6Z2nK9CYK9WWs2X1PyvXMv4JvLn
        o1cclfKwvL4vC5QGtTf0lJVryZLuNlswe7FZ1nB0=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659499450495407.43897795096336; Wed, 3 Aug 2022 09:34:10 +0530 (IST)
Date:   Wed, 03 Aug 2022 09:34:10 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "syzbot" <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "hdanton" <hdanton@sina.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <18261e01068.4a2910f2403165.1226720997594524412@siddh.me>
In-Reply-To: <Yumkx4Nc5ZyPGYMz@sol.localdomain>
References: <20220801103533.972-1-hdanton@sina.com>
 <000000000000c7a83905e52bd127@google.com> <Yumkx4Nc5ZyPGYMz@sol.localdomain>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
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

On Wed, 03 Aug 2022 03:57:19 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> It appears this was already fixed, so no need for any more activity on this bug:
> 
> #syz fix: watchqueue: make sure to serialize 'wqueue->defunct' properly
> 
> - Eric

It doesn't address the dangling pointer remaining in the watch_queue,
which was the root cause of this crash. The use-after-free happened
because the pipe was freed but a dangling pointer of it remained in
a watch_queue, and an attempt to dereference it was there.

Thanks,
Siddh
