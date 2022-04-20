Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22548508E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381030AbiDTRUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiDTRUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:20:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04BD2AE03;
        Wed, 20 Apr 2022 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650475044; x=1682011044;
  h=message-id:subject:from:reply-to:to:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9lRjAeBBehBjZyGcReBcO9upiamRkO2xt3HVhdAFJY=;
  b=i9HzPf5NKshm++9MsgnrGvXaJtAz0K+XBl0Sex4xBNLL0DXmgUzuZZxp
   MTZYt3ioRz5KjwOxqysfKEL2dpqOVF7Xvkv0rHqbz5kMRxg27JCbLQcOv
   6k65jKexl5o0s4TLjRz10TRlIBBbuWLrhaCu5wMy/M7XJli1pShRFhH4r
   K/6cTBtrSwmbkNxI0K23SHq6upX13mrqPSbyRBLSqOOnqvSJbvv2wSen0
   u1U4ulPe/UkHo6UGQ+PT39Zwtkd2fPvdUcFeKOGNSwX4QNsQqsVuwVwEJ
   gDCabA4TdvRH0MQes5Gs+hyq71tnyac55MhjyE8Obs5paItlD7eYEibho
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263560952"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="263560952"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="864219635"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2022 10:16:57 -0700
Received: from drakityx-mobl.amr.corp.intel.com (unknown [10.212.213.71])
        by linux.intel.com (Postfix) with ESMTP id DA579580AE2;
        Wed, 20 Apr 2022 10:16:56 -0700 (PDT)
Message-ID: <3a36e0c1634e7a53aede8a3a71a599905a42a89f.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] platform/x86/intel/sdsi: Poll on ready bit for
 writes
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Apr 2022 10:16:56 -0700
In-Reply-To: <BL1PR12MB5157EBB51DA629A40BE514EDE2F59@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220420155622.1763633-1-david.e.box@linux.intel.com>
         <20220420155622.1763633-3-david.e.box@linux.intel.com>
         <BL1PR12MB5157EBB51DA629A40BE514EDE2F59@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 16:34 +0000, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: David E. Box <david.e.box@linux.intel.com>
> > Sent: Wednesday, April 20, 2022 10:56
> > To: hdegoede@redhat.com; david.e.box@linux.intel.com;
> > markgross@kernel.org; platform-driver-x86@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH 2/3] platform/x86/intel/sdsi: Poll on ready bit for writes
> > 
> > Due to change in firmware flow, update mailbox writes to poll on ready bit
> > instead of run_busy bit. This change makes the polling method consistent
> > for both writes and reads, which also uses the ready bit.
> 
> Does this need some sort of guard on the behavior based on the firmware
> version you are running on or are these all pre-production still?

Firmware updates would include this change, but a guard isn't necessary. Polling
on run_busy would still work for the current ABI. Since currently mailbox writes
are single packet only, both ready and run_busy update at the same time. But it
would not work for future changes where there will be multi packet writes. In
that case, ready indicates completion of the packet while run_busy indicates
completion of the entire message.

David

> 
> > Fixes: 2546c6000430 ("platform/x86: Add Intel Software Defined Silicon
> > driver")
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel/sdsi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel/sdsi.c
> > b/drivers/platform/x86/intel/sdsi.c
> > index 11f211402479..89729fed030c 100644
> > --- a/drivers/platform/x86/intel/sdsi.c
> > +++ b/drivers/platform/x86/intel/sdsi.c
> > @@ -245,8 +245,8 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv,
> > struct sdsi_mbox_info *in
> >  		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> >  	writeq(control, priv->control_addr);
> > 
> > -	/* Poll on run_busy bit */
> > -	ret = readq_poll_timeout(priv->control_addr, control, !(control &
> > CTRL_RUN_BUSY),
> > +	/* Poll on ready bit */
> > +	ret = readq_poll_timeout(priv->control_addr, control, control &
> > CTRL_READY,
> >  				 MBOX_POLLING_PERIOD_US,
> > MBOX_TIMEOUT_US);
> > 
> >  	if (ret)
> > --
> > 2.25.1

