Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A254C572638
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiGLTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiGLTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:44:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4011AAB29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48898B81BD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C5FC341C0;
        Tue, 12 Jul 2022 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657654310;
        bh=O5l3DDkCL1GLC1cLcZh7E/j88FiYHXorbNoNPs9qYjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7mlHgNgtuET3TxAjKenZBXszlKL5EWencfe+7pE6MvAfl5dII94BZePOvH7Y9v+9
         aeQwJTYBa1Q8k/ixcCtlq5Qx/t/S6QtFtd1Qt0KqzhyG2/tPiR+MxMsBb4qiolssHp
         FNhjcDS/z85gj8K/4anC04dMYLqVoHhrA8C7EI5M=
Date:   Tue, 12 Jul 2022 21:31:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Message-ID: <Ys3MI7cv2yKj9RFc@kroah.com>
References: <Ys2jlGMqAe6+h1SX@kroah.com>
 <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:19:39PM -0400, Boris Ostrovsky wrote:
> 
> On 7/12/22 12:38 PM, Greg KH wrote:
> > Hi all,
> > 
> > I'm seeing the following build warning:
> > 	arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update(): can't find starting instruction
> > in the 5.15.y and 5.10.y retbleed backports.
> > 
> > I don't know why just this one hypercall is being called out by objtool,
> > and this warning isn't in 5.18 and Linus's tree due to I think commit
> > 5b2fc51576ef ("x86/ibt,xen: Sprinkle the ENDBR") being there.
> > 
> > But, is this a ret call that we "forgot" here?  It's a "real" ret in
> > Linus's branch:
> > 
> > .pushsection .noinstr.text, "ax"
> > 	.balign PAGE_SIZE
> > SYM_CODE_START(hypercall_page)
> > 	.rept (PAGE_SIZE / 32)
> > 		UNWIND_HINT_FUNC
> > 		ANNOTATE_NOENDBR
> > 		ANNOTATE_UNRET_SAFE
> > 		ret
> > 		/*
> > 		 * Xen will write the hypercall page, and sort out ENDBR.
> > 		 */
> > 		.skip 31, 0xcc
> > 	.endr
> > 
> > while 5.15.y and older has:
> > .pushsection .text
> > 	.balign PAGE_SIZE
> > SYM_CODE_START(hypercall_page)
> > 	.rept (PAGE_SIZE / 32)
> > 		UNWIND_HINT_FUNC
> > 		.skip 31, 0x90
> > 		ANNOTATE_UNRET_SAFE
> > 		RET
> > 	.endr
> > 
> > So should the "ret" remain or be turned into "RET" in mainline right
> > now?
> 
> 
> It doesn't matter --- this is overwritten by the hypervisor during initialization when Xen fills in actual hypercall code.
> 
> 
> So f4b4bc10b0b85ec66f1a9bf5dddf475e6695b6d2 added 'ret' to make objtool happy and then 14b476e07fab6 replaced 'ret' with RET as part of SLS fixes. The latter was not really necessary but harmless.
> 
> 
> So it can be 'ret', RET, or anything else that tools don't complain about. It will not be executed.

Cool, thanks.

But what about the objtool warning that I now see?  Is that "real"?

I don't run any Xen systems, so I can't test any of this myself.

thanks,

greg k-h
