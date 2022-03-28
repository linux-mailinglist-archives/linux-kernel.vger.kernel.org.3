Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99CD4E9283
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiC1KaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiC1KaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:30:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C22522D8;
        Mon, 28 Mar 2022 03:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B035FB80FC0;
        Mon, 28 Mar 2022 10:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1411C340F0;
        Mon, 28 Mar 2022 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648463303;
        bh=mbW5lOE0DiwZdxys0cKvpTjDkJc1/stJnOezmtZoeSY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JXWSYY8sovEf/LSZ79BbS/TkTb4uxARjJVpjLYdk3R+LH36tDuhsMWWJlNKZ5pQpg
         WXsWCYqqtps+5zv61bLMSzPNdvxdlH+OvsuB5EYL4ErDQYWShFsFSYYXTq8F6Wt4+2
         nbfq1vN8eCO2JwT2/VYWmLKfzidzIfx1LdS2eqS3wCBuB/muzU1SZc1Owo1uwp44oa
         s4QhlKD0s0uUrvQNJLATtyep1XI1qWTrLPBlq6xZzKZj8FT5aTOpl2MRmXnZkH7kgr
         tKyMU3jOgI7xUrF7OIzrR+Nm6nZ3swnMPkj6+0DMNcvtiWfvnDIIHHwaHH46O3E7Pl
         KBiGqwecokyyA==
Message-ID: <cd928bbbba3260dfe6ce4a964185a377b4a767cd.camel@kernel.org>
Subject: Re: [PATCH] ceph: remove unused CEPH_MDS_LEASE_RELEASE related code
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Mar 2022 06:28:21 -0400
In-Reply-To: <20220328022535.847164-1-xiubli@redhat.com>
References: <20220328022535.847164-1-xiubli@redhat.com>
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

On Mon, 2022-03-28 at 10:25 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The ceph_mdsc_lease_release() has been removed by commit(8aa152c77890)
> and the CEPH_MDS_LEASE_RELEASE will never be used.
> 

Like it says in Documentation/process/5.Posting.rst:

"...and please provide both the commit ID and the title when citing
commits"

You might want to reword this with something like:

"ceph_mdsc_lease_release was removed by commit 8aa152c77890 (ceph:
remove ceph_mdsc_lease_release). ceph_mdsc_lease_send_msg will never
call this function with CEPH_MDS_LEASE_RELEASE."

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

It might be possible to trim this function back further. There's only
one caller and it always calls this with the same "action" value. Still,
this looks fine...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
