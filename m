Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9952E324
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbiETDbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbiETDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:31:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6257B28
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wHef6Z3MEY5uLblxjBwpzUeUe+sPUOyaDIdO+GUS+wY=; b=TmGiw23nicyT2P87FuBkBrGDth
        AcURHnVmtwfvyAHpc8zwxmSSPWAwwmunJdnYkmrkcgE3rjyyhn7xfglNY3nGkwRhpp6+ulloeo/yH
        /okWjmfkP/VfFfWGwpzv9FzxQ+/GFjQgFZJQ8MAFQPq0/Vvu2NO78VdfFMo0t29yRSJgVZyvJETO6
        xVF117u4pFuWduLiV6dtjt5BQyfGcNgnuL63gdA6ZJNZgsk/G2TIiiUZrhsxSVzYQ/cw3l96P9ZiX
        HGVFvTEGPGS1FVf4GPHQ/MiZjdQIrT6SIy6srfGij07BIJEl40dm4R2JGLgHIk6luBgKeFZTDl9Nl
        O+tdatTA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtMa-00GUId-SQ; Fri, 20 May 2022 03:31:40 +0000
Date:   Fri, 20 May 2022 03:31:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Message-ID: <YocLnFa8mRpOkCZ5@zeniv-ca.linux.org.uk>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
 <YocEddeThi8VUcKb@zeniv-ca.linux.org.uk>
 <e70dfd3b-c2a6-d830-e3a0-6a25f0da9256@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e70dfd3b-c2a6-d830-e3a0-6a25f0da9256@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:25:30PM -0600, Jens Axboe wrote:

> > Feed it a buffer with only 1 byte mapped, watch it'll pass to mix_pool_bytes().
> > And see how much of 'block' has been used uninitialized...
> 
> I don't follow? Buffer with 1 byte, iter setup with 1 byte. We copy 1 byte,
> and we pass 1 byte to mix_pool_bytes(). What am I missing?

"only 1 byte mapped" != "len is 1"...  Anonymous mmap() of 2*PAGE_SIZE, munmap()
the second half, ask that sucker to write PAGE_SIZE from buffer + PAGE_SIZE - 1...
