Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B05A542E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiH2SrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiH2Sq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:46:58 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A407F248;
        Mon, 29 Aug 2022 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661798818; x=1693334818;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=kWXrMWoxMKnXgpeIogynQ/syzVdwWbA9O/ME+kKgv98=;
  b=i5bTBg1S4Y5C/VbztFAotyDSUIlnihntbNL+EUHF9yjReDygrENLj9+T
   OMpqOt0nZfkHSWXYG3YISJHVPF+vdebsx+xb6miL4DcNPXR+ryFPDqBj/
   gMTOKwEj7s/t7h5PnQAW83+h+x5zYs7QV0CXR5do4XWE3Nxt4Rt8riwJj
   I=;
X-IronPort-AV: E=Sophos;i="5.93,273,1654560000"; 
   d="scan'208";a="221791250"
Subject: Re: [PATCH v2 13/16] hwmon: (mr75203) add thermal coefficient properties for
 Moortec PVT controller
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:46:44 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com (Postfix) with ESMTPS id C59E1C08ED;
        Mon, 29 Aug 2022 18:46:40 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 29 Aug 2022 18:46:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Mon, 29 Aug 2022 18:46:40 +0000
Received: from [192.168.93.244] (10.85.143.174) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Mon, 29 Aug 2022 18:46:33 +0000
Message-ID: <ae479eb4-5367-b688-4084-6bf2ded90a5f@amazon.com>
Date:   Mon, 29 Aug 2022 21:46:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
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
 <20220817054321.6519-14-farbere@amazon.com>
 <20220818202531.GA3431466@roeck-us.net>
 <58a79e41-4d20-0e30-cecd-4ca37dd3dbfd@amazon.com>
 <20220822162519.GC4098765@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220822162519.GC4098765@roeck-us.net>
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

On 8/22/2022 7:25 PM, Guenter Roeck wrote:
> On Mon, Aug 22, 2022 at 04:24:20PM +0300, Farber, Eliav wrote:
>> On 8/18/2022 11:25 PM, Guenter Roeck wrote:
>> > On Wed, Aug 17, 2022 at 05:43:18AM +0000, Eliav Farber wrote:
>> > > Add optional "ts-coeff-g", "ts-coeff-h", "ts-coeff-cal5" and
>> > > "ts-coeff-j" properties to be used instead of defaults for the
>> > > thermal equasion.
>> > >
>> > Vendor prefix again, and shouldn;t there be some note about the
>> > to-be-used defaults ?
>> Can you please explain why to add a vendor prefix to these properties
>> (and also to all other properties I added in this series)?
>> All the properties I added are not specific to our SOC, and any other
>> vendor using the same mr75203 ip block in their SOC, can also use the 
>> new
>> properties.
>
> To me it seems that the properties are very mr75203 and thus vendor
> specific.
>
> However, I am not a DT maintainer. Stepping back to let DT maintainers
> respond and state their preferences.

I added "moortec" prefix to all the new properties I added in this
series.
Will be part of v3.

--
Thanks, Eliav

