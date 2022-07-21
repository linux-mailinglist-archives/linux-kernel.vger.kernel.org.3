Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFF57D17D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiGUQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:30:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5789649
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:30:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l23so4086864ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SikF4WEbroC+ee0jskL7hu5VA64LXeJBDP12R/A1emU=;
        b=Iy36JBH8NSYyPJDbnm7nYcUD+fzlk85sRYqRwBUl1k2RyS0t1FB/CT3xLh5M7006rr
         UsQz2z3CwUUvXyAs4X5N0tmUfhjn5pi27JVFWpTikKmIT3eO1DVCUAzOmyjoMpo2XYbU
         zF/0Jvkt8mk322XdAi8/ZbQA1KjT5C/FXLB28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SikF4WEbroC+ee0jskL7hu5VA64LXeJBDP12R/A1emU=;
        b=fPZiPQEVDVGhMglJ5+jDKrry1z0NfirCelEvLFTq+lvVRfY21tteiK26NPmnfo8W3K
         0GHqskW89yC/j6qEH7s05i9LwVj3WWaGJ2kY1fR4LoNkvLGDqoprllG8pOWPNIICWOmt
         uvYF4FUUkOC8I0WTd/J+7g0kl19ZODyyNGTwTsdrfLFvB0k1IyCtQ8BpI3FIsUUHhsCL
         nLfA4Sau9U4Qa5wOC4UB7E9KtikmrsOX1CrBUNuvI8joKCG6Oh6bYICn/Vl4o4FxvdJo
         vHG/K6dPUj3cP5ZE2NIPe8hEir1ElUNyrUY3eEBMJoD/mfEbuVbbOLUyVyPBUJWiRz/p
         bbhg==
X-Gm-Message-State: AJIora+h1iulRAJxeO2DqKZu97f5uOIrWpJ2doUYqBMB/mK/Vra7yrEo
        iLN/0mELU7kEbrr3vYxtKcu14A==
X-Google-Smtp-Source: AGRyM1tGDNSPTCixDUFMaYrFONIwHP90qD+gUKar2FeGvAbuySI6hqSAPxeKQV7Ez4Ae+q31ByJw0Q==
X-Received: by 2002:a17:907:7349:b0:72d:a080:f8b0 with SMTP id dq9-20020a170907734900b0072da080f8b0mr38030738ejc.389.1658421000070;
        Thu, 21 Jul 2022 09:30:00 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:bf07])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b0043a253973aasm1245386edy.10.2022.07.21.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:29:59 -0700 (PDT)
Date:   Thu, 21 Jul 2022 17:29:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <Ytl/B6pLOCRYVc7p@chrisdown.name>
References: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
 <202207220029.VYxE2uAL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202207220029.VYxE2uAL-lkp@intel.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot writes:
>sparse warnings: (new ones prefixed by >>)
>>> kernel/printk/sysctl.c:31:47: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
>   kernel/printk/sysctl.c:31:47: sparse:     expected void *
>   kernel/printk/sysctl.c:31:47: sparse:     got void [noderef] __user *buffer

Ah, since commit 32927393dc1c ("sysctl: pass kernel pointers to 
->proc_handler") we copy to kernelspace before passing to the callback, so it's 
not a userspace pointer. That's certainly an improvement.

Will fix for v4.
