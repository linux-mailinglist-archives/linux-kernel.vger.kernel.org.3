Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6285429B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiFHInk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiFHImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:42:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F6210FBD;
        Wed,  8 Jun 2022 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654675441; x=1686211441;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ohKd5bsxORSUUnTlFzuSnvXpE7owkbKmZu04f7MPi9w=;
  b=Bj5U4NfBVX6EOUsEzP3+kHMzlAdMUqLprilfMcxzi5hGsgE3e/QpshYx
   fTKlll3F3H+6B9jhPreQ27u1hauFDtFdoXIAatli8/5+xI1xb+aE7JIsv
   hDAwwDHPWpOSeSmBaw8j5jxZ0PLKTHsZqWW1qrVwXy2J0MtY25k5EyD+n
   NeXsEkLpHzYeAvQobr7np4UpHauSZzKasJBCYLFRbV5XjelgzAgSbf/BG
   VVpIM/zqPzwFTAxEBL0FwEOVnjlihuNUkCwb6aJL0Xk17zzw/r8eFBlf4
   BUwtH2inID6CK3brLUXzN44TgxkovXctbJkb2EVvaStumi4/qPVt+2dFj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="363143797"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="363143797"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:02:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636663935"
Received: from bmichals-mobl.ger.corp.intel.com ([10.252.57.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:02:35 -0700
Date:   Wed, 8 Jun 2022 11:02:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/36] tty/vt: consolemap: introduce UNI_*() macros
In-Reply-To: <e9fdf394-9dd2-b1d3-29c9-66eb3353c0ec@kernel.org>
Message-ID: <96808a-1c54-ed9b-ea35-565f49a6f360@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-10-jslaby@suse.cz> <2e2623a0-4b9f-f15d-78e0-d6e335bdcdff@linux.intel.com> <54049291-db20-a536-0615-cc3b56ceb3a3@kernel.org> <e9fdf394-9dd2-b1d3-29c9-66eb3353c0ec@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1122885340-1654674212=:1676"
Content-ID: <f538f35-3c89-8544-93a2-98803d82b593@linux.intel.com>
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

--8323329-1122885340-1654674212=:1676
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e1fe3ad4-5fdc-10cb-7bec-c32a636aba58@linux.intel.com>

On Wed, 8 Jun 2022, Jiri Slaby wrote:

> On 08. 06. 22, 8:59, Jiri Slaby wrote:
> > On 07. 06. 22, 15:47, Ilpo Järvinen wrote:
> > > On Tue, 7 Jun 2022, Jiri Slaby wrote:
> > > 
> > > > The code currently does shift, OR, and AND logic directly in the code.
> > > > It is not much obvious what happens there. Therefore define four macros
> > > > for that purpose and use them in the code. We use GENMASK() so that it
> > > > is clear which bits serve what purpose:
> > > > - UNI_GLYPH: bits  0.. 5
> > > > - UNI_ROW:   bits  6..10
> > > > - UNI_DIR:   bits 11..31
> > > > 
> > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > > ---
> > > >   drivers/tty/vt/consolemap.c | 21 +++++++++++++--------
> > > >   1 file changed, 13 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> > > > index 016c1a0b4290..e5fd225e87bd 100644
> > > > --- a/drivers/tty/vt/consolemap.c
> > > > +++ b/drivers/tty/vt/consolemap.c
> > > > @@ -190,6 +190,11 @@ static int inv_translate[MAX_NR_CONSOLES];
> > > >   #define UNI_DIR_ROWS    32U
> > > >   #define UNI_ROW_GLYPHS    64U
> > > > +#define UNI_DIR(uni)        ( (uni)                   >> 11)
> > > > +#define UNI_ROW(uni)        (((uni) & GENMASK(10, 6)) >>  6)
> > > 
> > > This is opencoding what FIELD_GET() does. Maybe just define these as
> > > masks and use FIELD_GET in the code below.
> > 
> > Ah, great -- I was thinking there should be something for that purpose
> > already, but didn't find this. But let's define these UNI_* macros using
> > appropriate FIELD_GET(). (And not using FIELD_GET() in the code.)
> > 
> > > > +#define UNI_GLYPH(uni)        ( (uni) & GENMASK( 5, 0))
> > thanks,
> 
> JFYI, I ended up with this diff to the original approach:
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -23,6 +23,8 @@
>   * stack overflow.
>   */
> 
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/kd.h>
>  #include <linux/errno.h>
> @@ -190,10 +192,17 @@ static int inv_translate[MAX_NR_CONSOLES];
>  #define UNI_DIR_ROWS   32U
>  #define UNI_ROW_GLYPHS 64U
> 
> -#define UNI_DIR(uni)           ( (uni)                   >> 11)
> -#define UNI_ROW(uni)           (((uni) & GENMASK(10, 6)) >>  6)
> -#define UNI_GLYPH(uni)         ( (uni) & GENMASK( 5, 0))
> -#define UNI(dir, row, glyph)   (((dir) << 11) | ((row) << 6) | (glyph))
> +#define UNI_DIR_BITS(max)      GENMASK((max), 11)
> +#define UNI_ROW_BITS           GENMASK(10,  6)
> +#define UNI_GLYPH_BITS         GENMASK( 5,  0)
> +
> +#define UNI_DIR(uni)   FIELD_GET(UNI_DIR_BITS(sizeof(uni) * 8 - 1), (uni))

That would be * BITS_PER_BYTE. But see below.

> +#define UNI_ROW(uni)   FIELD_GET(UNI_ROW_BITS, (uni))
> +#define UNI_GLYPH(uni) FIELD_GET(UNI_GLYPH_BITS, (uni))
> +
> +#define UNI(dir, row, glyph)   (FIELD_PREP(UNI_DIR_BITS(31), (dir)) | \
> +                                FIELD_PREP(UNI_ROW_BITS, (row)) | \
> +                                FIELD_PREP(UNI_GLYPH_BITS, (glyph)))
> 
>  /**
>   * struct uni_pagedict -- unicode directory
> 
> =======================================================
> 
> More text, but easier to follow, I think. except the UNI_DIR_BITS() has to
> have a parameter, otherwise compilation raises a too-big value warning with
> use of UNI_DIR() in con_insert_unipair() where uni is only of ushort type.

It doesn't raise any warnings if I do:

#define UNI_DIR_BITS           GENMASK(15, 11)

As UNI_DIRS is 32 it cannot ever be larger than that?

> Alternatively, we can cast uni to u32, but that produces worse assembly
> (extensions to u32 here and there).

-- 
 i.
--8323329-1122885340-1654674212=:1676--
