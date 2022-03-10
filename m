Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980294D3F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiCJCvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiCJCvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:51:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2639122F51
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OEeUvupJaC7PMpANt/u/wwWi72sUMQxcyYVd29Hfq6Q=; b=ic1GzHFyo63BC6p4pPwI61Jg6d
        aeh7FqnYnIBWXDUbnwSkvdjqrmu0w77l6efY4QLRjW/fxaXpnaAtXatKeBZFHENebs1qEXBBq5DoF
        5ojktKWoG+UShfM+UrF/sNY5tIq8H28Bp95HorT7BzQ7Wcxr11AAUJwctvwzGHkkMsMf8ib27Jni2
        amKjkpMnUtNMpR2IhnV6w2Ww9fmMH4cKmGY++LV3ipMcie4DQgtWMrxNzCn3EojsYjDp0VfTC/8NM
        lPBTA4IbcXZr96fkIzwWPPeF7Z1vIqB3gnJTHrmSj6DVFTs+YHmVStGwZPvw4EviiDxe56zpht8ls
        5wMAKjoA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS8sG-0008n5-Mq; Thu, 10 Mar 2022 02:49:56 +0000
Message-ID: <3179f015-58d9-6786-c2c4-6a54088c9221@infradead.org>
Date:   Wed, 9 Mar 2022 18:49:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] drivers: ddcci: upstream DDCCI driver
Content-Language: en-US
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk
References: <20220310004433.5713-1-yusisamerican@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220310004433.5713-1-yusisamerican@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/9/22 16:44, Yusuf Khan wrote:
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 740811893c57..c7aa439d23e7 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -451,4 +451,13 @@ config RANDOM_TRUST_BOOTLOADER
>  	pool. Otherwise, say N here so it will be regarded as device input that
>  	only mixes the entropy pool.
>  
> +config DDCCI
> +	tristate "DDCCI display protocol support"
> +	help
> +	  Display Data Channel Command Interface is a 

	                                         is an

Also, the line above ends with a space. Please check the entire patch
for lines that end with SPACE and remove the trailing spaces.

> +	  interface that allows the kernel to "talk"
> +	  to most displays made after 2005. Check your
> +	  display's specification to see if it has
> +	  support for this.
> +
>  endmenu

(2) ddcci appears to be a char driver, not a misc driver,
so its documentation probably should not be in Documentation/misc-devices/.

(3) The documentation file ends with:

+options ddcci dyndbg
+options ddcci-backlight dyndbg
\ No newline at end of file

so please add a newline at the end of the last line.

(4) What is the modalias stuff about?
Does the kernel have other drivers that play modalias games
like this?


(5) This standalone comment might need some more text.
Doesn't make much sense by itself.

+	/* Special case: sender to 0x6E is always 0x51 */

Does that mean something like "reply to 0x6E is always 0x51" ?


(6) Be a bit more generous with spaces around operators (kernel style).
And be consistent.  This first line is OK, second line not so much.

+	xor ^= ((p_flag << 7) | len);
+	*(ptr++) = (p_flag << 7)|len;

This line could also be improved with some spaces:

+	ret = payload_len+3+((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)?1:0);

(e.g. -- I expect that there are others.)


(7) Too much use of likely() and unlikely().

(8) I don't see anything in the Kconfig entries such as
	depends on I2C

so do these 2 drivers work without I2C being enabled in a kernel?

Oh, if I build ddcci without CONFIG_I2C:

../drivers/char/ddcci.c: In function ‘__ddcci_write_bytewise’:
../drivers/char/ddcci.c:104:8: error: implicit declaration of function ‘i2c_smbus_write_byte’ [-Werror=implicit-function-declaration]
  ret = i2c_smbus_write_byte(client, addr);
        ^~~~~~~~~~~~~~~~~~~~
  CC      kernel/delayacct.o
../drivers/char/ddcci.c: In function ‘__ddcci_write_block’:
../drivers/char/ddcci.c:165:9: error: implicit declaration of function ‘i2c_master_send’; did you mean ‘i2c_match_id’? [-Werror=implicit-function-declaration]
  return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
         ^~~~~~~~~~~~~~~
         i2c_match_id
../drivers/char/ddcci.c: In function ‘__ddcci_read’:
../drivers/char/ddcci.c:216:8: error: implicit declaration of function ‘i2c_master_recv’; did you mean ‘i2c_match_id’? [-Werror=implicit-function-declaration]
  ret = i2c_master_recv(client, buf, len);
        ^~~~~~~~~~~~~~~
        i2c_match_id
../drivers/char/ddcci.c: In function ‘ddcci_identify_device’:
../drivers/char/ddcci.c:413:10: error: implicit declaration of function ‘i2c_check_functionality’; did you mean ‘in_lock_functions’? [-Werror=implicit-function-declaration]
       && i2c_check_functionality(client->adapter,
          ^~~~~~~~~~~~~~~~~~~~~~~
          in_lock_functions
../drivers/char/ddcci.c: In function ‘ddcci_module_init’:
../drivers/char/ddcci.c:1835:8: error: implicit declaration of function ‘i2c_add_driver’; did you mean ‘ddcci_add_driver’? [-Werror=implicit-function-declaration]
  ret = i2c_add_driver(&ddcci_driver);
        ^~~~~~~~~~~~~~
        ddcci_add_driver
../drivers/char/ddcci.c: In function ‘ddcci_module_exit’:
../drivers/char/ddcci.c:1868:2: error: implicit declaration of function ‘i2c_del_driver’; did you mean ‘ddcci_del_driver’? [-Werror=implicit-function-declaration]
  i2c_del_driver(&ddcci_driver);
  ^~~~~~~~~~~~~~
  ddcci_del_driver



-- 
~Randy
