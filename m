Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A498D513901
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349628AbiD1Pva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiD1Pv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:51:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2F93982
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XOgwq5eoTTCPAfsOlyGMB7z+MPxPVXV6EHeT3BNE4Zg=; b=13L3/8xfYd5r7ei2jQ2e3XNKaR
        93LNWcgplTRQRfntmFheSDUHevjhCvG2wQLWO4Vf0fMQcZYYfXs6abIgZi+e+zXCpOFfRck1Lyjky
        F3XQANxUWkD4ipLofM72Oi2X4hmlt3cQ+8BleKnToAJ9HMW0/6srAQLIihIBG3bxwcTgpdF3IBls7
        b36uluoLcRXe0IqTMR6N62BxTqX4LASnHi2rMTL/ILd5+kTqno5L67DwRWsbNG6LGmQNEchUmAijY
        yQnB7Wc4pfk+PWSjoNYbBhCQjxzxg5/x+7T1WJdc8OHAAcG6730cW927P6E41k+RdYPKlBg1wT0BC
        HxI+VbhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk6NF-007j0b-4F; Thu, 28 Apr 2022 15:48:09 +0000
Date:   Thu, 28 Apr 2022 08:48:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] arm64: Cleanup ioremap() and support ioremap_prot()
Message-ID: <Ymq3OYm9tzppvHW+@infradead.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220428104612.GA14515@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428104612.GA14515@willie-the-truck>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:46:12AM +0100, Will Deacon wrote:
> That's not a massively compelling diffstat for a cleanup, in all honesty.
> I looked at generic_access_phys() to try to figure out why we would want
> that on arm64, but it seems like it's related to mmap() of devices in
> userspace. Bearing in mind that CONFIG_STRICT_DEVMEM=y by default, please
> can you justify why this is something worth doing?

While I don't care much about ioremap_prot I'd really love to eventually
convert everyone to the common ioremap code as there really is no
point in duplicating it in the architectures.
