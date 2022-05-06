Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44A451DFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391045AbiEFTf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391037AbiEFTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:35:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52B6E8D8;
        Fri,  6 May 2022 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KYjynMh8oTuhJ2M+10A3ZYR4VMfe0p38wFUuoJlJ0jY=; b=qNTidsh3yZUbG12y5r9LdAxcc2
        4yB/F/2WzO221X0AQ1NYTaL3vf8G7a5F5oAXjA7kUvkYekpoYEkwvUSTMQtpOSdyZMafxMsv2O7f2
        zBVXV3bhNOEB+Eakz8Mi8L9zPVo9l696toCnlV71r8UetOYDt+HcQNAxWR4mL9IdjRlfxjVCSLzJf
        lEljm10xPYz/4fq5gp8jGMBPMRmgBaAXB8tqs+jSHdhP+2d9Cdw5ft/K505wG76EjEgKV03x0iSvd
        ejz90Eyx8ac/Oqstb7E4VWXFvYD39yhQrNmStPpIvSQLKZ5aIBgnugjf6dfc34mCS/0EWnnW5HJeH
        OmFjSWJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nn3fg-00Bkhr-TQ; Fri, 06 May 2022 19:31:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA1773003AA;
        Fri,  6 May 2022 21:31:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A19582029A1AC; Fri,  6 May 2022 21:31:22 +0200 (CEST)
Date:   Fri, 6 May 2022 21:31:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
Message-ID: <YnV3iljKUM0Fqw/F@hirez.programming.kicks-ass.net>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
 <20220504062351.2954280-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504062351.2954280-2-tmricht@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:23:50AM +0200, Thomas Richter wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
> 
> arch_check_user_regs() is used at the moment to verify that struct pt_regs
> contains valid values when entering the kernel from userspace. s390 needs
> a place in the generic entry code to modify a cpu data structure when
> switching from userspace to kernel mode. As arch_check_user_regs() is
> exactly this, rename it to arch_enter_from_user_mode().
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---

With the note that NMI doesn't (necessarily) call this..

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
