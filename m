Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1E52DC54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiESSFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbiESSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:05:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062FBDFF58
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:05:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t6so8294311wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GXptsJcBObAmTHNgi3MV9lQPw8m5c8uSghS5yX++H8I=;
        b=bpVxe5OkU3xcWoEy8jrJOAYFaMoHctxc+PHbSJXzyYCy0RSD0DYf9SHj7dAZXOGY/b
         WTTer+QHHw/88590UJsnQArVErgQde6Q4L47VdMXa6+IfTBXGdy7nrrI8+zKC9K+OCu9
         PtZT89BQo2iQNx1zh+CkVSueLzuky3MJ+uCds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GXptsJcBObAmTHNgi3MV9lQPw8m5c8uSghS5yX++H8I=;
        b=M00AMqOXnM9oVnyMM9W0cN8U0dqOGwe3Gs0LJD5JXaElkRcINtRbb95yCzTmCli8w/
         6rbhy4r368DOU3APx+N/a6F39rDUwRP5nz3uCYMC6I5unu7l9/GNkxVLWfdNQfin6iNn
         JjEgNpcMtCMo5odi5FludBw9i/sG1sQuAOWq6KB2zTOQY/NWSTdWztY99zAHDr7cEbTI
         n5jjp6TO6G5IqABj8d3HYrYI9sg7wat2Ols4ABrbdmAz1mzhJNWf7f9vtcbsBQ+ROFEj
         9ksIEaZfGLGn8saZ/62yT7/1SysiqNCLOENe3zEGhkKjhB0wIpfulJt/gQuzcXqczsnX
         l+7g==
X-Gm-Message-State: AOAM531PnpnOTT3Bd9tWmt0Gy5NX/fCL1EvDmEqOzzXTr/t5qtQcIefd
        dWRRL9RYFdg3t6YNwc68MElO/Q==
X-Google-Smtp-Source: ABdhPJwN562D6hxL4omJgYXwo9pCJ9gFpCFSuYLQIrhIXXjkedD2mow75MiG73kTAvmCYIaoxLE0EA==
X-Received: by 2002:a05:6000:1acd:b0:20c:726a:3840 with SMTP id i13-20020a0560001acd00b0020c726a3840mr5068108wry.507.1652983534566;
        Thu, 19 May 2022 11:05:34 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c1eb])
        by smtp.gmail.com with ESMTPSA id s11-20020adfbc0b000000b0020c5253d8f3sm266099wrg.63.2022.05.19.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:05:33 -0700 (PDT)
Date:   Thu, 19 May 2022 19:05:32 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoaG7I9jDS0aQndK@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <CAMuHMdU2tUU6FAM-nK9oxd0GwcO3WwvZp9Um4=w5By+N0P0kXA@mail.gmail.com>
 <YoZWFi0AtmA9fvv/@chrisdown.name>
 <CAMuHMdU5=XW28XBdEx9ofrrysUCqqtoaS7=0U8Mr7TF3XdntWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdU5=XW28XBdEx9ofrrysUCqqtoaS7=0U8Mr7TF3XdntWw@mail.gmail.com>
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

Hi Geert,

Geert Uytterhoeven writes:
>CC DT

Thanks!

>On Thu, May 19, 2022 at 4:37 PM Chris Down <chris@chrisdown.name> wrote:
>> Geert Uytterhoeven writes:
>> >All of the above options are appropriate for "classic" systems,
>> >where the console device is selected using the "console=" option.
>> >
>> >On systems using Device tree, the serial console device is selected
>> >using the "chosen/stout-path" property in DT, and the graphical
>> >console is usually auto-detected and auto-enabled through DRM.
>> >Do you envision a way to specify a specific console loglevel on the
>> >kernel command line on such systems?
>>
>> Interesting question! I hadn't really thought about device tree. I actually
>> have very little understanding of how it works to be honest :-)
>>
>> I'm happy to add loglevel support to device tree, I assume I'd add another
>> property under the chosen node, like chosen/stdout-loglevel.
>
>Please do not add a new property there.
>IMHO, the loglevel should be specified on the kernel command line,
>and not be fixed using a DT property.

Ah, if that's what you want, it should already work I think (if I understood 
your point correctly).

As long as you know which console type will be brought up, you can just specify 
the following rule on the command line and the rule will be applied to 
whichever console is brought up by DT (untested, but it should work):

     # default 4, serial to 5
     loglevel=4 console=ttyS0/5

     # default 4, usb to 5
     loglevel=4 console=ttyUSB0/5

Is that the kind of thing you meant?
