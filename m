Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24C35A9B60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiIAPRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiIAPRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:17:52 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6960867C95
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:17:51 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 281FBJ1H024415;
        Thu, 1 Sep 2022 10:11:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 281FBHnO024414;
        Thu, 1 Sep 2022 10:11:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 1 Sep 2022 10:11:17 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on ppc
Message-ID: <20220901151117.GE25951@gate.crashing.org>
References: <20220829055223.24767-1-sv@linux.ibm.com> <20220829055223.24767-16-sv@linux.ibm.com> <2fb92e17-2ad5-9732-560c-a7321e6a2528@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fb92e17-2ad5-9732-560c-a7321e6a2528@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:32:46AM +0000, Christophe Leroy wrote:
> Le 29/08/2022 à 07:52, Sathvika Vasireddy a écrit :
> > +int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
> > +			    unsigned long offset, unsigned int maxlen,
> > +			    unsigned int *len, enum insn_type *type,
> > +			    unsigned long *immediate,
> > +			    struct list_head *ops_list)
> > +{
> > +	u32 insn;
> > +
> > +	*immediate = 0;
> > +	insn = bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
> > +	*len = 4;
> 
> Should be *len = 8 when insn >> 26 == 1.

But please use ppc_inst_prefixed().  And just use ppc_inst_len() here?

Not having convenience abstraction functions like that will give you
much more work in the future -- currently all prefix insns use primary
opcode 1, sure, and nothing else does; but this can change.


Segher
