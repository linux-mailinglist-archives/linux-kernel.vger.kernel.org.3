Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAA4D9CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbiCON73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiCON72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:59:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F832AC70
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:58:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647352693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dZE1qG3XKJsBo21sC7tItqZOERvUCP8F2BeC3VwtfE=;
        b=nzi9kj3AMwTnfS6RCNTtL2mA6KGjOHpr6RH1aoAyE99y26Fjzklur3apRCjB3wBED4nIdW
        c1twp1aCyB8dNHCQoLucKim3FCQG4jjKEtmC6v6uPLIntlE0LdM6jGR0FyEp+hQpDP2+ux
        fRn5vnUv339ge8YCM1PwkJKDgMgz8+Bfi+KZkAj8Q1WkuENTvOYu1t9VZ1oVa6KmEwt/Cr
        TqW6PTgvmlQZop427elt4P1u4SBUm1h/boIPhMblkuRlakBkzf4zakpz5LeMMFZCAGoF8l
        xEfLkSBCwN2rUVg1WCibilVmKAPIS7oyJOekxVF8SDz5QEmd/5wDB8maL84AgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647352693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dZE1qG3XKJsBo21sC7tItqZOERvUCP8F2BeC3VwtfE=;
        b=cjMutTKPyfLo+tVmWO6ghm6sXIogP7Rqytv2IzbWzewg1v9nXDSykfeNKlsSpFMV+1Wdck
        MxkBTfGeOMlkbCAQ==
To:     wudaemon <wudaemon@163.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RESEND] genirq: add log level to printk in print_irq_desc
In-Reply-To: <20220313034415.4110-1-wudaemon@163.com>
References: <20220313034415.4110-1-wudaemon@163.com>
Date:   Tue, 15 Mar 2022 14:58:12 +0100
Message-ID: <874k3z71xn.ffs@tglx>
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

On Sun, Mar 13 2022 at 03:44, wudaemon@163.com wrote:
> add KERN_DEBUG level for debuging purpose, use checkpatch.pl check prompt:

... and then ignore the checkpatch.pl output vs. the patch which "fixes"
the problems:

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...
#29: FILE: kernel/irq/debug.h:6:
+#define ___P(f) do {if (desc->status_use_accessors & f) printk(KERN_DEBUG "%14s set\n", #f); } while (0)

and 6 more of the same...

> Signed-off-by: wudaemon <wudaemon@163.com>

Please read Documentation/process/submitting-patches.rst especially the
chapter about the Developer's Certification of Origin:

   "... using your real name (sorry, no pseudonyms or anonymous contributions.)"

Thanks,

        tglx

