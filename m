Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B04CDC18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiCDSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiCDSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:18:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8A6344;
        Fri,  4 Mar 2022 10:17:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25003B827FA;
        Fri,  4 Mar 2022 18:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5FC340E9;
        Fri,  4 Mar 2022 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646417846;
        bh=8p/bTfZgdl3Yp2AL0wxkCRMjW2/exF31PYWxmfLOaRA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ro+FIe3EQJuIYZRUgqHYO8s9E5H30mPdXPnDV84mJP58T/+GlO9DLvWkzZoYKnzJS
         pI1/mMb5zXTlMwTdfilL9ay3ngeLyDqYXvvpwrrmHou+i2wAw6SnNN00Ob8KqWXlDX
         bXsezySAQuKEq/ryjVnP+qRccL2xDKYwh27P7VLIulzsCoSP0QNHKCX7iaPACudeWO
         xPrNYBTAuUtmoO9uEkc6KrpqQSSWaO8x1XqhMvxIxY4jV0I/8A3aUG3b/RVej5jS64
         Wk14JU1ln1HIUOwDLIuE/94HnSDPib6Nlw/8p/bY5jOFpk10aKneitTHhAoyMDybty
         bg/H5UNZldlhQ==
Message-ID: <fbf5211f69b5cda372c90d78c6aeee00524fcfbf.camel@kernel.org>
Subject: Re: [PATCH 1/3] ceph: fix error path in ceph_readdir()
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Mar 2022 13:17:24 -0500
In-Reply-To: <20220304161403.19295-2-lhenriques@suse.de>
References: <20220304161403.19295-1-lhenriques@suse.de>
         <20220304161403.19295-2-lhenriques@suse.de>
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
> This was introduced by commit
> 
>   "ceph: add support to readdir for encrypted filenames"
> 
> It will eventually leak the fscrypt_str names in this error path.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/dir.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 44395aae7259..0bcb677d2199 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -500,7 +500,6 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  					       next_offset);
>  			if (err) {
>  				ceph_mdsc_put_request(dfi->last_readdir);
> -				return err;
>  				goto out;
>  			}
>  		} else if (req->r_reply_info.dir_end) {

This doesn't seem to apply to the current wip-fscrypt tree. Are you
working against an older branch, perhaps?

-- 
Jeff Layton <jlayton@kernel.org>
