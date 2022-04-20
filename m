Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F74508E02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380885AbiDTRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356013AbiDTRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:10:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D2BE15;
        Wed, 20 Apr 2022 10:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E621B8210D;
        Wed, 20 Apr 2022 17:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79355C385A1;
        Wed, 20 Apr 2022 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650474442;
        bh=QAxVP4eS9yUe2My8LiKu9u/E2UpxORATLT2tPbgMn48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RmO8Q/g16xTHL/UFejqaVxdr/oHqxuONTfP4M47wVeBSn0Gy710Bm2+2hFccoUH0p
         aebHP9JNC4xtR4K2spDiYH82/Zen8UtXR94yWWGyDn3QBUDKxk7wFdc7WYoq5A3qdr
         fe8qAJLmkqrvAWeZZUJ1YaZS4CYabd1i72I8CESQ=
Date:   Wed, 20 Apr 2022 19:07:19 +0200
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
Message-ID: <YmA9x/Yn9lJwegsu@kroah.com>
References: <20220404054642.3095732-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404054642.3095732-1-tweek@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 94d1789a233e..416ee3cc6584 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -735,6 +735,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  		  size_t offset, u32 opt_flags)
>  {
>  	struct firmware *fw = NULL;
> +	struct cred *kern_cred = NULL;
> +	const struct cred *old_cred;
>  	bool nondirect = false;
>  	int ret;
>  
> @@ -751,6 +753,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	if (ret <= 0) /* error or already assigned */
>  		goto out;
>  
> +	kern_cred = prepare_kernel_cred(NULL);
> +	if (!kern_cred) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	old_cred = override_creds(kern_cred);

Can you add a comment here before the call to prepare_kernel_cred() to
say why you are doing this and what it is for?  Otherwise it is not
obvious at all.

thanks,

greg k-h
