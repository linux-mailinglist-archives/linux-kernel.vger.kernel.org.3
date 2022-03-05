Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41894CE697
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 20:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiCETnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 14:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiCETnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 14:43:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB46928C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 11:43:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E4560AB6
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 19:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68459C004E1;
        Sat,  5 Mar 2022 19:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646509381;
        bh=aTwFDS8jMOiSeLykSnLcKQ9n+zp/EVyGHLTn7DlzIkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=veIwZV6CHYNDlYHUU0i4h/aqyLz0BpL3r442nxVH4Fhow68c3KJgMw82DjRZtHGg+
         BvQr/1VWlJBPSGOqnAPmUhylAJ85ZEIlCgQSFSLEZOql/1nvNxTLG/WgRLKxkOsi/r
         E2m/lWGlkFhIoYSMNYsTWO3+bKA1ptcJyiuFcaGM=
Date:   Sat, 5 Mar 2022 20:42:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     Juergen Gross <jgross@suse.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] drivers/xen: use helper macro __ATTR_RW
Message-ID: <YiO9QDpqepZXEZ6L@kroah.com>
References: <20220305133823.158961-1-zhanglianjie@uniontech.com>
 <YiNry3TtIPbEh1Yr@kroah.com>
 <622382f3.1c69fb81.55f81.aff0SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622382f3.1c69fb81.55f81.aff0SMTPIN_ADDED_BROKEN@mx.google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 11:33:58PM +0800, zhanglianjie wrote:
> Hi,
> 
> 在 2022/3/5 21:55, Greg Kroah-Hartman 写道:
> > On Sat, Mar 05, 2022 at 09:38:23PM +0800, zhanglianjie wrote:
> > > Use helper macro __ATTR_RW to define HYPERVISOR_ATTR_RW to make code more clear.
> > > Minor readability improvement.
> > > 
> > > Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> > 
> > Is this the name you sign legal documents with?  (I have to ask...)
> Yes, this is my signature.
> > 
> > > 
> > > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
> > > index feb1d16252e7..fcb0792f090e 100644
> > > --- a/drivers/xen/sys-hypervisor.c
> > > +++ b/drivers/xen/sys-hypervisor.c
> > > @@ -22,11 +22,10 @@
> > >   #endif
> > > 
> > >   #define HYPERVISOR_ATTR_RO(_name) \
> > > -static struct hyp_sysfs_attr  _name##_attr = __ATTR_RO(_name)
> > > +static struct hyp_sysfs_attr _name##_attr = __ATTR_RO(_name)
> > 
> > Why change this line?  That's not relevant to this change :(
> > 
> There are two spaces between struct hyp_sysfs_attr and _name, by the way,
> modify it.

Coding style cleanups should be a separate patch, as each change should
only do one logical thing.

But hey, I'm not the maintainer of this file/driver, others might be
more lax.

good luck!

greg k-h
