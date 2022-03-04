Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8614CDC41
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiCDSVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiCDSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:21:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD971D3043;
        Fri,  4 Mar 2022 10:20:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E3C7B82B5D;
        Fri,  4 Mar 2022 18:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE82CC340EE;
        Fri,  4 Mar 2022 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646418033;
        bh=BSziwvpZZbxhrfTDkn6vO1row2wiUu/vJcwcC/LZZSQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AsLApxjFaTn5m4KzvOGFv7haIqJMDTxrGKO64VYZgAKnqDWwnoHBhCfxxPHQBTlt9
         og11A5uNZQMnQv/KitZqFTC5QnrdxsWvluLdcbYU3vhpWcQm4CeYXh1q2rhfbfT7x3
         mpfvOyTDbGex89mFydoHraU8u/TJGP3IeC1rJNoqbWJdkb/tpllxOTjDoxoQ9/RzCo
         flzjjt5ntvtkbsbjV3KQPByoD2LM/vmwRwvvAytM/KUE2jTCmqB89hkhtPmL6Fm4j5
         5Eoieh0HOsvr8rJitcutH+PDLB39tgLtz8YrjtnN6iPexD8fjWmaUTAVIkFO9IL7/K
         raMJrVLsqyXww==
Message-ID: <55c6363a0ef0dcca3e6a7c882783f5d47dbbbdc7.camel@kernel.org>
Subject: Re: [PATCH 2/3] ceph: fix use-after-free in ceph_readdir
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Mar 2022 13:20:31 -0500
In-Reply-To: <20220304161403.19295-3-lhenriques@suse.de>
References: <20220304161403.19295-1-lhenriques@suse.de>
         <20220304161403.19295-3-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 16:14 +0000, Luís Henriques wrote:
> After calling ceph_mdsc_put_request() on dfi->last_readdir, this field
> should be set to NULL, otherwise we may end-up freeing it twince and get
> the following splat:
> 
>   refcount_t: underflow; use-after-free.
>   WARNING: CPU: 0 PID: 229 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
>   ...
>   Call Trace:
>     <TASK>
>     ceph_readdir+0xd35/0x1460 [ceph]
>     ? _raw_spin_unlock+0x12/0x30
>     ? preempt_count_add+0x73/0xa0
>     ? _raw_spin_unlock+0x12/0x30
>     ? __mark_inode_dirty+0x27c/0x3a0
>     iterate_dir+0x7d/0x190
>     __x64_sys_getdents64+0x80/0x120
>     ? compat_fillonedir+0x160/0x160
>     do_syscall_64+0x43/0x90
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 0bcb677d2199..934402f5e9e6 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -555,6 +555,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
>  			dout("filldir stopping us...\n");
>  			ceph_mdsc_put_request(dfi->last_readdir);
> +			dfi->last_readdir = NULL;
>  			err = 0;
>  			goto out;
>  		}

I think Xiubo fixed this in the testing branch late yesterday. It should
no longer be needed.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
