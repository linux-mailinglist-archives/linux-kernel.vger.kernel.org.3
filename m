Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF9500BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiDNLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbiDNLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:09:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BE70CDD;
        Thu, 14 Apr 2022 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649934404; x=1681470404;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpK5uTsGwurYPm1EZSv9KDNdr4wZT3Uq8fQlImPzuTw=;
  b=nvyu91bkMdkz1y/WeyNHHECE9DuSUMZzQsCVTbKVzs83LGt03xqJqULY
   aYNKexW8d9DtoRIDnqjqytMwibliM6f8VDAw6CnUIi5tAfC/fjHZVPCXK
   O9utWiTf+DsnXDqTpOqanVKaQc4qCDn9wK0Spn3IbZVam7yjp418fdIIp
   B5mKOentbRtjyTDkO4OeUkArflvVFyUmh2YCcdkLp3O91utRNTFPBjgYP
   ETQFzq4/TZssJsU7kgG7p9SivYvHeridRFdxvnn8+EAYDRcmEtF/j3kY6
   UuSCZ7wtmiJz4bSzIkQX4OO1eqXuM/zyl5WtSp3TSbj5gYgHdGnZJ3zNk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="287960501"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="287960501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 04:06:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="573750098"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.213.16.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 04:06:41 -0700
Date:   Thu, 14 Apr 2022 13:06:36 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     "NeilBrown" <neilb@suse.de>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH/RFC] md: remove media-change code
Message-ID: <20220414130636.00002eca@linux.intel.com>
In-Reply-To: <164991636542.11576.2282590308338864748@noble.neil.brown.name>
References: <164991636542.11576.2282590308338864748@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 16:06:05 +1000
"NeilBrown" <neilb@suse.de> wrote:

> md only ever used the media-change interfaces to trigger a partition
> rescan once the array became active.  Normally partition scan only
> happens when the disk is first added, and with md the disk is typically
> inactive when first added.
> 
> This rescan can now be achieved by simply setting GD_NEED_PART_SCAN.
> So do that, and remove all the rescan.
> 
Hi Neil,

I experimented in this area in the past, mainly on IMSM (external
metadata). My problem is described here:
https://lore.kernel.org/linux-raid/SA0PR11MB4542ECA84F72506B39C3C9F1FFEE0@SA0PR11MB4542.namprd11.prod.outlook.com/
I lost reproduction on newer kernels, probably changes in block layer hide
issue, it seems to be time race. The change you proposed could bring the issue
back.

The current way is working, so I consider your change as potentially dangerous.
Anyway, I will help with testing if Song decides to take it.

For external metadata we should impose partition read after mdmon start (when
md device becomes RW), so it should be synchronized with mdadm.
It could break autostart functionality for native metadata (if it is still
in use).

Eventually, external metadata should be handled separately.

Thanks,
Mariusz


