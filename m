Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7C5A1A08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbiHYUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHYUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:08:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8DBFC5B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0be4Uw3fqExuolOVBE3ibWXBVDsYnkBq1CTcgz9rF6A=; b=FgGt0+ky9aSTj26GPlq9wqiUkc
        Nf9n0rEzsvWTnUVVCDjkll/C3DyY6cg4nK9XIJGslmgdIESeh7Xt/pwLE81q0hyeKS/3wc2BTBnG6
        XsfSRZR03AUi6rSK5+y/+IeS71+8FT9QfnyDZMRKVO9p2vqhRYtp2Ydmdca/SBUni30nXQtEVnXaO
        L/UflEmb1P8C7ICyiKUe8KBub2IaQbh+alE8Iu1dkXDkiazoTYBEkSE82ChK/hARnZnQT8e7df7IQ
        TRqFoptMgb0gYpmYO9NpLzBHWsCkdxGe9lfdSvBj695/WhF1eEqzmZO80xggAabLkJN19i0m1ZRhl
        gJbYrPsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRJ9Q-006653-Oj; Thu, 25 Aug 2022 20:08:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C018E9800E6; Thu, 25 Aug 2022 22:08:27 +0200 (CEST)
Date:   Thu, 25 Aug 2022 22:08:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] earlyprintk: Clean up pciserial
Message-ID: <YwfWu5Gz/Ouv8I8f@worktop.programming.kicks-ass.net>
References: <YwfPQ1cmzBZ2uP2o@worktop.programming.kicks-ass.net>
 <20220825195143.GA2867872@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825195143.GA2867872@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:51:43PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 25, 2022 at 09:36:35PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 25, 2022 at 12:39:59PM -0500, Bjorn Helgaas wrote:
> > 
> > > > -	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
> > 
> > > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > > index 6feade66efdb..1d2c7df8cd41 100644
> > > > --- a/include/linux/pci_ids.h
> > > > +++ b/include/linux/pci_ids.h
> > > > @@ -75,6 +75,9 @@
> > > >  #define PCI_CLASS_COMMUNICATION_MODEM	0x0703
> > > >  #define PCI_CLASS_COMMUNICATION_OTHER	0x0780
> > > >  
> > > > +/* I/F for SERIAL/MODEM */
> > > 
> > > I/F?  Grep says it's fairly common, but doesn't seem completely
> > > obvious.  I guess it means "interface"?
> > 
> > It does, I carried the nomenclature from the above line; happy to change
> > it if you want.
> > 
> >   https://wiki.osdev.org/PCI#Class_Codes
> > 
> > Calls it 'Prog IF'.
> 
> Personally, I would spell it out just to make it less arcane.  I
> wouldn't know where to find the definition, and the PCI specs don't
> seem to use the abbreviation.  But no big deal either way.

Ok,

/* Interface for SERIAL/MODEM */

it is.
