Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07DF4FDD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiDLLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbiDLLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:10:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50485945
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ctcFTn0w6V6dn60hCVOeQY6EpY2IAZwsL/yX59ESRQ8=; b=dOK9E5lZyl1dz7vt9gPzx3CK1M
        1F801At0ybIZuqpDkKGuxj4PwTUF7x2EqJ+/uU/bZQqSY1DEPp5dh/qZ3BiQ4Iz4If9nDsc7mi6d7
        I7xJ9/uJRDQ2EB76fDW7JoydZ+k/u7XWYogrJkZnJZXHFMwi09ZDRri2GM4vz0lTRH54V0aT1EBOb
        HABTFQrrP0gjWF3Zes79lkFGydbodovm74L0laTZ9rY5Gvyi2IfWOhF7fb+rdknRmgXxQBP/8Roix
        44DIsw8JA48FVAQWbec3NQAQnW1q7D+84sjkE6s1DtY8XqJDUXbrXRbtq5ubl0jAHzkGLMjtO0Vzn
        pWjPWv3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neDLC-004HeE-5W; Tue, 12 Apr 2022 10:01:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC9D4300250;
        Tue, 12 Apr 2022 12:01:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 944022DB89DC9; Tue, 12 Apr 2022 12:01:39 +0200 (CEST)
Date:   Tue, 12 Apr 2022 12:01:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com
Subject: Re: [PATCH 2/2] x86/unwind/orc: Fix address check size for
 deref_stack_iret_regs
Message-ID: <YlVOAw9yUbivp7Ki@hirez.programming.kicks-ass.net>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <1649749204-186363-2-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649749204-186363-2-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:40:04AM +0300, Dmitry Monakhov wrote:
> For historical reasons we check only IRET_FRAME_OFFSET, but this check
> is no longer valid because  we also access regs->sp field which is
> located beyond IRET_FRAME, so it is reasonable to validate full structure.

Uuuh, what? IRET frame is:

 ss, sp, flags, cs, ip

that very much includes sp.
