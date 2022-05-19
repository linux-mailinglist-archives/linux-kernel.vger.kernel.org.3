Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720EB52D63C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiESOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiESOhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:37:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9D698084
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:37:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so7470749wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvrP+8rCgkMvepnQXCIhMnc3T80MuXBpuTNeKYREL20=;
        b=hTiQI7PhXxZLhxDo4a5AJZOqlnFOeizRqaOHA0Qjy3yRXis1s5m2aiNeY1k/AV1Nna
         XzXegvc6/9+lxKg+BmcB8nEn5EZEsyIRrhJhWStW1490k+Ipn2oNXoXqg11QUdN4tLyd
         6R4WfNSYKuzHVazGDMnihrO+BocvrSQr9qt7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvrP+8rCgkMvepnQXCIhMnc3T80MuXBpuTNeKYREL20=;
        b=t9bxzXt+wNddV1GbAsnpeorLB6fVV04pWu9/4rjfby7RwU62pL6ruio/De2nHqIcBJ
         +tw3Jijb1YAKwxw/x4aV7lgxkjkZS2Cces1qZEjax1DS4H0Ny7qxFWoNjeZi4xAeDN2h
         WTj3YCL0ZOua6x42uUNz8CnwWck3++pguIfegdJzib2HBSJbigOgqbGW8mF32qQxFpTK
         bPqajj43pXqIUX66IVvi+hwu9l5KRs792kFCGNcblqPpq2MAWylFHKDviZDi/0HTrrdG
         Z+WuGihd8hVDLYyqclFj8VO779vwwHNYrdm6tnG9IRKpaJeVdygO/0Vos+CQ3BC3Q3Hi
         9aaQ==
X-Gm-Message-State: AOAM5323uVNfqBjl6tVjYq014gut7ZhJ/YW+RnbmSyw0r8XpXj9Tyn/j
        Fe4drK+1yupvlUb7lYlvnU85rQ==
X-Google-Smtp-Source: ABdhPJyVmTruZ1q+Pw1OVS9Q1CUTatwlpLSftgXoZMMNDA7bB5pbUAJGAv25R4HCQFgLhcfdm1RoQQ==
X-Received: by 2002:adf:c64c:0:b0:20a:79c7:4bf2 with SMTP id u12-20020adfc64c000000b0020a79c74bf2mr4266184wrg.587.1652971031327;
        Thu, 19 May 2022 07:37:11 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c1eb])
        by smtp.gmail.com with ESMTPSA id c4-20020adfc6c4000000b0020c5253d8desm5081803wrh.42.2022.05.19.07.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:37:10 -0700 (PDT)
Date:   Thu, 19 May 2022 15:37:10 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZWFi0AtmA9fvv/@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <CAMuHMdU2tUU6FAM-nK9oxd0GwcO3WwvZp9Um4=w5By+N0P0kXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdU2tUU6FAM-nK9oxd0GwcO3WwvZp9Um4=w5By+N0P0kXA@mail.gmail.com>
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

Hey Geert,

Geert Uytterhoeven writes:
>All of the above options are appropriate for "classic" systems,
>where the console device is selected using the "console=" option.
>
>On systems using Device tree, the serial console device is selected
>using the "chosen/stout-path" property in DT, and the graphical
>console is usually auto-detected and auto-enabled through DRM.
>Do you envision a way to specify a specific console loglevel on the
>kernel command line on such systems?

Interesting question! I hadn't really thought about device tree. I actually 
have very little understanding of how it works to be honest :-)

I'm happy to add loglevel support to device tree, I assume I'd add another 
property under the chosen node, like chosen/stdout-loglevel.

I have some questions, though:

1. It looks like DT is standardised. Do I need to get standards approval first?
2. Is there documentation on how to reliably test DT changes?

Thanks!

Chris
