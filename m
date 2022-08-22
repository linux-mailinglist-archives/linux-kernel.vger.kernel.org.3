Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDDB59C070
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiHVNYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiHVNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:24:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8E72A271;
        Mon, 22 Aug 2022 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661174674; x=1692710674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7tH/Ag7lZlQSetX8stDS+iZwQ7vUoY9E4x61qs33aN8=;
  b=Lzp5sCk/VRDQ4WScoteBFXuFOcGaNRHFhsOs3OfTe2Q0Ct6t+cQ8hKCs
   Vw2qO4ucf5TyEXQrnq8RYYWGBEAxlC4+lEVjDwTufUR0od07URXOiGXfJ
   kxpSzfn3mtMf8x6OLt9Fs2Cob/P+kRxFq9xuKOn6X6Mfqg4JlpRTiejfn
   4fKYq6diW5jk7ZVh0gFFiBSruv2uCeiY/5LWI+zWczuk6R5SjDE/PB1Rg
   0IQsN0jG2xUNgffxOIRAaFoPFBzDswmFskoQfJ+pu+ow5nYcx2wDUEkUH
   DeFLhP8yzFr32mDavF0mXBQQYj0h0y6BJCCTi91lBFoV25VGHaHE/lknj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276440512"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="276440512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 06:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="751281963"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2022 06:24:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Aug 2022 16:24:30 +0300
Date:   Mon, 22 Aug 2022 16:24:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Message-ID: <YwODjnYQD/KjxXdw@kuha.fi.intel.com>
References: <87r11cmbx0.wl-tiwai@suse.de>
 <YwEqtGB2WldUeiEN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwEqtGB2WldUeiEN@kroah.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 20, 2022 at 08:40:52PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
> > Hi,
> > 
> > we've got multiple reports about 5.19 kernel starting crashing after
> > some time, and this turned out to be triggered by ucsi_acpi driver.
> > The details are found in:
> >   https://bugzilla.suse.com/show_bug.cgi?id=1202386
> > 
> > The culprit seems to be the commit 87d0e2f41b8c
> >     usb: typec: ucsi: add a common function ucsi_unregister_connectors()
> 
> Adding Heikki to the thread...
> 
> >     
> > This commit looks as if it were a harmless cleanup, but this failed in
> > a subtle way.  Namely, in the error scenario, the driver gets an error
> > at ucsi_register_altmodes(), and goes to the error handling to release
> > the resources.  Through this refactoring, the release part was unified
> > to a funciton ucsi_unregister_connectors().  And there, it has a NULL
> > check of con->wq, and it bails out the loop if it's NULL. 
> > Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
> > and clear con->wq at its error path.  This ended up in the leftover
> > power supply device with the uninitialized / cleared device.
> > 
> > It was confirmed that the problem could be avoided by a simple
> > revert.
> 
> I'll be glad to revert this now, unless Heikki thinks:
> 
> > 
> > I guess another fix could be removing the part clearing con->wq, i.e.
> > 
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
> >  out_unlock:
> >  	mutex_unlock(&con->lock);
> >  
> > -	if (ret && con->wq) {
> > -		destroy_workqueue(con->wq);
> > -		con->wq = NULL;
> > -	}
> > -
> >  	return ret;
> >  }
> >  
> > 
> > ... but it's totally untested and I'm not entirely sure whether it's
> > better.
> 
> that is any better?

No, I don't think that's better. Right now I would prefer that we play
it safe and revert.

The conditions are different in the two places where the ports are
unregistered in this driver. Therefore I don't think it makes sense
to use a function like ucsi_unregister_connectors() that tries to
cover both cases. It will always be a little bit fragile.

Instead we could introduce a function that can be used to remove a
single port. That would leave the handling of the conditions to the
callers of the function, but it would still remove the boilerplate.
That would be much safer IMO.

But to fix this problem, I think we should revert.

thanks,

-- 
heikki
