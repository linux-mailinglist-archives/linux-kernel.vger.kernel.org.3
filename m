Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07104F7323
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiDGDVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiDGDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:20:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AA1AE199;
        Wed,  6 Apr 2022 20:17:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 7so4231375pfu.13;
        Wed, 06 Apr 2022 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ECmt53ENN2jTSZ+yk9t7OqADM5aN3rmA/Cfr/iZtqyY=;
        b=B2+JO5yI+5wdX7wjduKgOK1iY+a3XE7RD/B53psTleChFKGU8uR6NlC7aEbOQnT+GK
         jmzj0P/hp4Qqjaj1ql+sWZfTzqeIiYML1mj4znX102qQfTdLGSqj2Fv0a3y46H5tjh/v
         MGEJwyONg40XJLEVY9LXL3KiwEBe2fKRQhyzqJHlJu076p4EVFjzjOcQm/xppYtPMVUA
         tIB06J4B5MXKeM3jBo1s11Zdrwz1mTYOYuR6TjBrCaatdIWzD94AZAFVx0oRk8qfd16p
         I3YrizpYId4D9frCXbqMMHAyXfZ6nEGb+67D8viks4jenaIn9cRFEL4jOVZlVbFloju/
         +gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ECmt53ENN2jTSZ+yk9t7OqADM5aN3rmA/Cfr/iZtqyY=;
        b=myFPgV1SDpezVCF/nYrk4jmBcaHXs8GA6344PnGEXurY7W3efVSsQB5b8ak+P4Bkh5
         MG579iLr54HunYnLqNCxrm4XI2cU2GNCRwGwczQvfezKTnQBBF3pcIV1cveFXSm/nj0O
         Xbtsz0wvi35qxuLXIPyPWVaWjO+8R7jX72n4MOp5yXmRYl/NpFga0RrGGi6idgMv1KlK
         xMOHvOZ9lNNjKdKUrzIWEjPCneIoAzmZRHi+WB9QMI6duDNvJskACT4oeuQFzRMFe+Og
         U/2Uc+nUfaVEopCEXodoydX8lF+1qS1fsjK9GLKrp2ZZ6Kr8Bmny2OKddjBvLsokPQjC
         z2Dg==
X-Gm-Message-State: AOAM533Ez8y1+0c4c0z5gwOfjZQizGt4bPEutXAUeARK3Mz3hmYIeLSA
        Q2PFtU8jW20Vt8Jr9M8tbfM7chqChKJ9Ms6tH2bOX6VLXA1vYb0=
X-Google-Smtp-Source: ABdhPJzYlHBFFCPID3c+aXfPnq/UcFoEGxXixn4hk3VaXklHv8GR8jnqqLMpdKT0daWDP4nq/YoE4opZaPBdZiX7uNY=
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr9783752pgi.542.1649301446095; Wed, 06
 Apr 2022 20:17:26 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 7 Apr 2022 11:17:15 +0800
Message-ID: <CAMhUBjmTObCwaF=enLNkRSzxqSzK6KdkHf+4cWo5fqOO7B40iw@mail.gmail.com>
Subject: [BUG] hwmon: (adt7470) warning when removing the module
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug when removing the adt7470 module.

The following log can reveal it:

[   18.459479] ------------[ cut here ]------------
[   18.459852] do not call blocking ops when !TASK_RUNNING; state=1
set at [<ffffffffa006052b>] adt7470_update_thread+0x7b/0x130 [adt7470]
[   18.460857] WARNING: CPU: 7 PID: 365 at kernel/sched/core.c:9660
__might_sleep+0x96/0xb0
[   18.461523] Modules linked in: adt7470(-)
[   18.464568] RIP: 0010:__might_sleep+0x96/0xb0
[   18.472577] Call Trace:
[   18.472778]  <TASK>
[   18.472957]  exit_signals+0x2f/0x3b0
[   18.473251]  do_exit+0xcd/0x18c0
[   18.473534]  ? __mutex_unlock_slowpath+0x1b8/0x740
[   18.473927]  kthread_exit+0x42/0x60
[   18.474212]  ? adt7470_detect+0x140/0x140 [adt7470]
[   18.474622]  kthread+0x272/0x2e0
[   18.474885]  ? adt7470_detect+0x140/0x140 [adt7470]
[   18.475277]  ? kthread_blkcg+0xa0/0xa0
[   18.475601]  ret_from_fork+0x22/0x30
[   18.475901]  </TASK>

Regards,
Zheyu Ma
