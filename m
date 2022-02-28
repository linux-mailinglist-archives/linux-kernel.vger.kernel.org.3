Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945A74C70F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiB1PvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiB1PvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:51:08 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B17A9B8;
        Mon, 28 Feb 2022 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646063430;
  x=1677599430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EwPAkPPxKxS35tuFVR1SCR1lUDJX7spRDbDEEnTwIO4=;
  b=QKkppyMlvtohejea190Lwx+FyhcNajZrKSNWsegwZriq9dJYAhTVb/XU
   GHNb6UMmpZmOlU2VX+whOU3ukNWa93yEm3zmhOFhpcpLvLjw9qRM7uEMf
   oxVI/98e0pYkGe9xpHm/cQdtQMWQlwXtiH5vzdsvr+YNIHt5OcvHAM6kM
   N63u+WkAystDp/kchA91jaeDWghwY42GXxtEvjFrj7Oe8QpxPFXKMdAoC
   COnSw/Xn60nDeEbdDERQ0JcX2/11eRoKJwWLAJ9H0d/oLl/Qt1T++lFCN
   Jt71LFS45Yc6Hok5bylVSiYc7awB9qEXBM2Rl0lc6ARYhmqWzyZhncC79
   Q==;
Date:   Mon, 28 Feb 2022 16:50:27 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <kernel@axis.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: virtual: add devicetree support
Message-ID: <20220228155027.GA16152@axis.com>
References: <20220218110604.1329024-1-vincent.whitchurch@axis.com>
 <YhZDVGC7dPiisnI+@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YhZDVGC7dPiisnI+@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:23:16PM +0000, Mark Brown wrote:
> On Fri, Feb 18, 2022 at 12:06:03PM +0100, Vincent Whitchurch wrote:
> 
> > The reg-virt-consumer is very useful for development and testing of
> > regulator drivers since it allows voltages and modes to be set from
> > userspace.  However, it currently requires platform data so it cannot be
> > used on modern platforms.  Add support for probing it from the
> > devicetree to remedy this.
> 
> Meh, you can add a bit of code on module_init() to register a platform
> device or something.

Something like that could work during manual testing, but I'm hoping to
use this from a test framework where it's rather impractical to patch
individual drivers in that way.

> > Since this driver is only meant for testing and is a purely software
> > construct, no binding documentation is added.
> 
> That's not going to stop anyone.  We should at the very least be
> printing very loud warnings if anyone tries to intantiate this.

I can add a warning.  Maybe something like this, following the style of
kernel/trace/trace.c?

  pr_warn("**********************************************************\n");
  pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
  pr_warn("**                                                      **\n");
  pr_warn("** regulator-virtual-consumer is only for testing and   **\n");
  pr_warn("** debugging.  Do not use it in a production kernel.    **\n");
  pr_warn("**                                                      **\n");
  pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
  pr_warn("**********************************************************\n");

> 
> > +	if (!reg_id)
> > +		reg_id = "default";
> > +
> 
> Oh?

As you know, this results in looking for the regulator phandle in a
property named "default-supply".  I wasn't sure what supply name to use
for this virtual client.  Getting the name from another property seemed
unnecessary.  Would you prefer that, or would you suggest some other
name than "default"?
