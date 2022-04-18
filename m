Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84311505BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbiDRPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346138AbiDRPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:52:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45901137
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650296078; x=1681832078;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=SRNvMB6bOZswif/I19QJA25IGhzgKY/S8qZnWPXx9sg=;
  b=APBLlcGgLiR7Eo8ew36AGNOWpY9TDlYouWl+s0o9NRxFr4uf/dm9SJdX
   2jt8JgutZqZgaNiaau/GIzMvk42droKvfOpciShcuoWFSLL062Hn7x7C/
   Lim5rfIwybAakXiYZQBeTCdm5pGdwW9mFpTUPOb8+8QO7ZXPt6JCMquhz
   IxZRQxY7WPyuD2MfEmyvI2jIzyLxtx5zrLbWUanNt5ekuTJSOCIbEMGi+
   pW3sYcau4V6LiKRy3hFFy6Od0XAVfb17kqL7yh2qTx4JFc3DpF4wnXfkm
   JxpLJ4ZtwGuyeI6R18lV0t7yHkCIwsa6fXiaB9AL8F1qS78Kv4nxXrSYU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263301854"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="263301854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:34:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="554276474"
Received: from cebrown-mobl.amr.corp.intel.com (HELO [10.212.18.136]) ([10.212.18.136])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:34:36 -0700
Message-ID: <c1475d8e-3ad6-cdab-5cc9-b44fef998636@intel.com>
Date:   Mon, 18 Apr 2022 08:34:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220417034932.jborenmvfbqrfhlj@offworld>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 6/6] mm/migrate: export whether or not node is toptier in
 sysf
In-Reply-To: <20220417034932.jborenmvfbqrfhlj@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/22 20:49, Davidlohr Bueso wrote:
> This allows userspace to know if the node is considered fast
> memory (with CPUs attached to it). While this can be already
> derived without a new file, this helps further encapsulate the
> concept.

What is userspace supposed to *do* with this, though?

What does "attached" mean?

Isn't it just asking for trouble to add (known) redundancy to the ABI?
It seems like a recipe for future inconsistency.
