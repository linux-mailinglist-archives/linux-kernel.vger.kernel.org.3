Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782A4C9196
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiCARej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCAReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:34:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1092D41
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B340B81BE7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E568C340EE;
        Tue,  1 Mar 2022 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646156029;
        bh=nTSYxKRUBidJMvHb24iohQB1FzSc4ZEUjlCWVMB2nKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fuxIhc29THQGxx+xgQsKZkVW0Wh5XIuPam/ryISWwjOl9CILSZwa8cflV1Xs4Gllb
         n1YSI2+emVkunbelsWd6w6CEjjA4mjjSF7L0TPNNMp/ICL2p+b9eIXv9ZUOqT2BY5y
         X+oidhtU6kji9Cp18u2AlwrYhes1YkClG5Q1wsY4=
Date:   Tue, 1 Mar 2022 09:33:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in hugepage_add_anon_rmap
Message-Id: <20220301093348.0eb7071cab3d8f0e49613fdf@linux-foundation.org>
In-Reply-To: <0000000000009ee0ca05d9288b83@google.com>
References: <0000000000009ee0ca05d9288b83@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022 05:57:27 -0800 syzbot <syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    196d330d7fb1 Add linux-next specific files for 20220222

This seems to be a relatively old kernel?

> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b0618a700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45b71d0aea81d553
> dashboard link: https://syzkaller.appspot.com/bug?extid=d7ed29a6231d3747fb31
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:2330!

BUG_ON(!PageLocked(page)) in hugepage_add_anon_rmap()


