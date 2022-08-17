Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610AA596B38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiHQIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiHQIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD278BD8;
        Wed, 17 Aug 2022 01:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 396A9B81C68;
        Wed, 17 Aug 2022 08:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81324C433C1;
        Wed, 17 Aug 2022 08:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660724088;
        bh=1eqHEn7qqbB0WVLCEqCYh8umseGGjHGfqNS5U6FoUO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkQXgCqlRC5EXK+rLZBkLHyD1MEVJCjD3OUoj/fD/CzJFUTkMaxvflmdBoU9oS751
         2RELAuc1xEKA9+xriqZcASjiFYHYV5ouY8OrWoWOSMbJw5SUXHVrVRvr1WmPKlCNDA
         yTGkXwijPIXUunyzmkmfie/u8Rg72Ubfuj1+5QAc=
Date:   Wed, 17 Aug 2022 10:14:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>,
        it+linux-media@molgen.mpg.de, "Hu, Jerry W" <jerry.w.hu@intel.com>
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvyjdcV7BrRQuLRT@kroah.com>
References: <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com>
 <YvnybHVFmpUJs4qi@kroah.com>
 <YvyiLHBgRQ9XsTrW@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvyiLHBgRQ9XsTrW@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:09:16AM +0000, Sakari Ailus wrote:
> V4L2 + MC are not great APIs for supporting hardware such as IPU6 and
> coming up with an alternative is a major and risky endeavour. I expect many
> developers of drivers for similar hardware are in the same situation.

What has been done to help maybe make those apis work properly for this
hardware?  The hardware design pipeline is very long, this isn't
anything new that people just suddenly realized was going to need to
have full support on Linux.

> The hardware is getting increasingly complex and while there is some
> standardisation in the industry, it's mainly focussed on interoperatibility
> on hardware level rather than control interfaces or defining how a given
> feature is to be implemented.

Hardware standardization isn't an issue here, it's having working Linux
code to support all the crazy devices.

> As the camera is no longer a single, integrated device in this context but
> multiple devices from different vendors, there still remains a larger
> requirement for interoperability between, at the very least, cameras and
> CSI-2 receivers --- that in turn increasingly often are integrated in Image
> Signal Processors such as IPU6. This further raises the bar for an
> interface that would better support these devices.

Ok, great, what type of api would work for this hardware?  You all have
access to the hardware, know how it works, and know how userspace needs
to consume it.  So why not work to create the needed kernel support for
this now?  What is the causing the delay?

thanks,

greg k-h
