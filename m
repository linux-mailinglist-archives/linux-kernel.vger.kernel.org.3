Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665565528EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiFUBOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiFUBO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:14:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56822140AB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655774068; x=1687310068;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=b00p+JPCNLBqBtIBRmsVShSdYPWHF1lrMDDwHIhXKXY=;
  b=Lfi8V1zTtOGIuPz+Sk19Cmy+glMO9ZFnOkF6Ce42UC8kls8DIJl0Rqtp
   QlPh39SsPknbvm6XLxIDo/iLrQfAKDd8URqv8cZxsliJDHwFX+TdUAlbI
   rEwdIIPNbfq8XZCuTPVmlfMEcT0kaEbbznHzBX33JL+6Y0qPOQzJ9IVCx
   NClcrqh2cAbzhTD5/pMPZzmU+IhABuPb5a+p7CnMh798JuDKgABAIXbY1
   Vc6w6DBk2ncQxl7E2lmbe4a77ca3CT90dqeHFLNRne/xvxPCTGc/1nP+M
   YFF11cGnXOVr3FMMrKwF1EIhnZaj+2JF2kfVSg0pXVamSdUTmVVu8JgAf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="366322946"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="366322946"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:14:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="833333958"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:14:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of inuse_pages
References: <20220608144031.829-1-linmiaohe@huawei.com>
        <20220608144031.829-3-linmiaohe@huawei.com>
        <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
        <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
        <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
        <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com>
        <YrB6R5uHQaz1adhK@qian> <YrCCFwgoLKhDn7Fo@FVFYT0MHHV2J.usts.net>
        <YrDob8+9Xgig6mZw@qian>
Date:   Tue, 21 Jun 2022 09:14:00 +0800
In-Reply-To: <YrDob8+9Xgig6mZw@qian> (Qian Cai's message of "Mon, 20 Jun 2022
        17:36:47 -0400")
Message-ID: <87pmj2q0mf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <quic_qiancai@quicinc.com> writes:

> On Mon, Jun 20, 2022 at 10:20:07PM +0800, Muchun Song wrote:
>> The lock does not protect the read sides. So the write side should be
>> fixed by WRITTE_ONCE().
>
> https://lwn.net/Articles/816854/
>
> "Unmarked writes (aligned and up to word size) can be treated as if they had
> used WRITE_ONCE() by building with
> CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y (also selected by default).
> Experience has shown that compilers are much less likely to destructively
> optimize in-kernel writes than reads. Some developers might therefore
> choose to use READ_ONCE() but omit the corresponding WRITE_ONCE(). Other
> developers might prefer the documentation benefits and long-term peace of
> mind accruing from explicit use of WRITE_ONCE()..."

Thanks for pointing me to this great article.  So although not required
by KCSAN strictly, WRITE_ONCE() is still good for documentation, etc.
Just like we have done for swap_info_struct->highest_bit, etc.

Best Regards,
Huang, Ying
