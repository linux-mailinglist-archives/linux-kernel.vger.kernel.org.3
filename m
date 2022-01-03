Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB1483773
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiACTN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiACTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:13:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22FC061761;
        Mon,  3 Jan 2022 11:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76CA6B8106C;
        Mon,  3 Jan 2022 19:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183B8C36AED;
        Mon,  3 Jan 2022 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641237202;
        bh=i3/8XCzxXTG7v74n9n4aYeuVx0GK3Q93dUdM+qhv2Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/A9zSrHJlwC5Y6SHrPGxuwaM+wNvf+xL/qmdUM46ogjUaKoO/054BpHZnKowWyAc
         stKh+55cTBJf98WrLDoWbDdjE6MDWoD8iZwhUQqip2aE/NkWCcipO1NuFBY3XWubkG
         zodoRDI6vWN98sKf8oDTLaemZYAs0dfV3UatgjhJrGgK6rADAAKJxK6wEgwpPyX42h
         QnnlHrJ+GK1Kc5HWnsFwt3zGtUOLUdpl4MAt0qYD6yGGE8J+F00n6iC5Ja1sa95iTp
         GGZtZ4ZR/XO2exSjZreC3tpk84RxHECJuLS6IksTbuH0Sus2+ZVU3XmZX5gPHwT1rk
         0rhtC0a9PYvqQ==
Date:   Mon, 3 Jan 2022 11:13:21 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: sysfs: use default_groups in kobj_type
Message-ID: <20220103191321.GA31583@magnolia>
References: <20211228144641.392347-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228144641.392347-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 03:46:41PM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the xfs sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks good to me.  Shall I take this through the xfs tree?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_error.c |  3 ++-
>  fs/xfs/xfs_sysfs.c | 16 ++++++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
> index 81c445e9489b..749fd18c4f32 100644
> --- a/fs/xfs/xfs_error.c
> +++ b/fs/xfs/xfs_error.c
> @@ -213,11 +213,12 @@ static struct attribute *xfs_errortag_attrs[] = {
>  	XFS_ERRORTAG_ATTR_LIST(ag_resv_fail),
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(xfs_errortag);
>  
>  static struct kobj_type xfs_errortag_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_errortag_sysfs_ops,
> -	.default_attrs = xfs_errortag_attrs,
> +	.default_groups = xfs_errortag_groups,
>  };
>  
>  int
> diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
> index 8608f804388f..574b80c29fe1 100644
> --- a/fs/xfs/xfs_sysfs.c
> +++ b/fs/xfs/xfs_sysfs.c
> @@ -67,11 +67,12 @@ static const struct sysfs_ops xfs_sysfs_ops = {
>  static struct attribute *xfs_mp_attrs[] = {
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(xfs_mp);
>  
>  struct kobj_type xfs_mp_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
> -	.default_attrs = xfs_mp_attrs,
> +	.default_groups = xfs_mp_groups,
>  };
>  
>  #ifdef DEBUG
> @@ -239,11 +240,12 @@ static struct attribute *xfs_dbg_attrs[] = {
>  #endif
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(xfs_dbg);
>  
>  struct kobj_type xfs_dbg_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
> -	.default_attrs = xfs_dbg_attrs,
> +	.default_groups = xfs_dbg_groups,
>  };
>  
>  #endif /* DEBUG */
> @@ -296,11 +298,12 @@ static struct attribute *xfs_stats_attrs[] = {
>  	ATTR_LIST(stats_clear),
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(xfs_stats);
>  
>  struct kobj_type xfs_stats_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
> -	.default_attrs = xfs_stats_attrs,
> +	.default_groups = xfs_stats_groups,
>  };
>  
>  /* xlog */
> @@ -381,11 +384,12 @@ static struct attribute *xfs_log_attrs[] = {
>  	ATTR_LIST(write_grant_head),
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(xfs_log);
>  
>  struct kobj_type xfs_log_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
> -	.default_attrs = xfs_log_attrs,
> +	.default_groups = xfs_log_groups,
>  };
>  
>  /*
> @@ -534,12 +538,12 @@ static struct attribute *xfs_error_attrs[] = {
>  	ATTR_LIST(retry_timeout_seconds),
>  	NULL,
>  };
> -
> +ATTRIBUTE_GROUPS(xfs_error);
>  
>  static struct kobj_type xfs_error_cfg_ktype = {
>  	.release = xfs_sysfs_release,
>  	.sysfs_ops = &xfs_sysfs_ops,
> -	.default_attrs = xfs_error_attrs,
> +	.default_groups = xfs_error_groups,
>  };
>  
>  static struct kobj_type xfs_error_ktype = {
> -- 
> 2.34.1
> 
