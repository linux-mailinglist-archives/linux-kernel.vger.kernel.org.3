Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B9358A33E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiHDWXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiHDWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:23:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD0D80
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:23:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dc19so1734743ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wuIPXhY3idzutB593GnZw2u5yq1WdheojfsMIxWh2/0=;
        b=Y4f8uCDQHkxULs2LgwGBy1r5w46rj9fLBgLdZCIsacIjCprXVk3JuuEqv7aV0Rnmlb
         qTPzEhZIgsw2LA0ahseJwV3m4WUCrV7t7HgOwO1F9SK8HLYuP00b8C+9BYXBJV17rwZD
         DmSzqjfEz/zZfy+UKMdMX9sy7p0sgtZB3f0GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wuIPXhY3idzutB593GnZw2u5yq1WdheojfsMIxWh2/0=;
        b=zRD4MyAvhuMrITHea+oo2+/l1WzhQd17ItiF5aspe+t3XFc9aYN+JZ/C5AE5S9trzg
         AZ8ocepYaMszXQDrQn71jwR3f39T+oGsXAAQ7QD6HwcwI+C8a+goL/IXFnoYHN6GPBRe
         uwZ5SCmgvBHRWIOCoxaP5KRGh7es9lzpmCvzVGNoTF2rORT+WCh80pyZ7i3vEazkWFSd
         nO6Qf1s/0qwgragdWqjS3rVy1oWf19tvLtPO0BWE+yGBej6+oX4uSsGNWcByuz0gFDW6
         aJNxhYQovH0FXz2ceyihJnjCERA6pN9oeSaqzSmQxGNvPD1+bM0QNyi4ELzqBBnHpdCR
         QYIQ==
X-Gm-Message-State: ACgBeo1iUfC2Ffb7Virl0PbtIa77IZSIFD+IH645v3WN9ssP8bRNSTwM
        CKpcLQCJn2MHBImhULlIMfbLB+rDBAfw1maO
X-Google-Smtp-Source: AA6agR7fjkN163FKToIq2BFJhtNm7YXmC+vYPZBhcHo9AglYC/Kz1Fe3LCH/UvQg6FvFUpXyfhmLYQ==
X-Received: by 2002:a17:907:2d93:b0:730:d347:8b6e with SMTP id gt19-20020a1709072d9300b00730d3478b6emr2974328ejc.305.1659651813905;
        Thu, 04 Aug 2022 15:23:33 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906319800b0072b33e91f96sm763706ejy.190.2022.08.04.15.23.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 15:23:33 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id b6so571679wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:23:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr7251490wmq.145.1659651812985; Thu, 04
 Aug 2022 15:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <Yuo/mq0VrqTH9BS+@samfundet.no>
In-Reply-To: <Yuo/mq0VrqTH9BS+@samfundet.no>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 15:23:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6SoG7iSDLijPKWQXhJkfTknMTQ9ZUUTpz+pY=Sq5ziQ@mail.gmail.com>
Message-ID: <CAHk-=wj6SoG7iSDLijPKWQXhJkfTknMTQ9ZUUTpz+pY=Sq5ziQ@mail.gmail.com>
Subject: Re: [GIT PULL] AVR32 change for 6.0 - outstanding cleanups
To:     Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>, hskinnemoen@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 2:27 AM Hans-Christian Noren Egtvedt
<egtvedt@samfundet.no> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git for-linus

I've pulled this, but can I please ask you too to use a signed tag for
pull requests?

No, it's still not a hard requirement for kernel.org pulls since we
have strict rules for kernel.org anyway, but I've successfully
bullied^Wconvinced most people to do it, to the point where this merge
window I've so far only seen two pull requests that aren't using
signed tags.

Please?

                 Linus
