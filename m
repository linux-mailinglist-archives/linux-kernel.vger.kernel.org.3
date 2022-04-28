Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DC512E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiD1Ifx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiD1IeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:34:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E5A27FF;
        Thu, 28 Apr 2022 01:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E257B82B47;
        Thu, 28 Apr 2022 08:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBA8C385A9;
        Thu, 28 Apr 2022 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651134524;
        bh=FQ7tkUBDxzmIQSIuGVBUfG+AlREALsjEt5yG5PjK1+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTZb83o9GLYWJwu5A6wCFd9vhs9TWHnnQMLn9YPQvTKTWatkDPxOxcRjCCLvpt0xE
         gdX0ZvAECJ1PkQafYq81Fr0s2sYLtY1y2R5LiQ2sI8ZmPtJymzoy0SUU9i79cr57fM
         AMB1B2Xuzv0sDgWi8K2qlDCtllq7+6Ywl+OMBYeI=
Date:   Thu, 28 Apr 2022 10:28:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YmpQOSf0bdOcIZSU@kroah.com>
References: <20220428061707.768468-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428061707.768468-1-tweek@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:17:07PM +1000, Thiébaud Weksteen wrote:
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
> Previously, Android configurations were not setting up the
> firmware_class.path command line argument and were relying on the
> userspace fallback mechanism. In this case, the security context of the
> userspace daemon (i.e. ueventd) was consistently used to read firmware
> files. More Android devices are now found to set firmware_class.path
> which gives the kernel the opportunity to read the firmware directly
> (via kernel_read_file_from_path_initns). In this scenario, the current
> process credentials were used, even if unrelated to the loading of the
> firmware file.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---

As stated before, should this go to stable kernels?  If so, how far
back?

And you forgot to cc: John?

thanks,

greg k-h
