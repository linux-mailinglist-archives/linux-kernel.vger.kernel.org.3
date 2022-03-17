Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD034DCB65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiCQQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiCQQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:29:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681D114DC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647534465; x=1679070465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jgqA4epx8T6t7aXhyfOU+Wo7m6KRfTHcYD7JaGjzZ14=;
  b=OpbHoupt3VfSKYe1kHs8+N6dvgJEcA8qoOK2W9yfrwfYABWvcrlFrJJ2
   3PJWTS/1LhcgP2T0oH8klqgnAKquBGWom+sKUrBEH2ffS1QkIdDEY4NW7
   ku3ikzbW9b1KHdQ/n2vMz5ZXr9lpcyFYEaDtyNBRSsLNyIdB7oNc/T51t
   zN467VSzEVQiQRvIDtXZMeEGujIDss1J6CLSGMimER8JAlEtthzWd/7xE
   AO+5tgl7wcU2zV+Fb75jyCrQsEZasplwgS5PjQOb3XlGnUwFfFbmR3qvK
   ESZ9IUGx4SoGRKgYB2bB8189uEAoyyLsRlGmQLQzZeyVEmtzx2hXosrn4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="320119613"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="320119613"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 09:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="498888450"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 09:27:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:27:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:27:42 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Thu, 17 Mar 2022 09:27:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Pavel Machek <pavel@denx.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Thread-Topic: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Thread-Index: AQHYNMBHgmgs1nbay0qYe8hPygXs9azD68qA///go9A=
Date:   Thu, 17 Mar 2022 16:27:41 +0000
Message-ID: <532e45aad7c64349b52217bc548edaca@intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
 <20220310204854.31752-2-tony.luck@intel.com> <20220317111305.GB2237@amd>
In-Reply-To: <20220317111305.GB2237@amd>
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
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

> I'm not sure what split locks are, and if you want applications to
> stop doing that maybe documentation would help.

See existing Documentation/x86/buslock.rst

> Anyway, you can't really introduce regressions to userspace to "get
> stuff fixed" in applications.

Applications can inflict pain on the system with atomic operations
on unaligned operands that cross cache line boundaries. This
is just pushing some pain back to the applications.

An alternate title for this patch series could have been:

	"Split-locks: The OS strikes back"

Note that there are few applications that actually split locks.
Normal compiler alignment rules generally avoid them.
Applications that run on non-x86 architectures have to
avoid them because few others allow atomic operations
on unaligned operands.

-Tony
