Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66300560B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiF2UgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF2UgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:36:08 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 733CA313BD;
        Wed, 29 Jun 2022 13:36:06 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 25TKS467028346;
        Wed, 29 Jun 2022 15:28:04 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 25TKS1wF028345;
        Wed, 29 Jun 2022 15:28:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 29 Jun 2022 15:28:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ash Logan <ash@heyquark.com>, krzysztof.kozlowski+dt@linaro.org,
        paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        devicetree@vger.kernel.org, linkmauve@linkmauve.fr,
        linux-kernel@vger.kernel.org, rw-r-r-0644@protonmail.com,
        joel@jms.id.au, linuxppc-dev@lists.ozlabs.org, j.ne@posteo.net
Subject: Re: [PATCH v3 02/12] powerpc: wiiu: device tree
Message-ID: <20220629202800.GJ25951@gate.crashing.org>
References: <20220622131037.57604-1-ash@heyquark.com> <20220628133144.142185-1-ash@heyquark.com> <20220628133144.142185-3-ash@heyquark.com> <c760e444-57c3-0e1a-0e4d-f79d6ae9867a@linaro.org> <20220629161302.GG25951@gate.crashing.org> <908e7555-0090-84fe-4227-d6b349de1394@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908e7555-0090-84fe-4227-d6b349de1394@linaro.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:13:13PM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 18:13, Segher Boessenkool wrote:
> > On Wed, Jun 29, 2022 at 11:58:18AM +0200, Krzysztof Kozlowski wrote:
> >>> +		/* TODO: Add SMP */
> >>> +		PowerPC,espresso@0 {
> >>
> >> Node name should be generic, so "cpu". Unless something needs the
> >> specific node name?
> > 
> > This is how most other PowerPC firmwares do it.  The PowerPC processor
> > binding is older than the generic naming practice, so CPU nodes have
> > device_type "cpu" instead.  
> 
> ePAPR 1.0 from 2008 explicitly asks for generic node names. So 4 years
> before Nintento Wii U. Maybe earlier ePAPR-s were also asking for this,
> no clue, don't have them.

The majority of PowerPC 750 systems long predate that.  Many *current*
systems implement the PowerPC Processor Binding, too (not the epapr
thing, which is incompatible with the older standards!)

> > There is no added value in generic naming for CPU nodes anyway, since
> > you just find them as the children of the "/cpus" node :-)
> 
> There is because you might have there caches. It also makes code easier
> to read.

In the processor binding the cache nodes were subnodes of cpu nodes or
other cache nodes.  But in some server products you can have cache that
is enabled while the corresponding core is disabled; and also, not all
cache belongs to only one higher level anyway.  This was modelled pretty
uncleanly, yup (cleaner would have been to have a /caches node as well
as /cpus, for example).

But on 750 you just have "l2-cache" subnodes, and all nodes in /cpus are
CPUs :-)


Segher
