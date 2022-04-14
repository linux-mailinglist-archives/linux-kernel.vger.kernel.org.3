Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D16500569
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiDNFaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiDNFaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:30:22 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14630570;
        Wed, 13 Apr 2022 22:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649914079; x=1681450079;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=2uCzEJAQZ1S/abq8qomCN1D7IBy8U0sN2Uh5wC0Cs08=;
  b=PsBHDKfX4iN1fC/a6v8N/2FnPIKvzUchfdgZkfLrNOqoGv5XoxiQeEa4
   3YJ1L18t59CglApecNTyRRLtAizCowNK9uGJ9GNkElQIcyBcHQYojU0x1
   tkTuP1y5vT+yr0rHkvK2mfgT75+Zj88bs7bgQGP26YG8/8nacH31EGP4G
   M=;
X-IronPort-AV: E=Sophos;i="5.90,258,1643673600"; 
   d="scan'208";a="210589874"
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH] watchdog: sp805: disable watchdog on
 remove
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 14 Apr 2022 05:27:44 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com (Postfix) with ESMTPS id CFB8240ED1;
        Thu, 14 Apr 2022 05:27:43 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 14 Apr 2022 05:27:37 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Thu, 14 Apr 2022 05:27:37 +0000
Received: from [192.168.18.125] (10.1.213.24) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.32 via Frontend
 Transport; Thu, 14 Apr 2022 05:27:34 +0000
Message-ID: <a92322d9-6fb8-c1d8-0397-544465e1588d@amazon.com>
Date:   Thu, 14 Apr 2022 08:27:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, <wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <dwmw@amazon.co.uk>
References: <20220403052249.48784-1-farbere@amazon.com>
 <1009cf3a-587b-307a-d1c9-efe71cd0a104@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <1009cf3a-587b-307a-d1c9-efe71cd0a104@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2022 8:41 AM, Guenter Roeck wrote:
> Why not use watchdog_stop_on_unregister() ? 

I'll use watchdog_stop_on_unregister() instead of my change.

