Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349AE590750
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiHKUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiHKUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:21:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B174792D1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660249312; x=1691785312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/XeiRXvUCHCPWsD0FI4/ffQgvpcDN9GSEpMz6xgQk8g=;
  b=AvtPAoIMREvY+7IHWjnkqO8pKetVav/TSpvVZ2p6B962bw/iyHeZS0lU
   n8aexZcEO4yOl+fHm88ig94vO5YO6uiof5ZmTFRfGM0k2v4ShbYdp7/65
   Yogl3T+1wFJ9zcmSeKj+8npSp+UE0n20ujexpuMlKmWiEIyS6d2hO/t/C
   wPBEr7pAYwDJWWIZ6Cn7rZFDCRbr0Yp4p9Dz+hvAYrF7PmgVZ9k+6Fznx
   YX35vZ9eJjAw2DcF2c/AtjDT3n7r2b8KBKSZK+lg80DHuvVTimBl7rVtn
   50p3iaNw/fOqcoz6P6JaSKvqoa+/gzzzhvjphtkzroWv8sPmDp7OqeqP2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="289021322"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="289021322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:21:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="665534389"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.249.41.154]) ([10.249.41.154])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:21:49 -0700
Message-ID: <4a44b08c-ff30-3236-9e3e-775e4905561a@linux.intel.com>
Date:   Thu, 11 Aug 2022 22:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@intel.com, acme@redhat.com, namhyung@kernel.org,
        irogers@google.com
References: <20220810210656.2799243-1-eranian@google.com>
 <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
 <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com>
 <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
 <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/2022 5:33 PM, Stephane Eranian wrote:
>
> In fact, I don't see a case where you would not benefit from the branch type.
> Furthermore, not having the branch type DOES NOT save any space in the
> branch record (given we have a reserved field). So I think I prefer not having
> to specify yet another cmdline option to get the branch type. In fact, if you do
> not pass the option, then perf report -D reports some bogus branch types, i.e.,
> not all entries have empty types.

Perhaps Peter remember the details, but there was some ABI compatibility 
issue that motivated the extra save type bitmap.

Also there's another reason that if you don't need them and the hardware 
doesn't support it they add run time overhead because the branches need 
to be decoded in the PMI.

But I agree it would be useful to make them part of -b default, as long 
as there is some way to turn it off again when not needed. The extra 
option is kind of a pain.

-Andi

