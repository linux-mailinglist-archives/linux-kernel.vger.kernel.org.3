Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489765314C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiEWN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiEWN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:28:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 248783AA7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:27:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 640701063;
        Mon, 23 May 2022 06:27:36 -0700 (PDT)
Received: from bogus (unknown [10.57.66.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F993F70D;
        Mon, 23 May 2022 06:27:34 -0700 (PDT)
Date:   Mon, 23 May 2022 14:27:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     cgel.zte@gmail.com
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] firmware: arm_scmi: Avoid leak OF node on error
Message-ID: <20220523132728.lfk6mskynqk636m4@bogus>
References: <20220523111116.2898-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523111116.2898-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:11:16AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The OF node should be put before returning error in smc_chan_available(),
> otherwise node's refcount will be leaked.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/firmware/arm_scmi/smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 745acfdd0b3d..43018be70edc 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -55,10 +55,10 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
>  static bool smc_chan_available(struct device *dev, int idx)
>  {
>  	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
> +	of_node_put(np);

While this may work as of_node_put handles NULL as argument, what is the
point of unnecessary of_node_put(NULL) here ?

-- 
Regards,
Sudeep
