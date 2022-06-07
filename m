Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41492541762
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378705AbiFGVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357020AbiFGT6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:58:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AEA4B84C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 436CDB82380
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8D3C385A2;
        Tue,  7 Jun 2022 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654626258;
        bh=WQze2jI4iLnLMMFgWUExS0e2SHPtgx75puArLYQyzlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yNSqos55DIOrQcDPFBGRPyBCr/BoKJ6v2elSgDa9VbxpUZXDxHDJcfc7OVVYp7dyF
         bnVDWVaOXXUxUBpoikT79XhshrnvuF5VRvM6hOZLCK89Nt7J+njfb2Q0U/q2/8ulwl
         zjBNPDzDoryS04iD9Nd7dG+GfVOJJCzmCkHtAAg8=
Date:   Tue, 7 Jun 2022 11:24:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <willy@infradead.org>, <markhemm@googlemail.com>,
        <hughd@google.com>, <rientjes@google.com>, <surenb@google.com>,
        <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V5,2/2] mm: shmem: implement
 POSIX_FADV_[WILL|DONT]NEED for shmem
Message-Id: <20220607112417.5b47a5f55f20fe1f6cfb14e6@linux-foundation.org>
In-Reply-To: <7584364f-3aaf-282a-0a67-d8329a3415dc@quicinc.com>
References: <cover.1648706231.git.quic_charante@quicinc.com>
        <c2f7242faffd41f46120f82079256ece26b92bf0.1648706231.git.quic_charante@quicinc.com>
        <20220531142135.666b1fcf506e4a327af98ff9@linux-foundation.org>
        <7584364f-3aaf-282a-0a67-d8329a3415dc@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 20:22:34 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> > Is there an actual userspace/driver combination which will use this? 
> > Has the new feature been tested in such an arrangement?  And if so,
> > which driver(s)?
> > 
> 
> Currently my organization is using this setup where it does makes use of
> the shmem infrastructure to allocate the pages and its fd is passed to
> the user. The user is now deciding on when to reclaim these pages to
> free up the memory through already presented vfs_fadvise(DONTNEED)
> system call and bringing back them through vfs_fadvise(WILLNEED), when

OK, thanks.  Please capture all these thoughts in the [0/n] changelog,
leave it a few days for reviewer input then resend and I'll take a
closer look.

The patches don't seem to be getting a lot of traction.
