Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD054F8AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiDGXYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiDGXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F2D107816
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 238BF612DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE444C385A0;
        Thu,  7 Apr 2022 23:21:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c16yF8ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649373711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1hw3ZaUnlA/kb6IATAoV5F47fVM3GAcXC3l10wss9Y=;
        b=c16yF8ewETCp8NjMxhD07+ZQF5RkOPbs+TgeaZxQjWY9SsmP+5DPYOZLf1saJDKk/yrUY8
        a8WST2YvjBbFuMDNxH2vbwyuHzAO0UAM9u5gnpaESROaOxqP9OkSSbqFcTwN4pT31NhSKY
        C+ljnebBdh3sQ6EoYCcxMJ3OTzG7qJ0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e5a93b82 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 23:21:51 +0000 (UTC)
Date:   Fri, 8 Apr 2022 01:21:41 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, ak@linux.intel.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: x86: should clear_user() have alternatives?
Message-ID: <Yk9yBcj78mpXOOLL@zx2c4.com>
References: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
 <YgJnhB+bAxoNsiSB@zn.tnic>
 <9d3b36e9-f752-22bd-4ea3-cf169fa26e9b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d3b36e9-f752-22bd-4ea3-cf169fa26e9b@google.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Just a reminder that Samuel already did a lot of work and benchmarking
and made this a lot faster:

https://lore.kernel.org/lkml/20210523180423.108087-1-sneves@dei.uc.pt/

As far as I can tell, there was a lot of nitpicking, some of which might
have been pointless, and the author understandably didn't followup to
finish it off.

But the code and analysis is there, and maybe it'd be worthwhile for
somebody here to pick it up again?

Jason
