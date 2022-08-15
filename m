Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBF594ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiHPCk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241687AbiHPCkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:40:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE086054;
        Mon, 15 Aug 2022 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jYgL/K8hz07GJiAK21af3KOIMQ0hiyPepA8O+pLBNvg=; b=Cr2ibY2f3ipwPYhnorMIGpCzis
        OkyypRYHxZMcLaS1TmKCt0FoLJZKlhHWBHy9ZtXS1cJEHIlhJmT4M6ai9v/Njvp3DngRrGIxCW3+P
        FpXaHY0gwqKGjnWCBiFml40myGDSCistV8dpo5ukSQJzLn3N1RrSGokCvmER6dw/gYyCIdsr4y9aR
        TMAuLkutQZPVxj1nUb2iDbIuJ5sx5cXn4OGmDkYh/iTJx96KndAaDqEdRZtIbBnzrcboPDCWlWC/u
        w4RX9AHXnnBBtdhl2Z5pR07qJLWR82WDfVosJflru3V2IEu1E6m7k2HulPNLFfiG4f8QROUfQPmKp
        6R5egiiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNj87-004qO0-73;
        Mon, 15 Aug 2022 23:04:19 +0000
Date:   Tue, 16 Aug 2022 00:04:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiacheng Xu <stitch@zju.edu.cn>,
        Mudong Liang <mudongliangabcd@gmail.com>
Subject: Re: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
Message-ID: <YvrQ8xO9Lx7rdKq8@ZenIV>
References: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
 <YvqP/f2P2YgIIO9U@ZenIV>
 <CAKFNMomyjXpsz-=BtG+G3q1J7CFUBMEfP13FfxwhWB==9qb++w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKFNMomyjXpsz-=BtG+G3q1J7CFUBMEfP13FfxwhWB==9qb++w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:34:12AM +0900, Ryusuke Konishi wrote:

> Yes, I agree it's better if security_inode_alloc() is moved to the end as
> possible in the sense of avoiding similar issues.
> But, would that vfs change be safe to backport to stable trees?

Yes.

> It looks like the error handling for security_inode_alloc()  is in the
> middle of inode_init_always() for a very long time..

Look at the initializations done after it.  The only thing with effects
outside of inode itself is (since 2010) an increment of nr_inodes.

> If you want to see the impact of the vfs change, I think it's one way
> to apply this one in advance.  Or if you want to fix it in one step,
> I think it's good too.  How do you feel about this ?

IMO that should go into inode_init_always(), with Cc:stable.  If you
(or Dongliang Mu, or anybody else) would post such variant with
reasonable commit message, I'll pick it into vfs.git and feed to Linus
in the next window.  E.g. into #work.inode, with that branch being
made never-rebased, so that you could pull it into your development
branch as soon as it's there...
