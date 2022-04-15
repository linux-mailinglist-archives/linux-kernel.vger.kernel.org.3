Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA9502B41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354137AbiDONv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiDONvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:51:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761A65781
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:48:56 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso5434146otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oYla5eM88g11+YBO1ayh9P0EEyH36hXdUpHH4l9SgYA=;
        b=asQjyftN589QcStRfQhEPw+854ItHOO585YkA3DIxf0OK+iVar4H+wRMM6l4GLhmvH
         CXQLAoQPv/WkOvuVRGmIf4vEtTqxnE3cbzAu6C7/J9AeleLHGEJQYwCAoAu6rhYQdPKN
         lAhxg9tpM1L10Zc3+vnRC9YEI6iK0kw9OH137oCc/i5K5EwMSAI2Z6cS+uh5cdJu8NYj
         IGXkp1ArbmqUVeZAc6A9zfrOAQzSfPabV2MDgYL9n++4UchnMW2nyq5XdrL/qAIkS7jL
         Jju8JpcDvugNaXcT9gNaVhzpLOnQPhw12LcThx1cFYWWf6Hr+Jo3vGyldcjhm4BmFMOg
         SfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oYla5eM88g11+YBO1ayh9P0EEyH36hXdUpHH4l9SgYA=;
        b=vKZns2A0rgpXba4xA+2PySwzUvJfyBcWNt4kEDRk6pNzOdyzsyDT9dQTfdrNb7oasJ
         rJuhIMqrObIA7/nsQrlek1BqC0Od6N0TEbJNxDeCWv3iH4y7WDdpNk/fBDgCPvNvI2NU
         P2xY6h35Br2zN3KoAe3Z+dxNnbu/3yJ/l1zC/XNjPmLfcYt2ZQYAQnNQpghrsQBLqCVF
         ilhNLr+fqojL5F9s3KBU6n848Pu2EIkQZbH7ja0bTzAATO3RAU2jemGwCZ0Q4AUS1+Z9
         Rjtil/IQcsU0Z8BjT5DlWH1QRABLMMA97tmThUL3WAcbLDv7liq66kEgccI4to0aE2oD
         0aYQ==
X-Gm-Message-State: AOAM530TFyiSIuxqiZ9PTe9ofKsulDa7/iaS8NlQ3CU8WeP0xNrZgVB5
        tsIYikgxwm8oQbtlQpX6gXRaSogMXZc=
X-Google-Smtp-Source: ABdhPJx8AxCJTD4XzuFxmkFFDvWgT4sujeRGIWg5QVXw/n38UYO2+ps+V061yTQA+GLcVyXNAFk3OA==
X-Received: by 2002:a05:6830:1af8:b0:5b2:4e36:ad5f with SMTP id c24-20020a0568301af800b005b24e36ad5fmr2580407otd.257.1650030535811;
        Fri, 15 Apr 2022 06:48:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3-20020a056808138300b002f76b9a9ef6sm1170986oiw.10.2022.04.15.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:48:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Apr 2022 06:48:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] sound/oss/dmasound: fix build when drivers are mixed
 =y/=m
Message-ID: <20220415134852.GA2271702@roeck-us.net>
References: <20220405234118.24830-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405234118.24830-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:41:18PM -0700, Randy Dunlap wrote:
> When CONFIG_DMASOUND_ATARI=m and CONFIG_DMASOUND_Q40=y (or vice versa),
> dmasound_core.o can be built without dmasound_deinit() being defined,
> causing a build error:
> 
> ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_atari.ko] undefined!
> 
> Modify dmasound_core.c and dmasound.h so that dmasound_deinit() is
> always available.
> 
> The mixed modes (=y/=m) also mean that several variables and structs
> have to be declared in all cases.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202204032138.EFT9qGEd-lkp@intel.com
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> ---

m68k:allmodconfig fails to build with this patch in the tree.

Error log:
sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used

... because __setup() is empty if MODULE is defined.

Guenter
