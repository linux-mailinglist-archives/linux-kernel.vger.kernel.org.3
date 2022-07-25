Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30057FF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGYMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiGYMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524D63F4;
        Mon, 25 Jul 2022 05:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D452861092;
        Mon, 25 Jul 2022 12:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF9C341C6;
        Mon, 25 Jul 2022 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658753459;
        bh=rq5R6ViRqezzEg2QCXeGAAFf0M/MhLMEh9Y9kPhCsUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhB+MLIaybwyHgnuLVDeuvhX3rnJNJld+K2syPmBtOn0/iGZXhpVXeMURkfGHraiI
         3o/0BS9KjGoUvRCcubBZFyDGTScQiwKfC9cxB4cDsqUHtv0xhEDr3s9gbk2YjMWg21
         7use+ezgMFrLWyPHjfBulZ2WOGGjq99E12rwQphA=
Date:   Mon, 25 Jul 2022 14:50:55 +0200
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
Message-ID: <Yt6Rryi4SHVc4DR4@kroah.com>
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
> --- /dev/null
> +++ b/drivers/soc/visconti/uapi/dnn.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Toshiba Visconti DNN Accelerator Support
> + *
> + * (C) Copyright 2022 TOSHIBA CORPORATION
> + * (C) Copyright 2022 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_DNN_H
> +#define _UAPI_LINUX_DNN_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +#include "ipa.h"
> +
> +#define DRV_DNN_BIT_CONFIG_DESC_FINAL (0x8000U)
> +#define DRV_DNN_BUFFER_INDEX_MAX      (15)
> +
> +#define DRV_DNN_BASE_ADDR_NUM (8U) /* DNN number of base address */
> +
> +#define DRV_DNN_BASE_ADDR_PURPOSE_INPUT	    (1U)
> +#define DRV_DNN_BASE_ADDR_PURPOSE_OUTPUT    (2U)
> +#define DRV_DNN_BASE_ADDR_PURPOSE_AWB	    (3U)
> +#define DRV_DNN_BASE_ADDR_PURPOSE_TEMPORARY (4U)
> +
> +/**
> + * struct drv_dnn_status - DNN IPA status for IOC_IPA_GET_STATUS
> + *
> + * @state:     State of driver
> + * @eer_cmd:   Execution error command
> + * @eer:       Execution error
> + * @reserved:  Padding
> + * @eer_flags: Execution error flags
> + */
> +struct drv_dnn_status {
> +	enum drv_ipa_state state;
> +	__u32 eer_cmd;
> +	__u32 eer : 1;
> +	__u32 reserved : 31;

bitfields will not work like this for uapi files, sorry.

> +	__u32 eer_flags[32];

What endian is all of these?  Big?  Little?  Unknown?

> +};
> +
> +struct drv_dnn_base_addr {
> +	__u32 purpose;
> +	union {
> +		struct drv_ipa_addr ipa_addr;
> +		uintptr_t list_addr;

You really do not ever want a uintptr_t in a uapi file, that's not going
to be portable at all.  It's also not a valid kernel type :(

No documentation on what "purpose" is for?

> +	} addr;
> +};
> +
> +/**
> + * struct drv_dnn_descriptor - DNN IPA Descriptor for IOC_IPA_START
> + *
> + * @configuration:        Address of configuration data
> + * @configuration_offset: Configuration offset
> + * @configuration_size:   Configuration data size
> + * @list_num:             Number of input/output list
> + * @base_addr:            Base addresses
> + * @base_addr_flag:       Bit-fields of base_addr list config;
> + *                        0 for fixed address,
> + *                        1 for address list.

Where are the bitfield definitions?

What about unused bits, what happens with them?  You are checking them,
right?

> + * @config_done:          Flags of called configuration
> + * @buffer_info:          Table of buffer information
> + * @buffer_info_num:      Number of buffer_info
> + */
> +struct drv_dnn_descriptor {
> +	struct drv_ipa_addr configuration;
> +	__u32 configuration_offset;

What endian are any of these?

thanks,

greg k-h
