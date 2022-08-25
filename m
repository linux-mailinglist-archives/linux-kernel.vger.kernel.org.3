Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3186C5A199B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiHYTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiHYTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:36:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E0B9595
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvVzw/5CprLsmkP0IpFmWaZqng7fG+wcTqWK+jWt6xI=; b=ULjh7yEWHojJJ0NAJNI6FJhka7
        UOSPwzhmp2+JyDcMQprecc0Z1g1fNpIfTwB0qN19gKzgH/iOOavEolyIKk+HCepqqrvoLF/5z2upe
        NToZd97C2Y7rUE0OLOhp0ol94U8hkIwo/SBH4jJ7TZzLQDV8rlsNKG8JDiCmB8KRAWvBaK5EgNznw
        jEG4IakKCYgm29yt5p71xa0VEPGBGhLDevJe8b+sZYao/CONCabWKWH4k7ObZFZA50I6B7xKHfBdq
        1CI07LHgmPAG+eW+Jp5nVRTG6TIr53KERkGbmT3vyeKDxdNAPxeTdJ9BjftfegbzZFMt0dXtR9QE9
        OevjwrQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRIea-0065iD-As; Thu, 25 Aug 2022 19:36:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C5A49800E6; Thu, 25 Aug 2022 21:36:35 +0200 (CEST)
Date:   Thu, 25 Aug 2022 21:36:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] earlyprintk: Clean up pciserial
Message-ID: <YwfPQ1cmzBZ2uP2o@worktop.programming.kicks-ass.net>
References: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
 <20220825173959.GA2856913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825173959.GA2856913@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:39:59PM -0500, Bjorn Helgaas wrote:

> > -	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {

> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 6feade66efdb..1d2c7df8cd41 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -75,6 +75,9 @@
> >  #define PCI_CLASS_COMMUNICATION_MODEM	0x0703
> >  #define PCI_CLASS_COMMUNICATION_OTHER	0x0780
> >  
> > +/* I/F for SERIAL/MODEM */
> 
> I/F?  Grep says it's fairly common, but doesn't seem completely
> obvious.  I guess it means "interface"?

It does, I carried the nomenclature from the above line; happy to change
it if you want.

  https://wiki.osdev.org/PCI#Class_Codes

Calls it 'Prog IF'.

> > +#define PCI_SERIAL_16550_COMPATIBLE	0x02
> > +
> >  #define PCI_BASE_CLASS_SYSTEM		0x08
> >  #define PCI_CLASS_SYSTEM_PIC		0x0800
> >  #define PCI_CLASS_SYSTEM_PIC_IOAPIC	0x080010
