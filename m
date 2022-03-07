Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB04D0A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbiCGWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiCGWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:05:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3741042EDE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB126B81729
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D62BC340F4;
        Mon,  7 Mar 2022 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690653;
        bh=tHzv3jXO/6WBy7nP3aIzA2cZjv9B8tpQxuj2TUQdmLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8OoRzp4f0iPxFf6cm65htHnUT4HipPAgoKJr596kXYRr3tyJQonSF7NY/BY8occ1
         XREVLo81Z0rHwht20zE4NO9kXuvvOs1PoHQDM8lwP1TFIn6NzIVLr28fQJ/U/5NYs4
         JhD5z7THsdptDiRzwc79pQh1dB5RntXhWFIMy2xm1Mo240mTQE69msoQQYUuloQams
         Z2EcNSmGBUTj3belAl62BneBSyOGG8TINYXblE9gMOzOKpwLQhQe5WZhXN0JgTMMWp
         JyjCh29AO97eeDDEGJmG2YZgrO0alSb715c6X45MNti5mK1f/iEyb0dUO4dw7bhnN6
         ooILn0O4zOq7Q==
From:   Will Deacon <will@kernel.org>
To:     mike.kravetz@oracle.com, osalvador@suse.de, rientjes@google.com,
        mark.rutland@arm.com, Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, james.morse@arm.com,
        bodeddub@amazon.com, david@redhat.com, catalin.marinas@arm.com,
        song.bao.hua@hisilicon.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        smuchun@gmail.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, fam.zheng@bytedance.com
Subject: Re: [PATCH v2 RESEND 1/2] arm64: avoid flushing icache multiple times on contiguous HugeTLB
Date:   Mon,  7 Mar 2022 22:03:36 +0000
Message-Id: <164668935493.3276132.12110588269320094587.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220302084624.33340-1-songmuchun@bytedance.com>
References: <20220302084624.33340-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 16:46:23 +0800, Muchun Song wrote:
> When a contiguous HugeTLB page is mapped, set_pte_at() will be called
> CONT_PTES/CONT_PMDS times.  Therefore, __sync_icache_dcache() will
> flush cache multiple times if the page is executable (to ensure
> the I-D cache coherency).  However, the first flushing cache already
> covers subsequent cache flush operations.  So only flusing cache
> for the head page if it is a HugeTLB page to avoid redundant cache
> flushing.  In the next patch, it is also depends on this change
> since the tail vmemmap pages of HugeTLB is mapped with read-only
> meanning only head page struct can be modified.
> 
> [...]

Applied first patch only to arm64 (for-next/mm), thanks!

[1/2] arm64: avoid flushing icache multiple times on contiguous HugeTLB
      https://git.kernel.org/arm64/c/cf5a501d985b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
