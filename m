Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22799468814
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhLDWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhLDWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:30:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8EC061751;
        Sat,  4 Dec 2021 14:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E78B3B80D14;
        Sat,  4 Dec 2021 22:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE4EC341C0;
        Sat,  4 Dec 2021 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638656843;
        bh=U2jHqPN74XnPBal++8zreKkt4ASv3x+oh3bBY2NsWFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jo+24WchSW9zmxTdu+yoZwb9TT5VGQKEXr9Hue0i6PiiWeOc1V1f5IjcZFm+q0FvR
         aloJrxXHvO9udrhZIMOSjztWeY45CLTf/rvz4j+75n9vpMEOX4yHsgwqIuokUHet4J
         hiuLmSkcedxAnvvye0q5dAh+GfRgNWIUZMHDeiCM4rbtk75JCgYkH5NG26hVBVa95B
         QpcmuRc5oyF4f8/j1wCiu9hJdJzivGQ4VIHQr2cOCY3Y5GKfRtTSItoxjdBtDGPVS1
         QIgluKHFjuYtY/I8V6Q27njMvD+yiL7SfVdp9TPTrhRKsCojg6U2lgylDGXP49eT3S
         U7sPdpPLw540w==
Date:   Sun, 5 Dec 2021 00:27:20 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/25] x86/sgx: Support VMA permissions exceeding enclave
 permissions
Message-ID: <YavrSFDJBGqe7K46@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <7e622156315c9c22c3ef84a7c0aeb01b5c001ff9.1638381245.git.reinette.chatre@intel.com>
 <Yavq83gZzvkVaDqq@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yavq83gZzvkVaDqq@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 12:25:59AM +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 01, 2021 at 11:23:01AM -0800, Reinette Chatre wrote:
> > === Summary ===
> > 
> > An SGX VMA can only be created if its permissions are the same or
> > weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
> > creation this rule continues to be enforced by the page fault handler.
> > 
> > With SGX2 the EPCM permissions of a page can change after VMA
> > creation resulting in the VMA exceeding the EPCM permissions and the
> > page fault handler incorrectly blocking access.
> > 
> > Enable the VMA's pages to remain accessible while ensuring that
> > the page table entries are installed to match the EPCM permissions
> > without exceeding the VMA perms issions.
> 
> I don't understand what the short summary means in English, and the
> commit message is way too bloated to make any conclusions. It really
> needs a rewrite.
> 
> These were the questions I could not find answer for:
> 
> 1. Why it would be by any means safe to remove a permission check?
> 2. Why not re-issuing mmap()'s is unfeasible? I.e. close existing
>    VMA's and mmap() new ones.

3. Isn't this an API/ABI break?

/Jarkko
