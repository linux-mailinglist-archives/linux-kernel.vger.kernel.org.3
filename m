Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961951E5D2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382641AbiEGJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiEGJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:09:55 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C66A1AF2A;
        Sat,  7 May 2022 02:06:09 -0700 (PDT)
Date:   Sat, 7 May 2022 17:05:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651914367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j815uNVTrC2zbEfuQ1kKt5KWSsZfGH90td0/PQ5ogrQ=;
        b=iYt7riG/mfb9s7dyzVgXIqRzZwelacsgxjTdeN1AgJ91kN3y9nSM/W9WzuEGg70/Fl/UFN
        nb+4oOkKnazbkpCJgnlsQVbx7EBJ6qmgeDXxyqNDAWK6TXDKkXapdrfwQLxTnrwKJKldRE
        px0qOTi/OvwmWo8YbfXXNFlE5qf+B24=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 0/4] drm/nvdla: Add driver support for NVDLA
Message-ID: <20220507090542.GA30702@chq-T47>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <YmqgailZKIuY7zTZ@orome>
 <beacfd71-ebd0-7fde-187f-34b7a42a47de@kapsi.fi>
 <20220429032810.GA10104@chq-T47>
 <YnAPDRZMc88cDdYS@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnAPDRZMc88cDdYS@orome>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 5月 22 19:04:13, Thierry Reding wrote:
> On Fri, Apr 29, 2022 at 11:28:10AM +0800, Cai Huoqing wrote:
> > On 28 4月 22 18:56:07, Mikko Perttunen wrote:
> > > On 4/28/22 17:10, Thierry Reding wrote:
> > > > On Tue, Apr 26, 2022 at 02:07:57PM +0800, Cai Huoqing wrote:
> > > > > The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> > > > > which is integrated into NVIDIA Jetson AGX Xavier,
> > > > > so add driver support for this accelerator."
> > > > 
> > > > Hi,
> > > > 
> > > > nice to see this work going on. For subsequent revisions, can you please
> > > > also Cc the Tegra mailing list (linux-tegra@vger.kernel.org) as well as
> > > > the Tegra platform maintainers (that's Jon Hunter and myself). This will
> > > > make sure that more people with an interest in this will see your work.
> > > > Not everyone follows dri-devel, linaro-mm-sig or linux-media.
> > > > 
> > > > Thanks,
> > > > Thierry
> > > 
> > > From a quick glance it looks like this driver pokes DLA hardware directly
> > > which is not the intended programming model on Tegra hardware (there are
> > > Falcon microcontrollers that offload task scheduling and synchronization
> > > from the CPU). The hardware is also behind the Host1x bus so a simple
> > > platform device is not sufficient.
> > > 
> > > Was this driver developed against some platform with OpenDLA hardware (i.e.
> > > not Tegra)?
> > > 
> > > If so, we'd need to verify if the hardware matches the hardware in Tegra194.
> > > Also, this driver may not be ideal for Tegra platforms since we would lack
> > > the hardware scheduling and synchronization facilities. It is likely
> > > necessary to have separate drivers for OpenDLA and Tegra's DLA integration.
> > > 
> > > Thanks,
> > > Mikko
> > > 
> > Tegra DLA seems to work with a slave coprocessor, the host driver just
> > impelement message queue, share buffer, notification... The hardware
> > detail of DLA maybe in the slave driver(not linux OS?).
> > 
> > Sure, This driver just support for the SOCs or FPGAs that OPENDLA
> > inside. I will change this kind of description "integrated into NVIDIA Jetson AGX Xavier"
> > this driver dont support for Tegra directly.
> 
> Yes, I think it would be good to make it clear that this is not going to
> work with the Tegra instantiations so that people don't get confused.
> 
> I think it would be ideal, though, if we could reuse as much of this
> driver as possible to work with other instantiations. The only reference
> to OpenDLA that I can find and which seems somehow relevant to this is
> here:
> 
> 	https://github.com/SCLUO/ITRI-OpenDLA
Hi, thanks for your reply.

the hardware code here,
https://github.com/caihuoq/nvdla-hw
or https://github.com/nvdla/hw
which includes cmodel, RTL.

I also make a docker image to run cmodel simulator(based on qemu)
https://github.com/caihuoq/nvdla_docker
It can be used to check this driver.

Thanks,
Cai
> 
> Is that the version that you're using? Or is the version that you're
> using at least compatible with that one? Apart from that and the Tegra
> instantiations, are you aware of any other derivatives that we need to
> account for? I'm worried that this might fragment to the point where it
> becomes unmaintainable in upstream Linux.
> 
> Even if this doesn't concern the Tegra instantiation, I think most of my
> other comments remain valid. Things like global variables will get in
> the way of multiple FPGA instantiations as well, for example.
> 
> You will also need to provide the device tree bindings for the
> particular instantiation that you're working on. Typically this would be
> identified by a vendor-specific compatible string for your particular
> board, but if it stems from a "canonical" FPGA mapping, matching on that
> compatible string might also be an option. In either case, when you send
> out the DT bindings, please include the devicetree@vger.kernel.org
> mailing list so that they can be properly reviewed.
> 
> Thierry


