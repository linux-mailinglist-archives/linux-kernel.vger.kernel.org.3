Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12555265B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiFTVZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFTVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:24:59 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35051EC50
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:24:58 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-101cdfddfacso7885996fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9ifI65Hcjk0ar/WNQwl170y/WKbWs7okCtxxCy/qE2s=;
        b=kxQ9KYelCDOHLCxIXY4Ec9e+lo+qssx3BsNInwJUYnN3NeOHGQMEaw3aSTFIGBoMXw
         U0Udipi7DIYoCFYarfNbBADf1ksM4ESekmyKjLwZzXfcvjQafUCmyOKVzJsaiZgEwCEN
         ub39XMRq252e5PPns+fLndm120r20G9eZ1LgECBeWG8RHrJr42dbX8bOZuOaZ4maqO6t
         t7wsoy5i1XluLTn++5a9BgwOgZNfciZt4qCQMOt2PiKPF2Ryq22nQPQEpQ4H8lhNybKO
         C69lhbR0YT6Dv1u1odtNpXtjArt8bY5Mxt8nW7AHNNiZ6CSzhOtZskZJMwW4aiLOg4qI
         kKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9ifI65Hcjk0ar/WNQwl170y/WKbWs7okCtxxCy/qE2s=;
        b=WYLCHijI+CMaOTu6LmLD5d/nMKlmEQqB7leEWUgHnZusPw7P8DtPqol0d/KUSOnCEa
         +dBsT/sDTatqcKDAeMjZMsCdxJxrjJ0J2qJR7+yNKbnVLJidbOt+D07O97YAPf9DW/rx
         fxbztZN6AmWzE39f38eVWFKgR38ANrAskass/njcoXDOl92nloVms/+Y3SF2g/FXezgW
         jc/YdlFqyleSHEnu3jIUu0OIow7xJNyoQ64CtU++41kHE7mgZS4YYxMdIs2Q1fJgEZqw
         FNZSd5wLSy4wFG9m85yCOJ7BQt2d6UUvm3VqPVkzK2YC6s7aXQztSqC0mp3fVk1Z1/eT
         R28g==
X-Gm-Message-State: AJIora/gvEMwsl1fkEUw79+JW+xA/A20i3uZGEndw0RbvFG5FOzIBLUd
        w4ajTiOBJulk3kX4+GwZ4aRb3KfACdiDbfskfsMH1VyVWw0=
X-Google-Smtp-Source: AGRyM1sNWrQz/8SjM1QjBqcgnp3EbXT9/r2mcyrw0KOhjhQELEZA5rhDO1cpdpApAfsZfFcQa/GOhVT2OlJ1V97rUu8=
X-Received: by 2002:a05:6870:5247:b0:101:ec40:6a3a with SMTP id
 o7-20020a056870524700b00101ec406a3amr4274753oai.276.1655760298309; Mon, 20
 Jun 2022 14:24:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date:   Mon, 20 Jun 2022 23:24:47 +0200
Message-ID: <CAGzjT4c54TJA__dcx43745JKeZPeYQ3siowR66j0-KFe=EMRCA@mail.gmail.com>
Subject: Clocksource: should the read() function of a clocksource be NMI safe?
To:     daniel.lezcano@linaro.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
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

Hello all,

The ktime_get_*_fast_ns() functions in kernel/time/timekeeping.c are
listed as NMI safe.

If I am correct, the implementation of these functions uses the read()
function of the currently selected clocksource.

But a potential lockup can occur if this read() function uses a raw
spinlock. A running read() function can be interrupted by an NMI which
also calls the read() function. The NMI handler will then spin forever
in an attempt to lock an already locked raw spinlock.

Is my reasoning correct? Should the read() function of a clocksource
always be NMI safe? This requirement is not documented and I see that
several clocksource drivers (such as drivers/clocksource/i8253.c) are
not NMI safe (they lock a raw spinlock in their read() function).

Regards,
   Jaccon Bastiaansen
