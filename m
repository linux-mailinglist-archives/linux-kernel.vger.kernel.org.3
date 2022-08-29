Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16E45A5421
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiH2Smc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiH2SmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:42:23 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A0832C2;
        Mon, 29 Aug 2022 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661798542; x=1693334542;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=XTJr3HmYry0IYzQ6gYwbM4reF5LT9fKouCMQdpXCxXE=;
  b=khEMP/ebZBUJBXAbY08HXUHq9mTr9HX5FzSWeViB9TEBaNRWgz0SVMNR
   hMcS24J39a1a15PZsHC14+XcZpMiTlmXHf1+/vJlOaHIc7BJsXHt7rcLb
   OyUU5YHcz5uNBFkPQaAFsVWlyZec6KrYuMRSQcIBx+6b2niY+Lrk7Pclp
   M=;
X-IronPort-AV: E=Sophos;i="5.93,273,1654560000"; 
   d="scan'208";a="253995778"
Subject: Re: [PATCH v2 16/16] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:42:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com (Postfix) with ESMTPS id 41E2544F43;
        Mon, 29 Aug 2022 18:42:05 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 29 Aug 2022 18:42:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Mon, 29 Aug 2022 18:42:04 +0000
Received: from [192.168.93.244] (10.85.143.174) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Mon, 29 Aug 2022 18:41:59 +0000
Message-ID: <d5ea08a4-9094-8a7a-093c-0e6459281c1d@amazon.com>
Date:   Mon, 29 Aug 2022 21:41:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
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
 <20220817054321.6519-17-farbere@amazon.com>
 <20220818231106.GA3505191@roeck-us.net>
 <75165e58-8601-1fe5-7bdb-98761a73701f@amazon.com>
 <20220822162805.GD4098765@roeck-us.net>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220822162805.GD4098765@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/2022 7:28 PM, Guenter Roeck wrote:
> There needs to be an overflow protection. I am quite sure that 0xffffffff
> would result in overflows and thus in quite random reported values. 
Added overflow protection.
Will be part of v3.

--
Thanks, Eliav
