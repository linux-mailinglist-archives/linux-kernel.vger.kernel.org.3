Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03D357D8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiGVCb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGVCbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:31:55 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [210.0.225.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A25B781;
        Thu, 21 Jul 2022 19:31:53 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 22 Jul
 2022 10:31:26 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 22 Jul
 2022 10:31:25 +0800
Message-ID: <d9ce5dbb-0ca0-b2b3-ad8d-9fbf0c2ed39e@zhaoxin.com>
Date:   Fri, 22 Jul 2022 10:31:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <kishon@ti.com>,
        <dianders@chromium.org>, <s.shtylyov@omp.ru>, <mka@chromium.org>,
        <ming.lei@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>
References: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
 <YtlZn74MDEj+1On9@rowland.harvard.edu>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <YtlZn74MDEj+1On9@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/21 21:50, Alan Stern wrote:
> On Thu, Jul 21, 2022 at 02:08:33PM +0800, Weitao Wang wrote:
>> Usb core introduce the mechanism of giveback of URB in tasklet context to
>> reduce hardware interrupt handling time. On some test situation(such as
>> FIO with 4KB block size), when tasklet callback function called to
>> giveback URB, interrupt handler add URB node to the bh->head list also.
>> If check bh->head list again after finish all URB giveback of local_list,
>> then it may introduce a "dynamic balance" between giveback URB and add URB
>> to bh->head list. This tasklet callback function may not exit for a long
>> time, which will cause other tasklet function calls to be delayed. Some
>> real-time applications(such as KB and Mouse) will see noticeable lag.
>>
>> Fix this issue by taking new URBs giveback in next tasklet function call.
> 
> The patch also replaces the local high_prio_bh variable with a new
> bh->high_prio structure member.  This should be mentioned in the patch
> description.
> 
> Alan Stern
> .
Okay,I will take your suggestion and submit a revised version.

Thanks
weitao
