Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63E578E01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiGRXDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiGRXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:03:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D553335E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:03:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m16so17328529edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCuV65AO3xjvo3XNNmdojm9svHgvfqPfeodDABzyyBE=;
        b=kR7aR1HQxR0fwFVRuD2V30Hz1vbP5xF+IUONHdVl381RaIypdmjANYgjwMwNYiztQo
         4Bk5NCbRdBF+b3CUsebO4F+F+dM5Ogbns93F7S84OlQqwbS2x56MN7yaXA13uVQ+ipPS
         WjW/LwKzIoxMhiiC6NdfjaZKn2joO9PQou/I8hH2WaYNEiTiBkkIpnncpJ8mNzmiPTp+
         qd5lybeDHjE+yHpVyko1068N4YIn4XR+OVCwVb34gI0sqNfxNhk8p3O9LvrVQXFiqOEq
         eL80KFu4EDWDdaoeGo8SOb8cuTtT4R7iKVwsGO2C3jcDEYWcBzmnr4yILZVV0HDwryby
         a+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCuV65AO3xjvo3XNNmdojm9svHgvfqPfeodDABzyyBE=;
        b=ORc9wrDDgRLk5Nnp+Y1Nnf5PetF1q8wypoOjGNYcOSscp936yRDb7AxaOwlZBGQdba
         I8XMMEJgHfN2eSeYdCK5rPfowHX0/Ld4z4oK1e7wKvN0+u8mL6p6IObK8mD8iQwB4VN8
         5xECqDYx0tRMnH+xlgC+BBNwwItTzMTiNT0KeNJasXeFsqZ8bEO9o1GStn70AQitpxxq
         kArpsjrq7c3sVCFYwRtPJo5s4bAv9tXjPI3vVs3f56pAgdOkywuCvcwJswnUyNIqi/Mo
         sQ4DsEFPoZzNIEKFHi7At2BsmBdRqutkN5ChX6KVibmX4std+V1m711OI8NLX6kZ/XAF
         IdQg==
X-Gm-Message-State: AJIora8niCUHnOgrii4opoirM1xOCfzp+g9mjIXstH5qvpYz2p5MOzZx
        qpTNDjTI+fPgXiy99KR1P2KCsKfYiq9TZLZEY41SZA==
X-Google-Smtp-Source: AGRyM1tcOjq2PV7D5Cf2k01aq9MpqaWCMGHYdZB9ytd/ZcVGEwSJYBapdwKkXVxQYPYI6yKi5fdOOCg/EWWc2tdPpqI=
X-Received: by 2002:a05:6402:371a:b0:43a:ece9:ab8e with SMTP id
 ek26-20020a056402371a00b0043aece9ab8emr39311986edb.126.1658185383730; Mon, 18
 Jul 2022 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657907849.git.william.gray@linaro.org>
In-Reply-To: <cover.1657907849.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Jul 2022 01:02:52 +0200
Message-ID: <CACRpkdbYriKi8QN-KrMN=teeqH=g2JwzB3qnCT1AaLcqTD=ssQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] gpio: Implement and utilize register structures
 for ISA drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Fred Eckert <Frede@cmslaser.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:56 PM William Breathitt Gray
<william.gray@linaro.org> wrote:

> Changes in v3:

I'm happy with v3 from my POV, especially if also Andy's comments
are also addressed in the next iteration.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
