Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461D453D24A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349134AbiFCTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349309AbiFCTPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA853BA70
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DAF619F1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 19:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A6C385A9;
        Fri,  3 Jun 2022 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654283712;
        bh=oO/9RTOGeKeE7XOJRtdKUgYTY2usFFeexnx4Wu0J3Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zNTCmxruB8ygZWnTET/Buk9Oj4KwPTFghzLFxHEEB6rnhZjw4GHG0kntpEIbEtVkh
         qL2xAsPQdOMHGYc6ECPm1JMF7vq5F2t0WgDOuHqpIlpr9sRkIe2GSnpnpVB0FGfk64
         UbUosyJMAU84Tu4OL+/naITFoo1cNfxcQQMW2iyE=
Date:   Fri, 3 Jun 2022 12:15:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel.h: Move sysfs related macro to sysfs.h
Message-Id: <20220603121511.78aa66b02376d02557c29819@linux-foundation.org>
In-Reply-To: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
References: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jun 2022 20:21:01 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> As stated in the comment of VERIFY_OCTAL_PERMISSIONS() it's related to sysfs.
> Move it to the corresponding header.

arm allmodconfig:

In file included from arch/arm/mm/alignment.c:11:
./include/linux/moduleparam.h:294:13: error: implicit declaration of function 'VERIFY_OCTAL_PERMISSIONS' [-Werror=implicit-function-declaration]
  294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/moduleparam.h:330:9: note: in expansion of macro '__module_param_call'
  330 |         __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
      |         ^~~~~~~~~~~~~~~~~~~
arch/arm/mm/alignment.c:87:1: note: in expansion of macro 'core_param'
   87 | core_param(alignment, ai_usermode, int, 0600);
      | ^~~~~~~~~~
./include/linux/moduleparam.h:294:13: error: initializer element is not constant
  294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/moduleparam.h:330:9: note: in expansion of macro '__module_param_call'
  330 |         __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
      |         ^~~~~~~~~~~~~~~~~~~
arch/arm/mm/alignment.c:87:1: note: in expansion of macro 'core_param'
   87 | core_param(alignment, ai_usermode, int, 0600);
      | ^~~~~~~~~~
./include/linux/moduleparam.h:294:13: note: (near initialization for '__param_alignment.perm')
  294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/moduleparam.h:330:9: note: in expansion of macro '__module_param_call'
  330 |         __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
      |         ^~~~~~~~~~~~~~~~~~~
arch/arm/mm/alignment.c:87:1: note: in expansion of macro 'core_param'
   87 | core_param(alignment, ai_usermode, int, 0600);
      | ^~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:271: arch/arm/mm/alignment.o] Error 1
make[1]: *** [scripts/Makefile.build:500: arch/arm/mm] Error 2
make: *** [Makefile:1839: arch/arm] Error 2

