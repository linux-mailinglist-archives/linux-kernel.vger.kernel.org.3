Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1DB5A75DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiHaFno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHaFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:43:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA38B9FB4;
        Tue, 30 Aug 2022 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661924621; x=1693460621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1mdUS1i9OyqA2EbAUwK9qlwiUjRO20u1IquAdBojWA=;
  b=cuw6zyNl05gqFdW1dJYJNBuPjHz0/HVTUul/urCAZYIFYQCJ3UC5Pq+c
   Tr9gCvW9s7aRUxCgAVjcvLbAz9Q/5lsiyi/3cowFOGA5exi7v4/k/+URu
   3TyO5HN6Xd7YU6FchPh7BExgu+q44GKpEKi3R/0uQFPqnyRtDPl5nU5OL
   zPeXNptJvsKdcOiEwGFt8hcm2wTst4rGBQyrs4U12Bl/qpr0hXFO2HaMV
   0dq/lKzinYsqobhi8mnC/00+TrgubTtdvYXJ5RO9IE21fMEXkpiQRym9I
   eAFJC084RDIf/MJMt4aSylpSLW0uvFShbpzUINWrZtATLxKMrwZwEknVd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="359337468"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="359337468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 22:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="645117220"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 22:43:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3F687AD; Wed, 31 Aug 2022 08:43:54 +0300 (EEST)
Date:   Wed, 31 Aug 2022 08:43:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw71GqF5x7u16yom@black.fi.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:11:54PM +0300, Andy Shevchenko wrote:
> -#define VR_MODE_DISABLED        0
> -#define VR_MODE_AUTO            BIT(0)
> -#define VR_MODE_NORMAL          BIT(1)
> -#define VR_MODE_SWITCH          BIT(2)
> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> +#define PMIC_REG_MASK		GENMASK(11, 0)
> +
> +#define VR_MODE_DISABLED        (0 << 0)
> +#define VR_MODE_AUTO            (1 << 0)
> +#define VR_MODE_NORMAL          (2 << 0)
> +#define VR_MODE_ECO             (3 << 0)
> +#define VR_MODE_SWITCH          (4 << 0)

IMHO this one is worse than what it was.

Anyway, that's just a nitpick. The other parts look good,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
