Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2E53CBF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245322AbiFCPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245315AbiFCPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19764D0;
        Fri,  3 Jun 2022 08:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B00617FF;
        Fri,  3 Jun 2022 15:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7011BC34114;
        Fri,  3 Jun 2022 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654268655;
        bh=TfgOQQnio1Gq32hbniybR4SGAc81jw6qQ5iLxj317Zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UlyEZNmeolP0ezSHCY2rR/CuZaNustyIj+Lb2cH3kzLD1ke4IL3zOGIEky2tm36nM
         u4fgYK/H3g7YIMETzQH5pTNozxHZOmsyv3MbwXH81EMaB+QAeBFVWrJnVVWpOQBbSJ
         vTTeu3i9s5eTQ3HLDVJGQxpWvQPbx2daITuae/WTFoAtkLE6RQ22CoxMLYwrClmFl4
         BZe3egIxrK003JazP0RQ9FrRjMep9jeNLqkCjKnFxiMJY8nlI5rW9A8hQ0ds3v0rv8
         Z1cZFxJNex0h6ImV/U8a6WxjcgBSmzjEvJ1SylcNKAD9jf5TmW9Kjk1f3szap45HNP
         6AyZkBVWxyEZg==
Date:   Fri, 3 Jun 2022 16:13:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     rdunlap@infradead.org, peda@axentia.se, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: test: fix missing MODULE_LICENSE for
 IIO_RESCALE=m
Message-ID: <20220603161314.041643be@jic23-huawei>
In-Reply-To: <20220601142138.3331278-1-liambeguin@gmail.com>
References: <20220601142138.3331278-1-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jun 2022 10:21:38 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> When IIO_RESCALE_KUNIT_TEST=y and IIO_RESCALE=m,
> drivers/iio/afe/iio-rescale.o is built twice causing the
> MODULE_LICENSE() to be lost, as shown by:
> 
> 	ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
> 
> Rework the build configuration to have the dependency specified in the
> Kconfig.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 8e74a48d17d5 ("iio: test: add basic tests for the iio-rescale driver")
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Applied to the fixes-togreg branch of iio.git.

Thanks all for chasing this down and coming up with a resolution.

Jonathan

> ---
>  drivers/iio/test/Kconfig  | 2 +-
>  drivers/iio/test/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 56ca0ad7e77a..4c66c3f18c34 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -6,7 +6,7 @@
>  # Keep in alphabetical order
>  config IIO_RESCALE_KUNIT_TEST
>  	bool "Test IIO rescale conversion functions"
> -	depends on KUNIT=y && !IIO_RESCALE
> +	depends on KUNIT=y && IIO_RESCALE=y
>  	default KUNIT_ALL_TESTS
>  	help
>  	  If you want to run tests on the iio-rescale code say Y here.
> diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> index f15ae0a6394f..880360f8d02c 100644
> --- a/drivers/iio/test/Makefile
> +++ b/drivers/iio/test/Makefile
> @@ -4,6 +4,6 @@
>  #
>  
>  # Keep in alphabetical order
> -obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
> +obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
>  obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
>  CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)

