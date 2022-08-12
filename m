Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8E590A02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiHLBu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHLBuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:50:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48CE0E8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC42B8224C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17C3C433C1;
        Fri, 12 Aug 2022 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660269020;
        bh=9Gj1fVPo/TfV2UndXuyWK4XY3oW/T50N15LkHtMwRko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9lpFMEFdPFB4OL4LCtMIBVOOLaAlrM9in8lyM8qbZ5cQDmtOWosi1IgNP+owfjl6
         8ennE8/ac5BDgAtillJwQvrXmUNqD81EMT+N/O6dgRfgOliFkO8euiLWYOkAhcejGN
         XR5HeKxoejkuv8mQSefdUFU7eWf+Q77RQycL3+yr7Lzi+ZLdMS0vRM9Zlb4XVM/myU
         LAL8cnD+iFCjYQ+iMVA9Jc+CI4x6NmDdQoMo3QjNsjoqghH8qLPFaPEknPVbQ/ya9+
         gLrSjWcVPn3EgnXfjrMtzeKzVARt9FrFry77oUTxqHMtZgKgqnoDzS1e9GVwDSmBPI
         o6L2iMjohrSEg==
From:   SeongJae Park <sj@kernel.org>
To:     Zeng Jingxiang <zengjx95@gmail.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [PATCH] mm/damon: remove dead code in damon_lru_sort_enabled_store()
Date:   Fri, 12 Aug 2022 01:50:18 +0000
Message-Id: <20220812015018.115955-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812012459.481215-1-zengjx95@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zeng,

On Fri, 12 Aug 2022 09:24:59 +0800 Zeng Jingxiang <zengjx95@gmail.com> wrote:

> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> The variable damon_lru_sort_initialized is always true, causing the
> corresponding conditional expression cannot be executed.
> 
> Assigning true to damon_lru_sort_initialized here
> 544         damon_lru_sort_initialized = true;

Before the assignment, the variable is set 'false'.

> 
> The value of damon_lru_sort_initialized is always true.
> As a result, the following expression cannot be executed.
> 
> 463         if (!damon_lru_sort_initialized)
> 464                 return rc;

If this code is executed before the assignment, the expression can be executed.

Actually, there was a bug due to the absence of the variable.  You may refer to
that for the detail:
https://lore.kernel.org/damon/20220604192222.1488-1-sj@kernel.org/T/#t


Thanks,
SJ

[...]
