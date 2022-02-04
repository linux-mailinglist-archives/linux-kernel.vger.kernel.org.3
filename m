Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D004A9D20
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbiBDQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:46:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:30509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242805AbiBDQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643993188; x=1675529188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SPur9iPTpexjKN2A+3Wta7AUMnRGZcfyrnOsoR1g6M8=;
  b=R/18HjNoe6EVT4S6iBgYg8PfLerIBWwL/I20GFXMLyTqDpFf7av9iKAa
   dBAosX+lThBNVMsKrD0LCh92fvQAX3gUghOjDEp8Kd+TTEBKsZWNIAYRj
   +QqHpNi7HXWHmWJbgf4r3J6sjzHd9wcgJm40JDwH8iCBUd0s5KwKF6LOQ
   BmxJrIUJ2d+TqCAAy//0vghqR0HQ+O2RMgn6V1XaSclSjbCADeGH7eYDq
   7nq/gMiVcF23yC2moweqrnQsVYgx02u6Jp0YJuoV22ySFCwEqKGh5hvZX
   Ein4b8C1iIN6rTfxtuNwU/2zE9fZu7vIPuryYi4+1r7htKV/Z7XJgeMs4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309143701"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="309143701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 08:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="699726836"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2022 08:46:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 08:46:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 08:46:24 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Fri, 4 Feb 2022 08:46:24 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] cpumask: Add a x86-specific cpumask_clear_cpu()
 helper
Thread-Topic: [PATCH 1/3] cpumask: Add a x86-specific cpumask_clear_cpu()
 helper
Thread-Index: AQHYGaF7T495FtuqVESOZX1uAZJ2rayDmTIQ
Date:   Fri, 4 Feb 2022 16:46:24 +0000
Message-ID: <547b5ccef6a54df49e556f596aafaa39@intel.com>
References: <20220204083015.17317-1-bp@alien8.de>
 <20220204083015.17317-2-bp@alien8.de>
In-Reply-To: <20220204083015.17317-2-bp@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, always inline two more cpumask generic helpers.
>
> allyesconfig:
>
>    text    data     bss     dec     hex filename
> 190553143       159425889       32076404        382055436       16c5b40c =
vmlinux.before
> 190551812       159424945       32076404        382053161       16c5ab29 =
vmlinux.after

That looks odd. You added "always" to some inline functions, which I'd
have thought might cause *more* inlining, and thus an increase in text
size. But it actually went *down* by 1331 bytes.

-Tony
