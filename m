Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CBF4DB611
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbiCPQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiCPQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:24:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66B21E11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:23:41 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 336931EC0295;
        Wed, 16 Mar 2022 17:23:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647447816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c2EdQq8TYkNxnHKY80QxNf+A2xGQIKpT9IWZ5b+3ymo=;
        b=KHGJ8LGCxaeuPrv7yHyQOriggRm2PN1ht87H4D6fQXH08DLAeVU08xfRLMTyLmswLTxgV9
        w6S8Uq4b11nA13MXVoCmSf/rfkdkmUTYtrd1C1cYW/AIL/Igj385bCeiV1gWqTYel0sQlT
        F6kCZpE5tb+mOcUh7zFrhB5KS2w91NY=
Date:   Wed, 16 Mar 2022 17:23:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in
 memmove_64.S
Message-ID: <YjIPA1IagZDdi7iw@zn.tnic>
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211117210245.843374-1-goldstein.w.n@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:02:45PM -0600, Noah Goldstein wrote:
> Add check for "short distance movsb" for forwards FSRM usage and
> entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> modes" that are an order of magnitude slower than usual.
> 
> 'rep movsb' has some noticeable VERY slow modes that the current
> implementation is either 1) not checking for or 2) intentionally
> using.
> 
> All times are in cycles and measuring the throughput of copying 1024
> bytes.

All these claims need to be proven by

 - real benchmarks - not a microbenchmark - where it shows that
 modifications like that are not "in the noise". Others should be able
 to verify those results too.

 - on a bunch of CPUs from different vendors to verify that they don't
   cause performance regressions on any.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
