Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E85831BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbiG0SPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiG0SPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:15:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754DD7820F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:16:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s206so16447458pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Cp8hxjyFsaE82FE3kUlY/wY5Sc8ygaOOh3psw0ODPs=;
        b=gIyZY+gxDZfn2uH7MJzbE5BziRTX/OSE4vebEBtwvh9ioc/VZPVS5z293x+NDyQ21k
         wysreh65HygpoMKCHphFLL/OXEJY6K7Zv+rjD35eg87HO/Ztwawh6hw4EKDxk1rOIe08
         nLodSxyUXcbcB/JwXp66ZF3IBu+moTfdWcbZcdPYJZuHPvyu0siarx9pdvLteiom/3P1
         v/hA4gJkOWaY0nBYTvT93ZFJbsct5uRlTyJQZNQ6DaHBdbgKx6dif+QDa/x4fbU2vGRJ
         YPqbAG7SWVfyAo1yRXVXRe4Urq06+4YcxAdzhX0ghaOF9vQ4/Ic+WKh6nDiYLft0VzEj
         vVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Cp8hxjyFsaE82FE3kUlY/wY5Sc8ygaOOh3psw0ODPs=;
        b=65ZxPSIIg8urwHE/kjJRWMjziTk4tP18SstFOzLpYyGGik48x0cZLIHWupIgCxPlrH
         /W5+fpVm9u0dXh/0vhd8tY5lz/J+Xgh9sky+Q7sJ1a5dvK6pyJOZN+FjUX6v6MfFC2P2
         dajTfDEipM+7Mp/hVGEixlRCsPWm+82myGCK18hhdZgCFuOmQ1KXj7ynD/vyhEldsUWt
         m7xlyrOcDtayUD6nK48jIv3SIVJn+Vib3dDKT1FkMrO6n4tWAJkFrXx/DeSXiB9DinSt
         omejAI/AB62LxX5eKlDF/EDTN+/sQgvDs8C471cmtOaftWBmkqB87cYWLptSr7g/hz3o
         1cug==
X-Gm-Message-State: AJIora8ws8UHY29fH+/YQE8qERPrQQRkwKlcz6HOKK8gX5eCVB2qSdoD
        tj/LXKvpA8cbqQOnH7LEyD6X+r9E5SpOlw==
X-Google-Smtp-Source: AGRyM1t2p9mLNeFavg6JDGmNsDD591QfvcjLUIlhogsJg0Lzwt6k1eggGwfztu5hHmesV0ZyMMzfrg==
X-Received: by 2002:a63:4722:0:b0:40d:289e:8637 with SMTP id u34-20020a634722000000b0040d289e8637mr19464184pga.362.1658942179666;
        Wed, 27 Jul 2022 10:16:19 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a674100b001f262f6f717sm2061945pjm.3.2022.07.27.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:16:18 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:16:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Chris Lew <quic_clew@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] rpmsg: core: Add rx done hooks
Message-ID: <20220727171616.GA199805@p14s>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
 <1654651005-15475-2-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654651005-15475-2-git-send-email-quic_clew@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 06:16:42PM -0700, Chris Lew wrote:
> In order to reduce the amount of copies in the rpmsg framework, it is
> necessary for clients to take brief ownership of the receive buffer.
> 
> Add the capability for clients to notify the rpmsg framework and the
> underlying transports when it is going to hold onto a buffer and also
> notify when the client is done with the buffer.
> 
> In the .rx_cb of the rpmsg drivers, if they wish to use the received
> buffer at a later point, they should return RPMSG_DEFER. Otherwise
> returning RPMSG_HANDLED (0) will signal the framework that the client
> is done with the resources and can continue with cleanup.
> 
> The clients should check if their rpmsg endpoint supports the rx_done
> operation with the new state variable in the rpmsg_endpoint since not
> all endpoints will have the ability to support this operation.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  1 +
>  include/linux/rpmsg.h          | 24 ++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 290c1f02da10..359be643060f 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -351,6 +351,26 @@ ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>  }
>  EXPORT_SYMBOL(rpmsg_get_mtu);
>  
> +/**
> + * rpmsg_rx_done() - release resources related to @data from a @rx_cb
> + * @ept:	the rpmsg endpoint
> + * @data:	payload from a message
> + *
> + * Returns 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_rx_done(struct rpmsg_endpoint *ept, void *data)
> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->rx_done)
> +		return -ENXIO;
> +	if (!ept->rx_done)
> +		return -EINVAL;
> +
> +	return ept->ops->rx_done(ept, data);
> +}
> +EXPORT_SYMBOL(rpmsg_rx_done);
> +
>  /*
>   * match a rpmsg channel with a channel info struct.
>   * this is used to make sure we're not creating rpmsg devices for channels
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index a22cd4abe7d1..99cb86ce638e 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -76,6 +76,7 @@ struct rpmsg_endpoint_ops {
>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>  			     poll_table *wait);
>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
> +	int (*rx_done)(struct rpmsg_endpoint *ept, void *data);
>  };
>  
>  struct device *rpmsg_find_device(struct device *parent,
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 523c98b96cb4..8e34222e8bca 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -63,6 +63,18 @@ struct rpmsg_device {
>  	const struct rpmsg_device_ops *ops;
>  };
>  
> +/**
> + * rpmsg rx callback return definitions
> + * @RPMSG_HANDLED: rpmsg user is done processing data, framework can free the
> + *                 resources related to the buffer
> + * @RPMSG_DEFER:   rpmsg user is not done processing data, framework will hold
> + *                 onto resources related to the buffer until rpmsg_rx_done is
> + *                 called. User should check their endpoint to see if rx_done
> + *                 is a supported operation.
> + */
> +#define RPMSG_HANDLED	0
> +#define RPMSG_DEFER	1
> +
>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>  
>  /**
> @@ -71,6 +83,7 @@ typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>   * @refcount: when this drops to zero, the ept is deallocated
>   * @cb: rx callback handler
>   * @cb_lock: must be taken before accessing/changing @cb
> + * @rx_done: if set, rpmsg endpoint supports rpmsg_rx_done
>   * @addr: local rpmsg address
>   * @priv: private data for the driver's use
>   *
> @@ -93,6 +106,7 @@ struct rpmsg_endpoint {
>  	struct kref refcount;
>  	rpmsg_rx_cb_t cb;
>  	struct mutex cb_lock;
> +	bool rx_done;

Do you see a scenario where rpmsg_endpoint_ops::rx_done holds a valid pointer
but rpmsg_epndpoint::rx_done is set to false?  If not please remove.

>  	u32 addr;
>  	void *priv;
>  
> @@ -192,6 +206,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  
>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>  
> +int rpmsg_rx_done(struct rpmsg_endpoint *ept, void *data);
> +
>  #else
>  
>  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> @@ -316,6 +332,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>  	return -ENXIO;
>  }
>  
> +static inline int rpmsg_rx_done(struct rpmsg_endpoint *ept, void *data)
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
