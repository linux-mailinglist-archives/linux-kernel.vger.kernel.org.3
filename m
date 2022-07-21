Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAE57C6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiGUIwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiGUIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:52:44 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [210.0.225.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650B77E836;
        Thu, 21 Jul 2022 01:52:41 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Jul
 2022 16:52:14 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Jul
 2022 16:52:12 +0800
Message-ID: <154b2167-47f1-4d1e-0cd7-afab25033b76@zhaoxin.com>
Date:   Thu, 21 Jul 2022 16:52:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>, <kishon@ti.com>,
        <dianders@chromium.org>, <s.shtylyov@omp.ru>, <mka@chromium.org>,
        <ming.lei@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>
References: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
 <09fed539-909a-f274-1a73-428dc7439d69@suse.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <09fed539-909a-f274-1a73-428dc7439d69@suse.com>
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

On 2022/7/21 16:00, Oliver Neukum wrote:
> 
> 
> On 21.07.22 08:08, Weitao Wang wrote:
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
> 
> Hi,
> 
> ow do you know usb_hcd_giveback_urb() will be called in time to process
> isoc URBs in time, if you leave them on the list? In fact how do
> you be sure it will be called at all? I can see no upper time limit
> on that.
> 
> 	Regards
> 		Oliver
> 
> .
If the bh->head list is not empty, patch method will raise a softirq
immediately to call work function of every tasklet. Therefore, I think
the left URB in bh->head list will be get giveback in time.

Thanks
weitao
