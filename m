Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A30580BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiGZGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiGZGr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:47:29 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [210.0.225.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909A1EAFE;
        Mon, 25 Jul 2022 23:47:26 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 26 Jul
 2022 14:47:00 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Tue, 26 Jul
 2022 14:46:59 +0800
Message-ID: <3f2c941b-94cd-8357-13de-8656486e8cbd@zhaoxin.com>
Date:   Tue, 26 Jul 2022 14:46:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] USB: HCD: Fix URB giveback issue in tasklet function
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <kishon@ti.com>,
        <dianders@chromium.org>, <s.shtylyov@omp.ru>, <mka@chromium.org>,
        <ming.lei@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>, <CobeChen@zhaoxin.com>
References: <20220725065251.832087-1-WeitaoWang-oc@zhaoxin.com>
 <Yt6haeQBseJOEx1r@rowland.harvard.edu>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <Yt6haeQBseJOEx1r@rowland.harvard.edu>
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

On 2022/7/25 21:58, Alan Stern wrote:
> On Mon, Jul 25, 2022 at 02:52:51PM +0800, Weitao Wang wrote:
> 
> This is basically okay.  Just a couple of small comments...
> 
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
>> Add a member high_prio for structure giveback_urb_bh and replace the local
>> high_prio_bh variable with this structure member in usb_hcd_giveback_urb.
> 
> The patch description should do more than say what the new code _is_ --
> we can see that easily enough by reading the patch.  The description
> should explain _why_ the code was changed.
> 
Okay, I will improve this patch description.

>> -	/* check if there are new URBs to giveback */
>> +	/* giveback new URBs next time to prevent this function from
>> +	 * not exiting for a long time.
>> +	 */
> 
> Minor stylistic issue: The currently accepted format for multi-line
> comments is like this:
> 
This notes will be improved in next patch version also.
Thanks for your suggestion.

weitao
> 	/*
> 	 * Blah blah blah
> 	 * Blah blah blah
> 	 */
> 
> Alan Stern
> .
