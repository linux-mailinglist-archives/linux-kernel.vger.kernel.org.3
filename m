Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B394B11EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiBJPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:44:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiBJPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:44:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE71DB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E33B80E2D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6947FC004E1;
        Thu, 10 Feb 2022 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644507892;
        bh=yNnHCPnRLaN2yOM6XrRMec/8b28E1NUTOd61qm0f4wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+eVS5p+V6geTrly47Y4rMEYAqalEcF7KX2b1jzmd9o3aWa9fTxdhdFfaWi05+vtm
         w2IvA3ScEv2DV5ijXIjK8syFqYvzCsjfpvhNKy7NYmhR8kkDw5h8+CoTlcnjnpMB0u
         ZyqhmLLk1ARjt8W9DcrS0uGUiC4LLVwak04E9V3bgSnW5MesBoA+Iu5XHgtHS9WzFn
         NTtOIAJkPPTWQx87+uoQE7ulGWLJm4Qncfzau5qCE5sLSqr8qQ77Odvx/VP6kl4/g5
         0qFiGByX/mRtmLnZE2yzpwDokM/rifthcvpxUEVt06W++2TlXnvnNmra5FKZ8yu4ct
         GIlDSNVaIto0Q==
Date:   Thu, 10 Feb 2022 23:37:06 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: fix oops caused by irq on/off tracer
Message-ID: <YgUxIgMJRhJD6/GP@xhacker>
References: <20220129004226.32868-1-changbin.du@gmail.com>
 <YgAEb425uqy5/dw1@xhacker>
 <20220207123850.l4r5qjswaegwisbx@mail.google.com>
 <YgE7XRE/Uc6gTCWd@xhacker>
 <20220208003502.62gi5xhyg6bk2t2h@mail.google.com>
 <YgP6y99LWFSoxjHg@xhacker>
 <20220210133758.yzebffln6j76zme6@mail.google.com>
 <YgUuzZp/eiNoXejK@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgUuzZp/eiNoXejK@xhacker>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:27:21PM +0800, Jisheng Zhang wrote:
> On Thu, Feb 10, 2022 at 09:37:58PM +0800, Changbin Du wrote:
> > On Thu, Feb 10, 2022 at 01:32:59AM +0800, Jisheng Zhang wrote:
> > [snip]
> > > Hi Changbin,
> > > 
> > > I read the code and find that current riscv frame records during
> > > exception isn't as completed as other architectures. riscv only
> > > records frames from the ret_from_exception(). If we add completed
> > What do you mean for 'record'?
> > 
> 
> stack frame record.
> 
> > > frame records as other arch do, then the issue you saw can also
> > > be fixed at the same time.
> > > 
> > I don't think so. The problem is __builtin_return_address(1) trigger page fault
> > here.
> 
> There's misunderstanding here. I interpret this bug as incomplete
> stackframes.
> 
> This is current riscv stackframe during exception:
> 
> high
>  	----------------
> top	|		|  <- ret_from_exception
> 	----------------
> 	|		|  <- trace_hardirqs_on
> 	-----------------
> low

sorry, the "top" is wrongly placed.
 high
  	----------------
 	|		|  <- ret_from_exception
 	----------------
 	|		|  <- trace_hardirqs_on
 	-----------------
top

 low



> 
> As you said, the CALLER_ADDR1 a.k.a __builtin_return_address(1) needs
> at least two parent call frames. 
> 
> If we complete the stackframes during exception as other arch does:
> 
> high
>  	----------------
> top	|		|  <- the synthetic stackframe from the interrupted point
>  	----------------
> 	      .....	      
>         ----------------
> 	|		|  <- ret_from_exception
> 	----------------
> 	|		|  <- trace_hardirqs_on
> 	-----------------
> low

ditto

> 
> 
> Then we meet the "at least two parent call frames" requirement. IOW, my
> solution solve the problem from the entry.S side. One of the advantages
> would be we let interrupted point show up in dump_stack() as other arch
> do. What I'm not sure is whether it's safe to do so now since rc3 is
> released.
> 
