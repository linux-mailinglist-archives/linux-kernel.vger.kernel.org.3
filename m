Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31914468828
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhLDXDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:03:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF79C061751;
        Sat,  4 Dec 2021 14:59:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4932AB80DAE;
        Sat,  4 Dec 2021 22:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13070C341C0;
        Sat,  4 Dec 2021 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638658791;
        bh=K9TuvA4++mTT+YK0B9tvMxm2MZYd3c7L6kVDOaUn7SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLrqMzZxxCduItK1ey4aM6sAxR+6IhOkRSH18+/kPGnZ/7ehsdpoJlUxYMUr+cyYB
         WpsRRhIBMYZ/LaTDmA//BfM5uo2v5gltejzHqnbyQ/TPHfXPv7MD778ec5FXPFuOc9
         P4QtcOGMAk5ZUDk5HBeU2vK13cz4FdqHrfzVXxmuUi/xE71YhBI72Bqa/+u/ABz+JQ
         OW23e5RyhNgFXeP+mzpUn4eyZDMrO80Mtvpd2vMnuq+QDLbeeaNqV72mYFFNvdrFXV
         J392FVGa1zus8d4poYnCMsauQcHViAnP4vPEKkma71H63gPfay0W5GaWqxtcUQW8oa
         20pYEJKvDXXTg==
Date:   Sun, 5 Dec 2021 00:59:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/25] x86/sgx: Move PTE zap code to separate function
Message-ID: <Yavy5JTYAkdZjnK2@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd228c90c139437bb4fcc4b7b99063bfd3eb1439.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:05AM -0800, Reinette Chatre wrote:
> The SGX reclaimer removes page table entries pointing to pages that are
> moved to swap. SGX2 enables changes to pages belonging to an initialized
> enclave, for example changing page permissions. Supporting SGX2 requires
> this ability to remove page table entries that is available in the
> SGX reclaimer code.

Missing: why SGX2 requirest this?

> Factor out the code removing page table entries to a separate function,
> fixing accuracy of comments in the process, and make it available to other
> areas within the SGX code.
> 
> Since the code will no longer be unique to the reclaimer it is relocated
> to be with the rest of the enclave code in encl.c interacting with the
> page table.

This last paragraph should be removed. It can be seen from the code change
and diffstat.

/Jarkko
