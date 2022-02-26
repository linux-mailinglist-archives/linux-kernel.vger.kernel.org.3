Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97F4C546B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiBZHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBZHhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:37:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8EE1C2DBA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F5F160EC0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D0DC340F1;
        Sat, 26 Feb 2022 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645860994;
        bh=9U1dosmt2pukRAvnXabd5OeYRv7KjDE2kn+5adc7t5o=;
        h=Date:From:To:Cc:Subject:From;
        b=p87QLUBLGPPgek4FYXNS+bn8KDjo096LitA3vDCyKBy/Q+zPqT3DSxJJwEX0+Bone
         CPBjoUud+i10Jhrz5Iib/nEBt3UEsbKSyEJRKCCab9EnH4nzEfHfEbikhgYceKBri9
         OtrVyr1PeX03LA9Op4k3PQd56VU6YyAs493dqG/gqWovKlh5s1OCjEl8ZKciIMkPcR
         hZhYVlW8eI6d/f3YFGlVhOSoVdVqIjlzKkm/gEnUm0t4Ilt4EEVxpotI+81tYkojKq
         M7PtccR54m7H+wX0GWuyg26AUMJhCxMt4ppFrN0wVst5JTGZ6vZBxmNXYjjmrNDfjC
         xf80kHfhYtDxA==
Date:   Sat, 26 Feb 2022 09:36:26 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: memblock: use kfree() to release kmalloced
 memblock regions
Message-ID: <YhnYeoIbwkEy1ryt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2022-02-26

for you to fetch changes up to c94afc46cae7ad41b2ad6a99368147879f4b0e56:

  memblock: use kfree() to release kmalloced memblock regions (2022-02-20 08:45:39 +0200)

----------------------------------------------------------------
memblock: use kfree() to release kmalloced memblock regions

memblock.{reserved,memory}.regions may be allocated using kmalloc() in
memblock_double_array(). Use kfree() to release these kmalloced regions.

----------------------------------------------------------------
Miaohe Lin (1):
      memblock: use kfree() to release kmalloced memblock regions

 mm/memblock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
