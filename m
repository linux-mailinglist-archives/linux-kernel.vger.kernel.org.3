Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0656D706
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiGKHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGKHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:48:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA741A39E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657525702; x=1689061702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/S7BoLlBLWQmR+dvkC7uivZUKLbLOX2Eyfk8HcJrJSo=;
  b=FY4IZsZkM+U5lFE85C++t8Iq/64bSPVPfCsPnVmW1F7lHBrXdDKSMEpa
   yttkk7cyaYclyW2HuZ/LNrgXwk2PkCrpWGdK7RCCpXYlgh3//dkZW07vE
   3W4MdZQf1KsPFvAQQvncC7Iy+TcdHTb1odV67VWLNnDsNCSIisZsBNyCv
   JwKlub8v4qG7R16UbSrJl0auieZfxgvD2JBSbsK0MDqj/+dAR4GydKJ+K
   6+LHvP9amdrYudI4ipguCPEWaCkimAS0RYu6bzAxLdvjiB2E4LAXQawPg
   Ikekxv+nUzTR+y8dCd0WWJWOJa/+yBWXpME8Wx3StwnGmVF/jjVQkh0Hy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282150816"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="282150816"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 00:48:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="652357348"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 00:48:20 -0700
Message-ID: <edcf6946-1c47-c01a-e795-e874f42b2e2d@intel.com>
Date:   Mon, 11 Jul 2022 10:48:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] modules: Fix corruption of /proc/kallsyms
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20220701094403.3044-1-adrian.hunter@intel.com>
 <Yr9p4YOOfJp5evCq@bombadil.infradead.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Yr9p4YOOfJp5evCq@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/07/22 00:40, Luis Chamberlain wrote:
> On Fri, Jul 01, 2022 at 12:44:03PM +0300, Adrian Hunter wrote:
>> The commit 91fb02f31505 ("module: Move kallsyms support into a separate
>> file") changed from using strlcpy() to using strscpy() which created a
>> buffer overflow. That happened because:
>>  1) an incorrect value was passed as the buffer length
>>  2) strscpy() (unlike strlcpy()) may copy beyond the length of the
>>     input string when copying word-by-word.
>> The assumption was that because it was already known that the strings
>> being copied would fit in the space available, it was not necessary
>> to correctly set the buffer length.  strscpy() breaks that assumption
>> because although it will not touch bytes beyond the given buffer length
>> it may write bytes beyond the input string length when writing
>> word-by-word.
>>
>> The result of the buffer overflow is to corrupt the symbol type
>> information that follows. e.g.
>>
>>  $ sudo cat -v /proc/kallsyms | grep '\^' | head
>>  ffffffffc0615000 ^@ rfcomm_session_get  [rfcomm]
>>  ffffffffc061c060 ^@ session_list        [rfcomm]
>>  ffffffffc06150d0 ^@ rfcomm_send_frame   [rfcomm]
>>  ffffffffc0615130 ^@ rfcomm_make_uih     [rfcomm]
>>  ffffffffc07ed58d ^@ bnep_exit   [bnep]
>>  ffffffffc07ec000 ^@ bnep_rx_control     [bnep]
>>  ffffffffc07ec1a0 ^@ bnep_session        [bnep]
>>  ffffffffc07e7000 ^@ input_leds_event    [input_leds]
>>  ffffffffc07e9000 ^@ input_leds_handler  [input_leds]
>>  ffffffffc07e7010 ^@ input_leds_disconnect       [input_leds]
>>
>> Notably, the null bytes (represented above by ^@) can confuse tools.
>>
>> Fix by correcting the buffer length.
>>
>> Fixes: 91fb02f31505 ("module: Move kallsyms support into a separate file")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Queued up thanks!
> 
>   Luis

Thanks for processing this.

I notice it is -rc6 and I do not see it in Linus' tree. This is a fix
for a regression, shouldn't it be included in 5.19?
