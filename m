Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E205017C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiDNPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348621AbiDNPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B9BAAFACE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649949506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdkjcJswzvQkHBrLctMbhjrv/33JySDVE8Z4f4eM9ik=;
        b=HeowvGRyvzYI+sfBWgQTrBFJBJZKJD9rO2+OVN3SNC+nkkiqKQYAb9IK45jqmK96Ii1o+C
        07KhrKeiBCf8YdYVLjaaX3nFc2dBKrSbdB89JpIOvsz+oiXZM+9iSF76jQFPo4VwQXs0LA
        bIWXDX7Z0cdbxtNUDCkh+DBYrsMkQNI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-sLGqZFnvM66nKVLhcMfNTg-1; Thu, 14 Apr 2022 11:18:25 -0400
X-MC-Unique: sLGqZFnvM66nKVLhcMfNTg-1
Received: by mail-qk1-f197.google.com with SMTP id f21-20020a05620a409500b0069c0ba2ee79so3467416qko.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IdkjcJswzvQkHBrLctMbhjrv/33JySDVE8Z4f4eM9ik=;
        b=iwFu7sbidKPUdFjiLeAc/WXTHgxRNFK9G/9XuvtUAs0ekd6+mJ1V6ZHGpuSTpHgEVt
         xWIBxQhESaRYEVeQ1ty6cBzdtY3n3HT5EbNZvEwgAPdsTV24SjQhmcxDRHq7b3EZx1Lw
         S0rMBao4ZkR9TRMExowdmqd4Jtssu7meLY5vD00y0NCTSa9JNLtkwCuaTpDoNEQC1kcL
         5GFfnjncRY/qqP5cGVriyBJnkQjG4UkZXowtZoGLSE3vF5KIrcO4+Su6obHscA8htgp1
         S/aCXL6LxA1M9TTl92js2l2oh03DVkjjpgig92ODbQB9cLYFcKjbQeZtpbo8A0w1DOkp
         0AJg==
X-Gm-Message-State: AOAM532tvy5UlnjQrhaqvKQ7XxZe1jMrAkj6Xru3suIiihYv4tLdoTtm
        3jsD1NzXIvzcxdQt5CMHfkJDgqpY8QtQwB4ArLb7rR1X7bdA34xYoynhakEoeuLVCMdfZhD1h3Z
        zFmtmyCdmiCf6XRULAXsgIgRj
X-Received: by 2002:ad4:5b89:0:b0:441:6e09:dbeb with SMTP id 9-20020ad45b89000000b004416e09dbebmr13285388qvp.53.1649949504370;
        Thu, 14 Apr 2022 08:18:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXLG206zhciIUoPKy3WlSapgM8q6MRYZB74Hm68zQJyJCHYhdq4plbu3YlxHGQc/snnov0WQ==
X-Received: by 2002:ad4:5b89:0:b0:441:6e09:dbeb with SMTP id 9-20020ad45b89000000b004416e09dbebmr13285350qvp.53.1649949503846;
        Thu, 14 Apr 2022 08:18:23 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id q125-20020a378e83000000b0069bf8409e6fsm1115510qkd.28.2022.04.14.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:18:23 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:18:20 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com
Subject: Re: [PATCH 1/2] x86/unwind/orc: recheck address range after stack
 info was updated
Message-ID: <20220414151820.kbl4e5dp4nfufflz@treble>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <YlVQboACrT5QqbJQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlVQboACrT5QqbJQ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:11:58PM +0200, Peter Zijlstra wrote:
> 
> Also, guys, do we want something like so?
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..cb5fcb2a9cef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14220,6 +14220,7 @@ M:	Peter Zijlstra <peterz@infradead.org>
>  S:	Supported
>  F:	tools/objtool/
>  F:	include/linux/objtool.h
> +F:	arch/x86/kernel/unwind*
>  
>  OCELOT ETHERNET SWITCH DRIVER
>  M:	Vladimir Oltean <vladimir.oltean@nxp.com>

I could have sworn we already had a separate MAINTAINERS entry for the
x86 unwinder, senility must be rapidly approaching.

-- 
Josh

