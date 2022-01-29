Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1A4A30AC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352750AbiA2Qh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:37:27 -0500
Received: from relay036.a.hostedemail.com ([64.99.140.36]:34737 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352705AbiA2QhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:37:25 -0500
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 0E75360C6F;
        Sat, 29 Jan 2022 16:37:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id A7ADA3C;
        Sat, 29 Jan 2022 16:37:00 +0000 (UTC)
Message-ID: <17bc03b62ebb71ca8d80f0e7ad0c6a7a7ea96d0c.camel@perches.com>
Subject: Re: [PATCH] staging: media: atomisp: Use BIT macro instead of left
 shifting
From:   Joe Perches <joe@perches.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yizhuo <yzhai003@ucr.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Colin Ian King <colin.king@intel.com>,
        Kaixu Xia <kaixuxia@tencent.com>,
        Baokun Li <libaokun1@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Alan <alan@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Sat, 29 Jan 2022 08:36:59 -0800
In-Reply-To: <20220129113821.324180-1-mosescb.dev@gmail.com>
References: <20220129113821.324180-1-mosescb.dev@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f7hho91x7ghyxojz4sfacmj81jcsayi1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A7ADA3C
X-Spam-Status: No, score=-3.39
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/iKUfIN/lCXEcN3DWYYXRCadUaTK5AfDE=
X-HE-Tag: 1643474220-22022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-29 at 12:38 +0100, Moses Christopher Bollavarapu wrote:
> There is a BIT(nr) macro available in Linux Kernel,
> which does the same thing.
> 
> Example: BIT(7) = (1UL << 7)
[]
> diff --git a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
[]
> @@ -548,7 +548,7 @@ static long __ov5693_set_exposure(struct v4l2_subdev *sd, int coarse_itg,
>  	 * The way is to write coarse_itg/2 to the reg, meanwhile write 2*hts
>  	 * to the reg.
>  	 */
> -	if (coarse_itg > (1 << 15)) {
> +	if (coarse_itg > BIT(15)) {

Not all uses of 1 left shift should be converted to BIT
Especially when used with a non-bit value comparison test.

This is a size and not a bit position so this is likely not appropriate.

It'd probably be better as
	if (coarse_itg > 0x8000)
or
	if (coarse_itg > 32768)
or
	if (coarse_itg > SOME_CONSTANT_DEFINE)

> diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
[]
> @@ -1913,11 +1913,11 @@ void atomisp_css_input_set_mode(struct atomisp_sub_device *asd,
>  			    &asd->stream_env[ATOMISP_INPUT_STREAM_GENERAL].stream_config;
>  		s_config->mode = IA_CSS_INPUT_MODE_TPG;
>  		s_config->source.tpg.mode = IA_CSS_TPG_MODE_CHECKERBOARD;
> -		s_config->source.tpg.x_mask = (1 << 4) - 1;
> +		s_config->source.tpg.x_mask = BIT(4) - 1;

These should probably use GENMASK

> diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
[]
> @@ -626,11 +626,11 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
>  	 * IRQ, if so, waiting for it to be served
>  	 */
>  	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
> -	irq = irq & 1 << INTR_IIR;
> +	irq = irq & BIT(INTR_IIR);

The rest seems sensible.


