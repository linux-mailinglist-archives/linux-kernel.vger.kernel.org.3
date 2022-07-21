Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837E57D160
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiGUQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiGUQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:20:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D2175A9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:20:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y8so2807840eda.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYNUaK8jJFnuvWY6ZaXhNrlKEurX99oKVRVffSa9xdc=;
        b=kezGf34ZnjTW9umEubulc7Ol1A6+x9snwxhZCv9yKmnBHNVRzTmI2V6Mw7vOhKLMkn
         /Yl7oorqlgol6xpJqBaaJ1hrCFYXyiu5J23mdxpxVxTBzfdFMNr9HcU04iW9lnuG9Ksp
         VMs3AXhsrFRFVGqbg70L2UXsGEmbYtBT3gxXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYNUaK8jJFnuvWY6ZaXhNrlKEurX99oKVRVffSa9xdc=;
        b=CPmEsDUHAfblsGpKMtf8+ufeBYu/3kyhXhhzpYZFugiK/2dte9vpHJkYyUtzZBFEz0
         8WJ3dLcxN0jz3waQfeENq/bnNuamb4nNfPXQf6Jml35/x64YH//Ty5BAzJa4dE3OMu8a
         5azed/67Gqq5nCOPSVi1eI05ZJgQxBrN/2x77CZSMXXeQA8M9HWk75/XwMPe3gCB5dn0
         O2D1lw8ExgtAntWoIuiN1ezGmKlp4ITxhdj/92kL4qUM5eoL5vHtY5NCFMaVVWz1p/FW
         besI6a3EHNoyPwBNiVm6tQH4Pc1xIqTZ/7v9I7NuX/M0RSeaoUZd51bp/FIJZvTXW5ET
         W4GQ==
X-Gm-Message-State: AJIora9ZCGV3sMZloQngu/l3wsfcWrRVzCnbkTpNHZVYtXc7GkzcbnUW
        G5Vznq2H6HPF8YDi0SpXONX/ZQ==
X-Google-Smtp-Source: AGRyM1s5u/R6VD5+aHBYsanOpWipN6QpdKchPowNlKVgxx9kMrZoUZTbiO9LinCKCd1t+17CUYTgpQ==
X-Received: by 2002:a05:6402:5114:b0:43a:d072:83b9 with SMTP id m20-20020a056402511400b0043ad07283b9mr59270396edd.260.1658420434189;
        Thu, 21 Jul 2022 09:20:34 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:bf07])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0043a6a7048absm1213986eds.95.2022.07.21.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:20:33 -0700 (PDT)
Date:   Thu, 21 Jul 2022 17:20:33 +0100
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
Message-ID: <Ytl80XBaaa4cCtoT@chrisdown.name>
References: <b9fa85cfed3a97ab4292daca51476e4e23da2f9a.1658339046.git.chris@chrisdown.name>
 <202207211731.9YcNa5UE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202207211731.9YcNa5UE-lkp@intel.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will fix for v4.
