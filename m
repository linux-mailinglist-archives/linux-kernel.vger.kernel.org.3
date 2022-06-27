Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320755D084
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiF0OKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiF0OJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B813D29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A66D7B80D32
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167A8C3411D;
        Mon, 27 Jun 2022 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338986;
        bh=xhvWltMXg+SSvEHevs4lDe27xjF6keZkwSpn8bSxVuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y99jHXlIE9ZI1VHse4hD4ZVRmhzGI2f13ataXk8uzxnTlC+rFGNBIs5eotRzr24Zs
         6LD7uDRRzGydZh4G8kTdEhiZiSg+GxoXQvwJ1nD49utFx4JRu2ErHs+0b3hbQYix8j
         7AXyVBehtLrDspFTIPKt2dJRREVJUqtqp2g1Pitw=
Date:   Mon, 27 Jun 2022 16:09:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liang He <windhl@126.com>
Cc:     broonie@kernel.org, ckeepax@opensource.cirrus.com,
        michal.simek@xilinx.com, abhyuday.godhasara@xilinx.com,
        simont@opensource.cirrus.com, ronak.jain@xilinx.com,
        peng.fan@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: Hold a reference for of_find_compatible_node()
Message-ID: <Yrm6JztPuqYmKlKF@kroah.com>
References: <20220621032625.4078445-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621032625.4078445-1-windhl@126.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:26:25AM +0800, Liang He wrote:
> In of_register_trusted_foundations(), we need to hold the reference
> returned by of_find_compatible_node() and then use it to call
> of_node_put() for refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  include/linux/firmware/trusted_foundations.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/firmware/trusted_foundations.h b/include/linux/firmware/trusted_foundations.h
> index be5984bda592..399471c2f1c7 100644
> --- a/include/linux/firmware/trusted_foundations.h
> +++ b/include/linux/firmware/trusted_foundations.h
> @@ -71,12 +71,16 @@ static inline void register_trusted_foundations(
>  
>  static inline void of_register_trusted_foundations(void)
>  {
> +	struct device_node *np = of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations");
> +
> +	of_node_put(np);
> +	if (!np)

While this is technically correct, you are now checking to see if this
points to a memory location that you no longer know what it really
belongs to.  C will let you do this, but it might be nicer to fix it up
properly so it doesn't look like this.

thanks,

greg k-h
