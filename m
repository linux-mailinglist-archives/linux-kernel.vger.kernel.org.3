Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31D5428B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiFHH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiFHHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:55:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B11A048A;
        Wed,  8 Jun 2022 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654673068; x=1686209068;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n6ZzcLPLeuptMeqjzTvwmiJodh+6qVPTBoekvS/R3Pk=;
  b=B/41e0HX++2sRmVG/e8GUSATjv4wZQ5Mdtts7lXDOnHZwYoqWBsRkvrD
   uSuhfzlFnOIjcilvvtiFrKWAwSqBC3vXI7J2VZ5+B/k7tv0t3HhQS+H7d
   LIoqXX2y/8WE6IOthXOVo+as5VtPoguFj5+brLUqACyBhbLBEvgNI6F++
   opsjKQ36WSGkTPZU21QIO0SG15ODm5w12Qmk4joN3qSBAN6LUxnbpURZC
   fGmFfXYKhNWb9CYQO9Xhkt1MfqUch4gnL4VOQpqOcqrk/fKHGnkQyp7JA
   UpvSYagR1KZfWnNtFeh4yIlYVr7+wm9ps/Ltx9raHbr0LF6D34YiOq9qG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277632430"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="277632430"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 00:23:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636636736"
Received: from bmichals-mobl.ger.corp.intel.com ([10.252.57.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 00:23:52 -0700
Date:   Wed, 8 Jun 2022 10:23:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/36] tty/vt: consolemap: use sizeof(*pointer) instead
 of sizeof(type)
In-Reply-To: <37ced336-ac77-4c8f-1142-1f55c01383ca@suse.cz>
Message-ID: <b2df9240-2b47-6fe3-4a65-3bdfcb961e4@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-12-jslaby@suse.cz> <8c809bd0-552d-8027-a1a7-96b77369d06e@linux.intel.com> <37ced336-ac77-4c8f-1142-1f55c01383ca@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1026436096-1654673033=:1676"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1026436096-1654673033=:1676
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> On 07. 06. 22, 16:00, Ilpo Järvinen wrote:
> > On Tue, 7 Jun 2022, Jiri Slaby wrote:
> > 
> > > It is preferred to use sizeof(*pointer) instead of sizeof(type). First,
> > > the type of the variable can change and one needs not change the former
> > > (unlike the latter). Second, the latter is error-prone due to (u16),
> > > (u16 *), and (u16 **) mixture here.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > This seems fine but see the comments below which are not directly related
> > to the change itself.
> > 
> > > ---
> > >   drivers/tty/vt/consolemap.c | 23 ++++++++++++-----------
> > >   1 file changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> > > index 097ab7d01f8b..79a62dcca046 100644
> > > --- a/drivers/tty/vt/consolemap.c
> > > +++ b/drivers/tty/vt/consolemap.c
> > > @@ -251,12 +251,12 @@ static void set_inverse_trans_unicode(struct vc_data
> > > *conp,
> > >   		return;
> > >   	q = p->inverse_trans_unicode;
> > >   	if (!q) {
> > > -		q = p->inverse_trans_unicode =
> > > -			kmalloc_array(MAX_GLYPH, sizeof(u16), GFP_KERNEL);
> > > +		q = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
> > > +				sizeof(*q), GFP_KERNEL);
> > >   		if (!q)
> > >   			return;
> > >   	}
> > > -	memset(q, 0, MAX_GLYPH * sizeof(u16));
> > > +	memset(q, 0, MAX_GLYPH * sizeof(*q));
> > 
> > Convert kmalloc_array into kcalloc and place memset() into else branch?
> 
> IMO, the way it is now is more obvious.

Fair enough.

> > > @@ -514,11 +514,12 @@ con_insert_unipair(struct uni_pagedict *p, u_short
> > > unicode, u_short fontpos)
> > >   	n = UNI_ROW(unicode);
> > >   	p2 = p1[n];
> > >   	if (!p2) {
> > > -		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16),
> > > GFP_KERNEL);
> > > +		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(*p2),
> > > +				GFP_KERNEL);
> > >   		if (!p2)
> > >   			return -ENOMEM;
> > >   		/* No glyphs for the characters (yet) */
> > > -		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
> > > +		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(*p2));
> > 
> > This could have been kcalloc'ed.
> 
> Why would you zero it before setting it to 0xff?

Yes, nevermind that. I obviously completely missed the fact it wasn't 
memsetting to zero.

-- 
 i.

--8323329-1026436096-1654673033=:1676--
