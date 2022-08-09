Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF158DD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiHIR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbiHIR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:27:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DED1FCC7;
        Tue,  9 Aug 2022 10:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC33B8168C;
        Tue,  9 Aug 2022 17:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88DBC433D6;
        Tue,  9 Aug 2022 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660066048;
        bh=jAu9dpyXy8eLfzB3y+ekTXCh1hUDnv0KWYvUbtEC6Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=md2/BPIdoRVJYCrTG6QLMvK65R5wQujiw446y5UGapdlH1c5Xh6mKqQ3J8LXCHph2
         n9IRax1IFt2RrTBh32sqlIMPEFNWsZT/IhalOswFkNYjIn64BiZwi3q2hJBxmtEsPm
         MzHcJYrRnl2fPVtc/5dDPIMGE9qzq+wjbxJwJEFE=
Date:   Tue, 9 Aug 2022 19:27:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] devcoredump: Add per device sysfs entry to
 enable/disable coredump
Message-ID: <YvKY/eoOYTITIivc@kroah.com>
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <20220809083112.v4.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809083112.v4.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:35:24AM -0700, Manish Mandlik wrote:
> The /sys/class/devcoredump/disabled provides only one-way disable
> functionality. Also, disabling devcoredump using it disables the
> devcoredump functionality for everyone who is using it.
> 
> Provide a way to selectively enable/disable devcoredump for the device
> which is bound to a driver that implements the '.coredump()' callback.
> 
> This adds the 'coredump_disabled' driver attribute. When the driver
> implements the '.coredump()' callback, 'coredump_disabled' file is added
> along with the 'coredump' file in the sysfs folder of the device upon
> driver binding. The file is removed when the driver is unbound.
> 
> Drivers can use this attribute to enable/disable devcoredump and the
> userspace can write 0 or 1 to /sys/devices/.../coredump_disabled sysfs
> entry to control enabling/disabling of devcoredump for that device.
> 
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v4:
> - New patch in the series
> 
>  drivers/base/dd.c          | 43 +++++++++++++++++++++++++++++++++++---
>  drivers/base/devcoredump.c |  2 +-
>  include/linux/device.h     |  4 ++++
>  3 files changed, 45 insertions(+), 4 deletions(-)

You can't add a new sysfs file without also a Documentation/ABI update
at the same time :(

thanks,

greg k-h
