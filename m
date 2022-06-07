Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E154006C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244907AbiFGNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFGNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:47:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F21A390;
        Tue,  7 Jun 2022 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654609645; x=1686145645;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PJdnobkYo/Zla5LJJXMvO7fy98qmm6tAkYvl7osPsnE=;
  b=Ru/KYz3CPzVjM9bjAXni1ef8Y7/i2ZTV5RkgqMOnH2v/bEOGcMdieXsA
   hW1j9bEdEUThD256PwofPGHAsoazM5Yw9U5ITv47um3PGBZHYg69eOKZN
   2ENGjbayYuyeqa6ZhyszmiyhAqvRiA+uBk8wXE0vMxCoC6eT29v68MsqD
   qqeJBZkHyRK8nl6YigUkf/CKjQ/9B0uHtKR+RQQS+aXG+KnMaTxgoVhNh
   sVuxNRNR+I0qVtbvbux76wmWWPYk8Dtv7hV52uX0ig2raIzAism05GPzx
   LE7O2fcpjPzjeXgAMbu9+9qKLSG6bQDgCb8XKvDm035RAy1A2VXhSzUO5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302083520"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="302083520"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:47:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636131988"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 06:47:23 -0700
Date:   Tue, 7 Jun 2022 16:47:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/36] tty/vt: consolemap: introduce UNI_*() macros
In-Reply-To: <20220607104946.18710-10-jslaby@suse.cz>
Message-ID: <2e2623a0-4b9f-f15d-78e0-d6e335bdcdff@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-10-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The code currently does shift, OR, and AND logic directly in the code.
> It is not much obvious what happens there. Therefore define four macros
> for that purpose and use them in the code. We use GENMASK() so that it
> is clear which bits serve what purpose:
> - UNI_GLYPH: bits  0.. 5
> - UNI_ROW:   bits  6..10
> - UNI_DIR:   bits 11..31
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/consolemap.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 016c1a0b4290..e5fd225e87bd 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -190,6 +190,11 @@ static int inv_translate[MAX_NR_CONSOLES];
>  #define UNI_DIR_ROWS	32U
>  #define UNI_ROW_GLYPHS	64U
>  
> +#define UNI_DIR(uni)		( (uni)                   >> 11)
> +#define UNI_ROW(uni)		(((uni) & GENMASK(10, 6)) >>  6)

This is opencoding what FIELD_GET() does. Maybe just define these as 
masks and use FIELD_GET in the code below.

> +#define UNI_GLYPH(uni)		( (uni) & GENMASK( 5, 0))
> +#define UNI(dir, row, glyph)	(((dir) << 11) | ((row) << 6) | (glyph))
>
>  /**
>   * struct uni_pagedict -- unicode directory
>   *
> @@ -265,7 +270,7 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
>  				glyph = p2[k];
>  				if (glyph >= 0 && glyph < MAX_GLYPH
>  					       && q[glyph] < 32)
> -					q[glyph] = (i << 11) | (j << 6) | k;
> +					q[glyph] = UNI(i, j, k);
>  			}
>  		}
>  	}
> @@ -497,7 +502,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
>  	int i, n;
>  	u16 **p1, *p2;
>  
> -	n = unicode >> 11;
> +	n = UNI_DIR(unicode);
>  	p1 = p->uni_pgdir[n];
>  	if (!p1) {
>  		p1 = p->uni_pgdir[n] = kmalloc_array(UNI_DIR_ROWS,
> @@ -508,7 +513,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
>  			p1[i] = NULL;
>  	}
>  
> -	n = (unicode >> 6) & 0x1f;
> +	n = UNI_ROW(unicode);
>  	p2 = p1[n];
>  	if (!p2) {
>  		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
> @@ -518,7 +523,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
>  		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
>  	}
>  
> -	p2[unicode & 0x3f] = fontpos;
> +	p2[UNI_GLYPH(unicode)] = fontpos;
>  	
>  	p->sum += (fontpos << 20U) + unicode;
>  
> @@ -788,7 +793,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
>  						continue;
>  					if (ect < ct) {
>  						unilist[ect].unicode =
> -							(i<<11) | (j<<6) | k;
> +							UNI(i, j, k);
>  						unilist[ect].fontpos = *p2;
>  					}
>  					ect++;
> @@ -857,9 +862,9 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
>  		return -3;
>  
>  	p = *conp->vc_uni_pagedir_loc;
> -	if ((p1 = p->uni_pgdir[ucs >> 11]) &&
> -	    (p2 = p1[(ucs >> 6) & 0x1f]) &&
> -	    (h = p2[ucs & 0x3f]) < MAX_GLYPH)
> +	if ((p1 = p->uni_pgdir[UNI_DIR(ucs)]) &&
> +	    (p2 = p1[UNI_ROW(ucs)]) &&
> +	    (h = p2[UNI_GLYPH(ucs)]) < MAX_GLYPH)
>  		return h;
>  
>  	return -4;		/* not found */
> 

-- 
 i.

