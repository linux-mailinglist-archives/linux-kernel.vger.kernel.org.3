Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68359FC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiHXN7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbiHXN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:58:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE11298D21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:57:38 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:57:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661349456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpalXE2XjDnPtjQgOFh+FhkS2pbYMvN3W0ynIcjZ+BY=;
        b=Y0/dLE+SPfTPT/KULnkf2BnawwCm17T01ZoKyPNosxbGXtvYHrgz3hFAdma/E8asoxIo0K
        tyvUR2iPwxAeFxO9fJ/JuP+Hd6olytuLmCheC1bBOhZmHenuYxSDp0PdPQSMSqfuWsCaXM
        8fRBh6++0K6X1iflKpatQLe03W8cMr47fUyJb9VXmvgO+8uzsuvKSqHsFk5o/LierldBic
        qeYmfMmfiMVa4II6wWVQDt8QOPJADMHqtOturNpFSixag56VtJ2+V74phYgrsQbmnzWBvy
        FJYWBwWv4ewuzoELRkH1P/iwtNakSvx3zJBXFM+wOwNaUUI4wDx9l8b5ZKbZzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661349456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpalXE2XjDnPtjQgOFh+FhkS2pbYMvN3W0ynIcjZ+BY=;
        b=nTVcJDUZxuy80SX/8yJGoC4OngRrITb4o8K9YIBwGn7nKZu+AvO8QDzoZYlZK2jmdmeqkO
        R3OzegOqJIoLOJAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Message-ID: <YwYuT0lzbexTRn6Y@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-2-bigeasy@linutronix.de>
 <ffb4012b-e038-a92e-c84c-bb1d061fe29f@suse.cz>
 <YwYm31FKQJh/CVBn@linutronix.de>
 <e3f9bde2-7754-491a-78c0-a4a37dacbdd5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3f9bde2-7754-491a-78c0-a4a37dacbdd5@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-24 15:54:54 [+0200], Vlastimil Babka wrote:
> Yeah, realizing that this is true on RT led to the recent patch I
> referenced. Initially when converting SLUB to RT last year I didn't realize
> this detail, and instead replaced the irq disabling done (only on !RT) by
> e.g. local_lock_irqsave with the manual local_irq_save().

Ah, okay. Let me get to the other series then ;)

Sebastian
