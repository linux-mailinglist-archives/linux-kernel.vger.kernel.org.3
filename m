Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B09051B88A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbiEEHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbiEEHRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:17:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB147566
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:13:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 259071F45B;
        Thu,  5 May 2022 07:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651734806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Tzzzbunv7L2fZwqsDQQB5RtR0JzhRsIPRtf/4KTEtM=;
        b=HoyFk41lX5vjz6czuA6WrhcaKy4ywXcfo1F8uRnjSIIkypdKz84PeXThDgb+ZNbYfWkOIO
        ODJOhSTtOdHtSV6UE2LE9g4CEjWDDC+/cAxzazLShBz0b86MJmLhDAqk0mzuNUZ6SbIr8w
        P8+myXO+NaUeY3jkF3BXgf5bBLSCRXM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C16F72C141;
        Thu,  5 May 2022 07:13:25 +0000 (UTC)
Date:   Thu, 5 May 2022 09:13:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tao Lan <taolan@huawei.com>
Cc:     senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: fix =?utf-8?Q?kerne?=
 =?utf-8?Q?l_msg_leakage_in_syslog=5Fprint=5Fall_function=EF=BC=9B?=
Message-ID: <YnN5FTgeUu0DkqHW@alley>
References: <20220505025210.32249-1-taolan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505025210.32249-1-taolan@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-05-05 02:52:10, Tao Lan wrote:
> This function applies for memory but does not initialize the memory,and
> then invokes copy_to_user to copy the memory to the user space, which
> causes kernel information leaks.

It should not happen. copy_to_user() is used this way:

		textlen = record_print_text(&r, true, time);

		if (copy_to_user(buf + len, text, textlen))


It means that only @textlen bytes should be copied to the user space.
It is the length of the message read from the log buffer by
record_print_text().


> [ 148.439660] kernel memory leak value 0xffffff80aed972bc at
> 0xffffffd37f00a000 to 0x704b883e74

How did you produce this message, please?

Best Regards,
Petr
