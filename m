Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB5542A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiFHIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFHIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:53:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4536168;
        Wed,  8 Jun 2022 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654676018; x=1686212018;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K8bpO0zHCxGIcoWvjxaHYcyYQmN6LQ0gfUUWcfw/GzU=;
  b=DTA33SmL6EERWw9oZyRliqrvtR+CqMmTwzXffOvy/ktCmWO/W1p2sQBd
   d3+Ix99o8C6SFPJRZqCORZaxI8fXbgmAqLlljgy2b2+6G2AKXgEqOThaw
   MLUN63G9U6bL4s/HpRU9c9pR3ruKgSIlcRqSBR5Pj0aflg0GdPONVwXF3
   tbaJRBKwsRj9FlU6Pp8ZmaZve5A7EbvIjuOoYW0Slmocdik+ZtmU4Rd25
   LrbjcZO47ufd8bVPluBHchax5R00PaDg2hZcdq5Tup/4Yxfw3lcq21dpg
   GsLUO7mpAPBGMlygUgQYXo2p9aXDKLBHbfglREe2B0n+i4hCPrCJVZE1j
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="363144982"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="363144982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:13:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636668396"
Received: from bmichals-mobl.ger.corp.intel.com ([10.252.57.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:13:36 -0700
Date:   Wed, 8 Jun 2022 11:13:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
In-Reply-To: <e9f35a26-8f5b-f585-2e8c-19690bf3c770@kernel.org>
Message-ID: <10bf163-1b82-743-69f7-2d7a4a8245f5@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-16-jslaby@suse.cz> <8ad44d3b-449f-4a30-1a4c-dffd43bbbd1@linux.intel.com> <e9f35a26-8f5b-f585-2e8c-19690bf3c770@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-5759598-1654676018=:1676"
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

--8323329-5759598-1654676018=:1676
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 8 Jun 2022, Jiri Slaby wrote:

> On 07. 06. 22, 16:19, Ilpo Järvinen wrote:
> > On Tue, 7 Jun 2022, Jiri Slaby wrote:
> > 
> > > Only the return value of copy_to_user() is checked in con_get_unimap().
> > > Do the same for put_user() of the count too.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > ---
> > >   drivers/tty/vt/consolemap.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> > > index 831450f2bfd1..92b5dddb00d9 100644
> > > --- a/drivers/tty/vt/consolemap.c
> > > +++ b/drivers/tty/vt/consolemap.c
> > > @@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct,
> > > ushort __user *uct,
> > >   	console_unlock();
> > >   	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
> > >   		ret = -EFAULT;
> > > -	put_user(ect, uct);
> > > +	if (put_user(ect, uct))
> > > +		ret = -EFAULT;
> > >   	kvfree(unilist);
> > >   	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
> > >   }
> > > 
> > 
> > Doesn't this fix something?
> 
> If you mean a Fixes tag, this is pre-git.
> 
> If you mean a bug, well, likely yes, users now get informed. But I don't think
> anyone cares ;).

Yes, I meant Fixes tag but I guess it's not important.

> But who knows, maybe we will start seeing userspace failures
> now (as they might not provide writable count field -- unlikely). That's one
> of the reasons why I did this as a separate commit. Let's see if are going to
> revert this or not...

Ok.

-- 
 i.

--8323329-5759598-1654676018=:1676--
