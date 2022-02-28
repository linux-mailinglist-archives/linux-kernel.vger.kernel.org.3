Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E614C64E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiB1IdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiB1IdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:33:04 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC021AA;
        Mon, 28 Feb 2022 00:32:24 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id AA922586;
        Mon, 28 Feb 2022 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646037144;
        bh=CCCJGLwREFudXAQ71006Rww33yHRQbbj3lk5h/iUP7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSLlx5cpu6/a3Z/YK5BUN+3pKJVP2HvMkrVnWDg5ngfiReScKDSrUrRYagxb8EEAV
         xlTlmYlbiISSanrSe/gT5KWmFVlnlIxpwqWTPLSgGkA6JG9Z7UkN3ha1pckO11vYyY
         9ttb1mGvnXpmAnThWty/HDef4OFb6Ngeo8xXY20E=
Date:   Mon, 28 Feb 2022 00:32:23 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] hwmon: (nct6775) Split core and platform driver
Message-ID: <YhyIlz5hW4u6qrDc@hatter.bewilderbeest.net>
References: <20220227154447.GA766647@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220227154447.GA766647@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 07:44:47AM PST, Guenter Roeck wrote:
>On Sat, Feb 26, 2022 at 05:30:45AM -0800, Zev Weiss wrote:
>> This splits the nct6775 driver into an interface-independent core and
>> a separate platform driver that wraps inb/outb port I/O (or asuswmi
>> methods) around that core.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>I think it would be much better to convert the entire driver to regmap
>and not just use regmap for i2c. This way all register read/write
>operations can be hidden behind regmap, and the read/write callbacks
>are unnecessary. The tmp401 driver gives an example how to do this -
>essentially implement reg_read and reg_write functions in struct
>regmap_config, then handle all register accesses through regmap.
>
>Couple of additional comments inline.
>

Alright, that sounds reasonable -- I'll work on an entirely regmap-based 
v2 (and address the other points as well).


Thanks,
Zev

