Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79A517268
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385739AbiEBPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385751AbiEBPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:24:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEEBA1AF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651504830; x=1683040830;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3eV2vVXH7WHHzEX7UlnYBUTcCZN92RvrzzPd/WWwpzQ=;
  b=UxnBSN9QyG/5RrrRGvMOO76SDBEOJBprRzOqswsjTr9UXBFQmmrepSPl
   DeaKUF7SqT0iStblxnkwyFFNsEtDs8h7cGsCLl3kqF4DwQra+uKrQtFQB
   PqD/7gK7j8XSqOH5PpxpVe4XHgkzUKqwK7jJ+QPWbs7975qjZlDkkp1c3
   cCUvVHrBNiolTLxD3O0uOYvgJh2VbKdhAAmsdTLvpPxe8Ate4AXVPvl3m
   FWGd3y3nDRhx1Gv+5Md0luynz5Dv4XnIG7g9IIag6ZoQ9cDoJfL36cgBo
   y4OqHjIAJAEgT+vOEi4Vkdhw6OwvQFEePHeDjha138Q2bmwkw7QtKAo/0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330227449"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330227449"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:20:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="663565365"
Received: from gsteinke-mobl.amr.corp.intel.com (HELO [10.209.165.8]) ([10.209.165.8])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:20:26 -0700
Message-ID: <c18e273b-f30c-da5c-581b-0cc4672f4481@intel.com>
Date:   Mon, 2 May 2022 08:20:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The current memory tiering interface needs to be improved to address
> several important use cases:

FWIW, I totally agree.  We knew when that code went in that the default
ordering was feeble.  There were patches to export the demotion order
and allow it to be modified from userspace, but they were jettisoned at
some point.

> Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> node.

Yeah, this would be a welcome improvement if we can get there.

> * /sys/devices/system/node/memory_tiers
> 
>   Format: node list (one tier per line, in the tier order)
> 
>   When read, list memory nodes by tiers.

Nit: this would seems to violate the one-value-per-file sysfs guideline.
 It can be fixed by making tiers actual objects, which would have some
other nice benefits too.
