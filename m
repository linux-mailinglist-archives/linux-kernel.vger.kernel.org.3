Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045D651770C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387024AbiEBTEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387014AbiEBTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:03:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7D1091;
        Mon,  2 May 2022 12:00:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651518026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFN2WdqzeQgS5RZmSYBBhPah4ZERNvMYVR3oemiypyA=;
        b=VVCXveVrglTJO+py77rxRcLewjhMSOAqz6KbQPP+jZ06befE0vVuYoMZQFO1Yp7sVfFbjV
        eowVD+Xzea+vvAoXaEOlQJrqqsMJRijOqOs54dH/7vOsVNdkTn/t5oP9XMBG/eRnF9jL/z
        AaA+nqYfSZmroz4q2Q1tpVygPuTLAaER+ewKvaVpkP/HIVMG+OUmrJ05g/9JRK7XPNXcvk
        LDKJttwxK1143D7Gahd4Ds7VqLP1Y0ntfTgaddiuqhvcE8WDeHQp7kUPqT23aNHNDtzo8z
        A94hMVpdLMBIJVcKwpwD3SQj4/BXSRLGxiRoSbo7QVyfJXGaAFM6YWEEjHpi9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651518026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFN2WdqzeQgS5RZmSYBBhPah4ZERNvMYVR3oemiypyA=;
        b=JMGQYnCzotx+pHJfzEw3Da+0YcRKN3m4LSdwDdFRa+XG0LHzNKRqZn1zeZOCjEs/uilsSo
        2wATdimnD9bb8eAw==
To:     Thomas Pfaff <tpfaff@pcs.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <bbe3603c-df84-290-fb3c-10f450c21518@pcs.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
 <87mtg0m2jb.ffs@tglx> <bbe3603c-df84-290-fb3c-10f450c21518@pcs.com>
Date:   Mon, 02 May 2022 21:00:25 +0200
Message-ID: <87a6bzn4ja.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02 2022 at 17:34, Thomas Pfaff wrote:
> On Mon, 2 May 2022, Thomas Gleixner wrote:
>
> I can confirm that your patch works.

But for the very wrong reasons. desc->threads_active is a counter and
not a mask. Where is that brown paperbag?

Let me merge your patch and add the information about the root cause to
the changelog.

Thanks,

        tglx
 
