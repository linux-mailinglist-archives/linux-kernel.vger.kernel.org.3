Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCB474598
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhLNOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:52:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56666 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhLNOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:52:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0A20B819F0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B0C34605;
        Tue, 14 Dec 2021 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639493548;
        bh=yFfkRGn3Zbbf+escEJ2y5n1s3r/WuEZMooEpjeq9CYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsnSf7GM5HtnKJuYn9dOkq5YoMNVd8W+nxOoJ/qz9iFIAa941uF9l5n/Ryc2aUCtr
         klQEkwyZ3TOQmN4iI8EvgK82iJnpzh3WppkGXUGSsurBhGIc7iPgU+Wq0KDRAEplK3
         i7fbDFveAiL1lWaKB8Z/zi84imY6ze9oEQ5nUv5DZNfnkOFHvRN1FcN4Yzb/7NQlq3
         1RGSM5K2VggUKKBmWvSXsScaPbRDxj6klDGMsYZ6HlUVKRxhWkyHtUcffWcH3pFLAg
         pXpiwhG1zinyGz4xgwG6yaTo2wbUU2yEALRQDjhvEnlQNEaWSW3pAYYSpj42tq6zQC
         PkwY9Dkj3HMvw==
Date:   Tue, 14 Dec 2021 14:52:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrew Walbran <qwandor@google.com>
Cc:     Quentin Perret <qperret@google.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 10/15] KVM: arm64: Introduce wrappers for host and hyp
 spin lock accessors
Message-ID: <20211214145222.GC14837@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-11-qperret@google.com>
 <CA+_y_2HKwtm5839QyEY9D8PaZWky_Zvn3msrw2gcR2Z7UZgObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_y_2HKwtm5839QyEY9D8PaZWky_Zvn3msrw2gcR2Z7UZgObQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 02:48:30PM +0000, Andrew Walbran wrote:
> On Wed, 1 Dec 2021 at 17:04, 'Quentin Perret' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: Will Deacon <will@kernel.org>
> >
> > In preparation for adding additional locked sections for manipulating
> > page-tables at EL2, introduce some simple wrappers around the host and
> > hypervisor locks so that it's a bit easier to read and bit more difficult
> > to take the wrong lock (or even take them in the wrong order).
> Looks good, but how does this help prevent taking locks in the wrong order?

I just found that I would easily forget what exactly was protected by
"pkvm_pgd_lock" and so relating that back to "take host before hyp" was
error-prone. Having helpers with "host" and "hyp" in the name helps me with
that, at least.

Will
