Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B763B58CB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbiHHPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243752AbiHHPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:49:13 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A1A1572D;
        Mon,  8 Aug 2022 08:49:12 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id w6so6753971qkf.3;
        Mon, 08 Aug 2022 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3YuKysJ6SUi7XM5ub76x1HcRzTy5Zg6xfhZ6fRfKq1c=;
        b=pBzU1olC4SeWCC8Hos3DuUl5uXgI3UhN7VQs50KteFFIU+eW3DPV2+SC6VCePCfrCY
         z9hKwwYHv9JmHauF9GoiPn19V+2y2OZEfOjEyCn3omyuq/AIMDWPW+Uu6dfwkZcKC1v1
         O+jHbdQNUTiOXby+6tunzTU0dUTehk6ngfWqIV3DsJV3waqDAarNAT2tmwWFpa77Ws5o
         99UWB0wMIDROoEYGWr46Iwel+SGEsUivXqCnFypezBZ/kFq5/PF4+8n87yhdmYR+Q+5Y
         P0rDmUt+jSnYVReRZ4E9IPRlVupXPcG9EvLqD7aJXf00a/WHGUdaFjO1PE/L/GDIaesD
         dv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3YuKysJ6SUi7XM5ub76x1HcRzTy5Zg6xfhZ6fRfKq1c=;
        b=RLTIgYPya/IevC0PyFDU8i13chNcKvlvkgpYBB6uPWWBbKdb/Ceb5jMxF42n0RRgjg
         2jOavqrrPiFIruzLPP8Ukwqqy6PDKU3dVPp5pyZQ/auME20/tqDIi3dHV3yIluwRzdZo
         99sM/xu3lxCA2LVrc6csKkmk5Bk8KhA89iVIzIDOpER46l9VhEJv0bx/4bS+vgzwI5Vb
         ynLafYJAxfF+XX9Y8HAkil/sDH1UvPuMHKIHMf73RKjiuG8q0V0sy6d8oxHzvF/ONbK4
         snbCflnuUHrMR6jZE8yKLaOG5cnO5W7W2faOa0SZoF5mUsLIStwbmRzoZ2dJzRXnzgTq
         q+fw==
X-Gm-Message-State: ACgBeo3VuOXWoNpXmndJIsyTGsr7y8mZPmP/RGam6/Z4e+pfiGhhKnwr
        LPH6Onj4pAysPnD0RiJyvw22e3ON6JRoUmOjpwU=
X-Google-Smtp-Source: AA6agR4R1VTujA9OSeHWsup/hGRNoFSUfr04MkyTPAUNImHNAb+BPr5rf8qtlTJ1e/Spjasu9ychwAUemAi8vYp3ctU=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr14142236qkb.320.1659973751791; Mon, 08
 Aug 2022 08:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220808031132.10075-1-luke@ljones.dev> <20220808031132.10075-2-luke@ljones.dev>
In-Reply-To: <20220808031132.10075-2-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:48:35 +0200
Message-ID: <CAHp75Vds+DmQdeuSM7ixtZiX60jg83CWveFZNcQoQ=QyiqcvUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 5:12 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Due to multiple types of tablet/lidflip, the existing code for
> handlign these events is refactored to use an enum for each type.

handling

Can you run a spell checker for your commit messages?

...

To the switch-cases, please add a "default" case to each of them.

-- 
With Best Regards,
Andy Shevchenko
