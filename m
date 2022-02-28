Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5E4C6531
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiB1JCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiB1JCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:02:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1966AC1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:01:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d28so14258396wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GklO/UHCHEE9F5DiQFSvvtbE7AZlaReUkQYnTqJmpAI=;
        b=ywFgbJzrh/DZClHZ80xiwFkRi6o9PJgtnA5qZ87ix1K4Dc7VPHm7hkmJmzEbNSTHdz
         Dm79YKPrll7KOUeQe9Ik3eKSGFz5rHB5YuAQbb5nnPPHDqlXqBpPwTNqMYpkuNejJKVl
         bMWopoyytqWNeIhRi8ebORgk9K/X0aDgdDebHgGtnWwQif4xujvmzBy9Pe6j/EkL246n
         DWr9SN9UM2QlDxJl51nKzhaoyr6STfoP7RbjwtfYJJWX5rcyzf+F0Di/d3KoAgA1/u9H
         9124JV1MODZVXIKIdHmSJeuu0QPpdsECy0iO4omzIx3yBwRYUguyDi1Rx2eBUy60Wh87
         53Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GklO/UHCHEE9F5DiQFSvvtbE7AZlaReUkQYnTqJmpAI=;
        b=W+h93YsnzB1PtiTnNkzbTmirI3k6XPgv+4u6SGiECdTJzNwaDR/vuEIp7p5SVNcaFn
         T5paREon38p6jqaD9TtrA3N3ajFLdrUsOt7HyIMNFj2rZ/Zv3DZr4GMoVGAZ1b5XQeh5
         xvGAzaF1ho6VWQOOW2cE9j3NHdHwwFaIm4+LZRPUWjRXHgERaiCwFXMlDBVyQnUbZxxG
         SD1P8jPsLL6aoR40b8Bu8WaDGGwtL6OclR36cEJ3O3mJm63YIGE/NMfQQVuwQnr0BR3j
         zWjeQ0flLXtPNzCogoIXIzOrwirXvNCcWKdvr9Qq7TbTBZ+TGSQWwsPE9ON5UPmXvESj
         4EEw==
X-Gm-Message-State: AOAM531v10ecckxh5T8rdP0QCfs9691066dx4MnSYgY1y6+riS4T+7Qm
        cgLXlQyjuXZE1pmoiPpPDwgefw==
X-Google-Smtp-Source: ABdhPJzDkZIVZHzdceQbuQQa3A+DqOc0pW2JK4Xes6piiRp38ouCSl9r0mt6vKg4TeGRtJ9A9lpQ+w==
X-Received: by 2002:a5d:40c7:0:b0:1ed:bd9d:e2e8 with SMTP id b7-20020a5d40c7000000b001edbd9de2e8mr14779672wrq.693.1646038912837;
        Mon, 28 Feb 2022 01:01:52 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c4-20020adfed84000000b001e5b8d5b8dasm14202553wro.36.2022.02.28.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:01:52 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:01:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <YhyPfcjJtIKNQtF8@google.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228193928.3ec6ee98@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Stephen Rothwell wrote:

> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:

I did ask for this *not* to be merged when it was in -testing.

I'll follow-up with Greg.

>   drivers/mfd/simple-mfd-i2c.c
> 
> between commit:
> 
>   5913eb45d036 ("mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a")
> 
> from the mfd tree and commit:
> 
>   d0cac2434c8e ("mfd: simple-mfd-i2c: Add Delta TN48M CPLD support")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 



-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
