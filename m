Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D72563F46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 11:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGBJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:39:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69F4B4A2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 02:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71C5560B22
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6E6C34114;
        Sat,  2 Jul 2022 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656754795;
        bh=sNB4SSev9GGBp702mzMS6UGh+tOd6kOa4UDTbCW0xXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjVlZJuYdsPcA+gR+qKyRz4Ssc0rWw008xgaxYEVorFvWUrm+DAuEIHyRIAeoC4rT
         rosc5GYX2ScJtXc5LspG8095kJSZeU3xXF2EYclkSgI5TY5kXlr+7gNzZzuclbb7BD
         e4rr3mxXLExQrFO2xa1Jxm9F4/GiC+lWliXhf5rXFA27qvxJbvp581Cvob6ocCI0Tt
         /XF4Vix2yitYy8XZldPmKjuqjopiKh61D0WWb+Lq3j6fmcMUhzBVWfZaFq1f0SD/lI
         xMoz3B+ORU6oJY5+LfT+cf8wdFpuquf4uuAXdEeMCYkhiVpfSVUea+/qUwz/3ZOe0j
         US4sd0E3DRoYA==
Received: by pali.im (Postfix)
        id 833EC777; Sat,  2 Jul 2022 11:39:52 +0200 (CEST)
Date:   Sat, 2 Jul 2022 11:39:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220702093952.ir7ctqsianztocik@pali>
References: <20220524093939.30927-1-pali@kernel.org>
 <20220524175955.GI25951@gate.crashing.org>
 <20220524181255.bmszzxmbwzv7zed7@pali>
 <20220524185247.GK25951@gate.crashing.org>
 <20220524191610.hnodzz2j7mlgthey@pali>
 <20220524195216.GL25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524195216.GL25951@gate.crashing.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2022 14:52:16 Segher Boessenkool wrote:
> On Tue, May 24, 2022 at 09:16:10PM +0200, Pali Rohár wrote:
> > On Tuesday 24 May 2022 13:52:47 Segher Boessenkool wrote:
> > > Aha.  Right, because this config forces -mspe it requires one of these
> > > CPUs.
> > > 
> > > You can use a powerpc-linux compiler instead, and everything will just
> > > work.  These CPUs are still supported, in all of GCC 9 .. GCC 12 :-)
> > 
> > Ok. I can use different "generic" powerpc compiler (It should work fine
> > as you said, as it has also -mcpu=8540 option). But I think that
> > compilation of kernel should be supported also by that gcc 8.5.0 e500
> > compiler.
> 
> That linuxspe compiler you mean.  Sure, why not, the more the merrier,
> as long as it doesn't get in the way of other stuff, I won't protest.
> 
> But please don't confuse people: you are talking about a
> powerpc-linuxspe compiler, not e500, which is supported just fine by
> current GCC trunk still, and does not have such limitations :-)
> 
> 
> Segher

I think the confusion is the calling "generic" or "stripped" compiler
without SPE support as e500 compiler.

The "true" e500 compiler has support for both both integer and floating
point ISA and not just subset or just one type.
