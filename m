Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE651DE33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444126AbiEFRQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379066AbiEFRQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:16:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47E22BFE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 10:12:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so8040734plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y5j094DPRHeZY99oesAJ3jD7eRhZ4vMFwjoZ+Ryi1tg=;
        b=PLWqkvfpBIz0YAKpzE8d7HqkW2be22+6wtRGeNO8rkofc+vVMVudpF9Vq5h3qfqvZe
         +Y97bEJYqTW+r+glnIE75TBr+6VysuOgDD0T/P6U4K3rHzjc/N8B52SwFBsO55KO7V28
         UH4edqC9e2bYKQ1IaI8gd0NGs7tvXen7wnh93P2uzEiIvZo265ZIApY9WdAgG920MI8+
         ix32KFwU91g1eCKIiFIbJrsASzTU90TWIDBhVE/iekvVovPqPZtuWRD+LMzKIXhNxhS5
         dQOYVBl6kk0attyw1yNZNl+j43uITlZkHCsSeAEqyHKLaqHOwvpzSeZm3BLlRgUvRDX+
         5srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5j094DPRHeZY99oesAJ3jD7eRhZ4vMFwjoZ+Ryi1tg=;
        b=nbAPyMPzWnCyukZ318ueqEmUi7mngHulRApOLRPYKtjOiyuybUFNJL3cB4pfW2rhj2
         srOMeiuiC/Qm7bThi7JcY3LHw7zs52dUGMw98XlCXoo93Y3Rz9a75sQDqAFPBXBadyfQ
         gGUoRbOElASxFAfFGdxcERueprjsSLReTvgGDucbS6AeSNqqcWt3H1PlBnXg9x8+cU6F
         ZQYK1CxhXzzRIz3Bx8ydhRce17O+GQO5tSfRBkLuB3iX14N3ADEo4vnNWDb3xrEzX5q5
         vD2u+NDv+uVbYLhoxEOugAq4ts2FWooXdqMNlSX/v91HJLFlpM5VrDdZfdwylE62lzwo
         muxQ==
X-Gm-Message-State: AOAM531qSnNNV8dglohiRtqvZOW62QMG9Q2JGgtNrQ223fZ4kGcIIhtK
        kI8nZQHFO1B9sBED8aId4d1BCg==
X-Google-Smtp-Source: ABdhPJyxvbn7xQx6eD34L504pFKRwq5Xji91lr3nz7ShqfmYHAW1qdEgkx4ky5S4KKsF7POvptuBgQ==
X-Received: by 2002:a17:90b:1bc3:b0:1dc:61fd:7ea4 with SMTP id oa3-20020a17090b1bc300b001dc61fd7ea4mr13197467pjb.31.1651857145904;
        Fri, 06 May 2022 10:12:25 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b0015e8d4eb222sm1168856pln.108.2022.05.06.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 10:12:24 -0700 (PDT)
Date:   Fri, 6 May 2022 11:12:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: virtio: set dst address on first message received
Message-ID: <20220506171222.GA2816011@p14s>
References: <20220315153856.3117676-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315153856.3117676-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:38:56PM +0100, Arnaud Pouliquen wrote:
> when a rpmsg channel has been locally created with a destination address

s/when/Wen

Also, please be more specific about the "locally created" part, i.e
rpmsg_ctrldev_ioctl() -> rpmsg_create_channel().  Otherwise it is really hard to
understand the context of this change.

> set to RPMSG_ADDR_ANY, a name service announcement message is sent to
> the remote side. Then the destination address is never updated, making it
> impossible to send messages to the remote.
> 
> An example of kernel trace observed:
> rpmsg_tty virtio0.rpmsg-tty.29.-1: invalid addr (src 0x1d, dst 0xffffffff)
> 
> Implement same strategy than the open-amp library:
> On the reception of the first message, if the destination address is
> RPMSG_ADDR_ANY, then set it to address of the remote endpoint that
> send the message.
>

I would have expected a "Fixes:" tag.

> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 
> ---
> Remark:
> An alternative (or a complement?) could be to add a NS bind/unbind in
> the NS announcement channel (in rpmsg_ns.c).
> This would allow the local and/or the remote processor to inform the
> remote side the the service announced in bound.
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 3ede25b1f2e4..99d2119cc164 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -708,6 +708,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>  static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  			     struct rpmsg_hdr *msg, unsigned int len)
>  {
> +	struct rpmsg_device *rpdev;
>  	struct rpmsg_endpoint *ept;
>  	struct scatterlist sg;
>  	bool little_endian = virtio_is_little_endian(vrp->vdev);
> @@ -746,6 +747,15 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  	mutex_unlock(&vrp->endpoints_lock);
>  
>  	if (ept) {
> +		rpdev = ept->rpdev;
> +		if (rpdev->ept == ept && rpdev->dst == RPMSG_ADDR_ANY) {

Please add a comment to explain the first part of the if() clause.  It took me
quite some time to understand. 

> +			/*
> +			 * First message received from the remote side on the default endpoint,
> +			 * update channel destination address.
> +			 */
> +			rpdev->dst = msg->src;

This triggers a bot warning and should be addressed.  If it can't be addressed add
a comment that clearly explains why so that we don't end up receiving patches
for it every 4 weeks.

Thanks,
Mathieu

> +		}
> +
>  		/* make sure ept->cb doesn't go away while we use it */
>  		mutex_lock(&ept->cb_lock);
>  
> -- 
> 2.25.1
> 
