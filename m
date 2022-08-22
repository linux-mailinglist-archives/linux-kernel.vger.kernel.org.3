Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE18259C075
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiHVNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiHVNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:24:56 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484172A404;
        Mon, 22 Aug 2022 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661174694; x=1692710694;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ooR8sB9GYGueiPCVBJSS4kl4I6TDSL4HppTzASXDEL0=;
  b=LpuMzXp/3DJVYPhOBUqwB1UJEuHn3W30tQFZhiZm91gEGIscqBxJRnXq
   vpodnZRLZ62qfjNZNxV1BS3vQLfkx0HK3/K7xQJWgXcEEZh5bZ8wM6KDZ
   zmzOYaf/UB0JI6nBFgLmtDTUAI3QJPu/2znEh4+zT7/q5Vgomjbt6Cly0
   o=;
X-IronPort-AV: E=Sophos;i="5.93,254,1654560000"; 
   d="scan'208";a="1046925892"
Subject: Re: [PATCH v2 13/16] hwmon: (mr75203) add thermal coefficient properties for
 Moortec PVT controller
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-f771ae83.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:24:27 +0000
Received: from EX13MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-f771ae83.us-east-1.amazon.com (Postfix) with ESMTPS id CF3E112002B;
        Mon, 22 Aug 2022 13:24:24 +0000 (UTC)
Received: from EX13D08UEB002.ant.amazon.com (10.43.60.107) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 13:24:24 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D08UEB002.ant.amazon.com (10.43.60.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 22 Aug 2022 13:24:24 +0000
Received: from [10.220.236.67] (10.220.236.67) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Mon, 22 Aug 2022 13:24:20 +0000
Message-ID: <58a79e41-4d20-0e30-cecd-4ca37dd3dbfd@amazon.com>
Date:   Mon, 22 Aug 2022 16:24:20 +0300
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
        <dwmw@amazon.co.uk>, <rtanwar@maxlinear.com>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-14-farbere@amazon.com>
 <20220818202531.GA3431466@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220818202531.GA3431466@roeck-us.net>
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

On 8/18/2022 11:25 PM, Guenter Roeck wrote:
> On Wed, Aug 17, 2022 at 05:43:18AM +0000, Eliav Farber wrote:
>> Add optional "ts-coeff-g", "ts-coeff-h", "ts-coeff-cal5" and
>> "ts-coeff-j" properties to be used instead of defaults for the
>> thermal equasion.
>>
> Vendor prefix again, and shouldn;t there be some note about the
> to-be-used defaults ?
Can you please explain why to add a vendor prefix to these properties
(and also to all other properties I added in this series)?
All the properties I added are not specific to our SOC, and any other
vendor using the same mr75203 ip block in their SOC, can also use the new
properties.

Regarding defaults, these properties are optional, so if they are absent
in device tree, the current defaults in code are used.

--
Thanks, Eliav
