Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D62463CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbhK3RWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:22:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57460 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241963AbhK3RWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:22:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A82AB81A96
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D05EC53FC1;
        Tue, 30 Nov 2021 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638292727;
        bh=G1WVbS81//21rP0WUcWlWVTfe9CPWo90pxb2Kd7mrbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gy8zqf6BsOoJjGqi3hwrr2n88e862LPIphxiHrpjalScBIMiv++BFm9G/5D36fqyn
         fub9n5mfs7eZRxBJAXFV5JTzRnHCFzGbBmxEPfVSiVNMMdt2kwYgnRcz94Dz3XSvbT
         IzFwmvn/33uokqML+TmF6nlg+QseZuBTdve9VL19HiJtzm+UNgXbhO6ku7eJUN49Wk
         IJ7pQKv2a40SW7c12gA/P1ATJgzbE/HHomL1vHwDj57OMuzQJvbq0MfWygvxlJUw2L
         bNSSnd8edofbgPTD4RCweb88iHglCJBouQBOb5sTvCQsZj9KxqjDI/KSQRcqpHVrBT
         LKp29LskcQ9gA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms6ls-0000Ip-OV; Tue, 30 Nov 2021 18:18:25 +0100
Date:   Tue, 30 Nov 2021 18:18:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, Qiushi Wu <wu000273@umn.edu>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] fw_cfg: Fix memory leak in fw_cfg_register_file
Message-ID: <YaZc4LbX5hrJDnec@hovoldconsulting.com>
References: <20211116114233.29462-1-linmq006@gmail.com>
 <2ced2fae-2ffd-3a70-f02c-175662baf7bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ced2fae-2ffd-3a70-f02c-175662baf7bc@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 04:28:34PM +0100, Philippe Mathieu-Daudé wrote:
> On 11/16/21 12:42, Miaoqian Lin wrote:
> > When kobject_init_and_add() fails, entry should be freed just like
> > when sysfs_create_bin_file() fails.
> > 
> 
> Fixes: fe3c60684377 ("firmware: Fix a reference count leak.")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

No, no. This patch is completely bogus and would introduce a double
free.

> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/firmware/qemu_fw_cfg.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> > index 172c751a4f6c..0f404777f016 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -608,6 +608,7 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
> >  				   fw_cfg_sel_ko, "%d", entry->select);
> >  	if (err) {
> >  		kobject_put(&entry->kobj);
> > +		kfree(entry);

entry would already have been freed by kobject_put() and
fw_cfg_sysfs_release_entry() here.

> >  		return err;
> >  	}
> >  
> > 

Doesn't look like this patch has been picked up yet, so:

	NAK.

Johan
