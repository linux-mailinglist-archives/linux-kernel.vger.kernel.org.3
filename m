Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6825484EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiAEHaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:30:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:59474 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbiAEHax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641367853; x=1672903853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PFxCRpiRZz9sfwV8pZiuAMMSE+ViZkVIA0jUNcNOvHQ=;
  b=UEveNuKEiPED5jPu4PqYpeq8wGH6AfzF+OiS/Ps0JMUEN7PKr+1IuaHl
   gZ3p8wBXgNo2FpoNgIl0n3DzZxnu4f/TGmZfXmyMLiyYT9Sod1j3ii6Po
   YxY3m39Unh01zTPQuD2wWDHxMnjrfpyUaKiz5SNafjtfG136NHTrOMobT
   A0nrMnzmjmgLzfXOM0A7dRJXj72nq9ccMFPu8OdJ8nIO/cRDXWBRZtScT
   Yoe3ffD6fapjgsBUX1rL2b29uni0Fy5gLtM/p8BfV5LFwpYYR1aeHvRkj
   rzHLyU1HSaWG/MYCeRSmN+CTvLCfp9VQCKH4lAPMMD7CHDI9zaS8Ty+Nb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242344449"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242344449"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 23:30:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="590933141"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 23:30:49 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Jan 2022 09:30:47 +0200
Date:   Wed, 5 Jan 2022 09:30:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt:  Check for null pointer after calling
 kmemdup
Message-ID: <YdVJJ3PLZuSfrHzU@lahna>
References: <20220105064244.2316847-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105064244.2316847-1-jiasheng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 05, 2022 at 02:42:44PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the allocation, kmemdup() may return NULL
> pointer.
> Like alloc_switch(), it might be better to check it.
> Therefore, icm_icl_set_uuid() and icm_handle_event() should also check
> the return value of kmemdup().
> As for icm_icl_set_uuid(), which is assigned to icm->set_uuid, the
> return value of icm->set_uuid needs to check.
> And for icm_handle_event(), just free 'n' and directly return is enough,
> same as the way to handle the failure of kmalloc().

This is doing two things so I suggest sending two patches instead.
However, for the UUID part, I think it works fine if we get NULL (and I
think kmemdup() issues warning too).

> Fixes: 3cdb9446a117 ("thunderbolt: Add support for Intel Ice Lake")
> Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")

There are probably not needed either since the "fix" here is for pretty
rare case of running out of memory. I think there is not even a NULL
pointer dereference because UUID is optional.

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/thunderbolt/icm.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 2f30b816705a..09ab31ea9128 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -109,7 +109,7 @@ struct icm {
>  	int (*driver_ready)(struct tb *tb,
>  			    enum tb_security_level *security_level,
>  			    u8 *proto_version, size_t *nboot_acl, bool *rpm);
> -	void (*set_uuid)(struct tb *tb);
> +	int (*set_uuid)(struct tb *tb);
>  	void (*device_connected)(struct tb *tb,
>  				 const struct icm_pkg_header *hdr);
>  	void (*device_disconnected)(struct tb *tb,
> @@ -1643,7 +1643,7 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
>  	return 0;
>  }
>  
> -static void icm_icl_set_uuid(struct tb *tb)
> +static int icm_icl_set_uuid(struct tb *tb)
>  {
>  	struct tb_nhi *nhi = tb->nhi;
>  	u32 uuid[4];
> @@ -1654,6 +1654,10 @@ static void icm_icl_set_uuid(struct tb *tb)
>  	uuid[3] = 0xffffffff;
>  
>  	tb->root_switch->uuid = kmemdup(uuid, sizeof(uuid), GFP_KERNEL);
> +	if (!tb->root_switch->uuid)
> +		return -ENOMEM;
> +
> +	return 0;
>  }
>  
>  static void
> @@ -1739,6 +1743,11 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
>  
>  	INIT_WORK(&n->work, icm_handle_notification);
>  	n->pkg = kmemdup(buf, size, GFP_KERNEL);
> +	if (!n->pkg) {
> +		kfree(n);
> +		return;
> +	}
> +
>  	n->tb = tb;
>  
>  	queue_work(tb->wq, &n->work);
> @@ -2152,8 +2161,11 @@ static int icm_start(struct tb *tb)
>  	tb->root_switch->no_nvm_upgrade = !icm->can_upgrade_nvm;
>  	tb->root_switch->rpm = icm->rpm;
>  
> -	if (icm->set_uuid)
> -		icm->set_uuid(tb);
> +	if (icm->set_uuid) {
> +		ret = icm->set_uuid(tb);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = tb_switch_add(tb->root_switch);
>  	if (ret) {
> -- 
> 2.25.1
