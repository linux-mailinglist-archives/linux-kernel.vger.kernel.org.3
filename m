Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E84F110C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiDDIfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiDDIfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:35:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6671EEE6;
        Mon,  4 Apr 2022 01:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB956B8095D;
        Mon,  4 Apr 2022 08:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB4C2BBE4;
        Mon,  4 Apr 2022 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649061223;
        bh=3+aXnyKAGwDONEMRGlKqtjt4U0eKGQljW4RqsyU3N/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3TzRA2fqLCEn/HnsbE80WeJd6HFLyT3iRfwz+TBCVW4RXocou4pEPOxp8hcTCAfz
         Ac5YJIRgzNmKAGu4ByL2ByWxY4Fx/jKKuQxpVUnYTdpXGEOA1MF8MX1AddYVM9OtfS
         f/aJqjNe5dVOXSOl1WCv/VyHHOGTqdxWU4gey4uQ=
Date:   Mon, 4 Apr 2022 10:33:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YkqtZFuMpYxDBAH+@kroah.com>
References: <20220404054642.3095732-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404054642.3095732-1-tweek@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 03:46:42PM +1000, Thiébaud Weksteen wrote:
> Device drivers may decide to not load firmware when probed to avoid
> slowing down the boot process should the firmware filesystem not be
> available yet. In this case, the firmware loading request may be done
> when a device file associated with the driver is first accessed. The
> credentials of the userspace process accessing the device file may be
> used to validate access to the firmware files requested by the driver.
> Ensure that the kernel assumes the responsibility of reading the
> firmware.
> 
> This was observed on Android for a graphic driver loading their firmware
> when the device file (e.g. /dev/mali0) was first opened by userspace
> (i.e. surfaceflinger). The security context of surfaceflinger was used
> to validate the access to the firmware file (e.g.
> /vendor/firmware/mali.bin).
> 
> Because previous configurations were relying on the userspace fallback
> mechanism, the security context of the userspace daemon (i.e. ueventd)
> was consistently used to read firmware files. More devices are found to
> use the command line argument firmware_class.path which gives the kernel
> the opportunity to read the firmware directly, hence surfacing this
> misattribution.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  drivers/base/firmware_loader/main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Is this a bugfix?  if so, what commit does this fix?  If not, how has
this never been a problem in the past (i.e. what changed to cause
problems?)

thanks,

greg k-h
