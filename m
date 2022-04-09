Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30284FAA2C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbiDISic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiDISi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:38:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82215FC6;
        Sat,  9 Apr 2022 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649529381; x=1681065381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nwxYJAzF/LAA0DJM4O2jahEN8qOB5l2Eu97VtmdfefQ=;
  b=OZcljuFEe6sc8a9N9kCfQCdnTO5hZjEIAHgBSUw4LG8Rz2uu9pBnx7Lw
   sK01y+MhpeLNbmtOO1Et4TjBtadeDyZfM/ZOaNNFDQ2deD/89BJeTdcAP
   9HAN6KpgK71Uh2a3kJ1pRqXDGuTnsYCj/8AXLNsk43YBZxTeKaEOsbOVX
   jE1inMUfeUITIWvgm0bUtcGkAAvAA7VmKNFUrce7Gh+Rg1rd31Tu2QoMA
   8yLw9F6zYKw0JIMuHDwsqly4Vq5pQHREG3yzxnXyorTqwubJ27NGOFZkN
   pd2B0OwzXY8R5txKtvwSgvZipieT0rtHQTeZs9DGBokRrRf7h7L1EgZYU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="260714533"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="260714533"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 11:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="698755489"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2022 11:36:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Apr 2022 11:36:19 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Sat, 9 Apr 2022 11:36:19 -0700
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
Subject: RE: [PATCH v5] ACPI: APEI: fix missing erst record id
Thread-Topic: [PATCH v5] ACPI: APEI: fix missing erst record id
Thread-Index: AQHYTAyQxdgmMBplYUmGBj6YE5b9Mazn6P5g
Date:   Sat, 9 Apr 2022 18:36:17 +0000
Message-ID: <43244db2842d441a8ba9e2f6bf8bf478@intel.com>
References: <1649506891-27622-1-git-send-email-liuxp11@chinatelecom.cn>
In-Reply-To: <1649506891-27622-1-git-send-email-liuxp11@chinatelecom.cn>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> v4->v5  implement a new function for looking for a specific record
> type, suggested by Luck Tony

Looks ok to me.

Reviewed-by: Tony Luck <tony.luck@intel.com>

