Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A64D6ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiCKWxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCKWwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:53 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56671FAA03
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:30:08 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so12203949ooj.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yr+EpRW9Z0TSAD7dSRiRBdvgDfolyIlRbve+K3pZ6CU=;
        b=sK5PFeJEOg8sIlRshJg3bAbaGWntnn8gqRnEpXHzLfHthZOKB4sWkf08LgBv9JvheE
         4FPriDMxTV4y5+5LJv1MKgZ72yFQIcEmy4ytltQG1KTFDCBj09wxJM70GinaBSMZgcWr
         9Unmg5Xgha7ZQ5c9T45EQOiAJ46rWB9C2ttLVRP7tH+3tKimK8DeUCzC5w92PsewgvaR
         oY5gUUeCAa7VIZaV7dvlpmYMpJyu9Ztxxu/MFnLV2/Jyh92BY5fzyNrihsJhVs7WsFPI
         8AN5gWYOHo6K3G23HqFdBmoBgUkSIgbJe6y7nYdOqG2YYx3OSs8COh1Aay9x+rxIVBZp
         0cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yr+EpRW9Z0TSAD7dSRiRBdvgDfolyIlRbve+K3pZ6CU=;
        b=4z35TTT6kdVz5cL9JZOt0OiRHW5YiLyxw1mJK5V0t6vwBzKhV6/QYyl0RIaA07wTEl
         3c9sJT2o7vKbQ/EsFUKecNm/Xc/kcaDD9K6FFiOaCuWHVmO+mDXJ6XV/iWyX/B5DH1jP
         cOlTLFt9S54ZO/FxwBM0XLzRV191E0DV6otKpqx3e8R67LqIlAOEVZDwtWu1OnBQoMhM
         GZYG2zgkmr0sC+fi64YcCie6ADYrYA17pbsQmhkxggU0PrdgFi2xxP86+yrOrclXRk/9
         EI16FF99AbSuIcSvfXjGwuUFvNCXXpR3nv/yUIia+JhrM+JD4absca1lbiFSySLMZP24
         7bfw==
X-Gm-Message-State: AOAM530UFeJa+URkdqXybe83y3EqBfWikS7TMVI2FdvAPTJHLfkC6DpX
        7aiLaK5Or6rU2UFZXAHrMsj3yI6vQqlV3w==
X-Google-Smtp-Source: ABdhPJxry66IE5gf3DaRXf2Wzvoc+Z3uEVp+kLSeb4hIL6nULTEjW7sAoNaahJ0ohD+KTPWh4EBixA==
X-Received: by 2002:a05:6808:148d:b0:2d9:9049:b0e8 with SMTP id e13-20020a056808148d00b002d99049b0e8mr7436984oiw.151.1647033102656;
        Fri, 11 Mar 2022 13:11:42 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830310300b005c93d1cbb9fsm1172891ots.68.2022.03.11.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:11:42 -0800 (PST)
Date:   Fri, 11 Mar 2022 15:11:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH V2 1/3] rpmsg: core: Add signal API support
Message-ID: <Yiu7DPHDY3uwcnLK@builder.lan>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-2-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642534993-6552-2-git-send-email-quic_deesin@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:

> Some transports like Glink support the state notifications between
> clients using signals similar to serial protocol signals.
> Local glink client drivers can send and receive signals to glink
> clients running on remote processors.
> 
> Add APIs to support sending and receiving of signals by rpmsg clients.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>  include/linux/rpmsg.h          | 14 ++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index d3eb600..6712418 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -328,6 +328,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>  
>  /**
> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> + * @ept:	the rpmsg endpoint
> + * @enable:	enable or disable serial flow control
> + *
> + * Return: 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)

This API looks nice and clean and deals with flow control.

> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->set_flow_control)
> +		return -ENXIO;
> +
> +	return ept->ops->set_flow_control(ept, enable);
> +}
> +EXPORT_SYMBOL(rpmsg_set_flow_control);
> +
> +/**
>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>   * @ept: the rpmsg endpoint
>   *
> @@ -535,6 +553,9 @@ static int rpmsg_dev_probe(struct device *dev)
>  
>  		rpdev->ept = ept;
>  		rpdev->src = ept->addr;
> +
> +		if (rpdrv->signals)
> +			ept->sig_cb = rpdrv->signals;
>  	}
>  
>  	err = rpdrv->probe(rpdev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index b1245d3..35c2197 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -53,6 +53,7 @@ struct rpmsg_device_ops {
>   * @trysendto:		see @rpmsg_trysendto(), optional
>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>   * @poll:		see @rpmsg_poll(), optional
> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>   * @get_mtu:		see @rpmsg_get_mtu(), optional
>   *
>   * Indirection table for the operations that a rpmsg backend should implement.
> @@ -73,6 +74,7 @@ struct rpmsg_endpoint_ops {
>  			     void *data, int len);
>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>  			     poll_table *wait);
> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>  };
>  
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 02fa911..06d090c 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -62,12 +62,14 @@ struct rpmsg_device {
>  };
>  
>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
> +typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32);

This callback however, is still using the original low level tty
signals.

Is there any reason why this can't be "rpmsg_flowcontrol_cb_t" and take
a boolean, so we get a clean interface in both directions?

Regards,
Bjorn

>  
>  /**
>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
>   * @rpdev: rpmsg channel device
>   * @refcount: when this drops to zero, the ept is deallocated
>   * @cb: rx callback handler
> + * @sig_cb: rx serial signal handler
>   * @cb_lock: must be taken before accessing/changing @cb
>   * @addr: local rpmsg address
>   * @priv: private data for the driver's use
> @@ -90,6 +92,7 @@ struct rpmsg_endpoint {
>  	struct rpmsg_device *rpdev;
>  	struct kref refcount;
>  	rpmsg_rx_cb_t cb;
> +	rpmsg_rx_sig_t sig_cb;
>  	struct mutex cb_lock;
>  	u32 addr;
>  	void *priv;
> @@ -111,6 +114,7 @@ struct rpmsg_driver {
>  	int (*probe)(struct rpmsg_device *dev);
>  	void (*remove)(struct rpmsg_device *dev);
>  	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
> +	int (*signals)(struct rpmsg_device *rpdev, void *priv, u32);
>  };
>  
>  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
> @@ -188,6 +192,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  
>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>  
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
> +
>  #else
>  
>  static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
> @@ -306,6 +312,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>  	return -ENXIO;
>  }
>  
> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return -ENXIO;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>  
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> -- 
> 2.7.4
> 
