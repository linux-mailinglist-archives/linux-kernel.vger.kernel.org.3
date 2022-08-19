Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174705995E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiHSHNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbiHSHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:13:41 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D212F676;
        Fri, 19 Aug 2022 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660893221; x=1692429221;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=IbYBPJ+G32c9+JDgUOIkmcCLLurLRBV2IsJAkpWtx94=;
  b=QSWojJCmrw/0stNv1wO9Lh/IZjwLuDi9TH2zzIbybDeBd91g4Z/YpgXR
   nUGLYCgQz9bUi1MENpvJ/vT4Ha/RN/1TDtiRJG/elgCeep5fep8cfCtKC
   RdM4431bwvudZvF8LBpyc7MPg05bYcIxIUT80NevxXzp5niaMWbnzP2Tf
   o=;
X-IronPort-AV: E=Sophos;i="5.93,247,1654560000"; 
   d="scan'208";a="234849990"
Subject: Re: [PATCH v2 09/16] hwmon: (mr75203) add VM pre-scalar property for Moortec
 PVT controller
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-b09d0114.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 07:13:29 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b09d0114.us-east-1.amazon.com (Postfix) with ESMTPS id AE34781619;
        Fri, 19 Aug 2022 07:13:26 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 19 Aug 2022 07:13:26 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Fri, 19 Aug 2022 07:13:25 +0000
Received: from [192.168.95.21] (10.85.143.173) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Fri, 19 Aug 2022 07:13:20 +0000
Message-ID: <2ed7d787-f4ee-55af-5279-b13377ea0ec3@amazon.com>
Date:   Fri, 19 Aug 2022 10:13:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dwmw@amazon.co.uk>, <rtanwar@maxlinear.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-10-farbere@amazon.com>
 <20220818201138.GA3423710@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220818201138.GA3423710@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2022 11:11 PM, Guenter Roeck wrote:
> Is that how such properties are implemented ? Seems to me that
> results in a lot of decode complexity.
>
> Why not use an array property like the other properties ?

Each VM has up to 16 inputs and there might be more than one VM.
Assuming an example of 2 VMs, and channels 5 and 6 in first VM have pre-
scalar of 2, while channel 2 in the second VM has pre-scalar of 3 and
channel 11 has pre-scalar of 2, the alternative was to do something like
this:
vm-pre-scalar-0=[01 01 01 01 01 02 02 01 01 01 01 01 01 01 01 01];
vm-pre-scalar-1=[01 01 03 01 01 01 01 01 01 01 01 02 01 01 01 01];
Most of the inputs are 01, which are anyway the default.
I don't see a difference in decoding complexity between the different
approaches but if you prefer this I'll modify my patches.

