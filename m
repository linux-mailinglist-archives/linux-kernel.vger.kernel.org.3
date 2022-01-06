Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B848672B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiAFP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiAFP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:56:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FECC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:56:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E797B82250
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFD8C36AE0;
        Thu,  6 Jan 2022 15:56:33 +0000 (UTC)
Date:   Thu, 6 Jan 2022 15:56:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YdcRLohx777jzWah@arm.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:13:06AM +0000, Jianyong Wu wrote:
> I test this patch in your way using both EDK2 V2.6 and EDK2 v2.7. it's
> peculiar that this issue shows up on v2.6 but not on v2.7.
> For now, I only find that if "CONFIG_DEBUG_LOCK_ALLOC" is enabled, the
> kernel boot will hang. However, I can't debug it by printk as this
> issue happens before pl11 is ready.

I tried earlycon but that doesn't help either.

> I will go on debugging, but very appreciated if someone can give some
> hints on it.

FWIW, passing "nokaslr" on the kernel command line makes it boot (and
this makes debugging harder). That's as far as I've gone.

-- 
Catalin
