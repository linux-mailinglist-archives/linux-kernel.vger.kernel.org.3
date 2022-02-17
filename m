Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142F84BA830
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiBQS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:27:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbiBQS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:26:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7B63E0;
        Thu, 17 Feb 2022 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645122397; x=1676658397;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=k332e9GjAKrmUyxR7c5L2ox5oku2avcOBT6oCrMU0Co=;
  b=GvhOsnK/Ji9Mg8bUR9D3sk1EJIOTe6OiCtbgkcjxGKp1SfdFo41DTBCD
   r033af0M4xywpp2oyBwfdLdCOjZNV5TBeWCdOd8qf56ohgB5SdJbe7TyA
   JH+s7d6NzPDIEGmLF2J6gNW/Ky3SxxgE1YeeCMOA+M+JzUMcKF0FYqahE
   cNdyVnQsJgFwVPFqrCNZP7MuH2H1ZjtcYEnszwHQLL7iExEkY2b2wU9OR
   6L5adV+H6586MJeYeEi7VWs4/YHqRCxLmmoo4cY3P4VRjcDf72xGDm2C1
   cuPUZ9t65SOrc/LuplbeM45GTwL/mfClWBWGsBkR3SnNcNoP4tpWp0u6u
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="230905265"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="230905265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:26:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="530420110"
Received: from drichard-mobl2.amr.corp.intel.com (HELO [10.209.21.238]) ([10.209.21.238])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:26:36 -0800
Message-ID: <cec52989-04b0-5d5f-06ef-334abec10d14@intel.com>
Date:   Thu, 17 Feb 2022 10:26:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com>
 <91fd3b35-b791-af37-6663-9c37055f339e@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3] x86/sgx: Add poison handling to reclaimer
In-Reply-To: <91fd3b35-b791-af37-6663-9c37055f339e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 16:25, Reinette Chatre wrote:
>> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark free pages")
>> Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and free pages")
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Could you please consider this fix for inclusion?

Thanks for the reminder.  It's merged here:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=e5733d8c89c3b5
