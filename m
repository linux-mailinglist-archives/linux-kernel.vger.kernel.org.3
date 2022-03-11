Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579D74D6A15
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCKXDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiCKXCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:02:51 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23529EA357
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:57:00 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id z8so11021018oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yzD1RK3pSrLk9IQZWHEqYqXIzTPUld+BN2oJpwWhxXs=;
        b=y2kEMmHWrdSGLy13N1UopU0NsU8PwQXMpsT5ULm/ANc9IAUQp1hx0p/66nJSl/PrWI
         OqOpUP7bgQJTXebZdmmW6u8c1qrHyYD/m59TC9YhN6nOlFB9RwBm09J7s08x71BToGtz
         GtrK9BxN0++ZASSmEG1eaGYMMcAJj4H4M0ejsUJY1yHqD/1J9N02QKjepxfGEGiKrqw9
         PglskyxGLjbi+SR/Vuhrda3X7Xe2N7eR2nrMp2A1Xdz3Uhw5jre+x3o9ZUk6SYx82Lbe
         HnOFLRDchTWcw2Xzqz7HXtbp89RuOfJgoT6hsnQtifM1Ws9ZFM8C+xuumJHul8k9pmOR
         eblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yzD1RK3pSrLk9IQZWHEqYqXIzTPUld+BN2oJpwWhxXs=;
        b=PLIOO7Syspdf9pEoa7V7hf54+CotzUBekzqZWN2LqDn2b4AaJ/CUkyUsxMk0iN42PG
         g7z6lLgaLi7mUI37MZZax0Mro4GcoZYS3mTVdcFurVKvypTLBiN/iDWu59qVjXCRKsi8
         /CLuUMm+RlkHXXNfQmUV5STAZIIK3CzfUMrvJNkdQoiMet8lGmwcHtoEwbDFCj6mjhFa
         pllpo3xnsUlwVLzI4fHoLC43VS+p5Gp8235YbelavaBdQG+K9+bDuuMEpDmySX3b+5ux
         OqwqnjrNnqqpRhFMy7NGnqrqMQ+wb6YZxeb7Z5hZeviLQTP7qb4+7RXjW5IGx58hHAUM
         9nbw==
X-Gm-Message-State: AOAM531jb+RfGo0W8U3OXYAANdj/kZsn/1RuaK7XVFzzSxqTMGnENkdp
        lSMcF5b8IdMTUQIHO05KIrPTz/LlLji5FA==
X-Google-Smtp-Source: ABdhPJxwm0eMWuv8Cx+IDd9t4EsguO15cCAebWBRr3MSUHjJT08kxq3GZ8bSPCd+FB8BlQr72tggWw==
X-Received: by 2002:a05:6870:1492:b0:da:b3f:322e with SMTP id k18-20020a056870149200b000da0b3f322emr6529020oab.222.1647032964730;
        Fri, 11 Mar 2022 13:09:24 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id k15-20020a056808068f00b002d91362e56esm4154417oig.1.2022.03.11.13.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:09:24 -0800 (PST)
Date:   Fri, 11 Mar 2022 15:09:22 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH V2 2/3] rpmsg: glink: Add support to handle signals
 command
Message-ID: <Yiu6guYrKYRhGtei@builder.lan>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
 <1642534993-6552-3-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642534993-6552-3-git-send-email-quic_deesin@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18 Jan 13:43 CST 2022, Deepak Kumar Singh wrote:

> Remote peripherals send signal notifications over glink with commandID 15.
> 
> Add support to send and receive the signal command and convert the signals
> from NATIVE to TIOCM while receiving and vice versa while sending.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>

Co-developed-by: seems appropriate here, or you need to ensure the
author remains Chris, as his S-o-b comes first.

> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 77 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 3f377a7..d673d65 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -17,6 +17,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/workqueue.h>
>  #include <linux/mailbox_client.h>
>  
> @@ -205,9 +206,16 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops;
>  #define RPM_CMD_TX_DATA_CONT		12
>  #define RPM_CMD_READ_NOTIF		13
>  #define RPM_CMD_RX_DONE_W_REUSE		14
> +#define RPM_CMD_SIGNALS			15
>  
>  #define GLINK_FEATURE_INTENTLESS	BIT(1)
>  
> +#define NATIVE_DTR_SIG			BIT(31)

Seems reasonable to prefix these with GLINK_, perhaps GLINK_SIGNAL_DTR?

> +#define NATIVE_CTS_SIG			BIT(30)
> +#define NATIVE_CD_SIG			BIT(29)
> +#define NATIVE_RI_SIG			BIT(28)
> +#define	SIG_MASK			0x0fff;
> +
>  static void qcom_glink_rx_done_work(struct work_struct *work);
>  
>  static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
> @@ -1003,6 +1011,70 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>  	return 0;
>  }
>  
> +/**
> + * qcom_glink_set_flow_control() - convert a signal cmd to wire format and
> + * 				   transmit
> + * @ept:	Rpmsg endpoint for channel.
> + * @enable:	True/False - enable or disable flow control

"enable flow control" sounds sufficient (i.e. no need for True/False)
part.

Regards,
Bjorn

> + *
> + * Return: 0 on success or standard Linux error code.
> + */
> +static int qcom_glink_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +	struct glink_channel *channel = to_glink_channel(ept);
> +	struct qcom_glink *glink = channel->glink;
> +	struct glink_msg msg;
> +	u32 sigs;
> +
> +	/**
> +	 * convert signals from TIOCM to NATIVE
> +	 * sigs = TIOCM_DTR|TIOCM_RTS
> +	 */
> +	if (enable)
> +		sigs |= NATIVE_DTR_SIG | NATIVE_CTS_SIG;
> +	else
> +		sigs |= ~(NATIVE_DTR_SIG | NATIVE_CTS_SIG);
> +
> +	msg.cmd = cpu_to_le16(RPM_CMD_SIGNALS);
> +	msg.param1 = cpu_to_le16(channel->lcid);
> +	msg.param2 = cpu_to_le32(sigs);
> +
> +	return qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
> +}
> +
> +static int qcom_glink_handle_signals(struct qcom_glink *glink,
> +				     unsigned int rcid, unsigned int sigs)
> +{
> +	struct glink_channel *channel;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&glink->idr_lock, flags);
> +	channel = idr_find(&glink->rcids, rcid);
> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
> +	if (!channel) {
> +		dev_err(glink->dev, "signal for non-existing channel\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!channel->ept.sig_cb)
> +		return 0;
> +
> +	/* convert signals from NATIVE to TIOCM */
> +	if (sigs & NATIVE_DTR_SIG)
> +		sigs |= TIOCM_DSR;
> +	if (sigs & NATIVE_CTS_SIG)
> +		sigs |= TIOCM_CTS;
> +	if (sigs & NATIVE_CD_SIG)
> +		sigs |= TIOCM_CD;
> +	if (sigs & NATIVE_RI_SIG)
> +		sigs |= TIOCM_RI;
> +	sigs &= SIG_MASK;
> +
> +	channel->ept.sig_cb(channel->ept.rpdev, channel->ept.priv, sigs);
> +
> +	return 0;
> +}
> +
>  static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>  {
>  	struct qcom_glink *glink = data;
> @@ -1067,6 +1139,10 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>  			qcom_glink_handle_intent_req_ack(glink, param1, param2);
>  			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>  			break;
> +		case RPM_CMD_SIGNALS:
> +			qcom_glink_handle_signals(glink, param1, param2);
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> +			break;
>  		default:
>  			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>  			ret = -EINVAL;
> @@ -1442,6 +1518,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
>  	.sendto = qcom_glink_sendto,
>  	.trysend = qcom_glink_trysend,
>  	.trysendto = qcom_glink_trysendto,
> +	.set_flow_control = qcom_glink_set_flow_control,
>  };
>  
>  static void qcom_glink_rpdev_release(struct device *dev)
> -- 
> 2.7.4
> 
