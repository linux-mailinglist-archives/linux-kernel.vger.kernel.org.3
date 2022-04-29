Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3903514103
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiD2DlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiD2DlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:41:16 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704814FC64;
        Thu, 28 Apr 2022 20:37:59 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:37:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651203477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TeqiwakqteIi2ux9lGt03PezpQ4Ym4Vpg4af5bUrfCk=;
        b=A8RwEq/r9EAn+Oa7cpOExaCcnom40vxxnKfIQHrrTjJISw1kLb22sEDC7KLr9k5NEQYFBI
        gYWc2ur/A2f5zaV+GQ6X49tdJGex9XeU5NsE7t1L3F3elKVKi6LoEUr2y4hjHIpNrCuUJU
        U/DzOkxM0LsiKRuoLwjq2gG4YkyU++o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/nvdla: Add driver support for NVDLA
Message-ID: <20220429033733.GA15753@chq-T47>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <YmqgailZKIuY7zTZ@orome>
 <beacfd71-ebd0-7fde-187f-34b7a42a47de@kapsi.fi>
 <aa55c03c-6d22-9718-a2a5-28d9ce114954@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa55c03c-6d22-9718-a2a5-28d9ce114954@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 4月 22 17:35:56, Jon Hunter wrote:
> 
> On 28/04/2022 16:56, Mikko Perttunen wrote:
> > On 4/28/22 17:10, Thierry Reding wrote:
> > > On Tue, Apr 26, 2022 at 02:07:57PM +0800, Cai Huoqing wrote:
> > > > The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> > > > which is integrated into NVIDIA Jetson AGX Xavier,
> > > > so add driver support for this accelerator."
> > > 
> > > Hi,
> > > 
> > > nice to see this work going on. For subsequent revisions, can you please
> > > also Cc the Tegra mailing list (linux-tegra@vger.kernel.org) as well as
> > > the Tegra platform maintainers (that's Jon Hunter and myself). This will
> > > make sure that more people with an interest in this will see your work.
> > > Not everyone follows dri-devel, linaro-mm-sig or linux-media.
> > > 
> > > Thanks,
> > > Thierry
> > 
> >  From a quick glance it looks like this driver pokes DLA hardware
> > directly which is not the intended programming model on Tegra hardware
> > (there are Falcon microcontrollers that offload task scheduling and
> > synchronization from the CPU). The hardware is also behind the Host1x
> > bus so a simple platform device is not sufficient.
> > 
> > Was this driver developed against some platform with OpenDLA hardware
> > (i.e. not Tegra)?
> > 
> > If so, we'd need to verify if the hardware matches the hardware in
> > Tegra194. Also, this driver may not be ideal for Tegra platforms since
> > we would lack the hardware scheduling and synchronization facilities. It
> > is likely necessary to have separate drivers for OpenDLA and Tegra's DLA
> > integration.
> 
> 
> I believe that this is derived from the following github project ...
> 
> https://github.com/nvdla/sw
> 
Sure, based on https://github.com/nvdla/sw

The copyright retain in this driver,
like "Copyright (C) 2017-2018 NVIDIA CORPORATION"

Thanks
Cai
> Jon
> 
> -- 
> nvpublic
