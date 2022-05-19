Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2352DC13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbiESRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243390AbiESRz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:55:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2047C59300
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:55:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k126so3306847wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcURIzUAaO0hawwQBa3QbU95nABbOKjkzznKXnu7p/M=;
        b=JWpmXJZ1wlQ3Jru3rS1u9eB8UO05ZEUrunbAL22mtbQEv4+uiHhOI0vbxMeDuqVY0x
         slBw40ljhv9NRn7gH+uzvSgsWaO1OrExdnCg4qxIVhyEh++rukgXukFP+ydfM0pL2Kr0
         M8c0TQbyFyZUrRI1cVeSevhx56MMgLy1AN3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcURIzUAaO0hawwQBa3QbU95nABbOKjkzznKXnu7p/M=;
        b=N0ivc5hoRvl8FQVEkGZiv/mtzYIAy6pINFBFU1MwWsAu1NqKylnIg8ZKYK56Ez+YOk
         voXLpGA2xGHPc2Skp0KULT7TsPHG8+j/q9r7dPB8kvvURCQsvwC3LDJfg5VQktISxO2R
         LkYPve0OCrqr1gUeTzUBI3GHstzLcu6rPxYnhPoN/3LPYTNpvnk3csp4zeAFbvUw3hQB
         Rs3LBSDxeWDMU0Ojns7RlNLPrNO+0U+vArVHF+aYV3z2NrfFUY8gYw8IPW8PZMnD2CsM
         aj00Fi4bhGS0+U3ZpgJDcCmpF8P9sihLVsdt8EDy3yiSyYREzKqr1MTCs4b2RIdn+3QL
         Hakg==
X-Gm-Message-State: AOAM533/9v3AHprCLkUMQkMFegp1r3WalNrFzqdF9OhbzQcY9DgYQTad
        J/3GEHdp4fbgyMkH4K3scC88zz1CIBEU5+/o
X-Google-Smtp-Source: ABdhPJyhZku1aSofMHOAw0WeaouxWQ4Dilpy9tUkJNSKLgbe6lC9ZCWtmCe/t4kaM6umX/2fX8/i7w==
X-Received: by 2002:a7b:c114:0:b0:394:47d3:693f with SMTP id w20-20020a7bc114000000b0039447d3693fmr5612215wmi.42.1652982926317;
        Thu, 19 May 2022 10:55:26 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c1eb])
        by smtp.gmail.com with ESMTPSA id q6-20020adfbb86000000b0020c5253d902sm206567wrg.78.2022.05.19.10.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:55:25 -0700 (PDT)
Date:   Thu, 19 May 2022 18:55:24 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoaEjNrBLjPBtx/p@chrisdown.name>
References: <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
 <YoZVvA5FP4wFLSH9@kroah.com>
 <YoZdVCfK4T8Ts2oS@chrisdown.name>
 <YoZhXe9CZE5o73fG@kroah.com>
 <YoZoXOghSuCy9Bi+@chrisdown.name>
 <YoaCN+OH6cG0p1CN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoaCN+OH6cG0p1CN@kroah.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>> So, just to try to come to a solution, here's the lay of the land as I
>> understand it. Currently pretty much all consoles are statically defined
>> (and most of the non-static cases are false positives)
>>
>>     % git grep 'struct console.*=' -- '*.c' | awk '/static/ { print "static"; } !/static/ { print "non-static" }' | sort | uniq -c
>>          15 non-static
>>         105 static
>
>ah, ok, then we have a problem, and your change to the struct device
>being a pointer is correct.
>
>That's the problem when you only see a tiny bit of the kernel in a
>patch, sorry for the confusion.

No worries! Just glad we got to the bottom of it :-)

>But you still need to free the device structure that is pointed to by
>the device in the release function.  Your release function can not be
>"empty" like your original patch was.

Great, then I'll implement it like the earlier diff I posted unless you have 
any objections.

Thanks a lot for your help and advice!
