Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDE54D1E42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348657AbiCHRNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348643AbiCHRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:13:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FBC5F6F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646759558; x=1678295558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=05og3bG3fwVmDMyEU+pQHSfX1B6HIrys12euCU98SW0=;
  b=LB6oaz79bOvMXWUFvfFbs8nAqMDwpUm+KaXDQxxN+uXRwwWfzIlmIrPx
   5caEpXvU734LJap79kkmczSLqaQoKICRWMlP6Os81p6cPYNPh2AT2fHPI
   g0azZMiAJU/QsagPGPK3kIMifAHAIX/QE7llGiWC46x1CPWjTmKLftnJW
   tfpaANLD9+Oe+kIhueKGYMawvz9bKKm9NGC7OjSuRvqZNqimDC5ph8P15
   ZVx0wrYlew9ba1qYbBxK4dFHB7ZF6vj7489MjmER9AJgMek8nYR2yYfo5
   ++YOeRYd1CQxs5uKOFb7KROoMyEEVNZDO67Uszug5xudCtyyv4bx2haGq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253574893"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253574893"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:12:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="578060557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 09:12:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 09:12:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 09:12:33 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Tue, 8 Mar 2022 09:12:33 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/split_lock: Make life miserable for split lockers
Thread-Topic: [PATCH] x86/split_lock: Make life miserable for split lockers
Thread-Index: AQHYI52JusZbuGFIckyHL7QBBN4/aay1JM6A//+ddgCAAXbhgP//nlcg
Date:   Tue, 8 Mar 2022 17:12:33 +0000
Message-ID: <fce8ed8b5ea94cdfa265e5dca01e0c11@intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com> <877d95l7jo.ffs@tglx>
 <YialXwpbED5kAUaZ@agluck-desk3.sc.intel.com> <87mti0jxr8.ffs@tglx>
In-Reply-To: <87mti0jxr8.ffs@tglx>
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
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I still do not like the inconsistent state between the TIF flag and the
> SLD MSR.

If I'm updating the "warn" option to work this way, I think I can make the =
TIF flag
and the code that updates the MSR in context switch go away. But need to wo=
rk
though the patch to make sure I'm not missing something.

-Tony

