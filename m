Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F15402BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbiFGPta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344308AbiFGPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:49:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A8F33A0;
        Tue,  7 Jun 2022 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654616952; x=1686152952;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=48gb7mAGbeYhtSJ293emSdKyHKxm0Jm2EjcSJnSpD8Y=;
  b=n5qWRIJhU/zAcNCgs027VlkEar+6FauiinVEu+bJjgrQac4JdT/6Ij9Y
   8rX8kn0w/jizDNB2JCzYPJ6DTCMuR0oI4WBCe6qtzD4GjB4rzx1A4Bpkm
   nRgxRlKNCwfCKCQJe2aEaMQzaxYE+f9YW/iSQgxgYJARoVvvrNiUnel2P
   /wlBM6e9dE2S7kh1wKvQaywoPx3OwbJZC1XkWO11xOx+24H7B6dvjyIP+
   Lty15KuytxDG//AJZ21+IFGDG9zCX9vJX30hrvxuNMeyW2W3QWGVOt3Pl
   ozkYRFMk63u7ah9WXkVG6fSmm34jx6gmNiHljW0eTX9p8Ql7Xmlv0JOuW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277578306"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277578306"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:31:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584245532"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:31:56 -0700
Date:   Tue, 7 Jun 2022 18:31:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 33/36] tty/vt: consolemap: change refcount only if needed
 in con_do_clear_unimap()
In-Reply-To: <20220607104946.18710-33-jslaby@suse.cz>
Message-ID: <ce9f52c5-4b46-77a8-8dd4-1de787e5b8b@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-33-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1422709916-1654615917=:1622"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1422709916-1654615917=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> con_do_clear_unimap() currently decreases and increases refcount of old
> dictionary in a back and forth fashion. This makes the code really hard
> to follow. Decrease the refcount only if everything went well and we
> really allocated a new one and decoupled from the old dictionary.
> 
> I sincerelly hope I did not make a mistake in this (ill) logic.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

It seems fine:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

One unrelated comment below for additional cleanup opportunity.

> ---
>  drivers/tty/vt/consolemap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 01b7e49f1f91..4d8efe74315c 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -535,22 +535,23 @@ static int con_do_clear_unimap(struct vc_data *vc)
>  {
>  	struct uni_pagedict *old = *vc->vc_uni_pagedir_loc;
>  
> -	if (!old || --old->refcount) {
> +	if (!old || old->refcount > 1) {
>  		struct uni_pagedict *new = kzalloc(sizeof(*new), GFP_KERNEL);
> -		if (!new) {
> -			if (old)
> -				old->refcount++;
> +		if (!new)
>  			return -ENOMEM;
> -		}
> +
>  		new->refcount = 1;
>  		*vc->vc_uni_pagedir_loc = new;
> +
> +		if (old)
> +			old->refcount--;
>  	} else {
>  		if (old == dflt)
>  			dflt = NULL;

This seems unnecessary as con_release_unimap() already does it.

> -		old->refcount++;
>  		old->sum = 0;
>  		con_release_unimap(old);
>  	}
> +
>  	return 0;
>  }
>  
> 

-- 
 i.

--8323329-1422709916-1654615917=:1622--
