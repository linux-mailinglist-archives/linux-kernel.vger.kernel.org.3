Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489B4DD8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiCRLNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiCRLNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:13:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6171C390C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n4sggZm7p9DHCB8j1DhsXlfgy0Kx1nlnCjGo117hMd8=; b=gJIrR7GSInjIKr2YQpdNOQS4uW
        890iA/I2AAQM4qOL03tOEJMb3I+Hg2RB+Zvzh1ZjdhtYR8gct24zzJ0TeHmOJ0nPw9X9fXzZTnWjT
        2VtsT3S7FeUEq3yMWDOMkR5np1e6bXbbWFbNhRull7KduJIL7Q+Mrl7sZPX0riW7ZQz2fZQjKOpFK
        HX7jkHJassSxdLrfBUKDZJT3vw7y0LWbpESVOQZ8UnLr2G3XXKdoB0BqunIkGq3dk6DRI+SSjzfh/
        fWJ1qKr2uhtUe+us1W+LUdwMuOOcXtQXvVK8VkTZPEfpRIwjWIy6zth58Qed1hSYWcz1yfI78XE7I
        WIq7i0ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVAWb-002BxM-HA; Fri, 18 Mar 2022 11:12:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D13F53001C7;
        Fri, 18 Mar 2022 12:12:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B31082D35E990; Fri, 18 Mar 2022 12:12:04 +0100 (CET)
Date:   Fri, 18 Mar 2022 12:12:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V3 3/7] x86/entry: Switch the stack after error_entry()
 returns
Message-ID: <YjRpBEXYHhjZrz54@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-4-jiangshanlai@gmail.com>
 <YjH8xJ3MKosyUl7M@hirez.programming.kicks-ass.net>
 <CAJhGHyBKC4Xe=FTtv=+QRG1b5o=6G+vdMDP+oH83cz+29VXHBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBKC4Xe=FTtv=+QRG1b5o=6G+vdMDP+oH83cz+29VXHBg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:43:02AM +0800, Lai Jiangshan wrote:
> On Wed, Mar 16, 2022 at 11:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > >  SYM_CODE_END(error_entry)
> >
> > So the new Changelog doesn't seem to help me much. But looking at both
> > fixup_bad_iret() and sync_regs(), they both have:
> >
> >   __this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1
> 

Yes, I can't read :/ Functions don't both use that.

Your patch is correct, not switching the stack in between runs sync_regs
from another stack, but the end result should be the same.
