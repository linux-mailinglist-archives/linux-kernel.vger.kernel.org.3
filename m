Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD9F5831D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiG0STM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbiG0SSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:18:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F23796BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:18:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f65so16428626pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WWCmALyIfyfxZcOwM+WnJXH5fX1Oapc9tMvQ2tyZ/gA=;
        b=RUGgbOZZiX9cKnAXmZSPCy70hMCEU8askQzkDRUlKVRVAodzICC7cgYAtYsie3UFzj
         L3TePliA+yGPcmjr9x0ihXFmgK0+p4Z3HIkfxhwXrqOWNp0iGDI0M7axOhthf2bDWtJ4
         fBf6wfG0P3yVO8lG6QMrjVT4qbsz6kbB6X+qRNG2/qP73aP5H0otgk4wulFpir6yq5tz
         PEN2viguJ7e1Q/BwDt8QZmdhSyl6gW9R07YA2Tnh+ksZj3osBIQsfKJL1SPw2Ow8ScZK
         6Z3t+/LppY9MZsKP3phkfXXWV7Kqz0/JNYxDVQQDkmyopr9z6n707dy7026MIwcW3iHy
         5WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWCmALyIfyfxZcOwM+WnJXH5fX1Oapc9tMvQ2tyZ/gA=;
        b=uRzg3jbkNBzeQjqGbZ01e3iL/G+PDusOkeEnkaigWxxUaXKdsImb6T2bK12n39FW9j
         6/JqMpaOlA3wdoLewJPD2bbCXVQgBgCV+K0qHDmPgciCd+2ZZ/ct0U/GkCsKgWtl3D/b
         3e6ltN40p8jdUoynypw53PWNNQvxVs8lZRg6d0G9deUCdtbAPGD+GzYuFICKSzKzSLGX
         Y+teLt1y4fTNqixIFdc8VxxqM+khfsZ5wGoFqt7QeIigUOYtsTxRPM+/7WjrxMIOCp7K
         rYfyQiHHVCrkm54Fiz963lLWJ2ncerEDYLtYgIlLhf5ORQ6KEYA2fAINn8rTkYN24HGO
         Rf6w==
X-Gm-Message-State: AJIora/MS8PZIgY16I96DHYAe61xXGS6vJN0reXu3xohdDC6PhZRJgUS
        v3N/oMqRintlS+JTUpgtLoyRwA==
X-Google-Smtp-Source: AGRyM1v6W5TTmMy+3aH01G2tHhgfhxx5mBK5jrf+PdOXn2Kww1Zmm2jC4Vo9LZW2r3fOUH6xPga6Jw==
X-Received: by 2002:a05:6a00:130a:b0:52c:5932:7160 with SMTP id j10-20020a056a00130a00b0052c59327160mr1898840pfu.19.1658942318560;
        Wed, 27 Jul 2022 10:18:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f2b0f8e047sm2081502pji.27.2022.07.27.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:18:37 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:18:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Chris Lew <quic_clew@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rpmsg: char: Add support to use rpmsg_rx_done
Message-ID: <20220727171836.GB199805@p14s>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
 <1654651005-15475-3-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654651005-15475-3-git-send-email-quic_clew@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 06:16:43PM -0700, Chris Lew wrote:
> Add support into the rpmsg char driver to skip copying the data into an
> skb if the endpoint supports rpmsg_rx_done. If the endpoint supports
> the rx_done operation, allocate a zero sized skb and set the data to
> the buffer returned in the rx callback. When the packet is read from
> the character device, release the memory by calling rpmsg_rx_done().
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 50 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index b6183d4f62a2..be62ddcf356c 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -91,8 +91,8 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_destroy);
>  
> -static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
> -			void *priv, u32 addr)
> +static int rpmsg_ept_copy_cb(struct rpmsg_device *rpdev, void *buf, int len,
> +			     void *priv, u32 addr)
>  {
>  	struct rpmsg_eptdev *eptdev = priv;
>  	struct sk_buff *skb;
> @@ -113,6 +113,43 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	return 0;
>  }
>  
> +static int rpmsg_ept_no_copy_cb(struct rpmsg_device *rpdev, void *buf, int len,
> +				void *priv, u32 addr)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +	struct sk_buff *skb;
> +
> +	skb = alloc_skb(0, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	skb->head = buf;
> +	skb->data = buf;
> +	skb_reset_tail_pointer(skb);
> +	skb_set_end_offset(skb, len);
> +	skb_put(skb, len);
> +

I was worried about all that open ended code but looking at the sk_buff API I
don't think it is possible to do otherwise.  As such:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>


> +	spin_lock(&eptdev->queue_lock);
> +	skb_queue_tail(&eptdev->queue, skb);
> +	spin_unlock(&eptdev->queue_lock);
> +
> +	/* wake up any blocking processes, waiting for new data */
> +	wake_up_interruptible(&eptdev->readq);
> +
> +	return RPMSG_DEFER;
> +}
> +
> +static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
> +			void *priv, u32 addr)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +	rpmsg_rx_cb_t cb;
> +
> +	cb = (eptdev->ept->rx_done) ? rpmsg_ept_no_copy_cb : rpmsg_ept_copy_cb;
> +
> +	return cb(rpdev, buf, len, priv, addr);
> +}
> +
>  static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  {
>  	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
> @@ -210,6 +247,15 @@ static ssize_t rpmsg_eptdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (copy_to_iter(skb->data, use, to) != use)
>  		use = -EFAULT;
>  
> +	if (eptdev->ept->rx_done) {
> +		rpmsg_rx_done(eptdev->ept, skb->data);
> +		/*
> +		 * Data memory is freed by rpmsg_rx_done(), reset the skb data
> +		 * pointers so kfree_skb() does not try to free a second time.
> +		 */
> +		skb->head = NULL;
> +		skb->data = NULL;
> +	}
>  	kfree_skb(skb);
>  
>  	return use;
> -- 
> 2.7.4
> 
