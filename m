Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB6504AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiDRBuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiDRBuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:50:44 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270C18391
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 18:48:05 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 Apr
 2022 09:48:05 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 18 Apr
 2022 09:48:03 +0800
Message-ID: <d15b8b61-f312-c1f6-dc05-cd45bbf145bf@meizu.com>
Date:   Mon, 18 Apr 2022 09:48:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V4] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20220415062000.GP3293@kadam>
 <1650004767-27432-1-git-send-email-baihaowen@meizu.com>
 <20220415065810.GQ3293@kadam>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <20220415065810.GQ3293@kadam>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/15/22 2:58 PM, Dan Carpenter 写道:
> On Fri, Apr 15, 2022 at 02:39:27PM +0800, Haowen Bai wrote:
>> This commit message suggested by Dan Carpenter as below:
> You don't need to add this.  If you feel you must then put it below the
> --- cut off line and it will be stored on lore.kernel.org until the end
> of time.
>
>> @@ -2292,8 +2298,8 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
>>  	if (errcode) {
>>  		ieee->softmac_stats.rx_auth_rs_err++;
>>  		netdev_info(ieee->dev,
>> -			    "Authentication response status code 0x%x",
>> -			    errcode);
>> +			    "Authentication response status code %d",
>> +			    le16_to_cpu(errcode));
> The error code is not a le16.  It's just an int.  The way to prevent
> these kinds of issues in the future is to run Sparse with the endian
> checking enabled.
>
> https://lwn.net/Articles/205624/
>
> regards,
> dan carpenter
>
Dear Dan Carpenter
Got it, thank you for your professional and patience.

-- 
Haowen Bai

