Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794465445FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiFIIer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiFIIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:34:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA21DE2F1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97D16B82C58
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57F6C34114
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:34:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oS5vlGJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654763664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fT4kfHBd0/oRv2uFCKoqenVhcKchfeKcVMd89ZZ/UXk=;
        b=oS5vlGJcnsJeIcskWfzosweRKFkVlmspV4/ddozWtEzmxCJVCBcGuGPBxNJCJMybGGyYSA
        OEgAmfNGJpK9pgkeLYvMVWw4PcQo7zkBNrhIVTKlFs189n8270LLPzwv91b2Tq5uE/Y5aX
        R7DQZbE98rrydpJxsRFCiHgwldW8o4g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6e9930e9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 9 Jun 2022 08:34:24 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id w2so40573280ybi.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:34:23 -0700 (PDT)
X-Gm-Message-State: AOAM530RijgUDqyjsqT7iIPcCdebkH7mL1iHgmV3Z3pQ37xgIO053d8c
        1DjSaK0gwRXdHZzijOCl0itjDc7fVGh3vXTcnik=
X-Google-Smtp-Source: ABdhPJz3a/TKVZt91DBhUMtZf39JYzLb6AW4mDoaRwyNprXq2pSTTWw2Z7U+Bg3Vly+mCd2t2kb2i1Ht7bFjR931Z2s=
X-Received: by 2002:a25:bf85:0:b0:64a:422c:24e7 with SMTP id
 l5-20020a25bf85000000b0064a422c24e7mr38705591ybk.637.1654763662531; Thu, 09
 Jun 2022 01:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
In-Reply-To: <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 9 Jun 2022 10:34:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
Message-ID: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
To:     monish.kumar.r@intel.com
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, alan.adamson@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, axboe@fb.com,
        Christoph Hellwig <hch@lst.de>, abhijeet.rao@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

Figured it out. 2.3 seconds to be exact... It looks like this is caused by:

bc360b0b1611 ("nvme-pci: add quirks for Samsung X5 SSDs")
https://lore.kernel.org/all/20220316075449.18906-1-monish.kumar.r@intel.com/

This commit doesn't have any justification and got applied without
much discussion. Perhaps Monish could supply some more info about why
this is needed here? FTR, I have no issues on my system when reverting
that. Perhaps it should be reverted. (I can send a revert commit for
that if necessary.)

Looking further, however, the PCIe ID is said to be for a "Samsung
X5", which Google says is a portable thunderbolt drive. Is the PCIe ID
correct? On my system, this is the PCIe ID of a Samsung 970 EVO Plus.
Is it possible that Monish copied and pasted the wrong PCIe ID? Or has
Samsung *reused* the same PCIe ID on both devices? In which case, we'd
need some additional data for that quirk to avoid the delay.

Also note that this (potentially errant) commit has been backported to stable.

Jason
