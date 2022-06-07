Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161C54009B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbiFGOBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbiFGOAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:00:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75FCC1EC0;
        Tue,  7 Jun 2022 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654610454; x=1686146454;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D7BshuRzvKV/lcPeklXlMOIDPXC7Yjkcl9zS17XOQrM=;
  b=BQky4QjXbPkXbxFPUgKtoiJo7V5vrYX3fMpIrsKTyxSqRI5eTHZRw4ya
   UHI66FvwamSe7GsVR+rgLx83vwaF5QZo3aG6AdQn5I/x+fWJ1+1KzwGZD
   kXpx6+JVjxK7myf5P5h+a9nltLbfIaiJjY54L3q2tnnHx0DuCN7HelvD8
   k1m8ylgmC677vuBoywVxmdWiSi6n0DNrJdKZiWz+yanofpiIlkdDdu8Gu
   oYx77GheRvTcgPHx4XgNF5eo+PiS3Kan3eBfU9RihaukuY6GaJ8hZZyas
   ja6+5PeFQIrf5SWMw6xTCZI2+K5CInxyeS0nE3oI56RPaTj4YJmJTX5kG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277526544"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277526544"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:00:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584208831"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:00:48 -0700
Date:   Tue, 7 Jun 2022 17:00:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/36] tty/vt: consolemap: use sizeof(*pointer) instead
 of sizeof(type)
In-Reply-To: <20220607104946.18710-12-jslaby@suse.cz>
Message-ID: <8c809bd0-552d-8027-a1a7-96b77369d06e@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-12-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-420996245-1654610449=:1622"
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

--8323329-420996245-1654610449=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> It is preferred to use sizeof(*pointer) instead of sizeof(type). First,
> the type of the variable can change and one needs not change the former
> (unlike the latter). Second, the latter is error-prone due to (u16),
> (u16 *), and (u16 **) mixture here.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

This seems fine but see the comments below which are not directly related 
to the change itself.

> ---
>  drivers/tty/vt/consolemap.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 097ab7d01f8b..79a62dcca046 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -251,12 +251,12 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
>  		return;
>  	q = p->inverse_trans_unicode;
>  	if (!q) {
> -		q = p->inverse_trans_unicode =
> -			kmalloc_array(MAX_GLYPH, sizeof(u16), GFP_KERNEL);
> +		q = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
> +				sizeof(*q), GFP_KERNEL);
>  		if (!q)
>  			return;
>  	}
> -	memset(q, 0, MAX_GLYPH * sizeof(u16));
> +	memset(q, 0, MAX_GLYPH * sizeof(*q));

Convert kmalloc_array into kcalloc and place memset() into else branch?

>  	for (i = 0; i < UNI_DIRS; i++) {
>  		p1 = p->uni_pgdir[i];
> @@ -478,8 +478,8 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
>  					continue;
>  				if (!p1[k] || !q1[k])
>  					break;
> -				if (memcmp(p1[k], q1[k],
> -						UNI_ROW_GLYPHS * sizeof(u16)))
> +				if (memcmp(p1[k], q1[k], UNI_ROW_GLYPHS *
> +							sizeof(*p1[k])))
>  					break;
>  			}
>  			if (k < UNI_DIR_ROWS)
> @@ -505,7 +505,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
>  	n = UNI_DIR(unicode);
>  	p1 = p->uni_pgdir[n];
>  	if (!p1) {
> -		p1 = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(u16 *),
> +		p1 = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(*p1),
>  				GFP_KERNEL);
>  		if (!p1)
>  			return -ENOMEM;
> @@ -514,11 +514,12 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
>  	n = UNI_ROW(unicode);
>  	p2 = p1[n];
>  	if (!p2) {
> -		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
> +		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(*p2),
> +				GFP_KERNEL);
>  		if (!p2)
>  			return -ENOMEM;
>  		/* No glyphs for the characters (yet) */
> -		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
> +		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(*p2));

This could have been kcalloc'ed.


-- 
 i.

--8323329-420996245-1654610449=:1622--
