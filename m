Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FD536EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiE1VcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiE1VcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:32:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13373E2794
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:32:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jx22so14439506ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxJ2r+TNsnnanLqRYy6MfloDYXh7EMOaPV3imVB7Wvw=;
        b=dy8wgzL8sXuJCdScjCxW4XpI2m3YN7EeRyQTDRIZPUn67i8QQPBN3cSZzwvjRXeFly
         xW8wjWOIyLOHGTHlC3kFPfs0sLkzVJ+xrrsMxohx9ZQA6Xqc7DF7bSTfDr9nSxZv6XYy
         kXW9F746szWArPdzVe+8MgPoZ757on9a7qavw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxJ2r+TNsnnanLqRYy6MfloDYXh7EMOaPV3imVB7Wvw=;
        b=Ud0iNgMGbsLx8by6JALsJ03UZTjUx7+qzG9As600d1lemELmGNcfQHbpzLCVyBu49d
         +b+fLml82GOuPlPo0KetXwIg/dUxJFY/Bt/pZklvcfcjoNzEFCEWe+xe5hqKPa96da3V
         a994x1mNHijuU3WJnt3t5v0qRKMxK9rJz/CwqAT7pynUSDutRBpMxH9XCP9uEUWQubRi
         daIaH3YhxxFxGc5BtS+9LyVe/MzpbDAV9VNLytneFn+GnK+bSbnoROZbsB7qjaqBOolr
         3BVf7FYHDMmbocjnma4Rt9oIk9NMBOXdZSVv9nKN0a8LRckiWpSCYA5yw4Yu3EBA0ewp
         Upgw==
X-Gm-Message-State: AOAM530y4ai1/MZlmec/pkXbSpGtiVNbpsY1XP42DmP5jUcgIJTzESNM
        GyvTlzB4cTIIIgWRWKXzs0HxFhngEKXJA7COfws=
X-Google-Smtp-Source: ABdhPJyPtyenhXWKGjGMSWqW00pAi9Z9UoEvZ+hFvudfXlurYfu4BmEcypY2bm0miAYmOKWdsfTrlA==
X-Received: by 2002:a17:907:971d:b0:6fe:c919:bb5f with SMTP id jg29-20020a170907971d00b006fec919bb5fmr31779234ejc.301.1653773520330;
        Sat, 28 May 2022 14:32:00 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm2706470ejb.172.2022.05.28.14.31.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 14:31:59 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso6456130wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:31:59 -0700 (PDT)
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id
 m17-20020a7bcb91000000b0039732250244mr12531851wmi.68.1653773519322; Sat, 28
 May 2022 14:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 May 2022 14:31:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEepjsY0-fDr3eyhOzJ6rOnOr1N+Zm73hth+rMkDp01w@mail.gmail.com>
Message-ID: <CAHk-=wiEepjsY0-fDr3eyhOzJ6rOnOr1N+Zm73hth+rMkDp01w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix some compile warnings in v5.18+
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 2:15 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> Building driver r8188eu in staging with -warray-bounds exposes two places
> where arrays are too small.

Odd participant list.

This should go to Greg, not me, and I think you should cc the other
people (ie Phillip Potter) listed for that driver too, no?

                    Linus
