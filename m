Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441154A08F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiFMU5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352213AbiFMUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3429D29353
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:20:58 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8640820C154C;
        Mon, 13 Jun 2022 13:20:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8640820C154C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655151657;
        bh=Nft++AK4Xo5eRcdhC/+nOVQRH0imfgMDAanvnC8iCGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0bSIsfsfTpuWw1wxebHkd2aPkjo0Gyxb/hYPwXstl6EQLvknbiRYqW/HO1jZAlxi
         4RY8Zijlv9dmd3IldYIG/q1jLlzlna24bgt4BfAHvvaknQNpNVG7Ot1ZgVD5WZ74Je
         ImAB7VOaW0frx6XujBx9pjxOV9fEfwVu7CY4sv0I=
Date:   Mon, 13 Jun 2022 15:20:53 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/06] fid refcounting improvements and fixes
Message-ID: <20220613202053.GI7401@sequoia>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612085330.1451496-1-asmadeus@codewreck.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-12 17:53:23, Dominique Martinet wrote:
> So:
>  - I could reproduce Tyler's generic 531 leak, fixed it by the first
>    commit in v9fs_vfs_atomic_open_dotl
>  - Found another less likely leak while reworking code
>  - Christian's comment that it's not obvious that clunk is just a
>    refcount decrease was very true: I think it's worth the churn,
>    so I've rename this all through a new helper...
>  - ... with the not-so-hidden intent to improve debugging by adding
>    a tracepoint for them, which I have also done.
> 
> I've also taken my comment in the other thread further and went ahead
> and made it in its own commit. Tyler, if you're ok with this I'll just
> squash it up. You can see rebased patches here:
> https://github.com/martinetd/linux/
> 
> Note that I also took the permission to add back '/* clone */' as a
> comment to your changing p9_client_walk's arguments: while I can agree
> variables are hard to track, figuring out what the heck that boolean
> argument means is much harder to me and I honestly preferred the
> variable.
> Having both through a comment is good enough for me if you'll accept
> this:
> ----
> @@ -222,7 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>                  * We need to hold rename lock when doing a multipath
>                  * walk to ensure none of the patch component change
>                  */
> -               fid = p9_client_walk(old_fid, l, &wnames[i], clone);
> +               fid = p9_client_walk(old_fid, l, &wnames[i],
> +                                    old_fid == root_fid /* clone */);

This is no problem at all. The rebased patches look good to me. Squash
your fix to my fix and it should be ready to go.

Thanks again!

Tyler

>                 /* non-cloning walk will return the same fid */
>                 if (fid != old_fid) {
>                         p9_client_clunk(old_fid);
> ----
> 
> 
> The last commit is just cleanups and should be no real change.
> 
> Dominique Martinet (6):
>   9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl
>   9p: fix fid refcount leak in v9fs_vfs_get_link
>   9p: v9fs_fid_lookup_with_uid fix's fix suggestion
>   9p fid refcount: add p9_fid_get/put wrappers
>   9p fid refcount: add a 9p_fid_ref tracepoint
>   9p fid refcount: cleanup p9_fid_put calls
> 
> 
> (diff stats include Tyler's commits)
> 
>  fs/9p/fid.c               | 71 +++++++++++++++-------------
>  fs/9p/fid.h               |  6 +--
>  fs/9p/vfs_addr.c          |  4 +-
>  fs/9p/vfs_dentry.c        |  4 +-
>  fs/9p/vfs_dir.c           |  2 +-
>  fs/9p/vfs_file.c          |  9 ++--
>  fs/9p/vfs_inode.c         | 97 +++++++++++++++++----------------------
>  fs/9p/vfs_inode_dotl.c    | 79 ++++++++++++-------------------
>  fs/9p/vfs_super.c         |  8 ++--
>  fs/9p/xattr.c             |  8 ++--
>  include/net/9p/client.h   |  3 ++
>  include/trace/events/9p.h | 48 +++++++++++++++++++
>  net/9p/client.c           | 42 +++++++++++------
>  13 files changed, 211 insertions(+), 170 deletions(-)
> 
> -- 
> 2.35.1
> 
