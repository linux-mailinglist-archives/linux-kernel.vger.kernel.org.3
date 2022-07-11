Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3295708B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGKRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKRPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:15:40 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58935140F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:15:38 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26BHCQwP008080;
        Mon, 11 Jul 2022 12:12:27 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26BHCQ80008079;
        Mon, 11 Jul 2022 12:12:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 11 Jul 2022 12:12:26 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 4/5] powerpc/44x: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
Message-ID: <20220711171226.GG25951@gate.crashing.org>
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu> <b0d982e223314ed82ab959f5d4ad2c4c00bedb99.1657549153.git.christophe.leroy@csgroup.eu> <CAK8P3a33jf5CUpyzWmRHpoUDMWB7TqSw5afUW=rcmMVSK8BvRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a33jf5CUpyzWmRHpoUDMWB7TqSw5afUW=rcmMVSK8BvRA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:05:04PM +0200, Arnd Bergmann wrote:
> Is there any value in building for -mcpu=440 or -mcpu=464 when targeting a 476?

The original 440 had a very short pipeline.  Later IBM 4xx have a longer
pipeline.  Getting this right (with -mtune=, or just with -mcpu=) is
important for performance.  So, no?

> Maybe add another !PPC_47x dependency for the first two. Ideally we would also
> enforce that 440/464 based boards cannot be selected together with 476, though
> I guess that is a separate issue.
> 
> Is there a practical difference between 440 and 464 when building kernels?
> gcc seems to treat them the same way, so maybe one option for both is enough
> here.

-mcpu= is used as the default for -mtune=, so that is always a
consideration.  PPC464 is treated the same as PPC440 in binutils as
well, so I don't think there is any issue there.


Segher
