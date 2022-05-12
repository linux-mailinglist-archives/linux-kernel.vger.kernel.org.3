Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F3D5250F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355746AbiELPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355775AbiELPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA0554A7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E145861E42
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC39CC385B8;
        Thu, 12 May 2022 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652368328;
        bh=uYvMyxzmEzgGs3lP9laB6AIOtldLOsLsxFxjFqAdLXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBQRfnUv/ca+85vrpjesPIxdKdgiMljkmIZppAtfxQyk09MZXAbwlvvUqjcOt2n2A
         dEoXTis3MD4xnnsEaPMpa1EgKQuBHkApCeNPkNLbxdkHELHL3KI67rGzSblRcD+QV0
         FJf7Uho/8upVG7WGp9d0OPH50jm4xBuV0pw2//XGqjgaSkCKkxhzM7BQKNVfcOX/IC
         4a71yQ5fJ/PbpfUBVmnzL209EriGr+YpbR4Wbjq+XdTj/FNUVHwJ0oNntwBaXvgAE4
         AGOeYW+imMB0UgQ8F+c3VKyve3jttJYDNBYEEwb3wt6tZ6zEWnn2A0VHQ3PKJ7pn2D
         AeV6sG/T2RCoA==
Date:   Thu, 12 May 2022 08:12:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Message-ID: <20220512151206.dphxz5jyeshwc4jb@treble>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <0b55f122-4760-c1ba-840a-0911cefec2ad@csgroup.eu>
 <20220328195920.dqlfra3lcardko6r@treble>
 <b8fac6e2-c117-86cf-2901-5ae0852ca403@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8fac6e2-c117-86cf-2901-5ae0852ca403@csgroup.eu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 02:52:40PM +0000, Christophe Leroy wrote:
> Hi Josh,
> 
> Le 28/03/2022 à 21:59, Josh Poimboeuf a écrit :
> > On Sun, Mar 27, 2022 at 09:09:20AM +0000, Christophe Leroy wrote:
> >> What are current works in progress on objtool ? Should I wait Josh's
> >> changes before starting looking at all this ? Should I wait for anything
> >> else ?
> > 
> > I'm not making any major changes to the code, just shuffling things
> > around to make the interface more modular.  I hope to have something
> > soon (this week).  Peter recently added a big feature (Intel IBT) which
> > is already in -next.
> > 
> 
> Were you able to send out something ?

Yes, the objtool rewrite is now in tip/objtool/core and linux-next.

-- 
Josh
