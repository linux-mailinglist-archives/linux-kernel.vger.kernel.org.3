Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282334C370B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiBXUug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBXUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:50:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230FA1CF0BC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:50:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y24so5985938lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7Q/Yaamh7u6ae3y6zkq/joMW6amPe2G20eLGXBMeLA=;
        b=LMlhah8SdQ2JxJ3A8LX9FtEG/kjw8TtC5fVbS/xgmC3I8CaYr7YE7fHIhHIsMq1g/g
         cjqxW8PLx4H7meNqtjpmtNS5G/RcHX3ub7b3DO1/cdh37glVOLbzVCbDvBeCqu/3NLzu
         SxnprZj4hBezMb3ITkFaMHuNdEazF5zxnNEhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7Q/Yaamh7u6ae3y6zkq/joMW6amPe2G20eLGXBMeLA=;
        b=iM67vli7AugwovoZaacp8/PgGHM8/xpOBUhOvABEYTQdarrMbD5fEisldZVTMPlUe5
         /2LJrzNPub8vaOZeXERpq+DchgBRRGcP2uS5X/Z2a5vR9Q4lVPmCZ/ruH9jZ3MZxh5Ev
         vOFPbpYVCNnDYbX60es1I7SB3wl9pCuu7aN8EJG8w0AGtk7Wr2hPCynuqWMBKJBNtjnh
         ctWEe6r5nHUoZ6E6HL0ynoxpR6NqP8uETTgX29YgDS08uAk0oxmc4Rnbd4oRNSELvDZk
         IADc8GLf2DPKEeSboFnmMA+QaHJxnw98lqu/nddIWlxx7VaqDdo3htFHvkVRyHbySC1u
         CHWA==
X-Gm-Message-State: AOAM533/j26e0Z4O0iahqCMODXgIDtsTHUPWphMZ5pwmq9cUxn6mC0eQ
        kj1QE95MRL1NMpu6jk+SIReIWgEfGnn6Howbrv0=
X-Google-Smtp-Source: ABdhPJxmK0V71o4b91cdGJz638BleqbSAin2SvaSXQCoA+kQcS8pWmszXU9JUpJbscRKqy/ELQcsMQ==
X-Received: by 2002:ac2:442f:0:b0:443:7bee:85d5 with SMTP id w15-20020ac2442f000000b004437bee85d5mr2779836lfl.294.1645735800110;
        Thu, 24 Feb 2022 12:50:00 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y15-20020a2ebb8f000000b0023134a7b265sm70977lje.36.2022.02.24.12.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:49:59 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id y24so5985845lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:49:58 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr2706158lfh.531.1645735798149; Thu, 24
 Feb 2022 12:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20220224195305.1584666-1-kuba@kernel.org>
In-Reply-To: <20220224195305.1584666-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Feb 2022 12:49:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWmb9fw1wnuZmaPca92X6+Ot1revY3+t2TKVc--xEVyQ@mail.gmail.com>
Message-ID: <CAHk-=wjWmb9fw1wnuZmaPca92X6+Ot1revY3+t2TKVc--xEVyQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.17-rc6
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Feb 24, 2022 at 11:53 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Current release - regressions:

.. and not listed here is the build fix for IPV6 being disabled that
has been reported multiple times.  Thanks.

                  Linus
