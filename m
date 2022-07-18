Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4F577D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiGRIcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGRIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:32:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028DB19019;
        Mon, 18 Jul 2022 01:32:05 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26I7VBb2032736;
        Mon, 18 Jul 2022 10:31:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+abmPYEQnU9+JlxUCqaWwS+GUJzoT8ValDRBagPFZmg=;
 b=R/D/pwpF/AZnDo1sRn+dRsDXD+enCHMXRONKwvYORIQ1oqxqox64lC6WNvX7y+J98hTQ
 l5ls3wb+4NEeeKUgH84faLGRe57U20drXuJdzXVx6ypujUaxepOKquWVIiUKLUqAqLGE
 rVjL/noW6D8Q8g14EP0wbpF6zkhLnQpKyGIN8XuVtshyn+QmGkcICrDcf11ruBJ9gOfA
 wwzcyGXGlvntu1GiQSH7mpbLfYY2y8L5OBLagxn4F0bdr7dn/SfDHxWlciuewl6sfbHu
 CO4xb3o1j5TLV0Dw6W6TIBM/lN++3KxfW4mPVUOmo+Pt+GyPbzMq2zuMUXmqy8Crvrxt vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnp5qw9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 10:31:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5F8B10002A;
        Mon, 18 Jul 2022 10:31:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E11E52138D7;
        Mon, 18 Jul 2022 10:31:57 +0200 (CEST)
Received: from [10.252.21.88] (10.75.127.47) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 18 Jul
 2022 10:31:56 +0200
Message-ID: <9a81c387-2b27-1227-ceb7-0da2d865f42d@foss.st.com>
Date:   Mon, 18 Jul 2022 10:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] rpmsg: core: Add rx done hooks
Content-Language: en-US
To:     Chris Lew <quic_clew@quicinc.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
 <1654651005-15475-2-git-send-email-quic_clew@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1654651005-15475-2-git-send-email-quic_clew@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_04,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 03:16, Chris Lew wrote:
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

DEFER or HOLD?
In both case, would be nice to update the up-streamed RPMSG service
devices to reflect this update, even if the compatibility is preserved.

> +
>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>  
>  /**
> @@ -71,6 +83,7 @@ typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
>   * @refcount: when this drops to zero, the ept is deallocated
>   * @cb: rx callback handler
>   * @cb_lock: must be taken before accessing/changing @cb
> + * @rx_done: if set, rpmsg endpoint supports rpmsg_rx_done

Same: done or hold?

Perhaps a bitmap here would be better for future.
I guess that similar feature could be requested for TX...

Regards,
Arnaud


>   * @addr: local rpmsg address
>   * @priv: private data for the driver's use
>   *
> @@ -93,6 +106,7 @@ struct rpmsg_endpoint {
>  	struct kref refcount;
>  	rpmsg_rx_cb_t cb;
>  	struct mutex cb_lock;
> +	bool rx_done;
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
