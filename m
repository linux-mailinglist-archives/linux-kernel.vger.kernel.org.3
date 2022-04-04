Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A14F1BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381872AbiDDVYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380689AbiDDVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:01:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1538A3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:59:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nbTnI-0004FN-Ih; Mon, 04 Apr 2022 22:59:24 +0200
Message-ID: <5f862219-2e48-72d0-af27-3ab2b5820a95@pengutronix.de>
Date:   Mon, 4 Apr 2022 22:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Possible performance regression with
 CONFIG_SQUASHFS_DECOMP_SINGLE
Content-Language: en-US
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net, phillip.lougher@gmail.com
References: <c22a0f1c-883d-5122-ef88-0d7c57ab4e66@pengutronix.de>
 <20220316053428.5758-1-phillip@squashfs.org.uk>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220316053428.5758-1-phillip@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Phillip,

On 16.03.22 06:34, Phillip Lougher wrote:
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
>> Hello,
>>
>> This an issue we had with v5.15 that we have since successfully worked around.
>> I am reporting it here as a pointer in case someone else runs into this and as
>> a heads up that there seems to be an underlying performance regression, so
>> here it goes:
>>
> 
> [snip]
> 
>>
>> Looking through the original kernel configuration we found that it has
>>  CONFIG_SQUASHFS_DECOMP_SINGLE=y and CONFIG_SQUASHFS_FILE_CACHE=y.
>>
>> Once changed to CONFIG_SQUASHFS_FILE_DIRECT=y and
>> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y, we were below 40s as we want.
> 
> This sounds like the slow-down that was introduced by commit c1f6925e1091
> "mm: put readahead pages in cache earlier" (Linux V5.8)
> 
> This commit prevents Squashfs from doing it's own readahead, which
> causes a slow-down in performance.  The slow-down is noticable when
> using a single decompressor (CONFIG_SQUASHFS_DECOMP_SINGLE=y), and
> can be solved by moving to a multi-decompressor configuration, because
> it removes contention on a single buffer in the single decompressor case.
> 
> This has been already been fixed by commit 9eec1d897139
> "squashfs: provide backing_dev_info in order to disable read-ahead"
> which is in Linux 5.17-rc1.

I just updated to v5.17.1 and I can confirm that this commit fixes the
performance regression. Single decompressor case is now nearly as fast
as multi decompressor. Reverting the fix increased boot time from
30s~ to 2min30s.

Thanks for clearing this up!

Cheers,
Ahmad

> 
> Phillip
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
