Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3234D9EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349606AbiCOP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349605AbiCOP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6050E16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FECF6122E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5EC340E8;
        Tue, 15 Mar 2022 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647358063;
        bh=ntKc+0V/pCo1xdEL+4LSr3fmP+YcSlucBc+b0X8zhMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKY/p9D/m7fo/AZ+uALMMw5azq5ppZgYThkPQFIRF6bAbz4/UXVtmJxcmc9QKRN/R
         2513m5Lrel/4uYNnDhSv9HlgDmhgiACMnYOruOzTIX11s/WX4nYemsaWNbc4Qu2pY+
         EGOh6rNjC2zVB5Bv/cdpc8JZ+EnPnWGXIovl7zbg=
Date:   Tue, 15 Mar 2022 16:27:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: mmal-vchiq: add a check for the return of
 vmalloc()
Message-ID: <YjCwagaijyA2oO8r@kroah.com>
References: <tencent_7F2A8AAFF05125C6FF159033E69B5C108E07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7F2A8AAFF05125C6FF159033E69B5C108E07@qq.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:42:07PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> vmalloc() is a memory allocation API which can return NULL when some
> internal memory errors happen. So it is better to check the return
> value of it to catch the error in time.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2  jump to the proper location and remove redundant instruction.
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 76d3f03..ff4b484 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -1909,6 +1909,10 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
>  	mutex_init(&instance->vchiq_mutex);
>  
>  	instance->bulk_scratch = vmalloc(PAGE_SIZE);
> +	if (!instance->bulk_scratch) {
> +		err = -ENOMEM;
> +		goto err_free;
> +	}
>  	instance->vchiq_instance = vchiq_instance;
>  
>  	mutex_init(&instance->context_map_lock);
> -- 

Your change just crashed the kernel :(

Please be more careful.

greg k-h
