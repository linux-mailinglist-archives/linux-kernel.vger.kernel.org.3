Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62849E314
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbiA0NH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbiA0NHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:07:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C36C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R10rczCoNInVexJ1TCTKIHNcjnMZr8Df6vy6pBlljCA=; b=ZD32iGgtBtIR37gKtxeU9b/cx7
        eBvrPWVWUGxAC1yS0g/jVw85HOgYplapNWQxUmXg2GE3h+VHpGw/OTXLudFcsknpCTS066W8gr2yO
        VGU71mJa2bxoZGXaUI4SsGb/tnMPoHiCXJnWAVZcFjijXa+xJl+oyrjokXLpW7ZcIo860EmWqs57q
        p7N7N9nF3wSMT5u894Q4Cpiv0tpD6YzfHGLMN0RyQ+tvg6znQcnfPFjUiMeJyizgu9CIw8nf91R5Y
        oCikq9Q7rBcVbinQze9AsXz6T766OvqboHxyDBKxUgNtkixvjIxaclX7vXlImynOx/YR6X/YJ+tHf
        Un8cTo+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD4Uf-005FVR-P7; Thu, 27 Jan 2022 13:07:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA7B8300268;
        Thu, 27 Jan 2022 14:07:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5B212B52092C; Thu, 27 Jan 2022 14:07:17 +0100 (CET)
Date:   Thu, 27 Jan 2022 14:07:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Subject: Re: [PATCH v5 09/13] perf/x86/amd: add idle hooks for branch sampling
Message-ID: <YfKZBQRpZAY/kMpn@hirez.programming.kicks-ass.net>
References: <20220126233454.3362047-1-eranian@google.com>
 <20220126233454.3362047-10-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126233454.3362047-10-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:34:50PM -0800, Stephane Eranian wrote:
> +static inline void perf_lopwr_cb(bool mode)
> +{
> +	/* key enabled only when BRS is available */
> +	if (static_branch_unlikely(&perf_lopwr_needed))
> +		perf_amd_brs_lopwr_cb(mode);
> +}

static_call() might be better at this point..
