Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42C52D7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiESPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbiESPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2526FE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BFD861B44
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE3C385AA;
        Thu, 19 May 2022 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652974576;
        bh=vy65R7ZsafQHBZhnUCG7N55ApplrExwQMDdxSADZFsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8dSUKFhLphktISiz+w4ZJn6xy/hfqwJNaRmdcCUXG1am2Eil/+f5wWFncdR0ijyd
         55GfQtwDqtuXBtxGvdQMMeke7S/aV0g507bIXavDu3hbAa+fZZ5//lR9Qd/mc8ZkLW
         0CtyS6rCZ5RKtfcgyAZl+Cit03FgRUKgHToBPUOg=
Date:   Thu, 19 May 2022 17:36:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srivathsan Sivakumar <sri.skumar05@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: spi.c: prefer ftrace
Message-ID: <YoZj7RS+awq/bC2R@kroah.com>
References: <YoP3S6mGQEwUTQDC@Sassy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoP3S6mGQEwUTQDC@Sassy>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 03:28:11PM -0400, Srivathsan Sivakumar wrote:
> fix the following checkpatch.pl warning:
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Signed-off-by: Srivathsan Sivakumar <sri.skumar05@gmail.com>
> ---
>  drivers/staging/rts5208/spi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
> index f1e9e80044ed..0d2d065508d3 100644
> --- a/drivers/staging/rts5208/spi.c
> +++ b/drivers/staging/rts5208/spi.c
> @@ -460,7 +460,6 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
>  	spi->write_en = srb->cmnd[6];
>  
> -	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
>  	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
>  	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
>  	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);

All three of the remaining ones should be on one line, right?

Can you fix this up and do that all at once?


thanks,

greg k-h
