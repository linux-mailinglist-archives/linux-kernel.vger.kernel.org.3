Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716A64B9E07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiBQLAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:00:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiBQK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:59:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84F297208
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k+K/S4k1lT6ap2ZGsdX1S59y95YGeivQRrtXWeBKtKc=; b=PxyZ3S7Dc+H9qAXWvihb6mdfqj
        qr4iIoJr6hxmeXH3A+JCqnWjG2dHuxQOPLFN0s5rOLaHCUdk4x/Js4gbfyJgoTeR7sbhAVVTAn/y0
        x0Dtob1izK7z+Wc8M/3caEFW0evRZDSsyI3/m9hvZKBLRuyRiktF/P2l42lHK3r+0iGk9kwTNrFdG
        yU97SEnSid1DI9VOva9Dqn3UswCLVwNbR3NUBupCsHfv7HXV/BfdG1/mJej3ztxK161PD6TtWYYNe
        NY7s55GKzueSfMV9nsLMxpDM5l4gFB2Tx0MXCio+/5TaWy13wBmLHwF/BNY0DhhsbKT1UGW+/LUBF
        wq+MIHfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKeUb-00AZMj-W6; Thu, 17 Feb 2022 10:58:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5F1730026F;
        Thu, 17 Feb 2022 11:58:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8D0B201A7CEE; Thu, 17 Feb 2022 11:58:31 +0100 (CET)
Date:   Thu, 17 Feb 2022 11:58:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, acme@redhat.com, ardb@kernel.org, bp@alien8.de,
        broonie@kernel.org, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 0/4] linkage: better symbol aliasing
Message-ID: <Yg4qV6GHaHuLrUmm@hirez.programming.kicks-ass.net>
References: <20220216162229.1076788-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216162229.1076788-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:22:25PM +0000, Mark Rutland wrote:
> Catalin, Will, Peter: I think this is ready now and would like to get it
> queued, but it looks like this may (trivially) conflict with other bits
> we'll want to queue in either the arm64 tree (Joey's string routine
> changes [4]), or tip tree (Peter's IBT series).
> 
> I assume the best thing to do would be to have a stable branch merged in
> both of those. I've tagged this such that it can be pulled (details
> below); Peter also suggested he could make a stable branch in the tip
> tree. Any preference?

No real preference, The conflicts on my end are really rather trivial
IIRC, but they're a nice clean-up.

If I don't take then, feel free to add:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

