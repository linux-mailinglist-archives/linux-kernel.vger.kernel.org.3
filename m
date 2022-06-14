Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98FD54ABDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiFNIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiFNIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:35:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428803CA52;
        Tue, 14 Jun 2022 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655195722; x=1686731722;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u3sRGLAkfFL/sgBy0Sm3AS3ifOZuCvaq5rzaaEC09fk=;
  b=hgw8ruxFotowZLI4pSWH/GU2qdQI36j7brMb2DQIfnrJfGXl+LslhJD9
   tzpj9xTlk6BbF8YwopgS+pbyuE2pH/cMjWFwhATcueRUHf1xBypmgYjrj
   EfyR32TBVO6SrkhzZuxmCqFMqd1KErJafWHyUQ6Jfai3L7vupEt1oXum8
   iBOwHMbKRY3Zt5xUU1IUn0K+yFpDTrjhGQr5QzDOx6v3PY+WrRGzutPQh
   w+rmrMbKYqYFL064/uAVgj1XABlC2NdP6/5OQGVeEjjhKpNcuAzm5G+JG
   YdKcPKaXhNGHyNXdgeEMr9lirqdIftFejEMUisBrkjWyS6lNSP5bdZM4u
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278589233"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="278589233"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:35:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640219457"
Received: from jlaghzal-mobl1.ger.corp.intel.com ([10.252.32.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:35:20 -0700
Date:   Tue, 14 Jun 2022 11:35:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] tty/vt: consolemap: saner variable names in
 set_inverse_transl()
In-Reply-To: <20220614075713.32767-4-jslaby@suse.cz>
Message-ID: <74fc76bf-a7f-be34-10cd-412234990f1@linux.intel.com>
References: <20220614075713.32767-1-jslaby@suse.cz> <20220614075713.32767-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1912782543-1655195721=:1605"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1912782543-1655195721=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 14 Jun 2022, Jiri Slaby wrote:

> The function uses too vague variable names like i, j, k for iterators, p,
> q, p1, p2 for pointers etc.
> 
> Rename all these, so that it is clear what is going on:
> - dict: for dictionaries.
> - d, r, g: for dir, row, glyph iterators -- these are unsigned now.
> - dir, row: for directory and row pointers.
> - glyph: for the glyph.
> - and so on...
> 
> This is a lot of shuffling, but the result pays off, IMO.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/consolemap.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index a69dfda8e3d0..3d0e10dac6d9 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -214,29 +214,29 @@ struct uni_pagedict {
>  
>  static struct uni_pagedict *dflt;
>  
> -static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
> +static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *dict,
>  	       enum translation_map m)
>  {
> -	int j, glyph;
>  	unsigned short *t = translations[m];
> -	unsigned char *q;
> +	unsigned char *inv;
>  
> -	if (!p)
> +	if (!dict)
>  		return;
> -	q = p->inverse_translations[m];
> +	inv = dict->inverse_translations[m];
>  
> -	if (!q) {
> -		q = p->inverse_translations[m] = kmalloc(MAX_GLYPH, GFP_KERNEL);
> -		if (!q)
> +	if (!inv) {
> +		inv = dict->inverse_translations[m] = kmalloc(MAX_GLYPH,
> +				GFP_KERNEL);
> +		if (!inv)
>  			return;
>  	}
> -	memset(q, 0, MAX_GLYPH);
> +	memset(inv, 0, MAX_GLYPH);
>  
> -	for (j = 0; j < ARRAY_SIZE(translations[i]); j++) {
> -		glyph = conv_uni_to_pc(conp, t[j]);
> -		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
> +	for (unsigned int ch = 0; ch < ARRAY_SIZE(translations[m]); ch++) {

This removes the compile error you introduced earlier. Other than that:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> +		int glyph = conv_uni_to_pc(conp, t[ch]);
> +		if (glyph >= 0 && glyph < MAX_GLYPH && inv[glyph] < 32) {
>  			/* prefer '-' above SHY etc. */
> -			q[glyph] = j;
> +			inv[glyph] = ch;
>  		}
>  	}
>  }
> 

-- 
 i.

--8323329-1912782543-1655195721=:1605--
