Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C9D4FE3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353377AbiDLOk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiDLOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C25F266;
        Tue, 12 Apr 2022 07:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A28660EC1;
        Tue, 12 Apr 2022 14:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83018C385A1;
        Tue, 12 Apr 2022 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649774316;
        bh=lcIKnqX7ND/P1RbiqjkdmPWf/TRA+1K8M7N7NXSFRw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsBwi3/WtJtFYWnmy7meXcP0++2CjGti6kYk2bXS0e2jXcizaYzuZMdxn7HFJVnA5
         R61xgErVwVl+UZkbuvdB2yOsDVIoVF/bqu1chYHRJXE+mcGTCQ8id1bBvSy5HaRmbE
         7aL1gzWpl57xnz0CFtzDr7ii88W+RFuLOXgtj99g=
Date:   Tue, 12 Apr 2022 16:38:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] usb: typec: Separate sysfs directory for all USB
 PD objects
Message-ID: <YlWO6UbZ8zM4f6b6@kroah.com>
References: <20220412130023.83927-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412130023.83927-1-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 04:00:20PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> In this version the USB Power Delivery support is now completely
> separated into its own little subsystem. The USB Power Delivery
> objects are not devices, but they are also no longer tied to any
> device by default. This change makes it possible to share the USB PD
> objects between multiple devices on top of being able to select the
> objects that we want the device to use.
> 
> The USB Power Delivery objects are now placed under
> /sys/kernel/usb_power_delivery directory. As an example:
> 
> 	/sys/kernel/usb_power_delivery/pd0

No, sorry, this is a device, it does NOT belong in /sys/kernel/

And this really should be a real device, as I mentioned before, not a
kobject.

> So now that pd0 can be linked to a device, or devices, that want (or
> can) use it to negotiate the USB PD contract with. An example where
> two devices share the PD:
> 
> 	/sys/class/typec/port0/usb_power_delivery -> ../../../../../../../kernel/usb_power_delivery/pd0
> 	/sys/class/typec/port1/usb_power_delivery -> ../../../../../../../kernel/usb_power_delivery/pd0

Point to the pd device, not the kobject.

> I did not change the directory hierarchy at all, because I'm assuming
> that it is not a problem anymore:
> 
> 	pd0/<message>/<object>/<field>

Let's get back to devices first, worry about crazy depth second.

thanks,

greg k-h
