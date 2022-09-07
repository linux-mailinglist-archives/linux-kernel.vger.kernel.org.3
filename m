Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD195B0BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiIGRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIGRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:44:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9AFBD771
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:44:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 202so18022106ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=N+KH0bFLs52wGl8kzsXXlEDsvOIn0U7dgBgJ6SkG/So=;
        b=Aoe02Mj5izznE3nsHvWbwiuwxP/svNeaiait61fx8gNuWRmRXcKHoL9Adoed44LPmC
         7Px5DVwpwvu1FVTGhpVAqCOmCYjY1c8lttl3+JoBw+FZ6QdfI6mW+Se/C1MVbE9CpovM
         47KweB6a35vnC0ihHF8MH1nX54sLf60teydGpUbqN4V7BLUGwLbH337GsAlCli2d/aOr
         MC8ot8rXUcYNE2ITrwDvFbIYuF2TbPX3UHm2sCeBlMDIcjKyfX6KZRLuUMlNnSlBS1Ux
         r44QOCqjaf4F0OfTvVPpLYj2MtcgajUO4BCVTcdZZNfbca+PHVS/oJTaCcJxqPLUCSNb
         r9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=N+KH0bFLs52wGl8kzsXXlEDsvOIn0U7dgBgJ6SkG/So=;
        b=Hh50ULmtOwmNmPsULlBdNskBqCA9Hjp97aBpYzrqUldiktQrWHPge8mYPwSGuWYWTA
         wcH5P1k9IrHJZs8KODkdO1usNP66yxcMnrvfbWASRwtAA63O0qwd9cTkWe1CoT0+Mu1z
         725bv8Phwk2PBbwVtKgUjf5H7pL8FT9r554CrIbc54i4v9mx9besQfg6QNi7maFuI/Km
         C+vzwby/nNYlfixtpZhGAgkc9Mbv9o+9FRtaxDFaqUth4MjCqG67On2keRkrwjhNuU6q
         ZXjyq4Qh3qyJh/9k+HUt/nLs5z2Bu5ppb7mbrSqr248jmnga+SQ/I4rE8DA0apYnQJR7
         KjtA==
X-Gm-Message-State: ACgBeo0rdROc8L5YOrbp4aK7pwocCJIQLlORxS/ubxXjwievTo0Yc/x9
        uK8/C0GnVX6Z8f/SuYrJNQJs7ujIqH4sNYayCdG3CA==
X-Google-Smtp-Source: AA6agR5JdE5bkesNzzxbwqA+UWtd9va9jrqL6BDhUAQIpLp41G5EDtiAnmNRcVYiAJuIVb7BChOlukChQiI+Dr/naCo=
X-Received: by 2002:a25:602:0:b0:6ac:9a9b:f587 with SMTP id
 2-20020a250602000000b006ac9a9bf587mr3750619ybg.125.1662572648292; Wed, 07 Sep
 2022 10:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220907173903.2268161-1-elver@google.com> <20220907173903.2268161-2-elver@google.com>
 <YxjXwBXpejAP6zoy@boqun-archlinux>
In-Reply-To: <YxjXwBXpejAP6zoy@boqun-archlinux>
From:   Marco Elver <elver@google.com>
Date:   Wed, 7 Sep 2022 19:43:32 +0200
Message-ID: <CANpmjNN2cch+HDVUYLD27sF9E39RaFrCf++KN=ZZ7j0DH8VaDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
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

On Wed, 7 Sept 2022 at 19:42, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Wed, Sep 07, 2022 at 07:39:03PM +0200, Marco Elver wrote:
> > Adds KCSAN's volatile barrier instrumentation to objtool's uaccess
>
> Confused. Are things like "__tsan_volatile_read4" considered as
> "barrier" for KCSAN?

No, it's what's emitted for READ_ONCE() and WRITE_ONCE().

Thanks,
-- Marco
