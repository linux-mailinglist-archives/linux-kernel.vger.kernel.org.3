Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99A5974D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiHQRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiHQRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A526053D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D56261222
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA73C433D6;
        Wed, 17 Aug 2022 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660756246;
        bh=p2NKXCx6Gscl2EjobX5+YFwoNxczqPBGjK2p1lckArQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tv4GZKzSRl5TUaDsS9lzLULWc2NPFHVoTn+jOfjPz1Aaf6fa/8Z5XTlRNk6xpts2G
         4mjWxwS07vbmrGp2qGjNLt3NHRZAq2/STQUv3w98d3kUKMjgGShigIYTPGJKlc62Kw
         KGuAEEIkYVt2+t9k+GSqe5nhPx6jylDumR4EVxus=
Date:   Wed, 17 Aug 2022 10:10:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 26/98] fs/libfs.c:1231:47: warning: Local
 variable 'anon_aops' shadows outer variable [shadowVariable]
Message-Id: <20220817101045.3aaa1525eaf0dfb81287cdeb@linux-foundation.org>
In-Reply-To: <202208152329.qv11tHmt-lkp@intel.com>
References: <202208152329.qv11tHmt-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 23:36:43 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   d2af7b221349ff6241e25fa8c67bcfae2b360700
> commit: e4ab315810850b93cac381d6f4efd532f45a790e [26/98] procfs: add 'path' to /proc/<pid>/fdinfo/
> compiler: or1k-linux-gcc (GCC) 12.1.0
> reproduce (cppcheck warning):
>         # apt-get install cppcheck
>         git checkout e4ab315810850b93cac381d6f4efd532f45a790e
>         cppcheck --quiet --enable=style,performance,portability --template=gcc FILE
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> cppcheck warnings: (new ones prefixed by >>)
> >> init/main.c:333:18: warning: Pointer addition with NULL pointer. [nullPointerArithmetic]
>     char *end = buf + size;
>                     ^
>    init/main.c:376:28: note: Calling function 'xbc_snprint_cmdline', 1st argument 'NULL' value is 0
>     len = xbc_snprint_cmdline(NULL, 0, root);
>                               ^
>    init/main.c:333:18: note: Null pointer addition
>     char *end = buf + size;

That's a pretty useless warning.

> >> fs/libfs.c:1231:47: warning: Local variable 'anon_aops' shadows outer variable [shadowVariable]
>     static const struct address_space_operations anon_aops = {
>                                                  ^
>    fs/libfs.c:1220:46: note: Shadowed declaration
>    static const struct address_space_operations anon_aops = {
>                                                 ^
>    fs/libfs.c:1231:47: note: Shadow variable
>     static const struct address_space_operations anon_aops = {

That's worth addressing.

--- a/fs/libfs.c~procfs-add-path-to-proc-pid-fdinfo-fix
+++ a/fs/libfs.c
@@ -1228,7 +1228,7 @@ bool is_anon_inode(struct inode *inode)
 
 struct inode *alloc_anon_inode(struct super_block *s)
 {
-	static const struct address_space_operations anon_aops = {
+	static const struct address_space_operations aops = {
 		.dirty_folio	= noop_dirty_folio,
 	};
 	struct inode *inode = new_inode_pseudo(s);
@@ -1237,7 +1237,7 @@ struct inode *alloc_anon_inode(struct su
 		return ERR_PTR(-ENOMEM);
 
 	inode->i_ino = get_next_ino();
-	inode->i_mapping->a_ops = &anon_aops;
+	inode->i_mapping->a_ops = &aops;
 
 	/*
 	 * Mark the inode dirty from the very beginning,
_

