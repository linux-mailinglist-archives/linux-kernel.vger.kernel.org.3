Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468F75AA034
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiIATjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiIATjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:39:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C97C773
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7PMktsvCeflqHXpmx1pY0BaMo+yb9eJasUdA0eZTbwU=; b=KvmI+7mukKhHzNfPM57th60Ylm
        aggKXxgw2lh3nJzK4r+PSS3jQHAhAQ9DNT0+H7GT5jRIZN/J/gpExo3Dwi1sZP3KhBigQ7D/qoKA+
        ZC94DLwMLjw2KFbT2g7VknZPCRLJimzESg854oPAvyQwAPZT0lroxc0HhKnveo56gkLawS920ec6z
        i5hqjDrlyzue2Rs8Eir0IDyzD6iYxCJK/+Jow/BXuDfqxtWYnbxhHEJ9x66wMduOmf8U/jxgOFo9V
        3rHL6A/7lnHXqzsFjVANbZht+CbgV4XJ4IzQUa2LKS37ibN5sZxaydcsR10j63gvb+dvReEhpc70P
        eP+fXgGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTq19-008TS4-U8; Thu, 01 Sep 2022 19:38:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E77BA300230;
        Thu,  1 Sep 2022 21:38:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C968E2B8D59A4; Thu,  1 Sep 2022 21:38:21 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:38:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        bgray@linux.ibm.com, agust@denx.de, jpoimboe@kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: Re: [PATCH v3 2/6] objtool: Add architecture specific R_REL32 macro
Message-ID: <YxEKLSpNlUTvj4yt@hirez.programming.kicks-ass.net>
References: <cover.1662032631.git.christophe.leroy@csgroup.eu>
 <1cfa46b215a2f39c7f8040ca5447113ff9eb7dd6.1662032631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfa46b215a2f39c7f8040ca5447113ff9eb7dd6.1662032631.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:48:21PM +0200, Christophe Leroy wrote:
> In order to allow other architectures than x86 to use 32 bits
> PC relative relocations (S+A-P), define a R_REL32 macro that each
> architecture will define, in the same way as already done for
> R_NONE, R_ABS32 and R_ABS64.
> 
> For x86 that corresponds to R_X86_64_PC32.
> For powerpc it is R_PPC_REL32/R_PPC64_REL32.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
