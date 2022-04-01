Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D44EF719
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbiDAPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353896AbiDAPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F43633E;
        Fri,  1 Apr 2022 08:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39756612B9;
        Fri,  1 Apr 2022 15:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7308C2BBE4;
        Fri,  1 Apr 2022 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648826634;
        bh=xWcXQye1OTcqa40wP8K9l3+u3eD7fmDLyJj7urdTmaY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DPYJcJMLE6W6curQMeYfdDhaZminHTICn5OWo5BncOHEinmeF4/zXesta30bj7pxZ
         zO20xAP5UYBZEnHZ58FBLnVR0ydYH86GMNtBONqiRPX6SK/7VILcxVinJi4e+hRIUt
         +POqaO3bvUg9hLZ6paBZC8U8BYeaTGLo7Tc/phLX19KTtUWVWO0rdVUQXY7w0LvT5a
         aDgTa4vKpuoO1J+WlvvGo2irGtnyjJJ0fgpwpSkcn/FNQqhgn/41YifTVGi6oGkC9f
         wDryZ+GzLzMoUBBfeu1K727FQsaFP7yCtawOvzqQTUSoFQ+uDXaqqhIy3e+yvnUyUY
         0UMdFkMJnpsQg==
Message-ID: <fc02b2d29ecb7e277d48afb340b01cdc684e2e5a.camel@kernel.org>
Subject: Re: [PATCH 2/2] ceph: replace usage of found with dedicated list
 iterator variable
From:   Jeff Layton <jlayton@kernel.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Fri, 01 Apr 2022 11:23:52 -0400
In-Reply-To: <20220331215329.882411-2-jakobkoschel@gmail.com>
References: <20220331215329.882411-1-jakobkoschel@gmail.com>
         <20220331215329.882411-2-jakobkoschel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-31 at 23:53 +0200, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  fs/ceph/caps.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 519750bc5a1a..70f9c5ffa9b7 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3179,10 +3179,9 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
>  				struct ceph_snap_context *snapc)
>  {
>  	struct inode *inode = &ci->vfs_inode;
> -	struct ceph_cap_snap *capsnap = NULL;
> +	struct ceph_cap_snap *capsnap = NULL, *iter;
>  	int put = 0;
>  	bool last = false;
> -	bool found = false;
>  	bool flush_snaps = false;
>  	bool complete_capsnap = false;
>  
> @@ -3209,14 +3208,14 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
>  		     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
>  		     last ? " LAST" : "");
>  	} else {
> -		list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
> -			if (capsnap->context == snapc) {
> -				found = true;
> +		list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
> +			if (iter->context == snapc) {
> +				capsnap = iter;
>  				break;
>  			}
>  		}
>  
> -		if (!found) {
> +		if (!capsnap) {
>  			/*
>  			 * The capsnap should already be removed when removing
>  			 * auth cap in the case of a forced unmount.
> @@ -3766,8 +3765,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
>  	u64 follows = le64_to_cpu(m->snap_follows);
> -	struct ceph_cap_snap *capsnap;
> -	bool flushed = false;
> +	struct ceph_cap_snap *capsnap = NULL, *iter;
>  	bool wake_ci = false;
>  	bool wake_mdsc = false;
>  
> @@ -3775,26 +3773,26 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
>  	     inode, ci, session->s_mds, follows);
>  
>  	spin_lock(&ci->i_ceph_lock);
> -	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
> -		if (capsnap->follows == follows) {
> -			if (capsnap->cap_flush.tid != flush_tid) {
> +	list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
> +		if (iter->follows == follows) {
> +			if (iter->cap_flush.tid != flush_tid) {
>  				dout(" cap_snap %p follows %lld tid %lld !="
> -				     " %lld\n", capsnap, follows,
> -				     flush_tid, capsnap->cap_flush.tid);
> +				     " %lld\n", iter, follows,
> +				     flush_tid, iter->cap_flush.tid);
>  				break;
>  			}
> -			flushed = true;
> +			capsnap = iter;
>  			break;
>  		} else {
>  			dout(" skipping cap_snap %p follows %lld\n",
> -			     capsnap, capsnap->follows);
> +			     iter, iter->follows);
>  		}
>  	}
> -	if (flushed)
> +	if (capsnap)
>  		ceph_remove_capsnap(inode, capsnap, &wake_ci, &wake_mdsc);
>  	spin_unlock(&ci->i_ceph_lock);
>  
> -	if (flushed) {
> +	if (capsnap) {
>  		ceph_put_snap_context(capsnap->context);
>  		ceph_put_cap_snap(capsnap);
>  		if (wake_ci)

Thanks Jakob,

Both patches look fine. Applied to the ceph-client/testing branch. This
should make v5.19 if there are no issues.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
