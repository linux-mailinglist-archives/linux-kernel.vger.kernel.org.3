Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD69D4F1E95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379717AbiDDWBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379970AbiDDSaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550313F48
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7509660DF1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80607C3410F;
        Mon,  4 Apr 2022 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649096883;
        bh=mXpgbaUOKADPld1qaxP9bMRmsQjHNjEPuGekcdbMNYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v6bjHFt5uljyjHe+ez9sjYIqqF9fzyUmoRru/bYCu24+F2cohePUpzuei3TBWgy6s
         Pb1gDf6fBUp+xjB8SolqraUeA5F1Dv8BTB2C5BuPVlLsiPTLqtzR1Iu8DX3Yax0aTB
         HurUYiqNhieSdhd+mULt7cLJfDk7cC8cdUmeJEXA=
Date:   Mon, 4 Apr 2022 11:28:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Zi Yan <zi.yan@sent.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH] mm: migrate: use thp_order instead of HPAGE_PMD_ORDER
 for new page allocation.
Message-Id: <20220404112802.4c07585b7b7e420342c9b0fb@linux-foundation.org>
In-Reply-To: <20220404165325.1883267-1-zi.yan@sent.com>
References: <20220404165325.1883267-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Apr 2022 12:53:25 -0400 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> With folios support, it is possible to have other than HPAGE_PMD_ORDER
> THPs, in the form of folios, in the system. Use thp_order() to correctly
> determine the source page order during migration.

Changelog doesn't describe the end user visible effects of the bug. 
And it really should, because

> Link: https://lore.kernel.org/linux-mm/20220404132908.GA785673@u2004/

it fixes a kernel crash!


