Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3347D00C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhLVKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:34:20 -0500
Received: from smtp1.axis.com ([195.60.68.17]:36794 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235010AbhLVKeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1640169259;
  x=1671705259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLMLmT5m3m7o69AaIKBFwKPKTlTsCPE8fqiz5LYmR68=;
  b=I5V2s3X+qEdyEm0ZzTycnYPNeZhN90SESk62UfyWIhRxSliTj2xaGsb4
   2+Gv6xECHEWMwN3G+nYD+t+rzCtyC5pAPpL7mCHzVSs/FyuRZ2C8bqAz8
   Y3Ait1HugHTaiwteFIXGqo/nHD76Eg1xDKYbZsnE2efkw580q/ywtr7FC
   1jAfeYmslCXM4Dk/UBM+rLdyHhT8SzUAH4dkcrWZADX1jcZz3xDT/Hz4J
   TD16qz5B6LR0eQm9Adm6fVgbLLdY8NOzXEW90u79ss/JQxZpv7iDLIe/0
   by65PZ+x4s4WlSYIo+GMu8nGNM/73AwFXXn3z/zfjKlmYtTNO4e7CZSV6
   Q==;
Date:   Wed, 22 Dec 2021 11:34:17 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Rob Herring <robh+dt@kernel.org>, kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] um: virtio_uml: allow probing from devicetree
Message-ID: <20211222103417.GB25135@axis.com>
References: <20211221090447.1567-1-vincent.whitchurch@axis.com>
 <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:48:26PM +0100, Johannes Berg wrote:
> On Tue, 2021-12-21 at 10:04 +0100, Vincent Whitchurch wrote:
> > Allow the virtio_uml device to be probed from the devicetree so that
> > sub-devices can be specified using the standard virtio bindings, for
> > example:
> > 
> >   virtio@1 {
> >     compatible = "virtio,uml";
> >     socket-path = "i2c.sock";
> >     virtio-device-id = <0x22>;
> > 
> 
> Given this, maybe it should modify
> Documentation/devicetree/bindings/virtio/virtio-device.yaml? Or actually
> add a new Documentation/devicetree/bindings/virtio/uml.yaml I guess?
> 
> +Rob, because I'm not really into any of this.
> 
> Also, I'm not even sure we should/need to document the DT bits that are
> basically only used for testing in the first place?

I wasn't sure either, but Rob was OK with not documenting some other
bindings which are only used for testing[0], so I assumed that that
applied here too:

 [0] https://lore.kernel.org/all/5baa1ae6.1c69fb81.847f2.3ab1@mx.google.com/ 

Also, DT bindings are supposed to be generic and based on what the
hardware has, but here we have no hardware and something very Linux and
UML-specific.

> Code looks good to me.

Thanks!
