Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9C7560478
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiF2PZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiF2PZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:25:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF9C2C13C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656516317; x=1688052317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gp6YtP/tV7OzkJtukww4PZaDDGHVNrVauB6vl/EWvMk=;
  b=SI1bruEJE2UQpa/fkXQSqNY5PTHLsKXvLs//hB55Z+YL/b75UHn0IXAP
   YhFzXsKsjD7yn3J+wYSqChJgSoW6qxkiBJ3mqoSdrYyJsKTsAy6zPYSzG
   7zJxJYbzlvvApdnSsBiRd3yxCN2g+v8/H2sMbyp+LGftKd1j0i+OjBlQt
   C4OlNApKktVS8Cm1hTYVEHdAoiAxDUF8cDSMUjDSdVGk9gDEltve3+gQ6
   lX1ZStEt5f6W3C5Q6AoIHtXNwRuGL/cxrG3L9oooL46/5bcMAa9HV1WLV
   HyX6fa1pQswNq0l50OunIzxmrvLDFXzCniSn+yRVAuUFV/E0ccCzGYJid
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="261857934"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="261857934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:25:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="693618747"
Received: from djschink-mobl1.amr.corp.intel.com (HELO [10.212.161.74]) ([10.212.161.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:25:16 -0700
Message-ID: <774e5f81-62e3-79e3-4910-39743c4399e0@intel.com>
Date:   Wed, 29 Jun 2022 08:24:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [REGRESSION] Unable to unlock encrypted disk starting with kernel
 5.19-rc1+
Content-Language: en-US
To:     Alexandre Messier <alex@me.ssier.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Andrew.Cooper3@citrix.com,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev
References: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
 <YrrHwxtD2dpts7PF@zn.tnic>
 <19f8897b-c445-4e66-49b2-9ceca738a263@me.ssier.org> <874k04e6o4.ffs@tglx>
 <a63bba3a-583b-603a-0a4b-2b329b6af1e6@me.ssier.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <a63bba3a-583b-603a-0a4b-2b329b6af1e6@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 16:24, Alexandre Messier wrote:
> Sorry again for the trouble, this was not a kernel regression, but my error.

Been there, done that!  I'm just glad we don't have anything to fix. :)
