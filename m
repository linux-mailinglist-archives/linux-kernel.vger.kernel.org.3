Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973ED51114B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358198AbiD0Gk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiD0Gkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864541FA55
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 236B3618E2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E2C385A9;
        Wed, 27 Apr 2022 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651041464;
        bh=qXANc54/oSBGvQcnTttyuOw+XK/qoUr1xwe2Ssmez1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbYEn11kqBOvASlNDPZQMRFNh/f3Dq5m9S78QbslQdh9yu2lpsl8dQGOnUbjuke35
         s5BKl3OkGjxSmBgEHwXSmcf8GvF2nc3t3BkHLOKnBq+cTD1vYDrSy4aucKkJBURSSo
         eQ8tTsY5R2Dmgq7VeDocY034DyjXFYtZfKo26u5c=
Date:   Wed, 27 Apr 2022 08:37:41 +0200
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
        "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>,
        Ashish Deshpande <ashish.deshpande@nxp.com>
Subject: Re: [EXT] Re: [PATCH] Uwb: Nxp: sr1xx: Uwb driver support for sr1xx
 series chip
Message-ID: <YmjktXZDb5ELR8Xp@kroah.com>
References: <20220307123732.2194907-1-manjunatha.venkatesh@nxp.com>
 <YiYFlnPzpK8mrLxq@kroah.com>
 <d0343411-f95f-e550-da69-2fdb15106312@nxp.com>
 <YjCHNlC2Xc1QoTzQ@kroah.com>
 <AM6PR04MB6407537BDB702B3D8C2BC73A8FFA9@AM6PR04MB6407.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB6407537BDB702B3D8C2BC73A8FFA9@AM6PR04MB6407.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:24:14AM +0000, Manjunatha Venkatesh wrote:
> Hello Greg,
> 
> Thanks for sharing your comments with us and apologies for our delayed
> response. 
> We have done a thorough review internally and would like to put forward a
> proposal for your consideration.
> 
> 1)  In our next submission we will define the kernel/user API clearly with
> kernel pre-defined IOCTL macros in the uapi header file and follow the
> standard IOCTL rules.

Why do you need ioctls at all?  Anyway, submit the code and we can
review the api then, I have no recollection of the previous submission
as it was thousands of patches ago.

> 2)  We agree that this is a simple driver which may not need a dedicated
> directory under Linux/drivers so we will move the driver to "misc" folder.
> 3)  We can also share some applications which show the usage of these driver
> API's from the user space.

That's great, submit away!

greg k-h
