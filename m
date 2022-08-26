Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776625A1DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbiHZBGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiHZBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:06:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E0C04CB;
        Thu, 25 Aug 2022 18:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 658BFB82EFD;
        Fri, 26 Aug 2022 01:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6A3C433D7;
        Fri, 26 Aug 2022 01:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661475975;
        bh=d+98VSFWBdfWJMrbnOZB0Q9wyRzkSjBnOtX3niQhhNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYYng0uKWqeMXZes0EoqtqNE0PRFP00QV+xYn4CppxiKryt1R9XWFQ6V+rzzu2ZEu
         m7sw0dirl4hQxTSVLUGltNy3JE8Owxp10GiVavucdJJC9IYe/WurEl3SxOusZDh3DY
         MrsTVJloknfwVhkw/4Dz/TxpeD0kTrUWKgGii1tM=
Date:   Thu, 25 Aug 2022 18:06:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm/mprotect: Fix maple tree start address in
 do_mprotect_pkey()
Message-Id: <20220825180614.0ea05648f898bfa17f95a83c@linux-foundation.org>
In-Reply-To: <20220825202939.3041660-1-Liam.Howlett@oracle.com>
References: <20220825202939.3041660-1-Liam.Howlett@oracle.com>
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

On Thu, 25 Aug 2022 20:30:24 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Use the untagged_addr() instead of the address passed into the function.

What are the runtime effects of this fix?
