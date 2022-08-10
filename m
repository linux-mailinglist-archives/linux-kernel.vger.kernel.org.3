Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A558F041
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiHJQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A125D642FE;
        Wed, 10 Aug 2022 09:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5BB861138;
        Wed, 10 Aug 2022 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C975BC433C1;
        Wed, 10 Aug 2022 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660148432;
        bh=mR5MkiYxhBloitX0py6T+VS5H2HSybt7+7SDSya1JiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddaOPiRMPZjMqFSQDysMhAgxeNBDVF3ELzpUlzOcqjKBbyDJlqBcx3fJkRFI4F/Au
         wjCzv3uUees1c/vtMzKPayd+XxSTF+99eppUs2bFUWR7tfsHzZbqlcOervdPj8NSMy
         rpKPYY7eg6B0W+str1FCBbwXhxhpfeQMlEb90UY4=
Date:   Wed, 10 Aug 2022 18:20:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] Bluetooth: btusb: Add btusb devcoredump support
Message-ID: <YvPayNHamzrt+xxF@kroah.com>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <20220810085753.v5.4.Id0d6e772f00432d55f6bcbf68a50cb4ad89396c6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810085753.v5.4.Id0d6e772f00432d55f6bcbf68a50cb4ad89396c6@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:00:37AM -0700, Manish Mandlik wrote:
> This patch implements the btusb driver side .coredump() callback to
> trigger a devcoredump via sysfs and .enable_coredump() callback to
> check if the devcoredump functionality is enabled for a device.
> 
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> (no changes since v4)
> 
> Changes in v4:
> - New patch in the series
> 
>  drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 30dd443f395f..b00851327aa3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1510,6 +1510,15 @@ static void btusb_isoc_tx_complete(struct urb *urb)
>  	kfree_skb(skb);
>  }
>  
> +#ifdef CONFIG_DEV_COREDUMP
> +static bool btusb_coredump_enabled(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +
> +	return !data->intf->dev.coredump_disabled;
> +}
> +#endif

Again, #ifdef in .c files is unmaintainable over time, please do not do
it if at all possible.

thanks,

greg k-h
