Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331659290F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiHOFXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHOFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:23:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77F13E37;
        Sun, 14 Aug 2022 22:23:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0467248F;
        Mon, 15 Aug 2022 07:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660540979;
        bh=FQbxZOfl5hG5q0hY8c6DYp8v+713cbsSwjVadQpIYBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nhc9UPm1vLzGKDSb4wrwLc/5kbB7TOOqZzICzwhpR6qSkYYTyxWAwrlIqrPI7xpSK
         pas4mrAEs611Vf0oUSE/jmUCOvwNrRlaxL4YhwAQYubZdXZ/I0njY9oarmOqLq3VLN
         hcbs6Lz6C6WvZQN6J1eeS40umXRNek6lmk24Q78Y=
Date:   Mon, 15 Aug 2022 08:22:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <YvnYJut3qIvIMVWa@pendragon.ideasonboard.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvmqL6Wz7o77ukF5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On Mon, Aug 15, 2022 at 11:06:39AM +0900, Sergey Senozhatsky wrote:
> On (22/08/11 17:30), Greg KH wrote:
> > On Thu, Aug 11, 2022 at 06:08:55PM +0300, Laurent Pinchart wrote:
> > > On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> > > > On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > > > > For the time being, I agree with your recommendation to not buy these
> > > > > devices if you care about camera support.
> > > > 
> > > > I second this, don't buy these devices if the vendor is not willing to
> > > > get their drivers upstreamed properly.
> > > 
> > > "Not willing" may be a bit too harsh here. I wouldn't just blame Intel
> > > for not upstreaming a driver if it turns out that the V4L2 API isn't a
> > > good match and we have no proposal to provide an alternative.
> > 
> > Did they propose an alternative?  From what I saw here they didn't even
> > attempt it, or did I miss that?
> 
> The plan here is to land CAM kernel API first and then switch IPU
> (driver and user-space) to it so that upstreaming for Intel will
> be easier.

In its current form, that API will likely have trouble going upstream.
Reception wasn't exactly positive in the mainline kernel community. I
would like to restate my recommendation of sitting down with the
upstream community around the same (virtual) table to design an that
will be suitable for the upstream kernel.

-- 
Regards,

Laurent Pinchart
