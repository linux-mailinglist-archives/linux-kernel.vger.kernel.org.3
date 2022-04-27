Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398165124F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiD0WHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiD0WHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:07:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986481FEB;
        Wed, 27 Apr 2022 15:03:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0610A45F;
        Thu, 28 Apr 2022 00:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651097034;
        bh=/2tkMx+1RN0GSTl1faiHvAjcdpMNmPvcQAcYBkTllXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJrU6O/5fSkddcNprynLQjZ3gpSV9chMFj79K3E5GujWHefdPG4K8pmT9S3KUKaCY
         3J/PtjQOYGLGfvG0h53X5V1UvPSJe87AXYZv+rdnsfOvuarzWxx8NisBcYJs5V45mg
         dHT0mzFrt2Imso6UWs7WNGIYdKVDm28QkxM1Y+uo=
Date:   Thu, 28 Apr 2022 01:03:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 0/4] Add Toshiba Visconti AFFINE image processing
 accelerator driver
Message-ID: <Ymm9yOsIW4lTjckp@pendragon.ideasonboard.com>
References: <20220427132345.27327-1-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220427132345.27327-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

Thank you for the patch. It's nice to see contributions from Toshiba in
the image acceleration domain :-)

I'll start with a high-level question before diving into detailed
review. Why is this implemented in drivers/soc/ with a custom userspace
API, and not as a V4L2 memory-to-memory driver ?

On Wed, Apr 27, 2022 at 10:23:41PM +0900, Yuji Ishikawa wrote:
> This series is the AFFINE image processing accelerator driver for Toshiba's ARM SoC, Visconti[0].
> This provides DT binding documentation, device driver, MAINTAINER files.
> 
> The second patch "soc: visconti: Add Toshiba Visconti image processing accelerator common source"
> is commonly used among acclerator drivers (affine, dnn, dspif, pyramid).
> 
> Best regards,
> Yuji
> 
> [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
>   
>   dt-bindings: soc: visconti: Add Toshiba Visconti AFFINE image
>     v1 -> v2:
>       - No update
> 
>   soc: visconti: Add Toshiba Visconti image processing accelerator common source
>     v1 -> v2:
>       - apply checkpatch.pl --strict
>   
>   soc: visconti: Add Toshiba Visconti AFFINE image processing accelerator
>     v1 -> v2:
>       - apply checkpatch.pl --strict
>       - rename hwd_AFFINE_xxxx to hwd_affine_xxxx
> 
>   MAINTAINERS: Add entries for Toshiba Visconti AFFINE image processing accelerator
>     v1 -> v2:
>       - No update
> 
> Change in V2:
>   - apply checkpatch.pl --strict
>   - rename hwd_AFFINE_xxxx to hwd_affine_xxxx
> 
> Yuji Ishikawa (4):
>   dt-bindings: soc: visconti: Add Toshiba Visconti AFFINE image
>     processing accelerator bindings
>   soc: visconti: Add Toshiba Visconti image processing accelerator
>     common source
>   soc: visconti: Add Toshiba Visconti AFFINE image processing
>     accelerator
>   MAINTAINERS: Add entries for Toshiba Visconti AFFINE image processing
>     accelerator
> 
>  .../soc/visconti/toshiba,visconti-affine.yaml |  53 ++
>  MAINTAINERS                                   |   2 +
>  drivers/soc/Kconfig                           |   1 +
>  drivers/soc/Makefile                          |   1 +
>  drivers/soc/visconti/Kconfig                  |   7 +
>  drivers/soc/visconti/Makefile                 |   8 +
>  drivers/soc/visconti/affine/Makefile          |   6 +
>  drivers/soc/visconti/affine/affine.c          | 451 ++++++++++++++++++
>  drivers/soc/visconti/affine/hwd_affine.c      | 206 ++++++++
>  drivers/soc/visconti/affine/hwd_affine.h      |  83 ++++
>  drivers/soc/visconti/affine/hwd_affine_reg.h  |  45 ++
>  drivers/soc/visconti/ipa_common.c             |  55 +++
>  drivers/soc/visconti/ipa_common.h             |  18 +
>  drivers/soc/visconti/uapi/affine.h            |  87 ++++
>  drivers/soc/visconti/uapi/ipa.h               |  88 ++++
>  15 files changed, 1111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-affine.yaml
>  create mode 100644 drivers/soc/visconti/Kconfig
>  create mode 100644 drivers/soc/visconti/Makefile
>  create mode 100644 drivers/soc/visconti/affine/Makefile
>  create mode 100644 drivers/soc/visconti/affine/affine.c
>  create mode 100644 drivers/soc/visconti/affine/hwd_affine.c
>  create mode 100644 drivers/soc/visconti/affine/hwd_affine.h
>  create mode 100644 drivers/soc/visconti/affine/hwd_affine_reg.h
>  create mode 100644 drivers/soc/visconti/ipa_common.c
>  create mode 100644 drivers/soc/visconti/ipa_common.h
>  create mode 100644 drivers/soc/visconti/uapi/affine.h
>  create mode 100644 drivers/soc/visconti/uapi/ipa.h

-- 
Regards,

Laurent Pinchart
