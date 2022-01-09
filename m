Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BA488A4F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiAIPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiAIPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:49:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CCC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 07:49:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m1so8628211pfk.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=501hrPPR2NA197ryGJ1qflWENP5i8cayYWfphaqX6q8=;
        b=NQkiFS3thn2czIYZuz0IHrcv4L8CaUwVoAH3KWGMuccrANsZ+hCc18qWqWyoyrJ8Bl
         UTtjk4CogHRknOdLY3WDcyGSJva8S3sHfiQiOmNJDDmi0YqC5Qy0kUyzUCome1Qvt0bf
         p56LomVPt/8xreogJ1kVh/1C8Trl6Sa8+95f79K543qFfVph0i7RLHthfFwQpMcaZ62N
         Iv89wWL0bthKjb1Iu24GMeJD6iVe4Gqli92KVM3yIXwGgQXPvOMZzHY0MgrlVn+XM4j7
         F2Yjsvtn6nU11uQ6oqKb0K6RZAgOcjwyOWs92M8fwQJKBVTzxhueBmhnNgA0uRe6tjaS
         MWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=501hrPPR2NA197ryGJ1qflWENP5i8cayYWfphaqX6q8=;
        b=PEuFYmBjLnZK2qFxI8uYrBRog5uzgnURFP7/E5KYGFqDsINL8WTzMeqr4QN2E1O12K
         QNgluGSrExvVZRmhqafDo2L6sfu704UFr0wiLWqXZuWF4fvz7sz5Vge897+lv0gXXQBS
         4bSt3vx5r/BWNJUQptLU3YIg74VzvXe861fBwE+/pqW3F+wpMxBx+f/lwmMsVw/Rg+m7
         nM5lAWTeOSp9Y9bcpLE/1T4wzBvR1aKWtxETprwXRuPI3a4COWrYOEgdvDEH8mQilFZQ
         rDB2Clarb/PYW9jrIugs0cNDBJrlKAMUycHKcrG5jh2jXbcvpWB5ENb3hh0E5DPkUn57
         6/6w==
X-Gm-Message-State: AOAM531szmkgm7G4xPwwt2JZRtQERyw6qiu6r7vt2h3HeK91lCM7kfgR
        /5O5227rpCM88MNQwRNGQsU=
X-Google-Smtp-Source: ABdhPJwbnjU5708553O1rPJMIrLe79sBqcsILgX2F7IMK6ZajDCq1PcISmwQWKan6N8poqMRi72AfA==
X-Received: by 2002:a65:460c:: with SMTP id v12mr62315121pgq.58.1641743398140;
        Sun, 09 Jan 2022 07:49:58 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id q9sm3320011pgv.71.2022.01.09.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 07:49:57 -0800 (PST)
Date:   Sun, 9 Jan 2022 15:49:50 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: enforce tx_cfg to be set before any
 message can be sent
Message-ID: <20220109154950.GA27767@realwakka>
References: <20220108222652.GA11883@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108222652.GA11883@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 11:26:52AM +1300, Paulo Miguel Almeida wrote:

Hi, Paulo.
Thanks for the patch.
I have some opinion below.

> this driver relies on exposing a char device to userspace to tx
> messages. Every message can be sent using different trasmitter settings
> such so the tx_cfg must be written before sending any messages.
> Failing to do so will cause the message to fail silently depending on
> printk/dynamic_debug settings which makes it hard to troubleshoot.
> 
> This patch add a control variable that will get initialized once tx_cfg
> is set for the fd used when interacting with the char device.

I don't know that adding flag is good idea. It seems that initializing
to default is better than this.

> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Patch dependency: 
> - This patch needs the patch below to be applied first as both tweak the
>   same file.
> https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
> 
> meta-comments:
> - I'm not entirely sure if -EPERM is the best error code to return here,
>   I'm taking suggestions
> ---
>  drivers/staging/pi433/pi433_if.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 051c9052aeeb..3e9913f4bc7d 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -108,6 +108,9 @@ struct pi433_device {
>  struct pi433_instance {
>  	struct pi433_device	*device;
>  	struct pi433_tx_cfg	tx_cfg;
> +
> +	/* control flags */
> +	bool			tx_cfg_initialized;
>  };
>  
>  /*-------------------------------------------------------------------------*/
> @@ -823,6 +826,16 @@ pi433_write(struct file *filp, const char __user *buf,
>  	if (count > MAX_MSG_SIZE)
>  		return -EMSGSIZE;
>  
> +	/*
> +	 * check if tx_cfg has been initialized otherwise we won't be able to
> +	 * config the RF trasmitter correctly due to invalid settings
> +	 */
> +	if (!instance->tx_cfg_initialized) {
> +		dev_dbg(device->dev,
> +			"write: failed due to uninitialized tx_cfg");
> +		return -EPERM;
> +	}
> +
>  	/*
>  	 * write the following sequence into fifo:
>  	 * - tx_cfg
> @@ -897,6 +910,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return -EFAULT;
>  		mutex_lock(&device->tx_fifo_lock);
>  		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
> +		instance->tx_cfg_initialized = true;
>  		mutex_unlock(&device->tx_fifo_lock);
>  		break;
>  	case PI433_IOC_RD_RX_CFG:
> @@ -950,7 +964,7 @@ static int pi433_open(struct inode *inode, struct file *filp)
>  	/* setup instance data*/
>  	instance->device = device;
>  	instance->tx_cfg.bit_rate = 4711;
> -	// TODO: fill instance->tx_cfg;
> +	instance->tx_cfg_initialized = false;
>  
>  	/* instance data as context */
>  	filp->private_data = instance;
> -- 
> 2.25.4
> 
