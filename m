Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75EF50BA44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448737AbiDVOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448731AbiDVOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:40:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E05BD27;
        Fri, 22 Apr 2022 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=roXSkgp7AcHF/lcjOHhcpN8Xmx+GkKmLRVoKkTd+Adg=; b=tX4y9UPOAPrnbbwo+/TBmRkSgf
        Cd+ngehcbDyo3TrDTO3BCcy391X73BF1SaPWigbX5EapQk26CDRz6dG0tPasYpTSLP1peYb0l4qoY
        AX98pK4gmSd5wkhfSS3AN14hwwtaQsUTgY7eOTw8BegTdF5/jf9nLkymP0poHrcfm/fxwSP3ihL8K
        G3Us+PEcBvBHfg3idr6YvVakesrsHKHuzeVh+AMsNjStnSCZksWcm2tHNaQ8fJkqtYsceAJlwji9U
        VETXSFsHDrB2gRtRHgnYzmOlCq8vY0ZoNoHICEcEzD1h2VknMwJQESlD8UJFJNxb3pLU6Fgf8BZDi
        hUfxK/hA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhuPG-000qpU-B7; Fri, 22 Apr 2022 14:37:10 +0000
Date:   Fri, 22 Apr 2022 07:37:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YmK9lhEENKFnr6sd@bombadil.infradead.org>
References: <20220422013215.2301793-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220422013215.2301793-1-tweek@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:32:15AM +1000, Thiébaud Weksteen wrote:
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

Can you elaborate on the last sentence? It's unclear how what you
describe is used exactly to allow driver to use direct filesystem
firmware loading.

And, given the feedback from Android it would seem this is a fix
which likely may be desirable to backport to some stable kernels?

Otherwise looks good

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> v2: Add comment
> 
>  drivers/base/firmware_loader/main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 94d1789a233e..8f3c2b2cfc61 100644
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
> @@ -751,6 +753,18 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	if (ret <= 0) /* error or already assigned */
>  		goto out;
>  
> +	/*
> +	 * We are about to try to access the firmware file. Because we may have been
> +	 * called by a driver when serving an unrelated request from userland, we use
> +	 * the kernel credentials to read the file.
> +	 */
> +	kern_cred = prepare_kernel_cred(NULL);
> +	if (!kern_cred) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	old_cred = override_creds(kern_cred);
> +
>  	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
>  
>  	/* Only full reads can support decompression, platform, and sysfs. */
> @@ -776,6 +790,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	} else
>  		ret = assign_fw(fw, device);
>  
> +	revert_creds(old_cred);
> +
>   out:
>  	if (ret < 0) {
>  		fw_abort_batch_reqs(fw);
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
