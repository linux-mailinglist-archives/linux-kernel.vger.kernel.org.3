Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A8E486D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiAFXSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:18:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:31224 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234795AbiAFXSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641511089; x=1673047089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Mc4tzycr6jWlFZQz8raP5gr2J8yzJdF9QaVRrJdufA=;
  b=V5/6+uDH8H9QmsXTYDW62aKXr1OsJ3WFQ8haA3w6fjKcwhknsEDPk0m3
   J8VowWG5CwGtd+7N3y4LcU6I0lrN9KkSW9FkRdUxhVNeX7Lv2e6H0YMhA
   mfjLCxVT4ZZN0Zegi3fgsbbLfx0uQHnCykUfzRg4HV2GAqVpjC7ksDdSS
   IyNNKjAKP3j80KoUvm7+uTIhNWNtjJhStSj4TS/vv1Wns81+885o1NqJI
   8a8v6A4QAVaHQ/lz620H22fGePpUDeuomcfAJJwzTe4m9Oju2WZ0edypp
   JN27iWQFmntMzHJzTgJneS1IlgMiR5sAmjHubr7hPxtMxQ/HLFFlDuIx+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240312483"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="240312483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:18:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471101272"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.11.235]) ([10.212.11.235])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:18:07 -0800
Message-ID: <4cda2676-eee2-bc41-5030-14d05c6e8224@intel.com>
Date:   Thu, 6 Jan 2022 16:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <20211214172437.1552740-1-broonie@kernel.org>
 <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
 <36975790-c9f8-a6f6-cbc2-493da4bdd8c1@intel.com>
 <20220105100407.69b16fe2@canb.auug.org.au> <YdVGmkzgUmvPDmlE@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YdVGmkzgUmvPDmlE@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2022 12:19 AM, Vinod Koul wrote:
> On 05-01-22, 10:04, Stephen Rothwell wrote:
>> Hi Dave,
>>
>> On Tue, 4 Jan 2022 14:41:00 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
>>>>>    +       */
>>>>>    +      list_for_each_entry_safe(d, t, &flist, list) {
>>>>>    +              list_del_init(&d->list);
>>>>> -               complete_desc(d, IDXD_COMPLETE_NORMAL);
>>>>> ++              idxd_dma_complete_txd(d, IDXD_COMPLETE_NORMAL, false);
>>>> Is "false" correct here?
>>> Hi Geert, took a closer look today. I believe it should be 'true'
>>> here since this is a normal completion that needs to release the
>>> descriptors. Sorry about the previous incorrect response.
>> I have updated my resolution from today.  Thanks for the feedback.
> I have merged fixes into next as well, so this should not be required
> tomorrow.
>
> Dave pls test..
Tested. Looks good. Thanks.
