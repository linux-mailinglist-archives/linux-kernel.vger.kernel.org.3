Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC235313D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiEWPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiEWPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:04:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76455BD2D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653318265; x=1684854265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ReV047EYtCbMUXsoUg3vLWxCvg/Zeg6iwFf6J0iLBs=;
  b=gNOgm1E7GKbcShwHMRdimGfaYaE7ZfawP1DNJ1NbTQzicyU2Dr3AJFAQ
   54Y48p3V8HxIDt9gj0TLE463a/lryYmDKzBmAmqX88FUygx97fu5Rk/AY
   fPf8CF8X/AKKE9fwCEscshu9cSFFQvT5W97xtWKo5TMMSERIEdpKa0i0L
   PsxGoVj8Rp9S0U+Bvy0geV3yigZWah79Ht+RoHh1emkFMs/8uQl1NqXg9
   ZKtNspodSHLKs2IudCXxfcBF4/Ll1mmcp1V4az2cA9Oyetsqsi+nEZov2
   2mCwn5NVCODKjf0H1mlu9Cr0855nQScia1GLe2AW8ro57mNRHZ9EgNxNm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="333893027"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="333893027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:03:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="600691370"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.249.171.16]) ([10.249.171.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 08:03:51 -0700
Message-ID: <a7bbd451-e054-c69c-6e39-e73320878b8f@linux.intel.com>
Date:   Mon, 23 May 2022 23:03:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: Add support for mx66l2g45g
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
References: <20220523143002.1754922-1-jiaqing.zhao@linux.intel.com>
 <fde9bd5a-7161-9222-4719-4279b2416163@linux.intel.com>
 <35d64d702798d437245090ce96ae29a8@walle.cc>
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <35d64d702798d437245090ce96ae29a8@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-23 22:59, Michael Walle wrote:
> Am 2022-05-23 16:33, schrieb Jiaqing Zhao:
>> Use PARSE_SFDP for now as the SNOR_ID3() patch is not merged yet, will
>> switch to it after it is merged.
> 
> Fair enough, could you resubmit it with
> { "mx66l2g45g",  INFO(0xc2201c, 0, 0, 0) PARSE_SFDP },
> 
> Looks odd, but is the same as SNOR_ID3(0xc2201c), so we can just
> switch to the new macro without any more testing. Or Pratyush can
> replace it inline while committing this patch if the SNOR_ID3()
> will make it in before.

I'll add a TODO comment in case we forgot it.

> -michael
