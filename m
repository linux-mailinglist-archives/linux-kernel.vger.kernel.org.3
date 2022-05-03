Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9814B518B67
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiECRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiECRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:50:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1427B0E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651600042; x=1683136042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sxiHAHKs3kGHAX7nEqE25i1M6VS4EbzVzl9niPw4Uv4=;
  b=TCYXAwFjhAWnieAh5FBmN7OkM7sTqpS/kbwsv4/Zh8neiMsWhZUT9VHi
   4kYO0FjWa7NmsPDs9/b3yIRH3GiitTGXFdY/bpEYPMMS3kxO1/7pZPd6J
   sJFsmWrU6NkbUsewPle5KrDr6hSATZvbZ9Is0wTcdEH3lF/tzvVu6Gv0o
   bQs6PR/ArRjo2vD1iXEXwXUI8Wpaic2qIS+RqbdvrrVwe49ZNWSyD2NmY
   Sud+kh7Lv4i+1rUD9+tqFfieTiaobaeuvNbz+o/f6xrUbjSaZY3Z5LnAJ
   McJrgtEKjBneRD6pxrwveUTqZdJ1AQGnYyeTHrcbQ92jVLGCJhYNGtx51
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267136843"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267136843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 10:47:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="536435108"
Received: from prdidome-mobl.amr.corp.intel.com (HELO [10.212.51.158]) ([10.212.51.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 10:47:01 -0700
Message-ID: <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com>
Date:   Tue, 3 May 2022 10:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld> <87o80eh65f.fsf@nvdebian.thelocal>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <87o80eh65f.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 10:14, Alistair Popple wrote:
> I would certainly be interested in figuring out how HW could provide some sort
> of heatmap to identify which pages are hot and which processing unit is using
> them. Currently for these systems users have to manually assign memory policy to
> get any reasonable performance, both to disable NUMA balancing and make sure
> memory is allocated on the right node.

Autonuma-induced page faults are a total non-starter for lots of
workloads, even ignoring GPUs.  Basically anyone who is latency
sensitive stays far, far away from autonuma.

As for improving on page faults for data collection...

*Can* hardware provide this information?  Definitely.

Have hardware vendors been motivated enough to add hardware to do this?
 Nope, not yet.

Do you know anyone that works for any hardware companies? ;)

Seriously, though.  Folks at Intel _are_ thinking about this problem.
I'm hoping we have hardware some day to help lend a hand.  The more
hardware vendors that do this, the more likely it is that we'll have
good kernel code to consume data from the hardware.
