Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A674AB4DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353362AbiBGGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbiBGGcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:32:23 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F9C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:32:22 -0800 (PST)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 10DEC80294;
        Mon,  7 Feb 2022 06:32:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 086812002E;
        Mon,  7 Feb 2022 06:32:14 +0000 (UTC)
Message-ID: <62a6db49ef29745514b0263b9bb39b5a16f90efe.camel@perches.com>
Subject: Re: [PATCH] Staging : android: Struct file_operations should be
 const
From:   Joe Perches <joe@perches.com>
To:     Leonardo Araujo <leonardo.aa88@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Date:   Sun, 06 Feb 2022 22:32:14 -0800
In-Reply-To: <20220207031711.13644-1-leonardo.aa88@gmail.com>
References: <20220207031711.13644-1-leonardo.aa88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 8dikj3qm5jo846ci3kktjr9bssgn3eqo
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 086812002E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/tJ4keTdXdL28cbp7ERmXh3BWFz4CR16g=
X-HE-Tag: 1644215534-707106
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 00:17 -0300, Leonardo Araujo wrote:
> From: "Leonardo Araujo" <leonardo.aa88@gmail.com>
> 
> WARNING: struct file_operations should normally be const

Always compile the files modified by a patch before you send it out.

[]
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
[]
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  

<apply patch>
$ make allyesconfig
$ make drivers/staging/android/ashmem.o
[...]
  CC      drivers/staging/android/ashmem.o
drivers/staging/android/ashmem.c: In function ‘ashmem_mmap’:
drivers/staging/android/ashmem.c:431:37: error: assignment of read-only variable ‘vmfile_fops’
  431 |                         vmfile_fops = *vmfile->f_op;
      |                                     ^
drivers/staging/android/ashmem.c:432:42: error: assignment of member ‘mmap’ in read-only object
  432 |                         vmfile_fops.mmap = ashmem_vmfile_mmap;
      |                                          ^
drivers/staging/android/ashmem.c:433:55: error: assignment of member ‘get_unmapped_area’ in read-only object
  433 |                         vmfile_fops.get_unmapped_area =
      |                                                       ^
make[3]: *** [scripts/Makefile.build:289: drivers/staging/android/ashmem.o] Error 1
make[2]: *** [scripts/Makefile.build:572: drivers/staging/android] Error 2
make[1]: *** [scripts/Makefile.build:572: drivers/staging] Error 2
make: *** [Makefile:1965: drivers] Error 2



