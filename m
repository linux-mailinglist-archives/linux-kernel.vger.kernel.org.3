Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90DD4A8708
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbiBCOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:55:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48372 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiBCOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:55:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2DA4B83477;
        Thu,  3 Feb 2022 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF798C340E4;
        Thu,  3 Feb 2022 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643900122;
        bh=Tv8nbPdlGMSs7EERPUna/DYO1nA6+2a7H/RHmD15kAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTnE2QWgxy+jjWpV/4ILOU8wmfuzskAonZ57J+sBcSED82JbcR63bZSxY9kPc7XKr
         Akzw5W545tX9HCrKpCAm9a4Ua3CZIloHUcVMt2n4MFlR5LfPHJ5JGxd0jZ4wN+sKkT
         E4UELY3WIODrKTw8PiHzO3aekRNmkFYyOvo61ivc=
Date:   Thu, 3 Feb 2022 15:55:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: Separate USB Power Delivery from USB
 Type-C
Message-ID: <Yfvs13vpsWULIVWu@kroah.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
 <20220203144657.16527-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203144657.16527-2-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:46:55PM +0300, Heikki Krogerus wrote:
> +/* These additional details are only available with vSafe5V supplies */
> +static struct kobj_attribute dual_role_power_attr = __ATTR_RO(dual_role_power);
> +static struct kobj_attribute usb_suspend_supported_attr = __ATTR_RO(usb_suspend_supported);
> +static struct kobj_attribute unconstrained_power_attr = __ATTR_RO(unconstrained_power);
> +static struct kobj_attribute usb_communication_capable_attr = __ATTR_RO(usb_communication_capable);
> +static struct kobj_attribute dual_role_data_attr = __ATTR_RO(dual_role_data);
> +static struct kobj_attribute
> +unchunked_extended_messages_supported_attr = __ATTR_RO(unchunked_extended_messages_supported);

Note, no 'struct device' should ever have a "raw" kobject hanging off of
it.  If so, something went wrong.

If you do this, userspace will never be notified of the attributes and
any userspace representation of the tree will be messed up.

Please, use an attribute directory with a name, or if you really need to
go another level deep, use a real 'struct device'.  As-is here, I can't
take it.

thanks,

greg k-h
