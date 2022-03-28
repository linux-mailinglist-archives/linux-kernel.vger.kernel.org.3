Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94F4EA092
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbiC1TwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbiC1TtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:49:09 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66176C93C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:45:34 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id YvIgnQ611uvBOYvIgnOLTK; Mon, 28 Mar 2022 21:45:15 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 28 Mar 2022 21:45:15 +0200
X-ME-IP: 90.126.236.122
Message-ID: <78d00a13-3cee-386c-07f1-8d16a24e4e67@wanadoo.fr>
Date:   Mon, 28 Mar 2022 21:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ia64: topology: Fix an error handling path in
 cache_add_dev()
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Tony Luck <tony.luck@intel.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <452b20c160a20754022407acefd2abb170f43d14.1648494330.git.christophe.jaillet@wanadoo.fr>
 <facd6471-4c4f-ff5a-e81f-38acd855eb8d@physik.fu-berlin.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <facd6471-4c4f-ff5a-e81f-38acd855eb8d@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/03/2022 à 21:16, John Paul Adrian Glaubitz a écrit :
> Hi Christophe!
> 
> On 3/28/22 21:07, Christophe JAILLET wrote:
>> If kobject_init_and_add()fails, kobject_put() needs to be called.
>> Add the missing call which is already there a few lines below in another
>> error handling path.
>>
>> Fixes: f19180056ea0 ("[IA64] Export cpu cache info by sysfs")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks for your patches. There is currently no maintainer for ia64, so the patches
> would have to go through Andrew Morton's tree.
> 
> However, I can test the patches and verify they don't break anything.
> 
> Adrian
> 

Hi,

digging deeper for other potential same issues in other file, I don't 
think that this patch is needed, and I don't think that it fixes anything.

The "name" of this kobject is "%s", "cache".
So nothing needs to be freed for that because kstrdup_const() will be used.

This kobject has no .release function.

If the add() part of kobject_init_and_add(), then 'state_in_sysfs' will 
still be 0, so nothing needs to be released for that either.


So, adding a kobject_put() would just be a no-op here (if I understand 
correctly).

I've been puzzled by the kobject_put() later, but in this case, _add() 
has already succeeded and state_in_sysfs=1 and the call is needed.


For the other patch, it is just a clean-up. Based on Wikipedia, IA64 is 
discontinued, so such clean-up does not make that much sense either.
(on the other hand, it should be eay to review and apply :) )


I don't think you need to spent time on it. Sorry for the noise.

CJ
