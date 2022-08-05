Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB458A6FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiHEHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEHYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:24:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BB1900D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC546615DB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F0C433D6;
        Fri,  5 Aug 2022 07:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659684273;
        bh=RMb+yWMJ1lHFHETbxbrZ62eKVFujJ06xkZ15vBzWUnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQEFtc/Li2O2gDEp9OJGVemiJH3nK+nLMXaLaU7X0LXyuIWupMPuLDJKMuVQkgJ3S
         eH0Q1N4ocIF+OMYkf105iIgEGFr6KmH+5vVEeFQXc1cUnatiwLSHBajQIFEa5tN3qg
         O7sMRZa9P0GmgeDSs664HNqF30jidKP5KSSysEWAPvJ1ybJ3w3tAR9x3yMbuQ1E1Ps
         +9e+XtH3+FlP7N5sALovH6AyIcwZLqHERWqt0jpNKcrDSFcy4Il4qbJ+I8063aN9yx
         b79u6JGH3zSOCQZh7O8enor0+O5MKMlpkGpigtIFT+OeqDiAtqjrCRCZd8ZS2ke+5O
         WvX7gXQMTvrbg==
Date:   Fri, 5 Aug 2022 00:24:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     christophe.jaillet@wanadoo.fr, corbet@lwn.net, dhowells@redhat.com,
        edumazet@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v2 3/3] kernel/watch_queue: Remove wqueue->defunct and
 use pipe for clear check
Message-ID: <YuzFrzrTnTtUHMn/@sol.localdomain>
References: <cd2a10ffd8cb11c79754f43d0d20fd3cd4ba9b7e.1659618705.git.code@siddh.me>
 <20220804144152.468916-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804144152.468916-1-code@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:11:52PM +0530, Siddh Raman Pant wrote:
>  static inline bool lock_wqueue(struct watch_queue *wqueue)
>  {
>  	spin_lock_bh(&wqueue->lock);
> -	if (unlikely(wqueue->defunct)) {
> +	if (unlikely(!READ_ONCE(wqueue->pipe))) {
>  		spin_unlock_bh(&wqueue->lock);
>  		return false;
>  	}

Why is the READ_ONCE() needed?  Doesn't wqueue->lock protect wqueue->pipe?

> +	/* This pipe will get freed by the caller free_pipe_info().
> +	 * Removing this reference also prevents new notifications.
> +	 */

This isn't the correct block comment format; it should look like:

	/*
	 * This pipe will get freed by the caller free_pipe_info().
	 * Removing this reference also prevents new notifications.
	 */

- Eric
