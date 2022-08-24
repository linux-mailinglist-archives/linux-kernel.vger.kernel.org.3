Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98759FCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiHXOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiHXOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:14:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E721E3CF;
        Wed, 24 Aug 2022 07:14:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661350490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onXIwT24w+dLpoyvwrvcKE6DSSsspuurq0qMZ2iYDwY=;
        b=cTRYzAt8znJF2n9iO0G8ZEu0aYpUIjGo+LCgXHjxysTFXOJS2KmU+zk14SY+m/G20D/DBu
        RPLJDq42KDHJ8ogy/188aR3zXsf1ShC7PyzdZS+fXTOg0N+Xbj6wOltPG7RRXo31EB1V7q
        NktSpioTmaoxgTMVR7ndEKDLxJ+2kmW40j0KnK2b419XddeODlLUHnBa5E0z7ql5YOHxOs
        pprEk8zla0akCJiIoQB3S6GBjlp/Pg4fJpaqJYf9B4+PwXHB2H+2SwC2xVF/lBUZVFWpSO
        V+6Kgu5cFUdYRugLqg8THY3GzdM8sudmSi5awyCRp4QWyhdz5VpM448j+MBy+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661350490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onXIwT24w+dLpoyvwrvcKE6DSSsspuurq0qMZ2iYDwY=;
        b=2y0YtCwMntDOgtmIXCgpJTb0905ezzalkjcK9SrizmhPglbgVycztLCfWGdFXLGUABaXsP
        26lfYJJYFQqXxuCQ==
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Steven Noonan <steven@uplinklabs.net>, usama.anjum@collabora.com,
        kernel@collabora.com
Subject: Re: [PATCH 3/3] x86/tsc: don't check for random warps if using
 direct sync
In-Reply-To: <20220808113954.345579-3-usama.anjum@collabora.com>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
 <20220808113954.345579-3-usama.anjum@collabora.com>
Date:   Wed, 24 Aug 2022 16:14:49 +0200
Message-ID: <87sfllybhi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08 2022 at 16:39, Muhammad Usama Anjum wrote:
> There's some overhead in writing and reading MSR_IA32_TSC. We try to
> account for it. But sometimes overhead gets under or over estimated.
> When we retry syncing, it sees the clock "go backwards". Hence,
> ignore random wrap if using direct sync.

This is just wrong. If the sync test can observe clock going backwards
then it can be observed during runtime too. Preventing that is the whole
point of the TSC sync exercise.

Thanks,

        tglx
