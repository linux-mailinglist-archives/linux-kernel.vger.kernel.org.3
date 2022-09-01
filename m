Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070BC5A96F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiIAMeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiIAMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2965CD112;
        Thu,  1 Sep 2022 05:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AED4961DF4;
        Thu,  1 Sep 2022 12:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8291AC433D6;
        Thu,  1 Sep 2022 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662035635;
        bh=9UIyfyyALoM0eBslsP+U76/M/W3Lbw5Q0719KJ6vMKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xvc/T3sCjwdDiqe3jU5SB+YjvT4jAnI6vmPeoP1OYgLt8fw9cBnmEDwC6xL3Sa3VL
         1RizMwJ36Apxl/q0v7NGjPx2eFF2c6l7kT/0xYGs3J2M73VoXT3cyF1MwtVzpfSzwJ
         rHRwtbtkw37e1xv+4v85vr/3QkTQyqhJCxEivyzMjl4xVaS7Ot+weuI3fX1zEUGQnq
         ku4y0O9hpmMEz1HvIc9YDmAjoOid8IwX8KxAgbFltvVNXHyDuz9Eev/Ix8GHfzrabC
         k0avvOm7M6MHs7I4/t3GJDtzlFwkNDrYHGI9iYGnGswMx9U4w2E5epMG6VU003Pht2
         WWGt+VVqOD5aw==
Date:   Thu, 1 Sep 2022 14:33:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH v3] ovl: Use ovl mounter's fsuid and fsgid in ovl_link()
Message-ID: <20220901123350.wak7yjbvddtcnwfb@wittgenstein>
References: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:29:29PM +0800, Zhang Tianci wrote:
> There is a wrong case of link() on overlay:
>   $ mkdir /lower /fuse /merge
>   $ mount -t fuse /fuse
>   $ mkdir /fuse/upper /fuse/work
>   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,\
>     workdir=work
>   $ touch /merge/file
>   $ chown bin.bin /merge/file // the file's caller becomes "bin"
>   $ ln /merge/file /merge/lnkfile
> 
> Then we will get an error(EACCES) because fuse daemon checks the link()'s
> caller is "bin", it denied this request.
> 
> In the changing history of ovl_link(), there are two key commits:
> 
> The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> overrides the cred's fsuid/fsgid using the new inode. The new inode's
> owner is initialized by inode_init_owner(), and inode->fsuid is
> assigned to the current user. So the override fsuid becomes the
> current user. We know link() is actually modifying the directory, so
> the caller must have the MAY_WRITE permission on the directory. The
> current caller may should have this permission. This is acceptable
> to use the caller's fsuid.
> 
> The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> which removed the inode creation in ovl_link(). This commit move
> inode_init_owner() into ovl_create_object(), so the ovl_link() just
> give the old inode to ovl_create_or_link(). Then the override fsuid
> becomes the old inode's fsuid, neither the caller nor the overlay's
> mounter! So this is incorrect.
> 
> Fix this bug by using ovl mounter's fsuid/fsgid to do underlying
> fs's link().
> 
> v1: https://lore.kernel.org/all/20220817102952.xnvesg3a7rbv576x@wittgenstein/T
> v2: https://lore.kernel.org/lkml/20220825130552.29587-1-zhangtianci.1997@bytedance.com/t
> 
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
