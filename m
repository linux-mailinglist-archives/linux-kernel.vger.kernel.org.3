Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742D24EA2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiC1WP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiC1WP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC23E28AB0C;
        Mon, 28 Mar 2022 15:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D6D06153C;
        Mon, 28 Mar 2022 21:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2256EC340ED;
        Mon, 28 Mar 2022 21:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648503699;
        bh=9eqkVxFD2Kacygi3vpts5s7jHVaoYVLrpTEOsLr633g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iwtsvsquYmktNJv8VP8HpQuVK5fGfsDyhzEUyqXltnwCxdS6QM0kQiBdTRAm8tOJC
         C4k5B5iKOj3EoQB0TR2BPr6bdUkZl3RVdD8ihegsc2rJWvSf6ucKDwmv2bW2gUyjq4
         hmz+ZPOU3HEZw0t1gK+b/ThDLnxqPfMFT6u4629/CHQ4ulGr2jBo0TUTmd1Jbe1hTZ
         Y6ZIu/dQA7rtRt1BHoTo5+D/CkWYdcIPczyshJtLIN7NgatzcdsoSsH4MHPf+WK2xe
         FyTNJHbP+JNNc2oHQtdIsYMxPbonBF8Nv0RRh7RpIr39TuCc/qqnvoJs6RkXVaNNMj
         HCfX3KZCIOsyw==
Message-ID: <9b799a29ec8bc87386bc370a03a11b33ac948209.camel@kernel.org>
Subject: Re: [PATCH v2] ceph: remove unused CEPH_MDS_LEASE_RELEASE related
 code
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Mar 2022 17:41:37 -0400
In-Reply-To: <20220328131026.923174-1-xiubli@redhat.com>
References: <20220328131026.923174-1-xiubli@redhat.com>
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

On Mon, 2022-03-28 at 21:10 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> ceph_mdsc_lease_release was removed by commit 8aa152c77890 (ceph:
> remove ceph_mdsc_lease_release). ceph_mdsc_lease_send_msg will never
> call this function with CEPH_MDS_LEASE_RELEASE.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 459c6f23915f..a89ee866ebbb 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4424,12 +4424,6 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
>  	memcpy((void *)(lease + 1) + 4,
>  	       dentry->d_name.name, dentry->d_name.len);
>  	spin_unlock(&dentry->d_lock);
> -	/*
> -	 * if this is a preemptive lease RELEASE, no need to
> -	 * flush request stream, since the actual request will
> -	 * soon follow.
> -	 */
> -	msg->more_to_follow = (action == CEPH_MDS_LEASE_RELEASE);
>  
>  	ceph_con_send(&session->s_con, msg);
>  }

Reviewed-by: Jeff Layton <jlayton@kernel.org>
