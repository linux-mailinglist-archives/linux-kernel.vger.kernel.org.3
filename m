Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2F5A5445
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiH2S7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2S7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:59:19 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1FB7A75D;
        Mon, 29 Aug 2022 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661799559; x=1693335559;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=Z4Fdi6PwUtHcQnapaTAtmWhU3/hJH2D6O3lKYqCKvok=;
  b=cNORc9M2i68WOKYrtN5ieXmryq+EQUyTxlAUaCzjIWvurCXMpLtFpRvB
   hIFpKEMWSGWW6kclQ0NgOapcEIchigz0NOecvrg0V/ORV+hvKwt/87N4y
   BdqOoc6+6YTbvAi/QqTPv7PQ4T9jsCtcFB0BsV+nW/mk8V+MqhMh/P/bF
   E=;
X-IronPort-AV: E=Sophos;i="5.93,273,1654560000"; 
   d="scan'208";a="221794884"
Subject: Re: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients from
 device-tree
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-d9fba5dd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:59:17 +0000
Received: from EX13MTAUEE001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-d9fba5dd.us-west-2.amazon.com (Postfix) with ESMTPS id BA87E44CAC;
        Mon, 29 Aug 2022 18:59:15 +0000 (UTC)
Received: from EX13D08UEB001.ant.amazon.com (10.43.60.245) by
 EX13MTAUEE001.ant.amazon.com (10.43.62.226) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 29 Aug 2022 18:59:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D08UEB001.ant.amazon.com (10.43.60.245) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 29 Aug 2022 18:59:11 +0000
Received: from [192.168.93.244] (10.85.143.174) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Mon, 29 Aug 2022 18:59:06 +0000
Message-ID: <cf67db7e-f707-2448-4648-3cffa459355a@amazon.com>
Date:   Mon, 29 Aug 2022 21:59:05 +0300
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
 <20220817054321.6519-15-farbere@amazon.com>
 <20220818202839.GA3431511@roeck-us.net>
 <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
 <20220819113842.GD3106213@roeck-us.net>
 <20200e60-c4e2-d272-1417-005994766380@amazon.com>
 <20220822163142.GE4098765@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220822163142.GE4098765@roeck-us.net>
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

On 8/22/2022 7:31 PM, Guenter Roeck wrote:
> It should not be necessary to provide explicit default values for any 
> of the
> series. Yes, default values can be overwritten with explicit coefficient
> properties, but it should not be necessary to provide those if the 
> defaults
> are used. So I would expect separate compatible properties for each of 
> the
> supported series plus separate coefficient properties.
I added a "moortec,ts-series" so that user will not need to provide all
4 coefficients.
The values of the "moortec,ts-series" can be 5 (default) or 6.
I didn't do it as a compatible property because the the driver is for
the Moortec controller (mr75203) while series 5 or 6 are only relevant
for the thermal sensor (mr74137).

--
Thanks, Eliav
