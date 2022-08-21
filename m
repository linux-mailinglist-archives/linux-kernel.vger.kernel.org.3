Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B859B175
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiHUDkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 23:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHUDkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:40:00 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB791F616
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 20:39:58 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27L3duGs023784;
        Sun, 21 Aug 2022 12:39:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 21 Aug 2022 12:39:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27L3duFO023781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 Aug 2022 12:39:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <304f443a-acda-6b31-78ac-fad205deb0ec@I-love.SAKURA.ne.jp>
Date:   Sun, 21 Aug 2022 12:39:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/2] tomoyo: use vsnprintf() properly
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
References: <YwFDLhioFG5Mlwws@ZenIV>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YwFDLhioFG5Mlwws@ZenIV>
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

On 2022/08/21 5:25, Al Viro wrote:
> Idiomatic way to find how much space sprintf output would take is
> 	len = snprintf(NULL, 0, ...) + 1;
> Once upon a time there'd been libc implementations that blew chunks
> on that and somebody had come up with the following "cute" trick:
> 	len = snprintf((char *) &len, 1, ...) + 1;
> for doing the same.  However, that's unidiomatic, harder to follow
> *and* any such libc implementation would violate both C99 and POSIX
> (since 2001).
> 	IOW, this kludge is best buried along with such libc implementations,
> nevermind getting cargo-culted into newer code.  Our vsnprintf() does not
> suffer that braindamage, TYVM.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thank you. You can send this change via your tree if you like.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

