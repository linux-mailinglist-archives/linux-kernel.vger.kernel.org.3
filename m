Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE14FF4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiDMKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiDMKkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:40:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0956C3F;
        Wed, 13 Apr 2022 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649846273; x=1681382273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=imKnuTeBvRy7CIUeZCDzmOhQmGCeyS22D0nVeuBNrW8=;
  b=inzHw1SOc8b1CoXoGI6Ox4zfKWCJRmCGvgHnExKNn5kN2f4B303uh35h
   vaVESfgBDWnr0QmfQtu60stRCYyczYifoKOX7s7LaMIJ3vuvBYKzIDinN
   vL83dbYwj3WnJHbJzPY1A93V1JAExAmoDz3EtNllnZ6/mo40wz4JGio6y
   43Mnht3jajlTCC6ffu3q+Il35ewfWoBQsyv1JZUBfe0TJpZPUqIjNYUTE
   ph2zIvFlQ5tDtuAGgv3MWa1o0RDr3U+vs3m7R95v28qIPu0A9T7ov7TiS
   +ue/QfKbVTZtu9GlzqHxQ5wmrtisHOV5o1sLNNjbNquCsoOJ/aCRC65gG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="349069939"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="349069939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="700199844"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Apr 2022 03:37:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Apr 2022 13:37:48 +0300
Date:   Wed, 13 Apr 2022 13:37:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: tipd: Add support for polling interrupts
 status when interrupt line is not connected
Message-ID: <Ylan/MzWWTeE8hDh@kuha.fi.intel.com>
References: <20220412145059.4717-1-a-govindraju@ti.com>
 <YlaZIual4Fa/a81I@kuha.fi.intel.com>
 <5672af5d-d4a9-08ab-0594-7da57cd0972b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5672af5d-d4a9-08ab-0594-7da57cd0972b@ti.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:32:50PM +0530, Aswath Govindraju wrote:
> Hi Heikki,
> 
> On 13/04/22 15:04, Heikki Krogerus wrote:
> > Hi Aswath,
> > 
> > On Tue, Apr 12, 2022 at 08:20:58PM +0530, Aswath Govindraju wrote:
> >> In some cases the interrupt line from the pd controller may not be
> >> connected. In these cases, poll the status of various events.
> > 
> > Well, if the alert/interrupt line is not connected anywhere, then
> > polling is the only way to go. I'm fine with that, but the driver
> > really should be told that there is no interrupt. Using polling
> > whenever request_threaded_irq() returns -EINVAL is wrong. We really
> > should not even attempt to request the interrupt if there is no
> > interrupt for the device.
> > 
> > Isn't there any way you can get that information from DT? Or how is
> > the device enumerated in your case?
> > 
> 
> Would checking if (client->irq) field is populated, to decide between
> polling and interrupts be a good approach?
> 
> I am sorry but I did not understand what you meant by device getting
> enumerated. The device is on an I2C bus and gets enumerated based on the
> I2C address provided. The device does not have I2C_IRQ line connected,
> in my case.

"I2C devices are not enumerated at hardware level":
https://www.kernel.org/doc/html/latest/i2c/instantiating-devices.html

So your PD controller I2C slave device has to be either described in
Devicetree or ACPI tables, or there is a board file or platform driver
that actually populates the device for it.

Can you tell a little bit about the platform you are running? Is it
ARM, x86, or what, and is it ACPI or DT platform?

thanks,

-- 
heikki
