Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B305857BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiG3BUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3BUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:20:11 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E929B61
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:20:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BE76A1E80D33;
        Sat, 30 Jul 2022 09:19:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jYse286_FaGi; Sat, 30 Jul 2022 09:19:52 +0800 (CST)
Received: from [192.168.10.17] (unknown [183.208.208.157])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id EA4441E80D0B;
        Sat, 30 Jul 2022 09:19:51 +0800 (CST)
Message-ID: <61a8a192-d10a-18f2-94f5-69c0902bb403@nfschina.com>
Date:   Sat, 30 Jul 2022 09:20:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] tracing: Do PTR_ERR() after IS_ERR()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com, jiaming@nfschina.com
References: <20220727153519.6697-1-liqiong@nfschina.com>
 <20220727122847.6b00e29d@rorschach.local.home>
 <efce3a4c-4480-99f5-0229-a44009ebe9d8@nfschina.com>
 <20220729125647.746379e5@rorschach.local.home>
From:   =?UTF-8?B?5p2O5Yqb55C8?= <liqiong@nfschina.com>
In-Reply-To: <20220729125647.746379e5@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/30 00:56, Steven Rostedt 写道:
> On Thu, 28 Jul 2022 08:28:08 +0800
> liqiong <liqiong@nfschina.com> wrote:
>
>> It's all right, assign  PTR_ERR()  to 'ret'  anyway.
>> But this assignment is valid only at the "IS_ERR()" path.
>> Maybe it is better put "PTR_ERR()" at error path, keep the code clear.
> No it does not. It adds unnecessary brackets.
>
> It is common in the kernel to have:
>
> 	ret = ERROR;
> 	if (some_condition())
> 		goto out;
>
> 	ret = ERROR1;
> 	if (some_other_condition())
> 		goto out;
>
> 	ret = ERROR2;
> 	if (some_new_condition())
> 		goto out;
>
> 	ret = 0;
> out:
> 	return ret;
>
> And your change breaks this.
>
> -- Steve

I got it, Thanks.


