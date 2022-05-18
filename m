Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6552C46D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiERU1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbiERU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:27:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97C131291
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:27:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er5so4404656edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cO7il1EbGLDAsi9btfMK56EFMu0vOnZ/hpfwtqzjMgo=;
        b=MG0OjiK2mlF4yW3YO6xj8BEA/URIDRgGe/IpfnWs0ugc9usajjC7Cvu+Hj7cSFPFuZ
         lcShlak7TwSLbCj+pvyRfhoDg7Fud6ndoRkL1czNwgEphhoy/CBRQ6UM5doJVWTltHCu
         rhZAyV9veHVVjzwWWUnb4UQtt4qHCoAiY50XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cO7il1EbGLDAsi9btfMK56EFMu0vOnZ/hpfwtqzjMgo=;
        b=5tVSKxbWzMLINvlYUlrKuNWIyHl7imO8IxlTp2iVl7AJUvm6vt9Y2sRwpr/MlPv8Uk
         QRdKamhnoCJk8qC4iZjHg1lrtdluDb/Wc/rP0w5MsE71ZSJTTHwLwwM8JHmJez8cZD1j
         NUDVBpmnSZSYjSPibClOggaOQuI/BWDeq6P+jYhInEBUWQDaeStou8lXa2yAH3yTPfku
         jn3babwNs5TC8f+hpPTG6tHOdApmsOJb/j3ehnJ+AwbfE/GdMBLsA32BFtC9ag7BeV8C
         truMYcKBLxRPG4GiH7Vg8dFkxdCpLZYt+1lCyZyAfGaCaoi4Lrk6IRwv8zEfKNQ4QcbG
         0eaQ==
X-Gm-Message-State: AOAM532W9M+FagJxiJOOrnSY5pVJB3YIsBVeYVXremP9o94ZzRotZkxs
        6gu2ISGP24qsT3EI5300xUtoQKpFU/KVmzhP
X-Google-Smtp-Source: ABdhPJzRYEdOygCMcTNR4F0ej4vRimfEvrcUEBuG5KhO0YLvwj1os2NBmjBvtmjOelL4ToMD6A0FtQ==
X-Received: by 2002:a05:6402:5190:b0:427:df4a:19d9 with SMTP id q16-20020a056402519000b00427df4a19d9mr1666103edd.384.1652905638464;
        Wed, 18 May 2022 13:27:18 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c43c])
        by smtp.gmail.com with ESMTPSA id f26-20020a50fe1a000000b0042617ba63c9sm1894857edt.83.2022.05.18.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:27:17 -0700 (PDT)
Date:   Wed, 18 May 2022 21:27:17 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoVWpZKHD7aec0CJ@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoVO23+fvsNPnpKh@kroah.com>
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
>> If you're talking about properly freeing the memory, I suppose it should
>> happen by doing something like the following in unregister_console():
>>
>>     if (!console_drivers)
>>         /* free the class object under console lock */
>>
>> ...right? Let me know if I'm misunderstanding you.
>
>You can't do that as the driver core should now be managing the
>lifespace of that object.  You can't "know" when the object's memory is
>to be freed EXCEPT in the release function.
>
>So free it there please.
>
>Or do not tie the lifepan of the console class device object to the
>console object, and keep it separate.  I don't remember exactly how you
>tied them together here, sorry.

[...]

>> > Do you ever free the class?
>>
>> Currently no. What do you think about the above proposal to do it once the
>> console driver list is exhausted?
>
>If the code can never be unloaded, no, don't worry about it.

So just so I understand, there's no problem here if we're not going to free the 
class object, correct? These two stanzas in your reply refer to the same thing, 
right?

For context: the class comes up with printk, and printk can never be unloaded, 
so the class is never freed.

The devices that attach to this class are stored in `struct console', which has 
its lifecycle managed externally from this code.

I feel like I'm missing something here, but the two quoted parts of your reply 
seem to contradict each other (the first one talks about the right place to 
free the class, whereas the second says it's not necessary to free the class), 
so I'm a bit confused.
