Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5A598DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiHRURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbiHRURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6CDC4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9881961499
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388FDC433D6;
        Thu, 18 Aug 2022 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660853852;
        bh=dTnWbyCxLymb2y1IHt7bcbwYUVC/MlbgC6SiikPfI7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ioOoH70nKp3OLMN+CcodyBGS+0qN5EyYBBGsWnNQurWVhGhj9POL1hxSojRT/aChR
         R8QCX9ToM2NQffQJ2JcoQ/4L8IYb0BRTCpz7f13XfZqdyrlR/cEqKJ6eJr1wpNdngB
         f5cB+gPsJofCD8C2tDtCUBYnHlvZG8NcIFBawrCAYeFdRjWbyukWWLcCOxFNFbDyN0
         qP7fc4kmrmO6UXSw/MTnxdd1uB3n2PBuqZctp225J1HNEUyvK3V3IreWX+CvRibhLQ
         WvdC0HgutL9lRJ2DeV8KRkXhk48CtHXDOnylONvS2KS7iri3l5ZEF1wF7FFhE5yo9n
         vmiGU6boi2RcA==
Date:   Thu, 18 Aug 2022 22:17:25 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pali =?UTF-8?B?Um9o?= =?UTF-8?B?w6Fy?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Subject: Re: [PATCH linux-phy v2 2/4] device property: Add
 {fwnode/device}_get_tx_p2p_amplitude()
Message-ID: <20220818221725.0601efa6@thinkpad>
In-Reply-To: <CAHp75VeenutmdUZW4Zb6JVz2h5AgwzWmC-okaVtsgRzm99HZ5g@mail.gmail.com>
References: <20220817200335.911-1-kabel@kernel.org>
        <20220817200335.911-3-kabel@kernel.org>
        <CAHp75Vcn1MXEB_+kJuR3qY8qxi6oq0pEFFSFrmKv2-tE-YP-zA@mail.gmail.com>
        <20220818214137.29ccb13a@thinkpad>
        <CAHp75VeenutmdUZW4Zb6JVz2h5AgwzWmC-okaVtsgRzm99HZ5g@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 23:10:09 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Yes, I have no objection to put it there, just that the above
> justification doesn't allow it to be in the generic code (yes, we may
> still have some awkward APIs in the property.c and ideally they should
> be moved to the respective subsystems).

OK

> > > You may count the values and read them all,  
> >
> > What do you mean? Count the values and read them all via one
> > call to fwnode_property_string_array_count() ?  
> 
> No, you obviously may not read them via string_array APIs, esp. one
> that is related to counting.
> 
> Count the vals first, read them all (it seems you need it in all
> branches of your flow). Then count names and compare them to the
> number of values, and so on... Also try to assign "default" only once.

1. there is one branch where I don't need to read the values: when the
   "-names" property does not exist, the DT binding documentation says
   that the value property should only contain one value, the default
   one. So in that case I early return
     return fwnode_property_read_u32(fwnode, vals_prop, amplitude);

2. I thought that I shouldn't check whether the size of the
   "tx-p2p-microvolt-names" array is equal to the size of
   "tx-p2p-microvolt". Rob Herring says (if I understand correctly) that
   kernel shouldn't validate device-tree, that we have dt-schema for
   that...

Marek
