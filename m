Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB73558E4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiHJB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiHJB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D8E7E317
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E676124B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B24C433B5;
        Wed, 10 Aug 2022 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660096635;
        bh=fzCgWcg8Y/G5tPN9s9vV3n0S/OCtwwmdTi510NoLYWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sex+uwmZgfCLP06EebthP+QPfEoWpHyYrkh+tgeBjGLKhDr05wc+gDNTRs4k1KHjV
         X0RNvllP63xrrW5MSVkCjYse9f8zAZncBzGSYy+7v6e2ob6sBfZ4TFjtlmocF4dkq4
         cWULzNfx7AHAa4jvvhBlBEaYgSS0zMtifWZRiqeo=
Date:   Tue, 9 Aug 2022 18:57:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <mhocko@suse.com>, <david@redhat.com>, <pasha.tatashin@soleen.com>,
        <sieberf@amazon.com>, <shakeelb@google.com>, <sjpark@amazon.de>,
        <dhowells@redhat.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Message-Id: <20220809185714.5af7057c1270b11079cb196a@linux-foundation.org>
In-Reply-To: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 20:16:43 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.

Has this race ever been observed at runtime?

Given the size of the fix, I'm looking for excuses to not backport it
into -stable kernels!
