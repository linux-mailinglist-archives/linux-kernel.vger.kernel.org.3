Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11325A7A64
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiHaJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHaJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:42:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0BBCAC4B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:42:55 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27V9grBV003452;
        Wed, 31 Aug 2022 18:42:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Wed, 31 Aug 2022 18:42:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27V9gfVa003416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Aug 2022 18:42:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <93064a89-872f-7e9c-fad9-92121919d736@I-love.SAKURA.ne.jp>
Date:   Wed, 31 Aug 2022 18:42:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tty: vt: Add checks after calling kzalloc
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        johan@kernel.org, zhangxuezhi1@coolpad.com, xyangxi5@gmail.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20220831090810.2175859-1-jiasheng@iscas.ac.cn>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220831090810.2175859-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check if your system can survive, by doing

On 2022/08/31 18:08, Jiasheng Jiang wrote:
> On Wed, Aug 31, 2022 at 03:57:42PM +0800, Jiasheng Jiang wrote:
>>>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>>>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);

-		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		vc_cons[currcons].d = vc = NULL;

>>> +		if (!vc) {
>>> +			console_unlock();
>>> +			return -ENOMEM;
>>> +		}
>>>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>>>  		tty_port_init(&vc->port);
>>>  		visual_init(vc, currcons, 1);
>>>  		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
>>>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);

and/or

-		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		vc->vc_screenbuf = NULL;

>>> +		if (!vc->vc_screenbuf) {
>>> +			console_unlock();
>>> +			return -ENOMEM;
>>> +		}

in addition to your patch.

This is __init function of built-in module, isn't it?
Who can recover from this allocation failure? ;-)

