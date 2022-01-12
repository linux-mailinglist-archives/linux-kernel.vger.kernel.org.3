Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56048C7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349695AbiALQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbiALQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:13:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F40C06173F;
        Wed, 12 Jan 2022 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G0+WM0j98iObaA9C7TB5WzjB/BZTanMfNLE+zZav7gk=; b=LvPWxY6RdYB2uGvehEABOnwH3G
        DMNa1G+Bil83ZQjIqfcBE/s4+fE4tpBcq4D+5IK5nbi2PSrSHPlRVDROEFEnTNoj/zyri+yPJix6T
        8avq3mHKdyILVkSVQHS2ij59er1/AHdJOycBxXrELJesDiBxSnrWBHQ+0iZwhULiHf2lvRmZPVnOj
        49Rtaqp6pqUP2EL6gF+sbGkVVxxCTMRGs7qL8O6Nt+lZ+0zBVyuVS9y3SOIYK+vEDn4W2ndL4y5Gj
        1+LBowBq97htMc1YuQohT8FrwUub1AM51MAF/Bw4qSxcEjuNBWEca9hY7dcdeTU35bgRLjzfnu1t2
        GTXLavZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7gFC-0033rD-QY; Wed, 12 Jan 2022 16:13:02 +0000
Date:   Wed, 12 Jan 2022 08:13:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH 05/12] module: Move arch strict rwx support to a
 separate file
Message-ID: <Yd7+DnFiuklVScmI@bombadil.infradead.org>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
 <20211228213041.1356334-6-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228213041.1356334-6-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 09:30:34PM +0000, Aaron Tomlin wrote:
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index 9d593362156d..95fad95a0549 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
>  obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
>  obj-$(CONFIG_LIVEPATCH) += livepatch.o
>  obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
> +obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
> diff --git a/kernel/module/arch_strict_rwx.c b/kernel/module/arch_strict_rwx.c
> new file mode 100644
> index 000000000000..68e970671ec5
> --- /dev/null
> +++ b/kernel/module/arch_strict_rwx.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * kernel/module/arch_strict_rwx.c - module arch strict rwx

No need to repeat the name of the file, a simple:

+ * module arch strict rwx

Would do it.

Please get 0day to test your git tree as you work on it, and before
posting patches ensure they get tested by 0day, so we run into less
issues once merged into modules-next.

  Luis
