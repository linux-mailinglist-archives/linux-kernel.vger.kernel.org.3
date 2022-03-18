Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A84DD2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiCRCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiCRCMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:12:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BEA2B5AFE;
        Thu, 17 Mar 2022 19:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647569464; x=1679105464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRaStKNDaOu3TSmH3+8cEhhm6JxyDKCuF64VgE2rLZs=;
  b=swUyz+CPYMrm1jqKjJ9+Vb6s8KvzPqglVYdTNEGVEOZ2zfIXZO/SwVjU
   1v3fn8AiM5OFw38VS3XW81s7YNNiHVL34wBq+AhMZzHAoCZ4yazHw1WYH
   x+QowEriSwrvKOTRk4xNOA7mG2tUgkF9H2qMUsqbciM9RK0hYO6jZrbeA
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Mar 2022 19:11:03 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 19:10:57 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 17 Mar 2022 19:10:55 -0700
Date:   Fri, 18 Mar 2022 10:10:52 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <mst@redhat.com>, <jasowang@redhat.com>, <quic_ztu@quicinc.com>,
        <robh+dt@kernel.org>, <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: virtio: mmio: add optional virtio,wakeup
 property
Message-ID: <20220318021052.GA16300@mingxue-gv.qualcomm.com>
References: <1646733156-19333-1-git-send-email-quic_mingxue@quicinc.com>
 <20220317063515.GA30789@mingxue-gv.qualcomm.com>
 <YjMJ32SFXTLCuaRY@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YjMJ32SFXTLCuaRY@myrica>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean and folks,
This is just an optional flag which could be used on an embedded system.
For example, if we want to use an virtio-input device as a virtual power
key to wake up the virtual machine, we can set this flag in the device
tree.
Currently, virio-mmio driver does not implement suspend/resume
callback(maybe no need). So we want to check this flag and call
enable_irq_wake()  accordingly in vm_find_vqs().

Regards,
Minghao

On Thu, Mar 17, 2022 at 10:13:51AM +0000, Jean-Philippe Brucker wrote:
> Hi Minghao,
> 
> On Thu, Mar 17, 2022 at 02:35:15PM +0800, Minghao Xue wrote:
> > Hi Jean,
> > 
> > Do you have any comment on this change? And do you consider to accpet
> > this commit? Looking forward to your reply.
> 
> Please send device-tree patches to devicetree@vger.kernel.org with the
> maintainer "Rob Herring <robh+dt@kernel.org>" on Cc. Add the virtio list
> virtualization@lists.linux-foundation.org for anything related to virtio.
> (You can find that by running "scripts/get_maintainer.pl <your patch>")
> 
> Regarding the patch itself it's outside my expertise, but I feel like
> there should be more generic mechanism to solve this problem, and firmware
> might not need to be involved if this is not describing a property of the
> platform. Plenty of drivers outside virtio deal with IRQ lines as wakeup
> source and I don't see similar properties in other device tree nodes, how
> do they do it?  It looks like a lot of drivers call enable_irq_wake() in
> their suspend() callback, so could we do the same for virtio-mmio?
> 
> Thanks,
> Jean
> 
> > 
> > Regards,
> > Minghao
> > 
> > On Tue, Mar 08, 2022 at 05:52:36PM +0800, Minghao Xue wrote:
> > > Some systems want to set the interrupt of virtio_mmio device
> > > as a wakeup source. On such systems, we'll use the existence
> > > of the "virtio,wakeup" property as a signal of requirement.
> > > 
> > > Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > > index 4b7a027..a5fe02a 100644
> > > --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> > > +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > > @@ -31,6 +31,10 @@ properties:
> > >      description: Required for devices making accesses thru an IOMMU.
> > >      maxItems: 1
> > >  
> > > +  virtio,wakeup:
> > > +    type: boolean
> > > +    description: Required for setting irq of a virtio_mmio device as wakeup source.
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > a Linux Foundation Collaborative Project
> > > 
