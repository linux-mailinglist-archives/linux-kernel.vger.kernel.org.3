Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0258B49F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiHFIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHFIxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:53:21 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E111C13
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:53:19 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KFYboXXEJGDTnKFYboaqyZ; Sat, 06 Aug 2022 10:53:18 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 10:53:18 +0200
X-ME-IP: 90.11.190.129
Message-ID: <3eacc364-90b7-7a5d-c936-1ed993428ef6@wanadoo.fr>
Date:   Sat, 6 Aug 2022 10:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Question: dev_err_probe() vs Printk Index
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When a driver is using dev_err(), part of it is inlined and it:
    - takes advantage of dev_fmt()  [1]
    - implements Printk Index       [2]

Printk Index works with some __builtin_constant_p() magic in it.
In case of a use in a probe, 99.99% of the time the log level and the 
format will be constant and the logic for Printk Index will be put in place.


In case dev_err_probe(), the format will be an argument passed to the 
function and will not be constant, so nothing will be generated in the 
'printk'_index section.


In case dev_err_probe(), a potential dev_fmt() defined in the drivers' 
file can't be taken into consideration.
(trusting my grep, we never use in files that define dev_fmt() in the .c 
file. I've not checked if it is true via #include "<something.h>")


Even if I've read [3], I don't fully understand the real need of this 
Printk Index mechanism (at least for my own needs :))


My questions are:
    - is my analysis right?
    - is the lack of these 2 functionalities (dev_fmt and Printk Index) 
expected, when dev_err_probe() is used?
    - if not, is it a issue?
    - should it be at least documented?


(not sure who to put in copy of this mail)

CJ

[1]: 
https://elixir.bootlin.com/linux/v5.19/source/include/linux/dev_printk.h#L143
[2]: 
https://elixir.bootlin.com/linux/v5.19/source/include/linux/dev_printk.h#L107
[3]: Documentation/core-api/printk-index.rst
