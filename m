Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161D54A02D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiFMUvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350468AbiFMUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:50:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE7E1381A8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:08:39 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id DE7A420C28A2;
        Mon, 13 Jun 2022 13:08:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE7A420C28A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655150919;
        bh=XospWdGbHYHg5WXVT5fW8u5lsaucq+kL7Wo1CwwcVMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6PkvaAdtO/qtQk2lCF6H4LffXHfpy01yoDfJ3XFk9dTVjHUbln+RI66pxu0CosF7
         Q8OaT0IoJFrT2MkxRrHqfAeGevs2soCKvYe1LhLECpoz8JXerJFy2REeTn3Ui3RiMj
         K25Ej+7BMg8LWiVNVjMAXzRMox41n3TAburGA2i8=
Date:   Mon, 13 Jun 2022 15:08:35 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/06] 9p: v9fs_fid_lookup_with_uid fix's fix suggestion
Message-ID: <20220613200835.GG7401@sequoia>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
 <20220612085330.1451496-4-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612085330.1451496-4-asmadeus@codewreck.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-12 17:53:26, Dominique Martinet wrote:
> Tyler, I can just squash this in your commit if you're ok with this,
> as I've already rebased the other patches on top of it.

Yes, that is fine. I've also tested this with my (binary-only)
reproducer and it works as expected.

Thanks!

Tyler

> 
> Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  fs/9p/fid.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index 5a469b79c1ee..baf2b152229e 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -221,12 +221,15 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
>  		 * walk to ensure none of the patch component change
>  		 */
>  		fid = p9_client_walk(fid, l, &wnames[i], clone);
> -		p9_client_clunk(old_fid);
> +		/* non-cloning walk will return the same fid */
> +		if (fid != old_fid) {
> +			p9_client_clunk(old_fid);
> +			old_fid = fid;
> +		}
>  		if (IS_ERR(fid)) {
>  			kfree(wnames);
>  			goto err_out;
>  		}
> -		old_fid = fid;
>  		i += l;
>  		clone = 0;
>  	}
> -- 
> 2.35.1
> 
