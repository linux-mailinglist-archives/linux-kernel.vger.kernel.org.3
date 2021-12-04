Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1B46885E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhLDXuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLDXuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:50:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCADC061751;
        Sat,  4 Dec 2021 15:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65438B80CF7;
        Sat,  4 Dec 2021 23:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F050C341C0;
        Sat,  4 Dec 2021 23:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638661624;
        bh=M0wBR0Go3o9++qzyhI7FWX1Nv7TxP9Qe7aCa0GyuNUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTsYctHvyq29NEkv2/pgzveHfr3c8u/2Pm6Tk4x3WKBMq80puzSvgTblfF/1ldRsH
         Ea690UdNpPHj9kunHj/exrftCPGBAbOWaPVEccfXgW9gCT0+FKytOKupDi6NOFZHoK
         PDeku0VwEZUMmyG3oBMz0fZ6NG1BiRrbD86hvFrlvx6DWEG0Ljlr5RR9hoZDR30qZc
         fmMHa3csJGj88SfY1VVb+XTwo28HXgKPVjSFRsRhhJrwQkCYmnCzMi4GMiS4k0s1/T
         WCLzxF/XM1X1PtP+pMUhK8jVZ4yUi+8iEJjR16vkSaytm7cKPrQB3QndOU+Vr+KlP/
         VkejP0TzFZilw==
Date:   Sun, 5 Dec 2021 01:47:00 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] x86/sgx: Free up EPC pages directly to support
 large page ranges
Message-ID: <Yav99E+wkPaQzH7N@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <4d3cc24f06ae75d99449f1d505cbff9ba53819a9.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3cc24f06ae75d99449f1d505cbff9ba53819a9.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:22AM -0800, Reinette Chatre wrote:
> The page reclaimer ensures availability of EPC pages across all
> enclaves. In support of this it runs independently from the individual
> enclaves in order to take locks from the different enclaves as it writes
> pages to swap.
> 
> When needing to load a page from swap an EPC page needs to be available for
> its contents to be loaded into. Loading an existing enclave page from swap
> does not reclaim EPC pages directly if none are available, instead the
> reclaimer is woken when the available EPC pages are found to be below a
> watermark.
> 
> When iterating over a large number of pages in an oversubscribed
> environment there is a race between the reclaimer woken up and EPC pages
> reclaimed fast enough for the page operations to proceed.
> 
> Instead of tuning the race between the page operations and the reclaimer
> the page operations instead makes sure that there are EPC pages available.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Why this needs to be part of this patch set?

/Jarkko
