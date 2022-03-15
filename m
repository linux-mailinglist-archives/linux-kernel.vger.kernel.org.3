Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015514D9B43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348322AbiCOMdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiCOMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218253722
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38762614F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFF8C340E8;
        Tue, 15 Mar 2022 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647347515;
        bh=E2eBpjD5jIw7gv0KgLK/o0cjIh46nKWrwiWNeEl7LAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tv4uc9mmNovaJsyEk3mdxoyAwFxQWQTaobhOG78enG+SLniz5JcMG9diJ+g8Xw9tF
         B+gxNrRH08KkRgq9hZEEMB5Hucmwi1JyV2c5d1FzE118b2tJ5GkmyjeZodgSJg7K+U
         CxI4riUXKQHk9OnVX++aAjqmUZxzn61vV9mi/fYc=
Date:   Tue, 15 Mar 2022 13:31:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "arnd@arndb.d" <arnd@arndb.d>, "mst@redhat.com" <mst@redhat.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [EXT] Re: [PATCH] Uwb: Nxp: sr1xx: Uwb driver support for sr1xx
 series chip
Message-ID: <YjCHNlC2Xc1QoTzQ@kroah.com>
References: <20220307123732.2194907-1-manjunatha.venkatesh@nxp.com>
 <YiYFlnPzpK8mrLxq@kroah.com>
 <d0343411-f95f-e550-da69-2fdb15106312@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0343411-f95f-e550-da69-2fdb15106312@nxp.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:43:47AM +0000, Manjunatha Venkatesh wrote:
> >> +     sr1xx_dev = filp->private_data;
> >> +     switch (cmd) {
> >> +     case SR1XX_SET_PWR:
> > You have custom ioctls on a device node, that's not very "subsystem"
> > like at all.
> >
> > You need to define a standard user/kernel api for this subsystem, do not
> > make it "whatever the device wants" like this currently is.
> >
> > And where is the userspace code that talks this brand new api?  We need
> > to see that so we can properly determine if this is all working
> > properly.
> Currently these ioctl calls used for handling proprietary operation with 
> respect to SR1xx chip.
> corresponding user space UWB code is proprietary and might be shortly 
> will be available as part of AOSP release, till that time not sure can 
> share user space code outside or not.
> Still if you think need the user space code required to evaluate driver 
> part will check internally and come back on this.

For obvious reasons, we can not take kernel drivers that add a custom
user/kernel api without any userspace code that we can see to use it.
You wouldn't want us to take such code anyway.

So please, fix that, otherwise this is not going to go very far at all.

thanks,

greg k-h
