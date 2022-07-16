Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9986C577089
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiGPRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBF1D0ED;
        Sat, 16 Jul 2022 10:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 342A1611F1;
        Sat, 16 Jul 2022 17:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08624C3411C;
        Sat, 16 Jul 2022 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657994018;
        bh=Lp7KQSH5DD2kT+Gb+r4iUxsQ3cjHy1yjYW7yoqxoiAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jRULfFjyhl6TC8JTmuWk/cofXgn7fFK4gQtPo2JuuXPoN9ss1JGEK0ZVbzgE5f69t
         0H7yjjJQTjSrmE0L/g0tZgZQX1mcLCb/4JAaQFZ2R2mxOP42v3r27R6Bl7D5CQSW60
         eJgqn6akerc+ih2G720rr4Tkm8BQgQ1huw94mFAX+V1ViKw0Xo536CNRqkX+9V0G9P
         sZzrWZhPEt6T1arZDOtbWWwYY6E6xtq4omao3+mSuV26V6lb6wAZ+xt5u3oMWyNatQ
         UdPuRBRxBjx+VznYRjoA+nM8AuVhGZFm3OR34LZzwtUL+yDP4fzciFL328BaJ9wLsR
         e+zKolLSWB62A==
Date:   Sat, 16 Jul 2022 19:03:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     geert@linux-m68k.org, peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] iio: test: rework Kconfig to support modules
Message-ID: <20220716190331.43f5bc03@jic23-huawei>
In-Reply-To: <20220710013109.3349104-6-liambeguin@gmail.com>
References: <20220710013109.3349104-1-liambeguin@gmail.com>
        <20220710013109.3349104-6-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Jul 2022 21:31:09 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> Rework the IIO test Kconfig to support building KUnit tests as modules.
> This lets users execute tests at runtime in addition to the usual
> tools/testing/kunit/kunit.py script.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
One trivial comment inline.  Fixed that up and applied to the togreg branch
of iio.git. Not I'll only push out as testing for now as will be rebasing
the tree after rc1.

Jonathan


> ---
>  drivers/iio/test/Kconfig | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 7dbf51bc4934..82924727b2cc 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -5,15 +5,25 @@
>  
>  # Keep in alphabetical order
>  config IIO_RESCALE_KUNIT_TEST
> -	bool "Test IIO rescale conversion functions"
> -	depends on KUNIT=y && IIO_RESCALE=y
> +	tristate "Test IIO rescale conversion functions" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && IIO_RESCALE
>  	default KUNIT_ALL_TESTS
>  	help
> -	  If you want to run tests on the iio-rescale code say Y here.
> +	  build unit tests for the iio-rescale code.

Build

>  
> -	  This takes advantage of ARCH=um to run tests and should be used by
> -	  developers to tests their changes to the rescaling logic.
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
>  
>  config IIO_FORMAT_KUNIT_TEST
> -        bool "Test IIO formatting functions"
> -        depends on KUNIT=y
> +	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  build unit tests for the IIO formatting functions.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.

