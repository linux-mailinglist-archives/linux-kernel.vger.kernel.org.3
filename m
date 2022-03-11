Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914C4D5F39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbiCKKOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347751AbiCKKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:14:07 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC0B1BF933;
        Fri, 11 Mar 2022 02:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646993583;
  x=1678529583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=StZfRVd0d1zSRSJuYQP+XpRtxzfPsHSLjEbIXgq6bj4=;
  b=XoO1H0HufINNN9YnOJMmd+Tzr+w+Rx8/AKHqTxW0QxH+aPZqtsy2+tST
   b/Ko95zd1yvw6KPWz/q+BdIdC1Btq/4AOCCvK5qfZbtds0BLKe85rwMH1
   CzFirUkf/pTo7bwlO23Td4oO68Wt0u34cLhgo1fAh1P+XwZ2xX343otAR
   XihwqSd5bcVOf1RmbIiaOocfVVzHKgmF1v95Sg5E6xf6eQUQWR+HKp95L
   aad3awvKbTJLK5rOsgLxXYVvkVy5G/w9Wf9VmzLWF8e71Iei9q2NtbA6g
   U9cSff4oSz1W9w+fqXHlYP5uEKH9ZVCynx1jlao8HZjCn0lm5B9LuXfOD
   Q==;
Date:   Fri, 11 Mar 2022 11:13:00 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "joern@lazybastard.org" <joern@lazybastard.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 2/4] dt-bindings: reserved-memory: Add phram
Message-ID: <20220311101300.GA32274@axis.com>
References: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
 <20220307141549.2732179-3-vincent.whitchurch@axis.com>
 <YipmkgOuLZGVqH7S@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YipmkgOuLZGVqH7S@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:58:58PM +0100, Rob Herring wrote:
> On Mon, Mar 07, 2022 at 03:15:47PM +0100, Vincent Whitchurch wrote:
> > Add bindings to allow MTD/block devices to be created in reserved-memory
> > regions using the "phram" driver.
> 
> What does 'ph' mean? Please define somewhere for the binding.

Judging from the Kconfig description it means "physical", as in
"physical memory" (as opposed to virtual memory I guess).  I will added
a note in the next version. 

[...]
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        phram: flash@12340000 {
> > +            compatible = "phram";
> > +            label = "rootfs";
> 
> That's an odd example...

If it's the "flash" name which is odd for RAM, that's mandated by the
mtd schema.

If it's the "rootfs" label which is odd, I'm not sure I understand why.
I use this feature to pass the rootfs to the kernel when booting from
RAM.  It is much faster and requires less memory than initrd (which is
on top of that being deprecated), and it allows the same disk images to
be used when booting from RAM, unlike initramfs.
