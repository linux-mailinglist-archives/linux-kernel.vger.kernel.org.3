Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664957FF47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiGYMsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiGYMsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E813F39;
        Mon, 25 Jul 2022 05:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2547361050;
        Mon, 25 Jul 2022 12:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19D0C341C8;
        Mon, 25 Jul 2022 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658753299;
        bh=qAnVSX5x86qMP5IdsAOZd+epe/BYqA3hZHfOWKWVjGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUDe4HDOY+CFXvceyY8SSSnKqJV1vBz7byKDOeHSySHrhz4N4E2MrZRLXPh5G/Fdt
         tRgFYl4Os306khdCifK9zq/ZHJRlmp2odPzPgyBDFP/DCfA2XTezYjh7fEwgzhPpfF
         d49s/awbT9tghBDe3t8SRnTu/jIZnNAJoAZXs8Bk=
Date:   Mon, 25 Jul 2022 14:48:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 3/5] soc: visconti: Add Toshiba Visconti DNN image
 processing accelerator
Message-ID: <Yt6RD2atLwkDrrsu@kroah.com>
References: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
 <20220722082858.17880-4-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722082858.17880-4-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 05:28:56PM +0900, Yuji Ishikawa wrote:
> Add support to DNN image processing accelerator on Toshiba Visconti ARM SoCs.
> The accelerator is applicable to DNN inference tasks.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> v1 -> v2:
>   - applied checkpatch.pl --strict
>   - removed unused code
> ---
>  drivers/soc/visconti/Kconfig           |   6 +
>  drivers/soc/visconti/Makefile          |   2 +
>  drivers/soc/visconti/dnn/Makefile      |   6 +
>  drivers/soc/visconti/dnn/dnn.c         | 523 +++++++++++++++++++++++++
>  drivers/soc/visconti/dnn/hwd_dnn.c     | 183 +++++++++
>  drivers/soc/visconti/dnn/hwd_dnn.h     |  68 ++++
>  drivers/soc/visconti/dnn/hwd_dnn_reg.h | 228 +++++++++++
>  drivers/soc/visconti/uapi/dnn.h        |  77 ++++
>  8 files changed, 1093 insertions(+)
>  create mode 100644 drivers/soc/visconti/dnn/Makefile
>  create mode 100644 drivers/soc/visconti/dnn/dnn.c
>  create mode 100644 drivers/soc/visconti/dnn/hwd_dnn.c
>  create mode 100644 drivers/soc/visconti/dnn/hwd_dnn.h
>  create mode 100644 drivers/soc/visconti/dnn/hwd_dnn_reg.h
>  create mode 100644 drivers/soc/visconti/uapi/dnn.h
> 
> diff --git a/drivers/soc/visconti/Kconfig b/drivers/soc/visconti/Kconfig
> index 8b1378917..a25287d0c 100644
> --- a/drivers/soc/visconti/Kconfig
> +++ b/drivers/soc/visconti/Kconfig
> @@ -1 +1,7 @@
> +if ARCH_VISCONTI
> +
> +config VISCONTI_DNN
> +    bool "Visconti DNN driver"
> +

We can't take Kconfig options with no help text at all, please provide
the needed information here.

And why can't this be a module?

