Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED204B8E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiBPQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:41:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiBPQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:41:18 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395582B0B0C;
        Wed, 16 Feb 2022 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645029655; x=1676565655;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDe6dEvQCoXRBTDoeOjGnIbZQc7xY+qSLseMg1KqhcQ=;
  b=JkJ+nrsvHqxQ4wsXpubKMgg78X8j0PidZMgdXsEyFksrhg1wDfAWhcj0
   s/SrP0khT0ewnyUgly6UVYOTxZ/DBFZH7A2d6jv+jOemlKLW2O0ImepjJ
   qB2fK0TKwVv9exrFOV1iOU/1EnpzMwgf7GoPnl+natGwWFcfvVrojOyNN
   IhvNDnckmdhOgOw/A6UfD3/BfQA58n0sDyW6DuGqUN/KNEJhLa2yz56K9
   F6Cmge7WOaZdnELE8RaKquM13Xzca3Q4At2qhekEcEmRndM5sKzhkGg80
   W3flc9a5TVKhCVw2Sry7THXzAohwqFRYj1/tEN6dpLBI8OKO3ajKYdE3B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311409603"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="311409603"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 08:40:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="633744605"
Received: from ddahlenx-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.148.13])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 08:40:53 -0800
Message-ID: <0be77e01c0dc91e227fcb7219cf89d9497b4be39.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/4] tools/lib/thermal: Add a thermal library
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 16 Feb 2022 08:40:52 -0800
In-Reply-To: <20220214210446.255780-1-daniel.lezcano@linaro.org>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 22:04 +0100, Daniel Lezcano wrote:
> The thermal framework implements a netlink notification mechanism to
> be used by the userspace to have a thermal configuration discovery,
> trip point changes or violation, cooling device changes
> notifications,
> etc...
> 
> This library provides a level of abstraction for the thermal netlink
> notification allowing the userspace to connect to the notification
> mechanism more easily. The library is callback oriented.
> 
Some minor comments.
May be better use some defines instead of returning "-1" for error
conditions.
> 

[...]

> +struct thermal_zone *thermal_zone_find_by_name(struct thermal_zone
> *tz,
> +                                              const char *name)
> +{
> +       int i;
> +
> +       if (!name)
> +               return NULL;
> +       
> +       for (i = 0; tz[i].id != -1; i++) {
> +               if (!strcmp(tz[i].name, name))
strncmp

> +                       return &tz[i];
> +       }
> +
> +       return NULL;
> +}
> +
> 

[...]

> diff --git a/tools/lib/thermal/thermal_nl.h
> b/tools/lib/thermal/thermal_nl.h
> new file mode 100644
> index 000000000000..54dbbad58349
> --- /dev/null
> +++ b/tools/lib/thermal/thermal_nl.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: LGPL-2.1+ */
> +/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano
> <daniel.lezcano@linaro.org> */
> +#ifndef __THERMAL_H
> +#define __THERMAL_H
__THERMAL_NL_H


> 
[...]

> +/*
> + * Low level netlink
> + */
> +extern int nl_subscribe_thermal(struct nl_sock *nl_sock, struct
> nl_cb *nl_cb,
> +                               const char *group);
> +
To complete API, don't we need nl_unsubscribe which calls
nl_socket_drop_memberships()?


Thanks,
Srinivas
