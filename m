Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C837A591347
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiHLPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiHLPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:48:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05748A4071
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE2C8B82471
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE9C433D6;
        Fri, 12 Aug 2022 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660319323;
        bh=cvTUSPVXoJaKfemksKrV/He9kW2/6kMVns4u0Rjwb4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUYmnY7lanhhpzrJoziQyLihzTxMt1xP5p04ujfx9cyJTKP8DcRnUv3+Bak3+/Gfd
         HNHcoqnH2AYZ2+ZlCtR5LuNDF22Uq5TfeYgta0c6W56u5j8b2yHddNaFDilRT+KCVQ
         6CpsM9ZSQyDzWs27m6VDnF2ZhuoJJjhZn8tuGX4MUSQJz1emqpFfUC3mkxgXokTXBe
         j4Qv8zDzfv8vHJtWyOrkVruGH8U3Fa+Q4wzcwtwHbQP2BWMXtkPEM6gap1robX1Y8a
         4U3/01qg7xdenf+PK2QRF+msgtnwAmS1TeiO7U9MMhhwG4KANZZHCKWA3SSETVCOOI
         9ytSxCl8WKlQQ==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/core: simplify the parameter passing for region split operation
Date:   Fri, 12 Aug 2022 15:48:41 +0000
Message-Id: <20220812154841.116570-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
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

Hi Kaixu,

On Fri, 12 Aug 2022 15:41:13 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The parameter 'struct damon_target *t' is unnecessary in damon region
> split operation, so we can remove it.

Good finding.  But, 't' is used while 'ctx' is unused in
'damon_split_region_at()' and 'damon_split_regions_of'.  Below code change is
also removing 'ctx', not 't'.  Could you please update the commit message for
that?

Also, please fix the kernel test robot reported issues together:
https://lore.kernel.org/damon/202208121823.8YTRPB1J-lkp@intel.com/


Thanks,
SJ

[...]
