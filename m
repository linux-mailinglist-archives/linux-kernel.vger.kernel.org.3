Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85655DA45
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiF0MCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiF0L57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:57:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 082C510576
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:54:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D170B2B;
        Mon, 27 Jun 2022 04:54:30 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE503F792;
        Mon, 27 Jun 2022 04:54:29 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:54:23 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Remove usage of the deprecated
 ida_simple_xxx API
Message-ID: <YrmabyDSlB9OMlLm@e120937-lin>
References: <20220616055052.4559-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616055052.4559-1-liubo03@inspur.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:50:52AM -0400, Bo Liu wrote:
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---

Hi Bo,

I've missed this patch of yours and I recently posted something similar
using a bare ida_alloc() (so starting with id 0 instead).

Anyway AFAIU, Sudeep will pick up your patch with a small change to use
ida_alloc.

Thanks for this,
Cristian


>  drivers/firmware/arm_scmi/bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index f6fe723ab869..d4e23101448a 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -181,7 +181,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
>  		return NULL;
>  	}
>  
> -	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
> +	id = ida_alloc_min(&scmi_bus_id, 1, GFP_KERNEL);
>  	if (id < 0) {
>  		kfree_const(scmi_dev->name);
>  		kfree(scmi_dev);
> @@ -204,7 +204,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
>  put_dev:
>  	kfree_const(scmi_dev->name);
>  	put_device(&scmi_dev->dev);
> -	ida_simple_remove(&scmi_bus_id, id);
> +	ida_free(&scmi_bus_id, id);
>  	return NULL;
>  }
>  
> @@ -212,7 +212,7 @@ void scmi_device_destroy(struct scmi_device *scmi_dev)
>  {
>  	kfree_const(scmi_dev->name);
>  	scmi_handle_put(scmi_dev->handle);
> -	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
> +	ida_free(&scmi_bus_id, scmi_dev->id);
>  	device_unregister(&scmi_dev->dev);
>  }
>  
> -- 
> 2.27.0
> 
