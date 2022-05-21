Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546452FCCE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbiEUNU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiEUNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7651DA57
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DEBCB80066
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A231C385A5;
        Sat, 21 May 2022 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653139214;
        bh=L1fVF5WYjSj5hAjqdg1l5A+GPVY6EJc/dtODL2e9lxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbmcyWjKbZypvmzgIEbJfLIyK8SV6sXgucAASzjSqY+++27urxZJa3/7hUjyhzb2Z
         PZEiIOs4RRBAuYNs56muqlsPqcrcTAOzBJUu/1Y0onLznKmuymlZEW8DuExiPV9SeE
         qYlEcaRELidAhwYCUycqbr38x/VkhLhJeoD2eVAY=
Date:   Sat, 21 May 2022 15:20:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srivathsan Sivakumar <sri.skumar05@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rts5208: spi.c: clean up dynamic debug code
Message-ID: <YojnC+kQXcxTMrua@kroah.com>
References: <Yojg1nXXTIL3G82l@Sassy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yojg1nXXTIL3G82l@Sassy>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 08:53:42AM -0400, Srivathsan Sivakumar wrote:
> I've condensed the three dev_dbg() lines into one as you requested in the
> previous patch thread; and sent them all as a singular patch.

This does not need to be in a changelog text.

> fix the following checkpatch.pl warning:
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Signed-off-by: Srivathsan Sivakumar <sri.skumar05@gmail.com>
> 
> Changes in v2:
>         - Condense three dev_dbg() code lines into one
> ---

The --- line needs to be right below the signed-off-by line as that is
where git will cut the changelog at.  You don't want the changelog in
the commit.

>  drivers/staging/rts5208/spi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
> index f1e9e80044ed..ea736a73e58c 100644
> --- a/drivers/staging/rts5208/spi.c
> +++ b/drivers/staging/rts5208/spi.c
> @@ -460,10 +460,7 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
>  	spi->write_en = srb->cmnd[6];
>  
> -	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
> -	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
> -	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
> -	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);
> +	dev_dbg(rtsx_dev(chip), "spi_clock = %d, clk_div = %d, write_en = %d\n ",                               spi->spi_clock, spi->clk_div, spi->write_en);

You might want to verify that you really meant to put that many spaces
in this line :(

thanks,

greg k-h
