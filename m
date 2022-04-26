Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E650FC80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349750AbiDZMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346373AbiDZMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B910FF0B;
        Tue, 26 Apr 2022 05:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02C36189F;
        Tue, 26 Apr 2022 12:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94633C385A0;
        Tue, 26 Apr 2022 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650974849;
        bh=OxbjqiCYqZGNcYKHfeRboE5u8cCVCIsg9sZ8AG+vy9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpW1BEj/wFo7lQ0z/48FqIScYvS+Kq3U5wnDcFPP/GWqtIoivm/mV1dHxQUrBWNzI
         jw9KIw7V1d8E/7vbHsq3LkC9pMt+rSBXZzH0G0i0UfK6I9TBLIcpoLcvwzSO6sV1R9
         AXJWZw8/2h3TPYFe1X+d7F9zpSo2AljJUY65ySrc=
Date:   Tue, 26 Apr 2022 14:07:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Won Chung <wonchung@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: typec: Separate USB Power Delivery from USB
 Type-C
Message-ID: <YmfgfRA1ecJwf12i@kroah.com>
References: <20220425124946.13064-1-heikki.krogerus@linux.intel.com>
 <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425124946.13064-2-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:49:44PM +0300, Heikki Krogerus wrote:
> --- /dev/null
> +++ b/drivers/usb/typec/pd.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __USB_POWER_DELIVERY__
> +#define __USB_POWER_DELIVERY__
> +
> +#include <linux/kobject.h>

Why kobject.h when:

> +
> +struct pd_capabilities {
> +	struct device dev;

This is a device?

> +	struct pd *pd;
> +	enum typec_role role;
> +};
> +
> +struct pd {
> +	struct device		dev;
> +	int			id;
> +
> +	u16			revision; /* 0300H = "3.0" */

So BCD?

> +	u16			version;
> +};



> +
> +#define to_pd_capabilities(o) container_of(o, struct pd_capabilities, dev)
> +#define to_pd(o) container_of(o, struct pd, dev)
> +
> +struct pd *pd_find(const char *name);

"struct pd" is just about the shortest structure name I've seen in the
kernel so far.  How about using some more letters?  :)

> +
> +int pd_init(void);
> +void pd_exit(void);

The kobject question above goes to the code as well.  You are creating a
bunch of raw kobjects still, why?  This should all fit into the driver
model and kobjects shouldn't be needed.  Are you trying to nest too deep
in the attributes?  If so, kobjects will not work as userspace tools
will not realize they are there and are attributes at all.

Try running some tests using libudev and see the lack of attributes with
this patch, tools are not going to be able to see them at all this way.

thanks,

greg k-h
