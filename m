Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74C5A19D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbiHYTvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiHYTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:51:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8962B14D8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74DE3B82A37
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3242C433D6;
        Thu, 25 Aug 2022 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661457105;
        bh=bDsBSc9D8CFPAf1LMWVvP0gWEdVoQLURNx3YOde3SBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FlIkg9gbsW+HqOTGN0GzpPd+NLGQNRpEjVBvVKM6O9oT3pkayfLNu0dRfzLVdbNYx
         V+U2jElo35qWP++HTF7we3ylR+wzW2Zx/z2Pfvmor5P9hfREziWPMAOmMd5wWsvlZh
         csqEWd8pWePUrSoXNE3zCKp8IuHDm5pwZpS9Uag5/e79ga3wHhNdoWvRb7fHwlHIC/
         I7k9tTjxilv+9QoasbREmLYaIP5Pe5OAH3XEOxjFPfVderRcMswpVzcMkAD3C2BRE5
         i+6cKpnN45QFzWeHKsfdtPiMw7ik3CMxloaLEFraBXhvb8pZtwKqKgk4rRUIvuyGQN
         f2q4J4qhERaMA==
Date:   Thu, 25 Aug 2022 14:51:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] earlyprintk: Clean up pciserial
Message-ID: <20220825195143.GA2867872@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwfPQ1cmzBZ2uP2o@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:36:35PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 12:39:59PM -0500, Bjorn Helgaas wrote:
> 
> > > -	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
> 
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index 6feade66efdb..1d2c7df8cd41 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -75,6 +75,9 @@
> > >  #define PCI_CLASS_COMMUNICATION_MODEM	0x0703
> > >  #define PCI_CLASS_COMMUNICATION_OTHER	0x0780
> > >  
> > > +/* I/F for SERIAL/MODEM */
> > 
> > I/F?  Grep says it's fairly common, but doesn't seem completely
> > obvious.  I guess it means "interface"?
> 
> It does, I carried the nomenclature from the above line; happy to change
> it if you want.
> 
>   https://wiki.osdev.org/PCI#Class_Codes
> 
> Calls it 'Prog IF'.

Personally, I would spell it out just to make it less arcane.  I
wouldn't know where to find the definition, and the PCI specs don't
seem to use the abbreviation.  But no big deal either way.

Bjorn
