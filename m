Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A67D511219
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358656AbiD0HO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358644AbiD0HOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:14:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FECF3BBE1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:11:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651043502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iieCc4+2+t84xbIfqg/Vt5XzM+5n2OlCTNJq4zoXcc8=;
        b=0pIffffN2I5m/8N9LfexvtHEo4q6IDwiY5HkK9UxLZpmPmffWzXLaRo8cwr/oRjCoFehod
        R2+ZNXjudo67tGth6QarlotZttilHguSsMgkiuOoQ+Lmr73bU6n4qQVfS+6at57cpByvIO
        J1j8i/H755GlqB8L3KHnPWVFVvdbtqEI9bfT6UYZj3MYS2gFTqiRLX484bhEjTLJoFkhWe
        Ob/b9TSuv9B0nQsjlPjwpn/46Ox0SZLTSrw+iMtAcJTWF+ak5oKfCAVL/yI8x9pYQY+tcd
        G+uZe4+Ju0DaDr146/H+LxiHPsp2oVFF+OyHdSC/cSN29Fd9yrRY0yuUbombNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651043502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iieCc4+2+t84xbIfqg/Vt5XzM+5n2OlCTNJq4zoXcc8=;
        b=d9k/+ElCCIWTJrGqz1Sn+P8kW59jlkDMd4IcgOaXa1aBWqq3gCEXd3hF74hDrTWgm2Cl4Q
        L9lFCH3ARO8BOHAg==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 09/13] task isolation: add preempt notifier to sync
 per-CPU vmstat dirty info to thread info
In-Reply-To: <20220315153314.130167792@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.130167792@fedora.localdomain>
Date:   Wed, 27 Apr 2022 09:11:41 +0200
Message-ID: <878rrryp8y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> If a thread has task isolation activated, is preempted by thread B,
> which marks vmstat information dirty, and is preempted back in,
> one might return to userspace with vmstat dirty information on the 
> CPU in question.
>
> To address this problem, add a preempt notifier that transfers vmstat dirty
> information to TIF_TASK_ISOL thread flag.

How does this compile with CONFIG_KVM=n?

Thanks,

        tglx
