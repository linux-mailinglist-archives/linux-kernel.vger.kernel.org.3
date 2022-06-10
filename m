Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7355466CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiFJMsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiFJMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:48:34 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B321E1B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:48:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e184so46823391ybf.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Sfhj5wdwRUjdvuShztWnVmtciB4bmqpt/yCTTC/qT1Q=;
        b=qoZTrQOJJqrmNKCLNaP7NcaBbh6iuWsbFYB4xngaH5zEuOzNZW6X3YyQT+0y+znjuR
         6QqH53aKiZ0M6kT8bMm5wk4M2Y7q6LbjfmYtl2kHAxSbgXzm9cPQqj8I1+HQOlC6KukY
         3rxaQFs1KPUP8o9qvjb5DsegfPRckr9Op4Diqhg6tyzHowUpPFO5Z4nj4YqEcS6LtBTs
         kfPImQh6bzaT+3Wbuy/KCB8B2VTUIFcIW87uswO5foKzxgyADBNrDPlCGSxNW6vqeKya
         r16heKxo6iDywBjlZy/PuvQ7l3ebsiOZnpia3wOvhoAmX1VEEQAgsur91muSJ53DrknD
         eSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Sfhj5wdwRUjdvuShztWnVmtciB4bmqpt/yCTTC/qT1Q=;
        b=nHDxVTXVjQfVNV8m15kBMyUcTYIV4odxUxO1M+uLdZPEKlJKcQVuKWWKUideibuG8e
         oghAGjAO3flmuWSkeFGOgF89uBDRo9FerYi45szAgSYxMJQ+0SCyuJLBYz6eldBqSp6N
         pFt9x17sjqGb5XJMby3QwQWbHNACWlBL632Xbqjqq6dkFFLY09gQ2buGmLeSHjDcaCe2
         67f2c9FMfeKjaqEM2y8Ndg/XXaTp+FIesUSArEVpXMDg3Li40MitEZ01Gwj+q68YWHZx
         M7iuwCHV8EuZ1raP3cjxk0AWZ0p0zsunHVmt3/cy7yG50Xli43qetHX5vQwOvrPixcl2
         nEEQ==
X-Gm-Message-State: AOAM533Wobagk+WVOb7cQsc3Na3/8vKL1Z7GWlQz/mLqTAZwqJNMMVyD
        L6PJe8oobeYqmGJ+3nJvSln1/k+1BsU0imYpsYs=
X-Google-Smtp-Source: ABdhPJwgGuJKr0Lv+asRzvW54Hvakrc7XqpEufJMBXIOtQFdLCsHv05NLGfrUagPF2W/jDZvLrjpttsGr6KfKNGRq/w=
X-Received: by 2002:a25:7611:0:b0:65c:b595:2822 with SMTP id
 r17-20020a257611000000b0065cb5952822mr43370508ybc.228.1654865311641; Fri, 10
 Jun 2022 05:48:31 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 10 Jun 2022 08:48:18 -0400
Message-ID: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
Subject: [BUG] Threaded printk breaks early debugging
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

First, I love this patch from a functional standpoint! However I've
run into an issue debugging early boot issues. Anything that causes
the kernel threading system to die (for example here, a NPE) causes
the boot console to halt before it outputs the error.

Would it be possible to have both a kconfig option and a runtime
option to toggle printk_fallback_preferred_direct()? Currently I've
had to force it at all times while debugging.

Thanks again for this amazing work!

Very Respectfully,
Peter Geis
