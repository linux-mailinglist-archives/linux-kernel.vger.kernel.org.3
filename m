Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02F851455F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356426AbiD2J2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiD2J2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:28:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E735DE7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:25:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p10so12939665lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUji6zAVtiYht4ILYbhZgwXQV0O6JLl6Q1rD9uPp5Sk=;
        b=X3lnaky/QbfAU3IyuTPhqc8KR1dht4Y9ZOo6Tixi8OkKpmSmitL1o0OmtsgX6C1SFS
         7Xdy+09tGZQj/Eh22wlS7x2rV8pcopImHN4YHN6UuBn+P0CcobPlXlGxTPy8cOFcSqAT
         hetc0HZ+fufOiNy+kxW7uE6/ZvF8GVF7U53SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUji6zAVtiYht4ILYbhZgwXQV0O6JLl6Q1rD9uPp5Sk=;
        b=RhFB24x66Pe9mb9BTUf7mlryWKaGNvV5SgPn7z5Fk/F9+XddKg5Pkd8aeMwwGc+uRJ
         XQ7N+4PXTt3NTUSBzU1Qgu7PhEWk3ZtfNxsGxiNv9EMKry+eqkCtzs2+BjA5DdgF6Uzd
         xq464M0GrKAlZjwC/SVJou0gTRlvPYSLGNJov2oijIZD/TuBgTupw7f7Y/NCKAK4M0QD
         wZfq17UdPwRyMlZ4K5vZ+L3MondMr18DC6jMaT+OpsbacawMfz2a4YjkxqO2JEaJ1f7k
         fgMIaFji1r6+e9A2QChEQPeKsr1VqddIae0XUCQHOf7TpE6A3hxNZ38NqXmTviQOn1/u
         5Ndw==
X-Gm-Message-State: AOAM530hD1nCwUjUED3WcmyZ5sbg7xChnNnPnyvyFkBzFT/qKeqElFlk
        Z07wh7iSin3SV2yb0B4KNfpubex8gvp+HqFiKqFOwA==
X-Google-Smtp-Source: ABdhPJyoLLeggzt3nTV5Z7Czv7Cr5OuuWB4eGk0wEY/IGrckouhusS1+o3AWNB2ETRcDShRE//6+ZWTxyKfmDlejppo=
X-Received: by 2002:a05:6512:22d4:b0:472:3fb9:cf0c with SMTP id
 g20-20020a05651222d400b004723fb9cf0cmr3542855lfu.308.1651224330023; Fri, 29
 Apr 2022 02:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220429023113.74993-1-sargun@sargun.me>
In-Reply-To: <20220429023113.74993-1-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Fri, 29 Apr 2022 11:24:54 +0200
Message-ID: <CACaBj2Z7BpLMYYEbqB8=gyQqbJdevLrRMbDcDzRAtP=Tn+4Ftg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Handle seccomp notification preemption
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This patchset addresses a race condition we've dealt with recently with
> seccomp. Specifically programs interrupting syscalls while they're in

I think you sent it to the wrong containers ml. It should be
containers@lists.linux.dev, right?

If the next time you can cc me to rodrigo@sdfg.com.ar instead, it will be great.


Best,
Rodrigo
