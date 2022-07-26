Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D10581633
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiGZPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGZPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957317E37;
        Tue, 26 Jul 2022 08:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86EFE6069B;
        Tue, 26 Jul 2022 15:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B62C433C1;
        Tue, 26 Jul 2022 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658848536;
        bh=JdYLPvm15DCGWDloUpXmxYYLmSi+V/FEw3vBEoaF+Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xBokB72rddFLxtHSosxuv3alJqsdn0oyulNn4jSAaE2unHKS0UIM1wLxL2J8T16L0
         k39NRaycdo4vXVxUP4FOVG+nE53iMehPLaex58j9lRVfL0OQ2uKPiGgF5dJfnEg16i
         sBHsTSPvke7L3MCKx6Puv+grQDjTJVYq56eH/DFk=
Date:   Tue, 26 Jul 2022 17:15:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     robh+dt@kernel.org, hverkuil@xs4all.nl,
        nobuhiro1.iwamatsu@toshiba.co.jp, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 3/5] soc: visconti: Add Toshiba Visconti DNN image
 processing accelerator
Message-ID: <YuAFEvKLnavheZMn@kroah.com>
References: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
 <20220722082858.17880-4-yuji2.ishikawa@toshiba.co.jp>
 <Yt6Rryi4SHVc4DR4@kroah.com>
 <TYAPR01MB62013C42CB26FD456929C0D592949@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYAPR01MB62013C42CB26FD456929C0D592949@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 06:10:37AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> Hi Greg
> 
> Thank you for your comments.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, July 25, 2022 9:51 PM
> > To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> > <yuji2.ishikawa@toshiba.co.jp>
> > Cc: Rob Herring <robh+dt@kernel.org>; Hans Verkuil <hverkuil@xs4all.nl>;
> > iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Jonathan Corbet <corbet@lwn.net>;
> > Sumit Semwal <sumit.semwal@linaro.org>; Christian König
> > <christian.koenig@amd.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-media@vger.kernel.org;
> > dri-devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org
> > Subject: Re: [PATCH v2 3/5] soc: visconti: Add Toshiba Visconti DNN image
> > processing accelerator
> > 
> > On Fri, Jul 22, 2022 at 05:28:56PM +0900, Yuji Ishikawa wrote:
> > > --- /dev/null
> > > +++ b/drivers/soc/visconti/uapi/dnn.h
> > > @@ -0,0 +1,77 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +/* Toshiba Visconti DNN Accelerator Support
> > > + *
> > > + * (C) Copyright 2022 TOSHIBA CORPORATION
> > > + * (C) Copyright 2022 Toshiba Electronic Devices & Storage
> > > +Corporation  */
> > > +
> > > +#ifndef _UAPI_LINUX_DNN_H
> > > +#define _UAPI_LINUX_DNN_H
> > > +
> > > +#include <linux/ioctl.h>
> > > +#include <linux/types.h>
> > > +#include "ipa.h"
> > > +
> > > +#define DRV_DNN_BIT_CONFIG_DESC_FINAL (0x8000U)
> > > +#define DRV_DNN_BUFFER_INDEX_MAX      (15)
> > > +
> > > +#define DRV_DNN_BASE_ADDR_NUM (8U) /* DNN number of base
> > address */
> > > +
> > > +#define DRV_DNN_BASE_ADDR_PURPOSE_INPUT	    (1U)
> > > +#define DRV_DNN_BASE_ADDR_PURPOSE_OUTPUT    (2U)
> > > +#define DRV_DNN_BASE_ADDR_PURPOSE_AWB	    (3U)
> > > +#define DRV_DNN_BASE_ADDR_PURPOSE_TEMPORARY (4U)
> > > +
> > > +/**
> > > + * struct drv_dnn_status - DNN IPA status for IOC_IPA_GET_STATUS
> > > + *
> > > + * @state:     State of driver
> > > + * @eer_cmd:   Execution error command
> > > + * @eer:       Execution error
> > > + * @reserved:  Padding
> > > + * @eer_flags: Execution error flags
> > > + */
> > > +struct drv_dnn_status {
> > > +	enum drv_ipa_state state;
> > > +	__u32 eer_cmd;
> > > +	__u32 eer : 1;
> > > +	__u32 reserved : 31;
> > 
> > bitfields will not work like this for uapi files, sorry.
> 
> I'll change the type of the member eer from bitfield to bool.

bool will not work for a user/kernel api structure at all, sorry.

> > > +	__u32 eer_flags[32];
> > 
> > What endian is all of these?  Big?  Little?  Unknown?
> 
> The processors and accelerators are little endian in Visconti SoC.
> Do I have to use more specific type such as __le32 ?

Of course, this has to be defined as to how the hardware sees it.  Why
wouldn't you specify this?

> > > +};
> > > +
> > > +struct drv_dnn_base_addr {
> > > +	__u32 purpose;
> > > +	union {
> > > +		struct drv_ipa_addr ipa_addr;
> > > +		uintptr_t list_addr;
> > 
> > You really do not ever want a uintptr_t in a uapi file, that's not going to be
> > portable at all.  It's also not a valid kernel type :(
> 
> I understand. The member list_addr should be typed "struct drv_ipa_addr*".

No, not at all, that too will not work and is not portable.  Please read
the documentation in the kernel for how to write correct user/kernel
apis with ioctl structures.  It is all documented there, please do not
ignore it and create an api that will be broken.

> > > + * @config_done:          Flags of called configuration
> > > + * @buffer_info:          Table of buffer information
> > > + * @buffer_info_num:      Number of buffer_info
> > > + */
> > > +struct drv_dnn_descriptor {
> > > +	struct drv_ipa_addr configuration;
> > > +	__u32 configuration_offset;
> > 
> > What endian are any of these?
> 
> They are little endian as processors and accelerators are LE.
> Do I have to use specific type such as __le32?

Yes, as that is defined by your hardware, not the processor the kernel
is running as.

> Do we need special care for endianness	when userland and kernel are sharing data (a drv_dnn_descriptor instance) ?

Yes, why wouldn't you?

> I thought there're no endianness problem when the driver is reading/writing HW's 32bit registers.

Is that what you are doing here?  It's impossible to tell.

For data that only crosses the user/kernel boundry, you can use the
native processor endian, but when it crosses the kernel/hardware
boundry, you HAVE to specify it as to what the hardware expects.

thanks,

greg k-h
