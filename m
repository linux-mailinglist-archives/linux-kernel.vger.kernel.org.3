Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E05A18D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiHYSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiHYSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:32:56 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADEF8C460
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661452338; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OV3DDQVVOgw/b/r91JXSP6t4Vj9RFSs3VDNKuF46yz2PIP29iGthMtGEaw9YYMrRBB/m9PTaeuhrhOAq69rL7lCeQOlOVf8KWIGgvLRzVLZrgZbtS8NN9JJU19Ljdyk8zeojwUwlLrNK+TyxG+3Ql6q5OjYKzlSZCT/4T/hh4Q4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661452338; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=cH3BOPF0q/RHPvHUT9MHcUX4ziGphT0mLZlLgbFP5EM=; 
        b=LCLVakGEUGfB7bMhrO/92MYk2qlDgp7hJM05UbFDZgnygdZfhlJBl7kSpINBGf+UcE7KEPM6npG91HUhg20mmBOjISOz4PVuhOeibIGto+Akj7cQ+ADqDcuaNm9G6RaP4iHhCp5CYRhckyFwpxtflEJJTx9Tx28CYRnhXHssoOA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661452338;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=cH3BOPF0q/RHPvHUT9MHcUX4ziGphT0mLZlLgbFP5EM=;
        b=CS6KtyWnxIISIHxFt9rqmkYAJKk6MJvrdSfIGBQu7S2IYeZyPZ8Op+ISMjRv6+20
        HLEk0ouOQcLNbMAifBu8valiUhS8bdKAsc61Z83ydvQut1oLGjMsM1TfAXJo2EDDf//
        kLJCgyy3Tz/d9qCqd1sTV15spYexMUoNvC7xMTNw=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1661452327559478.8124574215667; Fri, 26 Aug 2022 00:02:07 +0530 (IST)
Date:   Fri, 26 Aug 2022 00:02:07 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com>
Cc:     "akpm" <akpm@linux-foundation.org>, "anton" <anton@tuxera.com>,
        "chenxiaosong2" <chenxiaosong2@huawei.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev" <linux-ntfs-dev@lists.sourceforge.net>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>,
        "yin31149" <yin31149@gmail.com>
Message-ID: <182d6469a5e.4e1cc3b067845.2722724258679993431@siddh.me>
In-Reply-To: <0000000000006886bd05e714ec18@google.com>
References: <0000000000006886bd05e714ec18@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ntfs_attr_find
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 23:55:35 +0530  syzbot  wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c40e8341e3b3 Merge tag 'cgroup-for-6.0-rc2-fixes' of git:/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=161114c7080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f8dcabe4a3b2c51c607
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dd8265080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f30033080000
> 
> The issue was bisected to:
> 
> commit 38c9c22a85aeed28d0831f230136e9cf6fa2ed44
> Author: ChenXiaoSong chenxiaosong2@huawei.com>
> Date:   Thu Jul 7 10:53:29 2022 +0000
> 
>     ntfs: fix use-after-free in ntfs_ucsncmp()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f6cd8d080000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f6cd8d080000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11f6cd8d080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
> Fixes: 38c9c22a85ae ("ntfs: fix use-after-free in ntfs_ucsncmp()")

This is incorrect. The issue is caused by:
9b75450d6c58 ("fs/ntfs3: Fix memory leak if fill_super failed")

The fix for this can be seen by the two different patches tested by syzbot, which
are listed on the dashboard.

Thanks,
Siddh
