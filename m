Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7A513C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiD1TlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351454AbiD1TlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:41:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA11AFB37
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:38:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so8079403ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PviecKSNBQ9rvt14y/CLlsqQGaNe4zDSNifKgF5FE5c=;
        b=Mk/ZjIgpPO7ZjCxNJRE5W4RfcBcM9U03fLAGiHpSCx9OJwTUlKZlQFlhx+wLCTDfvD
         n4Pe7ckjUJ9CJogJ2um0a73RMV3NqhLe0fs6B+hSn1dc7FUEAtYSuVxnqaDMDdOOkmNV
         MfsNo4pco1mgdD+H5I5Vudi9U/F1WunaiWSOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PviecKSNBQ9rvt14y/CLlsqQGaNe4zDSNifKgF5FE5c=;
        b=c2ZaP/0cunhZliVrCu/Nbls7+jhURaK8dnC+Kyuf8wsDByFR4T3vTLGQSIbYMXYaiE
         Skfe6MI7BowOQA5eCLGshxiw8wtg1QP5HTevh4rWXvIixos8cyrn6ctGpdP5V23C37xA
         6zBdN9hF+V6aQXZqehYVHxirwSCWk09r8ToRMifZMg3tgidl42yYtcZDK0uZS8xLiuy+
         ZGV35/vQ5LACQ8/pp/479oSkkKo0gZ4NlNW2x/OjeKHrlmuG0WQ9pEZxf3Isbiozy8vk
         /sdx+fYVekJ0W29hZGPxLa8jmOESQCGq9tUqYm+DnCtxlZX6KjWWgZwPTeMrw4ueDVb+
         BWvg==
X-Gm-Message-State: AOAM531Cl3uOqR3zAG/CUh5DfAOL4Oq9x73ZeFvD5JelE56mO96G0j//
        NoomP5/nmuGG/F4pTPPbqXw4Cyl9JmQKTqK16aU=
X-Google-Smtp-Source: ABdhPJziK7tyOqOGcdBpY4b6ce/9SE7BVVuej6aWBd2yz0/ogU9nk4TMZDAL9O4nUbNfGozTCa5TYg==
X-Received: by 2002:a2e:6f12:0:b0:24f:2109:f038 with SMTP id k18-20020a2e6f12000000b0024f2109f038mr10066814ljc.311.1651174678544;
        Thu, 28 Apr 2022 12:37:58 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d14-20020a19f24e000000b00471a405963asm75519lfk.304.2022.04.28.12.37.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 12:37:57 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x17so10402922lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:37:57 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr24901401lfh.687.1651174677085; Thu, 28
 Apr 2022 12:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220428182554.2138218-1-kuba@kernel.org>
In-Reply-To: <20220428182554.2138218-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 12:37:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivb9faQ6Xuwfiqr6r1uHaR4a-i2oi6u142tWDppS-+gg@mail.gmail.com>
Message-ID: <CAHk-=wivb9faQ6Xuwfiqr6r1uHaR4a-i2oi6u142tWDppS-+gg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.18-rc5
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 11:26 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Misc:
>
>  - add Eric Dumazet to networking maintainers

He wasn't already? Strange.

            Linus
