Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361D4BFD43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiBVPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBVPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:42:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578E732059
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645544550; x=1677080550;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FLTgKGuXqZf5NiUOgzqrhOY1cBSgxdpx342UYX2l13Q=;
  b=V6P2QTntoey7g8ksvgfrdkwvYoj4u8zMyjvLkNKn/2NATUkvQgDj+wT6
   eTT86e98xlZhHfUS8rEPOLOjMJGPvC0UI7kinGsFCOltsXr9utxmN7E2M
   OJapyvxwdBfRugOxmnM+1MZZtQX8585RJUvPdzYe8KrmnW5srNm5MdhOX
   yxshQy4zlRTgyY1co8mlM2/TtTNxZOulRNoXsWfJ2PRM5F7R2wVWIDsPM
   lrCUd18Uvg2XVC/cr374JvRaRjhwJutcQHcq33ZLVxK61edzwBJGZWJh2
   Yc5R5hEJ+Yprp6rNiwIZkEJdeJe+9khCpr2TKqX44numk30SHC/RA48wS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231704978"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231704978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 07:42:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508033330"
Received: from chinhtn-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.26.159])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 07:42:21 -0800
Message-ID: <d0d03d62d377194a8dbc0ff9109a619defa951e3.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: fix memory leak in int3400_notify()
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chuansheng Liu <chuansheng.liu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Tue, 22 Feb 2022 07:42:21 -0800
In-Reply-To: <CAJZ5v0hziz4Eyk7qFgYMM4YYEZTpd_faukMczg7hnou9yP9yiQ@mail.gmail.com>
References: <20220222020021.19640-1-chuansheng.liu@intel.com>
         <CAJZ5v0hziz4Eyk7qFgYMM4YYEZTpd_faukMczg7hnou9yP9yiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 13:34 +0100, Rafael J. Wysocki wrote:
> Please resend this with a CC to linux-pm@vger.kernel.org.  Thanks!
> 
> On Tue, Feb 22, 2022 at 3:13 AM Chuansheng Liu
> <chuansheng.liu@intel.com> wrote:
> > 
> > It is easy to hit the below memory leaks in my TigerLake platform:
> > 
> > --
> > unreferenced object 0xffff927c8b91dbc0 (size 32):
> >   comm "kworker/0:2", pid 112, jiffies 4294893323 (age 83.604s)
> >   hex dump (first 32 bytes):
> >     4e 41 4d 45 3d 49 4e 54 33 34 30 30 20 54 68 65  NAME=INT3400
> > The
> >     72 6d 61 6c 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 
> > rmal.kkkkkkkkkk.
> >   backtrace:
> >     [<ffffffff9c502c3e>] __kmalloc_track_caller+0x2fe/0x4a0
> >     [<ffffffff9c7b7c15>] kvasprintf+0x65/0xd0
> >     [<ffffffff9c7b7d6e>] kasprintf+0x4e/0x70
> >     [<ffffffffc04cb662>] int3400_notify+0x82/0x120
> > [int3400_thermal]
> >     [<ffffffff9c8b7358>] acpi_ev_notify_dispatch+0x54/0x71
> >     [<ffffffff9c88f1a7>] acpi_os_execute_deferred+0x17/0x30
> >     [<ffffffff9c2c2c0a>] process_one_work+0x21a/0x3f0
> >     [<ffffffff9c2c2e2a>] worker_thread+0x4a/0x3b0
> >     [<ffffffff9c2cb4dd>] kthread+0xfd/0x130
> >     [<ffffffff9c201c1f>] ret_from_fork+0x1f/0x30
> > ---
> > 
> > Fix it by calling kfree() accordingly.
> > 
> > Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Please cc to stable

> > ---
> >  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 72acb1f61849..4f478812cb51 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -404,6 +404,10 @@ static void int3400_notify(acpi_handle handle,
> >         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d",
> > therm_event);
> >         thermal_prop[4] = NULL;
> >         kobject_uevent_env(&priv->thermal->device.kobj,
> > KOBJ_CHANGE, thermal_prop);
> > +       kfree(thermal_prop[0]);
> > +       kfree(thermal_prop[1]);
> > +       kfree(thermal_prop[2]);
> > +       kfree(thermal_prop[3]);
> >  }
> > 
> >  static int int3400_thermal_get_temp(struct thermal_zone_device
> > *thermal,
> > --
> > 2.25.0.rc2
> > 

