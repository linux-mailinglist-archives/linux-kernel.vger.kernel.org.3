Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5B5B034F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIGLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIGLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:41:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2D796B9;
        Wed,  7 Sep 2022 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662550867; x=1694086867;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=39OSOMlRyCa3uy7nd4l/z0VTCDqPadzfIU+GqUXnH28=;
  b=QCOAfcKQcyW9yovLjABM6j75Lnyo4sIF6czzi1DZM4mXkFzMos1nHDWc
   UAg+6YNrzzr6ii6vKy+tbdFGdGhtL+Iy3cXkmj05SP/L/kZL0MvQBJnqd
   11r3Zb7e9sfWZvgQPH1Doyzafple92UPc8G/cbeogIyhw5Hnh3VCldFxE
   hTTVsa6arHCkoWD6Qj1aKkWDmbJydXo/msNyhyLSi889USBpwNpD32GBp
   JmROPEmM13bnZdLhzYkvRBMWq/wrQf1l7k73OQ5CeYHQKCmvjBIJ5RswF
   P3FxkRsYwwf1iMqyj0D29iQsSQhew3YBJIETw656UdsyWtdHrDZd1rzDj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360795078"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="360795078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676150254"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 04:41:05 -0700
Message-ID: <5b38337c-6d39-de07-961c-e84eb05d5981@linux.intel.com>
Date:   Wed, 7 Sep 2022 14:42:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907074850.59693-1-niejianglei2021@163.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: host: xhci: Fix potential memory leak in
 xhci_alloc_stream_info()
In-Reply-To: <20220907074850.59693-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.9.2022 10.48, Jianglei Nie wrote:
> xhci_alloc_stream_info() allocates stream context array for stream_info
> ->stream_ctx_array with xhci_alloc_stream_ctx(). When some error occurs,
> stream_info->stream_ctx_array is not released, which will lead to a
> memory leak.
> 
> We can fix it by releasing the stream_info->stream_ctx_array with
> xhci_free_stream_ctx() on the error path to avoid the potential memory
> leak.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

Thanks, good to get this fixed.

Adding to for-usb-next and skipping stable as hitting this path is mostly theoretical.

-Mathias

