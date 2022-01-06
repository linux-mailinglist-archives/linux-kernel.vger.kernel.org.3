Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B010F486677
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiAFPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiAFPEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:04:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D12C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0765A61CAD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C8EC36AE0;
        Thu,  6 Jan 2022 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641481470;
        bh=3OUmKnE+UMjxBDqDe6gHiCL1TozO94OGQtgvjboZihI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdhXlgu6FpL0nNuMEPkNvKRk6z2rLKzO2YQP7/5GXP0rSwoVQtfRc58AyjEabmJGW
         RfW4qEKTF3IHiQUOlK8xoSzLVMIbgml2k4w6Q0gzm7oCBE1feI2UfnlEj6ftw9Bvjr
         QNX9hgEyc+09AQVpfewzVXJB5N356sn3sjFGKv64=
Date:   Thu, 6 Jan 2022 16:04:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: dm sysfs: use default_groups in kobj_type
Message-ID: <YdcE+9ppXYnPzijZ@kroah.com>
References: <20220106100231.3278554-1-gregkh@linuxfoundation.org>
 <Ydb7xzmOC8VN8miQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydb7xzmOC8VN8miQ@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:25:11AM -0500, Mike Snitzer wrote:
> On Thu, Jan 06 2022 at  5:02P -0500,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the dm sysfs code to use default_groups field which has
> > been the preferred way since aa30f47cf666 ("kobject: Add support for
> > default attribute groups to kobj_type") so that we can soon get rid of
> > the obsolete default_attrs field.
> > 
> > Cc: Alasdair Kergon <agk@redhat.com>
> > Cc: Mike Snitzer <snitzer@redhat.com>
> > Cc: dm-devel@redhat.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/md/dm-sysfs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
> > index a05fcd50e1b9..e28c92478536 100644
> > --- a/drivers/md/dm-sysfs.c
> > +++ b/drivers/md/dm-sysfs.c
> > @@ -112,6 +112,7 @@ static struct attribute *dm_attrs[] = {
> >  	&dm_attr_rq_based_seq_io_merge_deadline.attr,
> >  	NULL,
> >  };
> > +ATTRIBUTE_GROUPS(dm);
> 
> Bit strange to pass "dm" but then have ATTRIBUTE_GROUPS assume dm_attrs defined.
> Feels like it'll invite janitors sending patches, that they never
> compile, to remove dm_attrs.

0-day would instantly catch that :)

That's the way the ATTRIBUTE_GROUPS() macro works.  It's tricky, yes,
and I don't like it all that much, but couldn't come up with a better
way at the time.  It saves lots and lots of boiler-plate code from
having to be typed all the time.

thanks,

greg k-h
