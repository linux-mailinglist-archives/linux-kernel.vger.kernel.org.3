Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC44C3D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiBYE7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiBYE7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:59:00 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEEE179A23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:58:29 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w37so3633571pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THGaheywSZ3sa10RkBiKq1wUUC2jfNwyK7WlGMBrbNM=;
        b=VwgNHmPHPez4O6iDEnKp0/Tz7tqUTrrOK9n4fERCf/GL1mRfbXlA9VfRv04pL0VDes
         SjydC/ZqAZr2DF8mAV1BSoeNKrZqWnT2uiK+3qBdXFM8tWzz4ABGi64eYAc7r9/UG/Qx
         bVNTiFsix38g144ebDKIkyzqyE/h1RJg+cJgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THGaheywSZ3sa10RkBiKq1wUUC2jfNwyK7WlGMBrbNM=;
        b=uIG3l7PNEZ0a2jcj+tkMvGKHlD8J7amoF9/VG2l0g+V4jtYiDmsOR9lCVI/9hDAWgd
         MfAOVq2Q536xmDoYpQ6f/OaVNEpIe2coDfzydv1nmb9dwGnLpI1sD2fPOZnsTZypyntA
         a9SoV/p5cyJrmFB/KDEj/hNR8uxDZnqUDybxIRkdeVXAaMlfhCbui1JLzlSGt8o8w8RE
         xuZWobgPPTshz35++900w/1dYxhkjpvYZ7aewTZc1/Dx3QzEjdGU6sfkHq0S1FoC9C26
         YAnJMgxYGsvsvhz7Fx2Eq3uPyPADp6KIymlCuJygz47nZJKaPRrMsoAIUGH7Vj5Ln5LU
         NuoQ==
X-Gm-Message-State: AOAM530uTzk2dvsIfQBNz3iv0bz0EXtMUFXq0SaYVU176/xGHtgHyzmR
        MjnysSKx0RESFaZEXdphaS9/bg==
X-Google-Smtp-Source: ABdhPJziYpHfX0EETKu0t07zk32o785p7vXmXNVn5XIOwr56QSmApR+KSLH6ixNlYwG6BTmmsQ/dEA==
X-Received: by 2002:a62:7c41:0:b0:4e1:3185:cb21 with SMTP id x62-20020a627c41000000b004e13185cb21mr6146528pfc.82.1645765108977;
        Thu, 24 Feb 2022 20:58:28 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e94f:9f5e:13f6:a198])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f3b1c23497sm1283487pfj.101.2022.02.24.20.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 20:58:28 -0800 (PST)
Date:   Fri, 25 Feb 2022 13:58:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <Yhhh730RX1HpdXp2@google.com>
References: <20220224230035.36547137@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224230035.36547137@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/24 23:00), Steven Rostedt wrote:
> I've been noticing that my tests have been spitting out strange output on
> the console. It would happen at boot up and then clear up. It looks like
> something screwed up with the serial timing.
> 
> Attached is a dmesg of one of my test runs as an example.
> 
> I've noticed this on both 32 bit and 64 bit x86.
> 
> I haven't had time to look deeper into this, but I figured I let you know
> about it.
> 
> And it always seems to happen right after:
> 
>   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 
> Maybe this is a serial issue and not a printk one? :-/

Steven, did you notice this recently?
May I perhaps suggest git bisect? (sorry)
