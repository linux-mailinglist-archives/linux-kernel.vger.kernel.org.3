Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630A5930DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiHOOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiHOOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5ADA5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E91160FC4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B50C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660574246;
        bh=jfrvV04fo3CiDMoOZUz//YjuoPU5jqF0lo7fGVNmS6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A2XJYEhjb1OmKn7pmq5fKHWcm5pecKHe2CBlG5qzk6RoDqh3Myw5F2B09cZPOluD6
         qb2l2UoYFaO9d+a7SHvlhWQnJ67aQ0KZOJp3tXrb1HcxNaCX5FuxV0pRLBk1j8k14W
         oo4dvfLyJm6gq2kzWmn0Zc0pg1o03qcqsn+gl4J5uUv/k/SKtzp4Z1NrV38sRw3cl0
         TQlOytNKeQJEi4GTetQX2oVCL4dEqtk9aeUeCcg8NpGNZAFwTJp1ED0urtpeo1fcvZ
         lCv1iBK7FgX6D0vHx7SXUoc7kL6PYfnylEpSqKrLpQvAmZc5PxN2W06twH7IZx03rB
         +pzpH6BwrDw5w==
Received: by mail-ej1-f53.google.com with SMTP id i14so13845454ejg.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:37:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo1yWjJekEREDaEK+YxoE/wLF961w1XOb0XZC9APA/bugoGPPPLO
        mIrY/3sQI+Du5x2bl87ZYAv79tx3qaXJ0tsbOoA=
X-Google-Smtp-Source: AA6agR6vrzYb3TEjxTFBSU4d93P6JzjjQ1A5kVds01mTuAqZHPQ5fQf3yKdccfyDXOnTTuKnwXZBgkpmyR27++RMNwY=
X-Received: by 2002:a17:907:960f:b0:731:1e3:b198 with SMTP id
 gb15-20020a170907960f00b0073101e3b198mr10726558ejc.470.1660574245159; Mon, 15
 Aug 2022 07:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <202208140835.W6F1j6Da-lkp@intel.com> <Yvo8KUKJBlMtoNgI@casper.infradead.org>
 <CAK8P3a3Gx39P90k9ZUMdzHiNpjNn1tdvkTktQyzUqqfG+an4BA@mail.gmail.com>
 <YvpEkYMatTeNvNZa@casper.infradead.org> <CAK8P3a3=XC4ez-zeGptQb_9NtX5rVfr8Qq80eGaEckzUzjAxzg@mail.gmail.com>
In-Reply-To: <CAK8P3a3=XC4ez-zeGptQb_9NtX5rVfr8Qq80eGaEckzUzjAxzg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Aug 2022 16:37:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0TPYs2cbcx+0QGk=y8xjFrspdwnTHDxQCtsSwJmfvF6Q@mail.gmail.com>
Message-ID: <CAK8P3a0TPYs2cbcx+0QGk=y8xjFrspdwnTHDxQCtsSwJmfvF6Q@mail.gmail.com>
Subject: Re: fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds
 limit (1024) in 'ntfs_read_folio'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:48 PM Arnd Bergmann <arnd@kernel.org> wrote:

> I have no problems with a patch removing support for 256KB pages if that
> helps, as Hexagon is the only architecture to support this and there are close
> to zero Linux users anway. This would leave only three warnings for 64KB
> pages in allmodconfig:
>
> fs/mpage.c:131:20: error: stack frame size (1128) exceeds limit (1024)
> in 'do_mpage_readpage' [-Werror,-Wframe-larger-than]
> fs/mpage.c:447:12: error: stack frame size (1264) exceeds limit (1024)
> in '__mpage_writepage' [-Werror,-Wframe-larger-than]
> fs/ext4/readpage.c:223:5: error: stack frame size (1208) exceeds limit
> (1024) in 'ext4_mpage_readpages' [-Werror,-Wframe-larger-than]

I looked into these a bit more and found that these are arrays of sector_t,
which could be either 32-bit or 64-bit wide before 72deb455b5ec
("block: remove CONFIG_LBDAF"), but is now always 64-bit, so having
an array of 128 of these (65536/512) adds a 1KB to the stack and will
cause a warning. It's only slightly over the limit, and there are very few
32-bit systems that allow 64KB pages to trigger that warning.

I see now that ppc440 also supports 256KB pages and has the same
problem as hexagon, but also has been broken since the start of the
git history in this regard:

fs/mpage.c:638:1: error: the frame size of 4280 bytes is larger than
2048 bytes [-Werror=frame-larger-than=]

I don't know if anyone strongly cares about 256KB pages on
ppc44x any more, but given this, I'm fairly sure that they are
not using block based file systems. So we could just make
CONFIG_BLOCK depend on PAGE_SIZE_LESS_THAN_256KB
globally instead of dropping 256KB pages everywhere.

        Arnd
