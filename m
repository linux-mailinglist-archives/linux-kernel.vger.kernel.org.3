Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAFE50A932
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391810AbiDUTdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392103AbiDUTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:33:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51524D273
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7YCqoM+OLSScIKj5SFV1xnv7Lq3/KtSA68DSkvEprg=; b=Vhti+WEyr4COI6tQth8L0dFrJX
        L2Qc2PLVL/AHjkI6Hkl21Z4mjVTBJ2aYR2End8Zj5O14N7BfCgaZAabD6VddgKDMPH/1ZO+u3TXMi
        6LQIjCON6T5lsOgfkDbuujm+HFjoMmXUBsCK6vaV8MneweQ+aTM7ZeGS8ws9OqUKIjg6p04U7IQ1v
        seX0zss2MD+NHWCaEAgm79Fplz6wztO9g3O6CesQRj0rD9T0+IJGN5GN0K4aIa1lMC2M3xV2pHvBz
        i1AilLwl4bs8ZEPTGXYhX2wfh0PXfS1OCi1xw4J9cy0dFBMW4/sSnqdwsOrvaIRpZJR2Pd7300ex5
        kR3XchWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhcVR-005O1O-On; Thu, 21 Apr 2022 19:30:21 +0000
Date:   Thu, 21 Apr 2022 20:30:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RFC 2/3] futex: exit: Print a warning when futex_cleanup fails
Message-ID: <YmGwzRIHFlKZk3Hm@casper.infradead.org>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-3-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421190533.1601879-3-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:05:32PM -0400, Nico Pache wrote:
> @@ -1007,13 +1013,15 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
>  static void futex_cleanup(struct task_struct *tsk)
>  {
>  	if (unlikely(tsk->robust_list)) {
> -		exit_robust_list(tsk);
> +		if (!exit_robust_list(tsk))
> +			pr_info("futex: exit_robust_list failed");

Doesn't this allow a malicious user process to spam the kernel logs
with messages?  There needs to be a ratelimit on this, at least.

