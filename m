Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0758F6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiHKEUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKEUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:20:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA3DBC;
        Wed, 10 Aug 2022 21:20:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so15985206plr.8;
        Wed, 10 Aug 2022 21:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QA+DQaLDylf4F6yk3hQl/nabZXCeLiEG0/qFBjl/leg=;
        b=g5oEbXPsD6tfxj3aOfxCdkGlhm32CPZljA/7Vdm78a+d/h74nReeUTR7kZIa1Nyqun
         j6KNiz41EPrJbZHcrwhXiDzzfhfb3J/kFIC2liQ0oRkODYVDQk+rjGHL9MjQxbOvGiAe
         28F7OKpbN7KITgCs985cLKY+1IQSXnO4ezgy3RNmimn7zaqnBCOhBPPWFD4xN6e0QL21
         IB/0uDL2jyCqUdoWWVk+tPe2nUJHMOfmDB10EY09HWYQMArrnhrtueT3fi5UdbokKK2c
         SJGpdEG4W8WZsDpokueBSlj+szQlkOI0EK1/BxZNA42bAFx8frwZFwCsOodu9bXlQGwG
         7xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QA+DQaLDylf4F6yk3hQl/nabZXCeLiEG0/qFBjl/leg=;
        b=zuQbxLXpyBiJiufVileCiGwyPggjh5ZygOsdbiq7v3cY8keNYO/rb9MRsblgF/CNjq
         9LJG0VT0zGtW/Zl/AitBnIxTn/+rzOjv5/8BUm4VLt3HTCHMzM4SH5PupxavB1h1Yk3B
         7LOugZYmqcTzTvcmXyivbSJtwnAL3T7/UZcpmEo6ORMTcHi7bfGUpcU2hi5r205ihALX
         isEskrCmUaPd0jD6R2AJVfdVeihehzvMMBlU6AKwYX8BExG5XBIwn0eLdCWcyprL/aVm
         oKrNMeIG7/FMrLGvY5gyVK0MUGCu5dX4Wu7xSRc587qGUFTXyR/pjJZLf+32gxQ8RrvC
         DNvQ==
X-Gm-Message-State: ACgBeo3fciM3h/bLNhBgdVKhy64Yhp0Lnhkv501UbKc1w0qYtyXwGg/+
        ssjqhhkKBlTyVzoIRK8Li4w=
X-Google-Smtp-Source: AA6agR6NJfGKoeDt6mwEDLjjBzfUSAs4/w73oYNAY7occR922bkDme8MQy1RWU9KDPREcJ1AAK3zsQ==
X-Received: by 2002:a17:90b:2516:b0:1f7:26dc:3d3a with SMTP id ns22-20020a17090b251600b001f726dc3d3amr6876188pjb.115.1660191640804;
        Wed, 10 Aug 2022 21:20:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a68cc00b001f50c1f896esm2514182pjj.5.2022.08.10.21.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:20:39 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:20:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     margeyang <marge.yang@synaptics.corp-partner.google.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, benjamin.tissoires@redhat.com,
        marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com
Subject: Re: [PATCH V3] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Message-ID: <YvSDlPTMEBgj3OLL@google.com>
References: <1660186712-2598-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660186712-2598-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marge,

On Thu, Aug 11, 2022 at 10:58:32AM +0800, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>

I recommend using your official @synaptics.com email address for
upstream submissions.

> 
> The interrupt GPIO will be pulled down once
> after RMI driver reads this command(Report ID:0x0A).
> It will cause "Dark resume test fail" for chromebook device.

What exactly is the failure mode? Please describe what exactly happens.
Maybe you can also add dtor@google.com to the relevant internal bugs.

> Hence, TP driver will ignore rmi_hid_read_block function once
> after system resumes.

Do you really want to avoid reads, or we happen to signal wakeup from
attention handler somewhere? Is it still valid to skip read if the
touchpad or touchscreen is truly the wakeup source?

> 
> Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
> ---
>  drivers/hid/hid-rmi.c | 14 ++++++++++++--
>  include/linux/rmi.h   |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 311eee599ce9..fdaf2c4ce181 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -203,7 +203,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>  		if (ret < 0)
>  			goto exit;
>  	}
> -
> +	if (xport->ignoreonce == 1) {
> +		dev_err(&hdev->dev,
> +			"ignoreonce (%d)\n",
> +			xport->ignoreonce);
> +		xport->ignoreonce = 0;
> +		goto exit;
> +	}

Do we need to have it after updating the page register?

>  	for (retries = 5; retries > 0; retries--) {
>  		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
>  		data->writeReport[1] = 0; /* old 1 byte read count */
> @@ -468,8 +474,12 @@ static int rmi_post_resume(struct hid_device *hdev)
>  	ret = hid_hw_open(hdev);
>  	if (ret)
>  		return ret;
> -
> +	// Avoid to read rmi_hid_read_block once after system resumes.
> +	// The interrupt will be pulled down
> +	// after RMI Read command(Report ID:0x0A).
> +	data->xport.ignoreonce = 1;
>  	ret = rmi_reset_attn_mode(hdev)
> +	data->xport.ignoreonce = 0;
>  	if (ret)
>  		goto out;
>  
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index ab7eea01ab42..24f63ad00970 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -270,6 +270,8 @@ struct rmi_transport_dev {
>  	struct rmi_device_platform_data pdata;
>  
>  	struct input_dev *input;
> +
> +	int ignoreonce;
>  };
>  
>  /**
> -- 
> 2.22.0.windows.1
> 

Thanks.

-- 
Dmitry
