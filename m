Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8025AB74A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiIBROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiIBROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:14:02 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51F57112EED
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:14:01 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 282HAqvu018556;
        Fri, 2 Sep 2022 12:10:52 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 282HApOJ018555;
        Fri, 2 Sep 2022 12:10:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 2 Sep 2022 12:10:51 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Bergner <bergner@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: Re: [PATCH v2] powerpc: Fix irq_soft_mask_set() and irq_soft_mask_return() with sanitizer
Message-ID: <20220902171051.GU25951@gate.crashing.org>
References: <c0b486e782b6695092dcdb2cd340a3d44c8c266d.1661272738.git.christophe.leroy@csgroup.eu> <CMJ3VICKD1CI.SVFJOKYJPKZQ@bobo> <e022754d-b4d3-bc9f-cc79-2cf556180459@csgroup.eu> <CMJ8P06JA9OY.1S8VDV2XRU3W5@bobo> <7c11b659-5b8e-256c-508e-39395041fccb@csgroup.eu> <20220831224522.GX25951@gate.crashing.org> <bd00d8c2-663d-cb35-c1c3-4fa9bd4cb4ad@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd00d8c2-663d-cb35-c1c3-4fa9bd4cb4ad@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:57:27AM -0500, Peter Bergner wrote:
> On 8/31/22 5:45 PM, Segher Boessenkool wrote:
> > Yes, this is guaranteed.
> 
> Agree with Segher here.  That said, there was a gcc bug a looooong time
> ago where gcc copied r13 into a temporary register and used it from there.

r13 is a fixed register on most of our ABIs (everything that is not AIX
or Darwin, even), so this can never happen.  Except if there are bugs,
of course ;-)

> That's ok (correctness wise, but not ideal) from user land standpoint,
> but we took a context switch after the reg copy and it was restarted on
> a different cpu, so differnt local_paca and r13 value.  We went boom
> because the copy wasn't pointing to the correct local_paca anymore.
> So it is very important the compiler always use r13 when accessing
> the local_paca.

Yes.  So we either whould use -ffixed-r13, or just not use unsupported
compilers.  powerpc*-linux and powerpc*-elf work fine for example :-)


Segher
