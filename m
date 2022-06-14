Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF88454AB93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiFNIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiFNIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:17:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853423165;
        Tue, 14 Jun 2022 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655194649; x=1686730649;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tJSdpR3cy5y8n5BrL5O3gIawcza3XRTmmQVzgQ3ek70=;
  b=XYPX9rGdUgYPynaQm9+CO6SSO1An86YznjKKVzVmOppNIqKdoTdGqaWF
   UZbh25xrepNYie6B98cSAD2j5BwKEWjgGgPMLvYEB+oJRYuNBbQxvBDcJ
   YkNMDOCXBusN3LYi6PMHjHc1dZM5yScYj8ZZX+yYs3k6/NxJLuTQhym/p
   kt0XR3p4xSl7poP/nE1fzt20r9Yw0hLIPvliqXExIJmXgDV8Co6flVt93
   SVzqUZGAQ8KGcFvcGhwr9FjQigahDXVSRYGmQbVBB/6mkszUyYR6IwRrU
   5UTUXdlZlkdSrOUEc+WOT73XMnOV2niJrwCogKouqkBFdgVlLdp0wbu5P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261579607"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261579607"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:17:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640211422"
Received: from jlaghzal-mobl1.ger.corp.intel.com ([10.252.32.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:17:27 -0700
Date:   Tue, 14 Jun 2022 11:17:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] tty/vt: consolemap: use ARRAY_SIZE(), part II.
In-Reply-To: <20220614075713.32767-1-jslaby@suse.cz>
Message-ID: <68107f11-58bb-5c55-8f45-891717d08d33@linux.intel.com>
References: <20220614075713.32767-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-87723546-1655194648=:1605"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-87723546-1655194648=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 14 Jun 2022, Jiri Slaby wrote:

> The code still uses constants (macros) as bounds in loops after commit
> 17945d317a52 (tty/vt: consolemap: use ARRAY_SIZE()). The contants are at
> least macros used also in the definition of the arrays. But use
> ARRAY_SIZE() on two more places to ensure the loops never run out of
> bounds even if the array definition change.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/consolemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index fff97ae87e00..8aa7a48b3647 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -232,7 +232,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
>  	}
>  	memset(q, 0, MAX_GLYPH);
>  
> -	for (j = 0; j < E_TABSZ; j++) {
> +	for (j = 0; j < ARRAY_SIZE(translations[i]); j++) {

Any particular reason why you left its definition to have 256 instead of 
E_TABSZ (even after the patch series I mean):

static unsigned short translations[][256] = {


>  		glyph = conv_uni_to_pc(conp, t[j]);
>  		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
>  			/* prefer '-' above SHY etc. */
> @@ -367,7 +367,7 @@ int con_get_trans_old(unsigned char __user * arg)
>  	unsigned char outbuf[E_TABSZ];
>  
>  	console_lock();
> -	for (i = 0; i < E_TABSZ ; i++)
> +	for (i = 0; i < ARRAY_SIZE(outbuf); i++)
>  	{
>  		ch = conv_uni_to_pc(vc_cons[fg_console].d, p[i]);
>  		outbuf[i] = (ch & ~0xff) ? 0 : ch;
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-87723546-1655194648=:1605--
