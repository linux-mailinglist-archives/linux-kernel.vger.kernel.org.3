Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57A598A58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbiHRRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345382AbiHRRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510C52E9D2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD495616FA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD72C433D6;
        Thu, 18 Aug 2022 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660843405;
        bh=n+Zh5soEiKsYTavc5xpB5hD5bHQyBWVCiz9gxj6eumY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzRzyMDttnWkLveGuhV3m6MbEQeEFkChs0X3xIiXlnuxoRvx928i6qTBRVQTOWuUC
         3hEcEcVuS/ZO/7HTLRXXZrvg6u46R1FYIahF29qSBcwASDb31qK6k+daIrcxf2OrwR
         uZZ2E6zfM4+Lg0qBBpc47yrzhdNaAT4kH12vupPrysE8Feesz8ijiavPFdCuhd4lF8
         C/fGYfQwR5sS5zj9U/ruBzwIVbj6Y1t6IdMa+cE/xDdVmMIedkG47b/jOx3rnxHS0I
         1lRuRnuMcReC08JKkmZ6tefikIBX3j02YFnbSl4Fh58iL0SPC4uGAp+gazGHqceVi0
         owAqaZlZa7Nxw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mm/damon/lru_sort: Remove struct of damon_lru_sort_ram_walk_arg
Date:   Thu, 18 Aug 2022 17:23:22 +0000
Message-Id: <20220818172322.51705-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105732.34492-3-xhao@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Thu, 18 Aug 2022 18:57:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> The struct of 'damon_lru_sort_ram_walk_arg' is the same with struct of
> 'damon_addr_range', so, there no need to redefine it, just use struct of
> 'damon_addr_range' instead.

Reducing code is always good, thanks.  However, I think the type of the 'start'
and 'end' fields of 'struct damon_addr_range' might be changed in a future.
It's very unlikely, though.  Also, we might add some more fields to the struct
in a future.  After all, the purpose of 'struct damon_addr_range' is not saving
the 'start' and 'end' fields of 'struct resource'.  I'd like to avoid making
any possible dependency here, sorry.


Thanks,
SJ

[...]
