Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AC505EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiDRTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347753AbiDRTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966A24BDD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8DE060F6A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510EBC385A1;
        Mon, 18 Apr 2022 19:44:20 +0000 (UTC)
Date:   Mon, 18 Apr 2022 15:44:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 07/22] powerpc/ftrace: Use patch_instruction() return
 directly
Message-ID: <20220418154418.72ccc00c@gandalf.local.home>
In-Reply-To: <1650262058.altfknhzto.naveen@linux.ibm.com>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
        <b4505e936e1aee411f7132a27791cf138102f35f.1648131740.git.christophe.leroy@csgroup.eu>
        <1650262058.altfknhzto.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 11:51:16 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> > --- a/arch/powerpc/kernel/trace/ftrace.c
> > +++ b/arch/powerpc/kernel/trace/ftrace.c
> > @@ -78,10 +78,7 @@ ftrace_modify_code(unsigned long ip, ppc_inst_t old, ppc_inst_t new)
> >  	}
> > 
> >  	/* replace the text with the new text */
> > -	if (patch_instruction((u32 *)ip, new))
> > -		return -EPERM;
> > -
> > -	return 0;
> > +	return patch_instruction((u32 *)ip, new);  
> 
> I think the reason we were returning -EPERM is so that ftrace_bug() can 

That is correct.

> throw the right error message. That will change due to this patch, 
> though I'm not sure how much it matters. -EFAULT and -EPERM seem to 
> print almost the same error message.

In these cases it helps to know the type of failure, as the way to debug it
is different.

-EFAULT: It failed to read it the location. This means that the memory is
likely not even mapped in, or the pointer is way off.

-EINVAL: Means that what was read did not match what was expected (the code
was already updated, pointing to the wrong location, or simply the
calculation of what to expect is incorrect).

-EPERM: Means the write failed. What was read was expected, but the
permissions to write have not been updated properly.

Differentiating the three is crucial to looking at where the issue lies
when an ftrace_bug() triggers.

-- Steve
