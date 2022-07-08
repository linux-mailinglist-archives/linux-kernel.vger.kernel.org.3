Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2937356C019
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiGHRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiGHRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:06:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A66050E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657299975; x=1688835975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+ADmw6cOsgad1wiEE7DfCGuDQIqQwPGnx5VrvFmZZDU=;
  b=AF9LI4FfmSYo/fV+eCyDc8zE1/CQGgRbSqeTOTQkO74c+23R/aP7GQGi
   Osquo9jM1gk4XtnDkaiJdQ9YBBA9npRd8ImX1amizv5aKDlC+5bSDToz7
   gmc6xkjyBtPT1wWu20c68zv5aoVVCrd7SR71Tvd77No6ngf39+Ztuwj9w
   AAwqFxI0Gkcib3ezhxV22hNn8WtUtj0QLuYRih61IuoSjkKOsbf5HbP1z
   WIYJmGwg9cEHjp7FgAdCub3DPBmHLhQguA/4YsFRq3doqaR7Uxfiq/ALT
   XkOoQcesZ7aiLD3D5K7uaXDJZ14OLNFB+g+yiu3XcXGOiRjqOAnPLTT/A
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="283078441"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="283078441"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:01:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="626764382"
Received: from yyan2-mobl2.amr.corp.intel.com (HELO [10.212.242.16]) ([10.212.242.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:01:45 -0700
Message-ID: <a486ad3f-8fb6-c37b-9e7e-c6ba1a841b57@intel.com>
Date:   Fri, 8 Jul 2022 10:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220708003053.158480-1-namit@vmware.com>
 <b573a9c6-2ee0-20dc-1f28-84d3a81d40a2@redhat.com>
 <283d7660-000a-81af-1d6b-4fdedcb6dfd8@intel.com>
 <A604C6DA-5E5D-43F1-B63F-EF9D145CACCE@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <A604C6DA-5E5D-43F1-B63F-EF9D145CACCE@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22 09:54, Nadav Amit wrote:
> Since the bug was not during MADV_DONTNEED there is no reason for the
> results to be any different.
> 
> Famous last words?

Considering that your patch broke the kernel a way that surprised us
all, I think caution is warranted.  Re-running a microbenchmark that
takes five minutes and stresses things a bit is the least you can do, I
think.
