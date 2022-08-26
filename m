Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DE5A312C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbiHZVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:36:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A730A99F9;
        Fri, 26 Aug 2022 14:36:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn9so2746459ljb.6;
        Fri, 26 Aug 2022 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=c6MP6l8tMnYnAGrYSSMfpFmldXiz8bm135yAh0+Oups=;
        b=ANP8GaiIxkMP0UNDwGpLCSXoCxqSbOj9r8cO91y4c1xt6t2QchiMXXF9zrzyWSPR/y
         5s0JbNEhdMvO4/r/aJ8m46YfU1K9iwtoiBWkc1H7iCvsov+MHuf64dP8L+6VSr09qgBh
         0CSlywvyG0T1XQGHShOuF+Xuc29zhptZmaVonFX5EYDw/mRfYSAXZ8IadDl/gUfsAOeW
         zJKnP8zdR7FnJrDlhHpLgngVJ/LsVWdy2AXmh27gjDCSdZ8GCYUtLdT2dKh8Lj7Eu7QB
         4Jk4+x/rHxUWs98T30j4MrQz4QFkh8iucodd4OsPqx3Ao1Hj7xn6AxJ6Fdd3vSDIS3gN
         oudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=c6MP6l8tMnYnAGrYSSMfpFmldXiz8bm135yAh0+Oups=;
        b=6kHsUWQCjKtRn1A0Bg5Nh/VI6ryTMln19koO6c0jGD2vc2i1aVhgcFBWCr/K1fbmNI
         OiCkE5HQFJG4G6DXcpBe4692aSyZsNkE461fJs9cCUdPlq2RsZ+vmZ+V2tWvtHfJq5nV
         aub4WUD0ANTof4SdJRjC0tOfv5p1fSbGqOf4Xu5pfNQls91Z/1/5OAbhnN2qX5P7hX0p
         t/0vYris/zkpLK/GZoRtAgIKXvgw0xnheciAHTF6fEUIO/FNGwogQzerUGHfomiZ7o5v
         wwkkAXhYeoM6ZNBLxIJQok03T1uzm2VunAjD7uWs4qnq8F0kyQuj06OAsyDkgITy/jw/
         WVlw==
X-Gm-Message-State: ACgBeo2NvNErvWNMicQ9mQVTRUsA4KMvsMnjfvRFj2wpxQOsl6/MqavB
        UrGQOBHageOn4n6CE0mR8UMy3mbUqNrIYA==
X-Google-Smtp-Source: AA6agR4Jv4ibHpfMu5DQPODnsPQCpKZbvc9NRe7m43IEikWBomL9kSPnHV0y8zPj63wcLUdvBaN9Cg==
X-Received: by 2002:a2e:b2d5:0:b0:261:c67e:c34c with SMTP id 21-20020a2eb2d5000000b00261c67ec34cmr3023493ljz.519.1661549791731;
        Fri, 26 Aug 2022 14:36:31 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e8445000000b0025e4dcc48b1sm580090ljh.19.2022.08.26.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:36:31 -0700 (PDT)
Date:   Sat, 27 Aug 2022 00:36:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 02/11] spi: dw: add check for support of dual/quad/octal
Message-ID: <20220826213629.axf7dnlwwkah7d43@mobilestation>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-3-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-3-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:57:46PM +0100, Sudip Mukherjee wrote:
> Before doing the mem op spi controller will be queried about the
> buswidths it supports. Add the dual/quad/octal if the controller
> has the DW_SPI_CAP_EXT_SPI capability.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 97e72da7c120..77529e359b6d 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -488,8 +488,23 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  static bool dw_spi_supports_mem_op(struct spi_mem *mem,
>  				   const struct spi_mem_op *op)
>  {
> -	if (op->data.buswidth > 1 || op->addr.buswidth > 1 ||
> -	    op->dummy.buswidth > 1 || op->cmd.buswidth > 1)

> +	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
> +
> +	/*
> +	 * Only support TT0 mode in enhanced SPI for now.
> +	 * TT0 = Instruction and Address will be sent in
> +	 * Standard SPI Mode.
> +	 */
> +	if (op->addr.buswidth > 1 || op->dummy.buswidth > 1 ||
> +	    op->cmd.buswidth > 1)
> +		return false;
> +
> +	/* In enhanced SPI 1, 2, 4, 8 all are valid modes. */
> +	if (op->data.buswidth > 1 && (!(dws->caps & DW_SPI_CAP_EXT_SPI)))
> +		return false;
> +
> +	/* Only support upto 32 bit address in enhanced SPI for now. */
> +	if (op->data.buswidth > 1 && op->addr.nbytes > 4)

Sorry, it can't be done as you suggest. First you get to update the
supported mem-ops method with no adding actual ops support. Thus the
driver will permit submitting the enhanced SPI memory operations, but
won't handle them correctly. So the driver will be left broken after
this commit. Second the dummy bytes are supported for the Rx
operations only. Thirdly you don't check the length of the cmd field,
but you need to unless you add the 2-bytes long opcode support. The
conditional statement for the address data length is incorrect. Since
you get to fix the field length to 4 bytes the address will be always
sent as 4 bytes. Fifthly you haven't fixed the
dw_spi_adjust_mem_op_size() method, which permits SPI MEM Tx-transfers
of any size. It isn't true in your case. Finally you can easily add
the cmd and address sent via the same buswidth as specified for the
data by means of the SPI_CTRL0.TRANS_TYPE field settings, thus
supporting all the possible modes.

Instead I suggest for you to do the next things in this case:
1. Create separate dw_spi_supports_enh_mem_op() and
dw_spi_adjust_enh_mem_op_size() for the case of the Enhanced SPI
modes.
2. Return false if the dummy cycle is requested for the
Tx-operation.
3. Return false if:
   (op->addr.nbytes != 0 && op->addr.buswidth != 1 && op->addr.buswidth != op->data.buswidth) ||
   (op->cmd.buswidth != 1 && op->cmd.buswidth != op->addr.buswidth && op->cmd.buswidth != op->data.buswidth)
4. Return false if:
   (op->dummy.nbytes != 0 && op->dummy.nbytes / op->dummy.buswidth > 4)
5. Make sure the dw_spi_adjust_enh_mem_op_size() method fixes both Rx
and Tx transfer lengths.

All of the above needs to be added either in the framework of the
patch with the new SPI MEM ops functionality or in a ways so the
currently unsupported operations wouldn't be available for now.

-Sergey

>  		return false;
>  
>  	return spi_mem_default_supports_op(mem, op);
> -- 
> 2.30.2
> 
