Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E85082ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376551AbiDTH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376579AbiDTH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:57:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B23BBDC;
        Wed, 20 Apr 2022 00:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C243B81D71;
        Wed, 20 Apr 2022 07:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EE4C385A9;
        Wed, 20 Apr 2022 07:54:37 +0000 (UTC)
Message-ID: <2732e2ad-03bb-b30a-c649-08898419185b@xs4all.nl>
Date:   Wed, 20 Apr 2022 09:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/5] Visconti: Add Toshiba Visconti Video Input
 Interface driver
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

On 14/04/2022 07:35, Yuji Ishikawa wrote:
> This series is the Video Input Interface driver for Toshiba's ARM SoC, Visconti[0].
> This provides DT binding documentation, device driver, MAINTAINER fiels.
> 
> Best regards,
> Yuji
> 
> [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
> 
> 
>   dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface bindings
>     v1 -> v2:
>       - No update
> 
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface driver headers
>     v1 -> v2:
>       - moved driver headers to an individual patch
> 
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface driver body
>     v1 -> v2:
>       - moved driver sources to an individual patch
>    
>   media: platform: visconti: Add Toshiba VIIF image signal processor driver
>     v1 -> v2:
>       - moved image signal processor driver to an individual patch
> 
>   MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
>     v1 -> v2:
>       - No update
> 
> Change in V2:
>   - moved files into individual patches to decrease patch size

Thank you for your patch series.

However, there are quite a few things that need more work. I'll make some
high level guidelines here, and go into a bit more detail in some of the
patches.

First of all, run your patches through 'scripts/checkpatch.pl --strict' and
fix the many warnings, errors and checks. Use common sense, sometimes a
check or warning isn't actually valid, but the vast majority of what
checkpatch spits out appears reasonable.

Another thing I noticed is code like this:

+		if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;
+
+		if (param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
+			return -EINVAL;

This can easily be combined into a single if:

		if (param->r_cr_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
		    param->g_y_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
		    param->b_cb_in_offset > HWD_VIIF_CSC_MAX_OFFSET ||
		    param->r_cr_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
		    param->g_y_out_offset > HWD_VIIF_CSC_MAX_OFFSET ||
		    param->b_cb_out_offset > HWD_VIIF_CSC_MAX_OFFSET)
			return -EINVAL;

Easier to read and a lot shorter.

Another thing to avoid is mixing lower and upper case in function names.
A lot of functions have this prefix: 'hwd_VIIF_'. Just change that to
'hwd_viif_': that's much easier on the eyes.

I also see a fair amount of code that is indented very far to the right.
Often due to constructs like this:

	if (test) {
		// lots of code
	}
	return ret;

Which can be changed to:

	if (!test)
		return ret;
	// lots of code
	return ret;

The same can also happen in a for/while loop where you can just 'continue'
instead of 'return'.

This makes the code easier to read and review.

It doesn't look like this driver uses the media controller API. This is
probably something you want to look into, esp. in combination with libcamera
support (https://libcamera.org/). I've added Laurent to this, since he's
the expert on this.

Regards,

	Hans

> 
> Yuji Ishikawa (5):
>   dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
>     Input Interface bindings
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface
>     driver headers
>   media: platform: visconti: Add Toshiba Visconti Video Input Interface
>     driver body
>   media: platform: visconti: Add Toshiba VIIF image signal processor
>     driver
>   MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface
> 
>  .../bindings/media/toshiba,visconti-viif.yaml |  103 +
>  MAINTAINERS                                   |    2 +
>  drivers/media/platform/Kconfig                |    2 +
>  drivers/media/platform/Makefile               |    4 +
>  drivers/media/platform/visconti/Kconfig       |    9 +
>  drivers/media/platform/visconti/Makefile      |    9 +
>  drivers/media/platform/visconti/hwd_viif.c    | 2233 ++++++++++
>  drivers/media/platform/visconti/hwd_viif.h    | 1776 ++++++++
>  .../media/platform/visconti/hwd_viif_csi2rx.c |  767 ++++
>  .../platform/visconti/hwd_viif_internal.h     |  361 ++
>  .../media/platform/visconti/hwd_viif_l1isp.c  | 3769 +++++++++++++++++
>  .../media/platform/visconti/hwd_viif_reg.h    | 2802 ++++++++++++
>  drivers/media/platform/visconti/viif.c        | 2384 +++++++++++
>  drivers/media/platform/visconti/viif.h        |  134 +
>  include/uapi/linux/visconti_viif.h            | 1683 ++++++++
>  15 files changed, 16038 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
>  create mode 100644 drivers/media/platform/visconti/Kconfig
>  create mode 100644 drivers/media/platform/visconti/Makefile
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
>  create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
>  create mode 100644 drivers/media/platform/visconti/viif.c
>  create mode 100644 drivers/media/platform/visconti/viif.h
>  create mode 100644 include/uapi/linux/visconti_viif.h
> 

