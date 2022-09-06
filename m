Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B085AF329
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIFRya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIFRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:54:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D79C214
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:54:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id cu2so25171571ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K59f1Tpfob9n/llY6HrAt9pBw7AZwp44Lr77rOcXPy4=;
        b=PDObf7vFCbGSWNV4kWnyUou5IM7KJ+sNRDRNRPdolWMsXhi2ITI6riQuQHZJR/DNum
         Gh2esEm4P8TOkV7teSdUKVd7CBRxdcI1p1yIPXCc3OR1iCbd4EXCQWi1QSkgv1r4ysSk
         cJ1/hZgyeL0d+xXFJQsai89xsYBc54GD2jy4wfjFW/h+Mu75dTqLzJimHqLDrjLcsj7Y
         W2ae0YMJCUP7LEO6idA3NtuAI0F51t5Q06IwQb4j9jMQ70WfJ0qFy662jS/EAyvbNdlY
         vDs0IjqJxhVAOu4JQGrNhlD2BUuo88/A8C/lOKWDN2R22qswy3sXWF092F9IuZewBUOF
         RM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K59f1Tpfob9n/llY6HrAt9pBw7AZwp44Lr77rOcXPy4=;
        b=AiXxbSkkEWIC3IsHnsVjy2xQhOD0fR9B2xhtsgh9FRDSEZgLzQyRyjj7tBBGyrKzSh
         /SRXwhq4h1R1NE4FvfyP4aVMJ3i/2pCW9oIfHancP7QVsPHcC01TFnY0P6q6fM+OmkSA
         1VMnXnWkHzyzuKsO8NWF3KBXsCbYV8iWnzzz+BjIGR1n790TZzVmJz5s8D4TdCFeRmgV
         rFcEnBwBsDQbSlqsOTlBqzTNBcAF9u5mSUVdX8Up4sJg9S7MADeq4HCZiIgwV7igIpQ7
         TrsS3HCJDYCFjVP9qQChFcBWONC6jqy10a2HC2Z4CJfarBbROKzYVwfKY35AdCOqViwk
         7AgA==
X-Gm-Message-State: ACgBeo2IDP7yikka8a7k3IqLcai84dm6Ca8GwCkFf1Xq1bC3m5hz3p/F
        adDkxKX1UR3PIKo+zCC4w0LVHfjbEpxj2S1kAKpfcUsbPVd7eA==
X-Google-Smtp-Source: AA6agR51MYsEt6ivwSqpu6UMxCLznx2GE3B6Uyw2AaskZ4nTVXSeOt7nArLSeVttRGegolcDERQ7UTEeV1U5ZoeeZBg=
X-Received: by 2002:a17:907:d0c:b0:741:6115:a69 with SMTP id
 gn12-20020a1709070d0c00b0074161150a69mr32162441ejc.325.1662486854579; Tue, 06
 Sep 2022 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220818172852.3548-1-isaacmanjarres@google.com> <094b6125-6b3e-1b8e-024f-a924e4775305@gmail.com>
In-Reply-To: <094b6125-6b3e-1b8e-024f-a924e4775305@gmail.com>
From:   Isaac Manjarres <isaacmanjarres@google.com>
Date:   Tue, 6 Sep 2022 10:54:03 -0700
Message-ID: <CABfwK12ChYDmhvR2EO1q2NUS4Zhd1WO8UWWoSVNY331wwbKS0w@mail.gmail.com>
Subject: Re: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
To:     Gabriel Francisco <frc.gabriel@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        patches@armlinux.org.uk, Guenter Roeck <linux@roeck-us.net>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 4:15 AM Gabriel Francisco <frc.gabriel@gmail.com> wrote:
>
> This patch alone on top of v6.0-rc2 still gives me the null pointer.
>
> But combining it with Zhen Lei's patch (from
> https://lkml.org/lkml/2022/8/27/164) my device boots successfully.

Hi Gabriel,

Thanks for your e-mail. I think my AMBA bus patch and
https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/
(merged in 6.0-rc4), instead of Zhen Lei's patch, should fix the
problem entirely.

Thanks,
Isaac
