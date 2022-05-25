Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4B5341CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245514AbiEYQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiEYQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:58:35 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B2F9CC98
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:58:34 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24PGpCBP019535;
        Wed, 25 May 2022 11:51:12 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 24PGpBfh019533;
        Wed, 25 May 2022 11:51:11 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 25 May 2022 11:51:11 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Sathvika Vasireddy <sv@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Paul Mackerras <paulus@samba.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, mbenes@suse.cz,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 0/7] objtool: Enable and implement --mcount option on powerpc
Message-ID: <20220525165111.GP25951@gate.crashing.org>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu> <ac4e3ceb-7de8-2c3f-4689-1730d811bf3d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4e3ceb-7de8-2c3f-4689-1730d811bf3d@linux.vnet.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 03:44:04PM +0530, Sathvika Vasireddy wrote:
> On 24/05/22 18:47, Christophe Leroy wrote:
> >This draft series adds PPC32 support to Sathvika's series.
> >Verified on pmac32 on QEMU.
> >
> >It should in principle also work for PPC64 BE but for the time being
> >something goes wrong. In the beginning I had a segfaut hence the first
> >patch. But I still get no mcount section in the files.
> Since PPC64 BE uses older elfv1 ABI, it prepends a dot to symbols.
> And so, the relocation records in case of PPC64BE point to "._mcount",
> rather than just "_mcount". We should be looking for "._mcount" to be
> able to generate mcount_loc section in the files.

The dotted symbol is on the actual function.  The "normal" symbol is on
the "official procedure descriptor" (opd), which is what you get if you
(in C) take the address of a function.  A procedure descriptor holds one
or two more pointers, the GOT and environment pointers.  We don't use
the environment one, but the GOT pointer is necessary everywhere :-)


Segher
