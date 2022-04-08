Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019C4F9DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiDHT1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiDHT1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:27:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810571CCADF;
        Fri,  8 Apr 2022 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649445900; x=1680981900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QWXje4Jo7Kw+9lJyTdkR5NGVYVGitp430LMd/QOyuJA=;
  b=IS3krlXHehcXM8hdJjOHPtDN9bGh0Ocl0xhsSNgBsX74e5OAD8TX8IRV
   RlWvQyTyU9eXI4Bbj3IOdODtjC9FVm5qBPYp7SZbnZfF+dTVyGOLXCeZy
   rk4WAfamwXcNbrYpIDm8QhvPAdJH9sUiNToGkd22Bh9LQ9Yy57Oz7Ahy3
   axiZN/aNzZJu3pUkBI14CZf8/xdtF7TJmIe5WO4r0Hl0pnNGTfbuC9m/U
   PWCLK67is5zMRKu4O/5EhOnZyQXAfMXUSVZCFBUC2cJEyUGG6hnttU+C8
   bn8pmlHRolUcrB52Ti1Rj68LLOZL7n2feQnHAy0/KzQjxLYn3TkNx+URF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="348106879"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="348106879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="550625250"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2022 12:24:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 12:24:58 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Fri, 8 Apr 2022 12:24:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4] ACPI: APEI: fix missing erst record id
Thread-Topic: [PATCH v4] ACPI: APEI: fix missing erst record id
Thread-Index: AQHYSyKHiR0TBR/Q30CSA+N7POqBxqzmYapQ
Date:   Fri, 8 Apr 2022 19:24:58 +0000
Message-ID: <4208d2e15341432ba1137600b7e5b9ae@intel.com>
References: <1649406427-9357-1-git-send-email-liuxp11@chinatelecom.cn>
In-Reply-To: <1649406427-9357-1-git-send-email-liuxp11@chinatelecom.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it might be a cleaner solution if you first implement a new functio=
n:

/*
 * Like erst_read(), but look for a specific record type (by size and guid)
 * also retry -ENOENT returns by skipping to next record_id
 */
ssize_t erst_read_record(u64 *record_id, struct cper_record_header *record,
			size_t buflen, size_t recordlen, const guid_t *guid)
{
}

Step 2: Update apei_read_mce() and erst_reader() to use this function.

Step 3: Apply your erst_clear_cache() fix to the new function

-Tony
