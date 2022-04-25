Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E410A50EC52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiDYW7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiDYW7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:59:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D153A5ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650927400; x=1682463400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ED/M6gunqGqtqPcX2JL1MS5E+6aZpSysFeyzL8nmuak=;
  b=PvdRdccY7IPxitaLZ+MuaYmROhLmZvSLbgikhQ+slWeMb/hdIH10kPHC
   /t6ytJFGRZQlj99T3nyVXxfzABHK99gdVxmKmz4WuK7x6aacy8JJL6Yg8
   DKnvw+K/dCEC3C4ynF7Hk4PnZlqoO/+sgGoROpyMq3oHd3PMkczaHsaOQ
   KV2Y4F2KqeShFD7BSLgD/RXTD87+9IWFyeT1Bg24EohvlITKLSm91x/R5
   bCEdxK7JVaLYjj7kVk38g1DJ3/IiYzwAra0wvGwRqcKHMqfqEDGwEXEVZ
   4IG2ohMzDv2a4mdwT33QRz2dDVCVjJXbigamfg7BDnwGF/Ho42NsaYLJh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247314428"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="247314428"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 15:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="677530009"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2022 15:56:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 15:56:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 15:56:38 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 25 Apr 2022 15:56:38 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] topology/sysfs: Hide PPIN on systems that do not support
 it.
Thread-Topic: [PATCH] topology/sysfs: Hide PPIN on systems that do not support
 it.
Thread-Index: AQHYSgHuySQXf0KA6k2XiES1Q5bhWK0BzeAA//+NOpA=
Date:   Mon, 25 Apr 2022 22:56:38 +0000
Message-ID: <f7cb74f128e34b67999ba87a21897f70@intel.com>
References: <Yfhbj7Q99dqRIYaL@zn.tnic>
        <20220406220150.63855-1-tony.luck@intel.com>
 <20220425154616.a0e38aea35649d13d5afb5d4@linux-foundation.org>
In-Reply-To: <20220425154616.a0e38aea35649d13d5afb5d4@linux-foundation.org>
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I suggest this be fixed in the topology_ppin() stub implementation.  Do
> it as a nice inlined C function which avoids such problems.  Rather
> than as a crappy macro which causes them...

Greg already fixed this in his tree by dropping the local variable.

Fix should propagate to linux-next today.

-Tony

