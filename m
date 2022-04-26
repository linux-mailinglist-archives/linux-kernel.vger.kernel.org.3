Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9A51092D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiDZThi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354273AbiDZThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EE1A3242
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6021161ADE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86512C385A0;
        Tue, 26 Apr 2022 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651001653;
        bh=n31ADtdY32exhbef+u/KKAt0v24R0Zf/uCxWgtn7T0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BLJE9NbslN7afqw7w6RQ2FIW8E8wR1WzpyabnbwH1v0ac2NHYTYNtKDggXPHJGr66
         eHIJWSgUCwoXqj9BE91aRU09teTzlY9oaRWvsaFl7f9RBbmiK6Uww2RCOX7g9scMIW
         13DoCs49mCd/LKONv5bGeG2pgOe2yLbyk2yBsjdo=
Date:   Tue, 26 Apr 2022 12:34:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Message-Id: <20220426123412.51fb58780a8fe2b32c7814ce@linux-foundation.org>
In-Reply-To: <20220426193020.8710-1-fmdefrancesco@gmail.com>
References: <20220426193020.8710-1-fmdefrancesco@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 21:30:20 +0200 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:

> Add VM_BUG_ON() bounds checking to make sure that, if "offset + len>
> PAGE_SIZE", memset() does not corrupt data in adjacent pages.
> 

hm, why?  To match all the other functions in there?

I suppose that's logical.  Or we could just delete all the other
VM_BUG_ON()s.  Have any of them proven to be at all useful?
