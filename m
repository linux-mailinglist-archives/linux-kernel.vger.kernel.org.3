Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B85A9C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiIAQIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiIAQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE3923FA;
        Thu,  1 Sep 2022 09:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE13A61F59;
        Thu,  1 Sep 2022 16:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56638C433D6;
        Thu,  1 Sep 2022 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662048513;
        bh=eIhctK8SYZVGzBDfi2TjBEV1IDQq15uxmBiHJNqgDy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUBOtS/nmF0dCFVfjIxjp4X09wVKFYTBmhLB2kLMmuwEvy326c59MNrcndkFQXEoA
         eL+38c3uP2GCEpfR8Z9GTuBkZCK4upmhCfTXCM6a51fAl1y426n5w5TKehuWSvT+rH
         FVJ7R+2zE8rNn96HutrL8tXdGbBkA0MnogLKuVAsfu7WbWl03KB30vhmh/9gY1nmbO
         EYzcIrjurKIemSrixbax4RCHpX8hmNh8rYktIXHFo+FX2VJotnMU2HpTgA3lvqQrRa
         J0n460Gj6KlNobDXmF8yiX+H1nnH+8tlJS5Ad2xanb/AlEx+jwBV6/wAg7bz7R+Rk/
         4t6ETxxSYCxKw==
Date:   Thu, 1 Sep 2022 09:08:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
Subject: Re: [PATCH v2] xfs: donot need to check return value of
 xlog_kvmalloc()
Message-ID: <YxDZAP8zfQFqWFWY@magnolia>
References: <471db2ec-8836-14f5-fb33-579b294943e9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471db2ec-8836-14f5-fb33-579b294943e9@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:59:08AM +0800, Zhiqiang Liu wrote:
> In xfs_attri_log_nameval_alloc(), xlog_kvmalloc() is called
> to alloc memory, which will always return
> successfully, so we donot need to check return value.
> 
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Makes sense...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> Changelog:
> V1 -> V2:
>   1.add Reviewed-by: Eric Sandeen <sandeen@redhat.com>
>   2.remove santity check of xfs_attri_log_nameval_alloc()
>     suggested by Eric Sandeen.
> 
>  fs/xfs/xfs_attr_item.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
> index 5077a7ad5646..cf5ce607dc05 100644
> --- a/fs/xfs/xfs_attr_item.c
> +++ b/fs/xfs/xfs_attr_item.c
> @@ -86,8 +86,6 @@ xfs_attri_log_nameval_alloc(
>  	 */
>  	nv = xlog_kvmalloc(sizeof(struct xfs_attri_log_nameval) +
>  					name_len + value_len);
> -	if (!nv)
> -		return nv;
> 
>  	nv->name.i_addr = nv + 1;
>  	nv->name.i_len = name_len;
> @@ -441,8 +439,6 @@ xfs_attr_create_intent(
>  		attr->xattri_nameval = xfs_attri_log_nameval_alloc(args->name,
>  				args->namelen, args->value, args->valuelen);
>  	}
> -	if (!attr->xattri_nameval)
> -		return ERR_PTR(-ENOMEM);
> 
>  	attrip = xfs_attri_init(mp, attr->xattri_nameval);
>  	xfs_trans_add_item(tp, &attrip->attri_item);
> @@ -762,8 +758,6 @@ xlog_recover_attri_commit_pass2(
>  	nv = xfs_attri_log_nameval_alloc(attr_name,
>  			attri_formatp->alfi_name_len, attr_value,
>  			attri_formatp->alfi_value_len);
> -	if (!nv)
> -		return -ENOMEM;
> 
>  	attrip = xfs_attri_init(mp, nv);
>  	error = xfs_attri_copy_format(&item->ri_buf[0], &attrip->attri_format);
> -- 
> 2.33.0
> 
