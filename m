Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64F24AEB08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiBIHaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBIHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:30:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E57C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09565B81F16
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA90C340E7;
        Wed,  9 Feb 2022 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644391819;
        bh=RXiGHfQUfMek72sc59qczlVrxf0dk4OSwG3q/IG71Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdEBxd+8pVtQF637wjQxd60R9OhkV54fjWDkcCpX+dc89WHuWTFOqS54GH1NJ2VLr
         P3cIkSzymv0FP0LuZenf+WaZwdDRSYsSgrSYSkOZtdTDEyZfwvXL5x1lUWqrnOegyF
         +DlcdKMRbha3KJLOEu4Ki2LNL9YOOmuKLLnb2Mil9gn571DDx9bFOET1Hhtd/q06dk
         Ii9T0hC4luctD3upyI5fVQNouyE5o2Bmza5h0xWB1DZvj6nvAuCrlfhdxN0hTdfQSt
         jhJwFdAt39XcjWREh37ZC4ETNNwjYid9TDJX9JS2nQDy1ZWgu01Sb5PXjLsJ7exmer
         LeWjI05R+wS3w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 00/16] Introduce memblock simulator
Date:   Wed,  9 Feb 2022 09:30:13 +0200
Message-Id: <164439164219.933239.11298672957013820702.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 2 Feb 2022 12:02:59 +0100, Karolina Drobnik wrote:
> Memblock is a boot time memory allocator, which allows managing memory
> regions before the actual memory management is initialized. Because it is
> used so early during the booting process, testing and debugging it is
> difficult. As memblock has few kernel dependencies, it is possible to
> simulate its runtime behaviour in userspace after stubbing a couple of
> structs and functions.
> 
> [...]

Applied, thanks!

[01/16] tools: Move gfp.h and slab.h from radix-tree to lib
        commit: 5a198c3f9b0bf67ede95c1c065b8584b55f3f87a
[02/16] tools/include: Add phys_addr_t to types.h
        commit: 4c12918f1086a824082a95f633f501c20ced63a4
[03/16] tools/include: Add _RET_IP_ and math definitions to kernel.h
        commit: 826c23e10ee43cc2e65203403e4b606de6388a1f
[04/16] tools/include: Update atomic definitions
        commit: 24af9a87ae817400feca949dd4bc94b5779e7481
[05/16] tools/include: Add mm.h file
        commit: bad5c52beb213369fa218c88bf2a84e36cf099d9
[06/16] tools/include: Add cache.h stub
        commit: f181e1e4009b5a4d52ac7a0870bfa4cb608da71d
[07/16] tools/include: Add io.h stub
        commit: e4e9850709f98c6880e289dd6c364ef08a856dea
[08/16] tools/include: Add pfn.h stub
        commit: e97362caf658718a63ff08fd557299c583b1f953
[09/16] tools/include: Add debugfs.h stub
        commit: ab1f3ebd520caae193725043c70f5762f197241f
[10/16] memblock tests: Add skeleton of the memblock simulator
        commit: 46ad27eef5220e3cda0fe263e8a9f785896f7aec
[11/16] memblock tests: Add memblock reset function
        commit: d047055e609e23190c4d46899816dc32a6cc297b
[12/16] memblock tests: Add memblock_add tests
        commit: c294f4708f0116a0e5a9695a471a0cafd05d2899
[13/16] memblock tests: Add memblock_reserve tests
        commit: 7ee605ba936534c001c2b4b0b6f5f925d86fef6b
[14/16] memblock tests: Add memblock_remove tests
        commit: ed7b7402f9c9f37fd29267ee3c9a6a3eca8871c0
[15/16] memblock tests: Add memblock_add_node test
        commit: be95b2fb44340a00065f3153d75ab6c797c23740
[16/16] memblock tests: Add memblock_free tests
        commit: 5b3408a4e5ff7609cc5b06da255b973ca0ab66d1

Best regards,
-- 
Sincerely yours,
Mike.

