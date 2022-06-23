Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3274D5576A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiFWJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiFWJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:33:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDC8655A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655976779; x=1687512779;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=/10fnuDxKEJMd2TxLq1MP7a4UvhbAzgZkhcCFlHcNzM=;
  b=dLS6LXNLiQoZvacI3WxtSnrGB0kOVaChPq2+YB7la4iY4PfYwbsfWrHm
   fILcAAFZbS3fDjxhYKARWnwohn+e3onGEmQtQJuVMw6ZVMGxCp87Uc02C
   GoWVbB0D2l3WGnwZgl9vo3PbHnjKByEcR4zUoDtu6kYZZOjjOYpKA6utA
   iZY05dNnUnwN5JrhUXpl+AqN59MTbs9GbskUr9W0oy1fCx1gWuW2cf6qF
   vruS85xt2p1VUSP3/C5UA+Th6hUxvYa3dsd2v1istz+fZHuIycNKi8sy3
   eNLQjFv39RUf5gJKp30hYYy8N6LKaGRe3l2jMMYRAsyNouMDqHUWL5Fbg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279441083"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="279441083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:32:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644653251"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:32:57 -0700
Message-ID: <bc7bf65b-046c-788f-b817-6b8694c0d110@intel.com>
Date:   Thu, 23 Jun 2022 12:32:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 0/5] perf record: Preparation for sideband injection
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220610113316.6682-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220610113316.6682-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/22 14:33, Adrian Hunter wrote:
> Hi
> 
> Here are some small patches in preparation for "sideband injection".
> 
> I hope to run perf record in a virtual machine to capture sideband events
> while simulataneously running perf record with Intel PT on the host, and
> then subsequently inject the sideband events from the guest perf.data file
> into the host perf.data file, so that decoding can decode the Intel PT
> trace for the periods when the guest is running user space (kernel space
> is already decodable).
> 
> The patches are changes I have found so far that will be needed.

Are there OK?

> 
> 
> Adrian Hunter (5):
>       perf record: Always get text_poke events with --kcore option
>       perf record: Always record id index
>       perf record: Add new option to sample identifier
>       perf record: Add finished init event
>       perf script: Add some missing event dumps
> 
>  tools/lib/perf/include/perf/event.h      |  1 +
>  tools/perf/Documentation/perf-record.txt |  3 +++
>  tools/perf/builtin-inject.c              |  1 +
>  tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++++++-----
>  tools/perf/builtin-script.c              |  6 +++++
>  tools/perf/util/event.c                  |  1 +
>  tools/perf/util/header.c                 |  3 +++
>  tools/perf/util/record.c                 |  2 +-
>  tools/perf/util/record.h                 |  1 +
>  tools/perf/util/session.c                |  4 +++
>  tools/perf/util/synthetic-events.c       |  7 +++--
>  tools/perf/util/tool.h                   |  3 ++-
>  12 files changed, 65 insertions(+), 11 deletions(-)
> 
> 
> Regards
> Adrian

