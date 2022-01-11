Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAC48B472
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbiAKRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbiAKRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:50:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2CC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:50:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u21so47726708edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+o36HqJyPabSJM6qxiXAbPNSzH3hT+Ar4koIOaCZD0=;
        b=fkLdJd8K8wdXwYwvY0osqkiYuLRASRV7iBfN8SZv/EKDgP0s0+LCVi0O3e6PonZ3qJ
         ecYvUOMstnQGXFphVswgObo8yA29aRGxzyOiBr6Y48lppQlGPBm/EmUaEu4eZhiIZp5g
         PhhhTNkHlBahJ2BulJEjbNG+r8oJMjOo0vlMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+o36HqJyPabSJM6qxiXAbPNSzH3hT+Ar4koIOaCZD0=;
        b=ZmOPPgq05ZKfKogscUljXz0lW075LRJL4DtJ9JxqsVTWjxiZn1JLAVJdO3DjrEifWg
         kg1i9cYtUuYsr94er1Hd1vHGS01I5beve7Xrl/TmkIbLPeB4LoY2+KaK/p+IyRjNePDl
         lR1ke2SBT2umYMADYpeceVVDmR1ftrLYS8Oim+0VLPwDLO3RtHTPYiuSFkH2gLvv4vgA
         OuZPRzM59NoZf4uQu2B2NC//Ub5mcWbkfJq2QRqRXPNULY1UQk+peMc5iSKLtmtR5cpR
         z+QCJ4FDDVLAUS9ShilyIb2ljk0Z0NcdWMDRqbDrrG1CYo8kDJYWnQt5N8Ll96Bc7vZr
         GTwA==
X-Gm-Message-State: AOAM532BJlZEM7Yu3FDHVKxr0sJSgsRpMcJw9K8un24YqOeT/a/x+4df
        DPmf6cAa36dtLc2717NqCmpg3dwAiuI5ofIM5c8=
X-Google-Smtp-Source: ABdhPJz0Vnv2ocZi7lTWSVwMB1zI9r4F4JPs4lM1XavJhXUMjvDYkttjmpxwrp1SAavZkoGs0nJOfA==
X-Received: by 2002:a17:907:d29:: with SMTP id gn41mr4546141ejc.538.1641923456147;
        Tue, 11 Jan 2022 09:50:56 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id gt20sm3857971ejc.11.2022.01.11.09.50.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 09:50:55 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id q8so34345308wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:50:55 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr4682353wrp.442.1641923455029;
 Tue, 11 Jan 2022 09:50:55 -0800 (PST)
MIME-Version: 1.0
References: <87v8yrjtqe.fsf@meer.lwn.net>
In-Reply-To: <87v8yrjtqe.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 09:50:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiR_RfCq+ckZOEoV14CAV1+Vua3DM9XU30fxaVhqJ9RMQ@mail.gmail.com>
Message-ID: <CAHk-=wiR_RfCq+ckZOEoV14CAV1+Vua3DM9XU30fxaVhqJ9RMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation for 5.17
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:06 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
>  - The ability to pick your own theme for HTML builds; if the default
>    "Read the Docs" theme isn't ugly enough for you, you can now pick
>    an uglier one.

Wingdings isn't a choice, it's a way of life.

> The KUnit documentation update leads to a couple of simple conflicts
> with the KUnit tree - but they wanted this work to go via this path.

Well, I had to pick one of the configuration note rewrites, and who
knows if I picked the right one.

            Linus
