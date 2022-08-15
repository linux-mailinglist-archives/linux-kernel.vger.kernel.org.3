Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AEB592A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiHOHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbiHOHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF61C130;
        Mon, 15 Aug 2022 00:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D92960D2F;
        Mon, 15 Aug 2022 07:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF20EC433D6;
        Mon, 15 Aug 2022 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660546976;
        bh=fC/OC0XWgVeUHhUJakLD7xV+hhjBideZsl6F9+8rcKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWj2n7SfwVdy7GUnYHcv2vSrdWGaPHPuewcOXs/zIoFgWLhmFJXC1lws7D3qoXBe/
         kXnlEC8nT2mo6NN7oxwatXgdTBjgqdlSFNyNmOAZkzidQLr4cF4IG4GikKg3HnSBUP
         O8qc8EacRL9pX9gpqxE2D4gUaLee/VQtfiR0uxKI=
Date:   Mon, 15 Aug 2022 09:02:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvnvnL9pBAgWMgTk@kroah.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvnrJBI8599+E43T@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:43:48PM +0900, Sergey Senozhatsky wrote:
> On (22/08/15 08:36), Greg KH wrote:
> > On Mon, Aug 15, 2022 at 11:06:39AM +0900, Sergey Senozhatsky wrote:
> > > On (22/08/11 17:30), Greg KH wrote:
> > > > On Thu, Aug 11, 2022 at 06:08:55PM +0300, Laurent Pinchart wrote:
> > > > > On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> > > > > > On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > > > > > > For the time being, I agree with your recommendation to not buy these
> > > > > > > devices if you care about camera support.
> > > > > > 
> > > > > > I second this, don't buy these devices if the vendor is not willing to
> > > > > > get their drivers upstreamed properly.
> > > > > 
> > > > > "Not willing" may be a bit too harsh here. I wouldn't just blame Intel
> > > > > for not upstreaming a driver if it turns out that the V4L2 API isn't a
> > > > > good match and we have no proposal to provide an alternative.
> > > > 
> > > > Did they propose an alternative?  From what I saw here they didn't even
> > > > attempt it, or did I miss that?
> > > 
> > > The plan here is to land CAM kernel API first and then switch IPU
> > > (driver and user-space) to it so that upstreaming for Intel will
> > > be easier.
> > 
> > And what is the timeframe on the plan?  Where will these changes be sent
> > to for review?  I'm guessing they are already in a shipping device so
> > what's the delay?
> 
> We haven't sent out KCAM for upstream review yet. It's open sourced,
> as of this moment [1], but we still need some time and wanted to convert
> one of the previous generations of IPU drivers (IPU3) to KCAM first to
> see if everything is working as we wanted it to.

That didn't answer my question on when you were planning to actually
submit this :)

thanks,

greg k-h
