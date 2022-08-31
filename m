Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD85A7C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiHaL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:55:57 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE499B41;
        Wed, 31 Aug 2022 04:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661946955; x=1693482955;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ePUfUx0zpncff5AIJObPVTa9YaLGSkjcz7IFyxDJVxc=;
  b=hboJlnbjsRBVxvAz7LdZdBHXJYGASyJMG67xLYGPMh9O9vCTnpfRiv4J
   RvOzjSjXbg5deYSZB4Gi8XMRCSLxiUAB2ZczGLNG4yqtwPDGmZslZ9bq2
   K/x/bgcoRg9UOltHNbvkryxX3nBD9VHlA7vP8/FeHHp0kBC/BL5HfPOHP
   k=;
X-IronPort-AV: E=Sophos;i="5.93,277,1654560000"; 
   d="scan'208";a="1049907524"
Subject: Re: [PATCH v3 07/19] hwmon: (mr75203) enable polling for all VM channels
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:55:39 +0000
Received: from EX13D37EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 55C5481137;
        Wed, 31 Aug 2022 11:55:35 +0000 (UTC)
Received: from EX19D019EUB004.ant.amazon.com (10.252.51.91) by
 EX13D37EUB002.ant.amazon.com (10.43.166.116) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 11:55:34 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D019EUB004.ant.amazon.com (10.252.51.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 11:55:34 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 11:55:29 +0000
Message-ID: <df15cba8-a83e-73e8-d292-19af38d0b8d0@amazon.com>
Date:   Wed, 31 Aug 2022 14:55:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dkl@amazon.com>, <rahul.tanwar@linux.intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-8-farbere@amazon.com>
 <Yw9ESGq6zR3lwK+f@smile.fi.intel.com>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <Yw9ESGq6zR3lwK+f@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/31/2022 2:21 PM, Andy Shevchenko wrote:
> On Tue, Aug 30, 2022 at 07:22:00PM +0000, Eliav Farber wrote:
>> Configure ip-polling register to enable polling for all voltage monitor
>> channels.
>> This enables reading the voltage values for all inputs other than just
>> input 0.
>
> ...
>
>> +             val = GENMASK(pvt->c_num - 1, 0) | VM_CH_INIT |
>
> I believe in this case (BIT(pvt->c_num) - 1) is better, but not sure
> if c_num can be 32. 
c_num can't be 32.
I fix it in v4.

--
Thanks, Eliav
