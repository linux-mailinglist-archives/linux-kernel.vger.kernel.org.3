Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421C6598D68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbiHRULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbiHRUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:10:23 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1CD476C;
        Thu, 18 Aug 2022 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660853122; x=1692389122;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=lv07QCNfWXt+ZVjahIKXTMyMvM6zNtVFv07gtD8Z56c=;
  b=rKXaUdL+MyaqZHZAZovyWNgiGk1Zh6TycoxhckDfw+GujuSa2s8VKMEA
   SQtQ6nAxhvjMjmSPVjcK/rocfBQVTce1xM5i/u8f7/dKVHI3oj2kFUKQ5
   ldJdy7GYijXmQiJHUBWRND13vgh/jgPie81DXCEzsJ2xYfoZoaHPbNQmS
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,247,1654560000"; 
   d="scan'208";a="234686975"
Subject: Re: [PATCH v2 01/16] hwmon: (mr75203) fix VM sensor allocation when "intel,
 vm-map" not defined
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 20:02:01 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com (Postfix) with ESMTPS id 412871A0029;
        Thu, 18 Aug 2022 20:01:59 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 18 Aug 2022 20:01:59 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 18 Aug 2022 20:01:58 +0000
Received: from [192.168.92.216] (10.85.143.172) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 18 Aug 2022 20:01:54 +0000
Message-ID: <4814ab5d-1e7c-996a-0c3d-226fc16752c0@amazon.com>
Date:   Thu, 18 Aug 2022 23:01:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
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
 <20220817054321.6519-2-farbere@amazon.com>
 <20220818194008.GA3118944@roeck-us.net>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220818194008.GA3118944@roeck-us.net>
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

On 8/18/2022 10:40 PM, Guenter Roeck wrote:
> "intel,vm-map" is listed as required property in moortec,mr75203.yaml.
> If it is missing, the probe function should fail.

Indeed according to moortec,mr75203.yaml "intel,vm-map" is listed as 
required
but the code indicates otherwise:

/*
  * Incase intel,vm-map property is not defined, we assume
  * incremental channel numbers.
  */

The probe function takes care in case it is missing and does not fail.
It also seems less reasonable that an Intel proprietary parameter will be
required and not optional.
So in patch 03 I fixed the moortec,mr75203.yaml documentation and 
changed it to
be optional.

--
Regards, Eliav

