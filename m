Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35E4B5FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiBOBUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:20:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBOBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:20:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1BDB876
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=PwKQzxcZnxAMawMI5Ec96w6c+z5ZMtVLe3RYkYT8DPI=; b=ToqSXFCxkLecL05Fdfh38a7I51
        PWvh0Xx3d09NnBWXH4WSzRMAR8TuU0EC2EuVczc53pnlPpnd0I43dxJx0COLILNgf8kZsPxVHhqZn
        Z/gVrrPr7Q2AHLAPEDMaGlXkX8P/Kpodnkesm+JMVwk8lhfz5FuUMoZerRAIDlRrhWY0IVtedQyQ0
        ojEOxJ3UxbqoyBimphmh82YC5z4sPNw/2cnmRNcKZR63w43vhIhmVKNPKykt1gaCEg5cXZ+pcptvH
        j+QkrHcsp4wL/dRvJOVyxFcP2Ye8G9NDAPCI5XzDhibuKgjOcj4dxjOKT5htR1FKh6JdEjKlZUd9q
        ZgW95ADw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJmVU-00DPUp-PG; Tue, 15 Feb 2022 01:19:53 +0000
Message-ID: <cf2c9343-b4dd-635a-4c11-3259fdfd4f83@infradead.org>
Date:   Mon, 14 Feb 2022 17:19:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: Wrong __setup() callbacks return values and /init's environment
 pollution
Content-Language: en-US
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>, linux-kernel@vger.kernel.org
References: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru>
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

I have had this in my todo bucket for too long now...



On 12/25/20 09:20, Igor Zhbanov wrote:
> It seems that nobody knows how to write __setup() callback functions for
> parsing the command line parameters. And there are no documentation or
> comments about best practices.
> 
> Despite being declared obsolete __setup() is used about 435 times in the
> kernel and 51 of them (~11.2%) are erroneous in the sense of returning
> incorrect value (0) resulting in the /init process environment pollution.
> 
> Initially it was mentioned that the callback function should return 1 when
> the parameter value is parsed and consumed successfully, or return 0 to
> keep the unparsed option as init's environment variable.
> 
> But there are no comments or documentation about it, so developers often
> always returning 0 (as it is typically expected in other kernel functions)
> or returning -EINVAL on parse error. All these cases resulting in init's
> environment pollution (which is limited only to 32 variables in the config).
> 
> Even the original usage when 0 is returned on the parse error is questionable
> now. There are no (or not so many) parameter names clashes between different
> kernel subsystems, as well as there not so many parameters to be passed to
> init/systemd that could be interpreted as the kernel parameters. So if a
> kernel module sure that this is its own parameter, may be it would be better
> to always return 1 and consume it, even it is malformed.
> 
> Also there are no recommendations on whether to print a warning when
> incorrect parameter is passed. Some of the functions print a warning on
> incorrect values; some are silently proceeding with the default values.
> Some are even calling panic() on incorrect parameters (e.g.
> setup_time_travel() -> time_travel_connect_external()). So there is no
> consistency on what behavior for handling incorrect parameters values are
> recommended.
> 
> I've tried to categorize all of the __setup() usages. And here is the zoo:
> 
> Functions always returning 1 (right):
>   (About 324)

[cuts]


> 
> Functions always returning 0 (wrong):

> 
> Functions returning 1 on error, 0 on success (wrong):

> 
> Functions returning -errrno (-EINVAL mostly) on error, 0 on success (wrong):

> 
> Functions returning -EINVAL on error, 1 on success (wrong):

> 
> Functions that don't have the return statement at all (wrong):

> 
> So it would be better to document at least how a __setup() callback handler
> should behave regarding the return value, whether to print a warning on parse
> error. And the functions not returning 0 on error and 1 on success must be
> fixed.

Then how about starting with some documentation?
Can you send some?

> Also to avoid init's processes pollution may be it is even better to simply
> always returning 1 even on parse errors, because parameters names collisions
> are very infrequent.


thanks.
-- 
~Randy
