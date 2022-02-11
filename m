Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A878F4B28C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbiBKPJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:09:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBKPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:09:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE1A9;
        Fri, 11 Feb 2022 07:09:29 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:09:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644592167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLsUzGZCfbhtNRNcw2i65Hw9vSFvBNNoAOcENNoo8Ck=;
        b=BTVeEuTegcvfFax5qovr5Yr98KhUrar+yCyDwo1rM99IbBV231WAkbRJ1cXqoClM72jNRh
        +9VvzbHKuXCdvBBe8oFVb7unyOrWookhnXoyiy9xQT6X/zjw+9YPLDDQ8F63+4Bk+NJVmx
        27gUeJzqcKFMTu2XOvGCNeuVqv08UF7ndj8r14+pCFqlMWzB+ysv90y2pv2iNGIkIAD7Ed
        YROv5WRCtcp1hH1EUjLWZKTBGeNjhFlKkPRTmk+Rr8xf8S4pGjchzlHaKWZuBwrPp0XGMR
        liIwPOP+chxw/ESLY9ItMprymseP2tRn1DKwrjzKpPC0OcSeRdhpLMj4a6hflA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644592167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLsUzGZCfbhtNRNcw2i65Hw9vSFvBNNoAOcENNoo8Ck=;
        b=EU/rM1wkSokEgGeMDhgcbo0I2kMRvzR/Uwqs8M49fL+VteJSBYYyCnYVi4Lf90Kr9S6pQr
        G8seyYJyXx26jIBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH REPOST] irq_poll: Add local_bh_disable() in cpu_dead
 notifier
Message-ID: <YgZ8Jqu95drJFuBK@linutronix.de>
References: <YgJ/XWVxxWDVBBVA@linutronix.de>
 <YgNzsnIE9bwQZ1Zg@infradead.org>
 <YgUGI9qAKUh4AOUY@linutronix.de>
 <YgYDePJLsVLXKqEP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgYDePJLsVLXKqEP@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-10 22:34:32 [-0800], Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 01:33:39PM +0100, Sebastian Andrzej Siewior wrote:
> > You need to handle the pending softirqs. If you don't handle them
> > immediately or in a deterministic say (like on IRQ exit) then they will
> > be handled at a random point.
> 
> Yes.  Just like regular interrupts.

With the exception that this one was already handled and should be
handled and not delayed until the next interrupt.
And as I said, on NO_HZ you get a warning about unhandled soft-irqs if
the CPU goes idle.

Sebastian
