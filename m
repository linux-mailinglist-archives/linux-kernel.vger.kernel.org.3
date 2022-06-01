Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8C53AC3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356538AbiFAR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354322AbiFAR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:56:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D630996BB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:56:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fu3so3837631ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhCTn3B4dxAfM/2PE1MQ94TeLbKYYdaD0N5yaUHCbdM=;
        b=aLtB+6frvE6/OlUJBCsU3xdGUDBTfuYWQJzE4Fo6zdDxBY1WCQ4mwsIxthXAm9ILbM
         O4LZEcHrKNE4OsekZhjNBqVF8mWI15Z+Tcl7qvdjC/4KhOBvl0/kRjZElTWDaNfUSTgc
         Hhy4t7UpjNymxjSo3QYi2eAji1ki003staViI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhCTn3B4dxAfM/2PE1MQ94TeLbKYYdaD0N5yaUHCbdM=;
        b=lnUwDXLnU2t3scvHRW6lbm1jX6/GL1Bp4e0K+2zn8v4EQK/gPbik+nohMiQjbk3Sk9
         4J+zaHE9HA2qzschIspfDZuVlu+CcGpNFKw12aqmjsJPUNcTnU+n3NGVJXgPBxbdzi04
         V3GisJR2gmWxChp952Q9r/CbZp/LB+0GIAW6A2yUFSGcNeCzyeiAPlNtd0OouaaUbuWt
         t6h2ScoiJAWV+3jmxMdzYmhJdItnjJEzEo0bYNzPqZXpaaxjmK7twERYrEdMbPdwdsOn
         /5T41wuMnQdcH/VrsZtzaRueuicOdw1r0uUj3y//hV0LgbruWTasGwVobayeFql59/yF
         bgFw==
X-Gm-Message-State: AOAM530N0/48kkn0XK+xebO7IflObYySy884wJXO3aQsu69f6i5nX17g
        LsE1zkUPODvXi8qSZk+p6Rc3SERz7mFF9vKb
X-Google-Smtp-Source: ABdhPJxBOkneFLVMMYQhlGCympssHuJkZBe3MJQOV/XxcacQ6+MSyQbSjQ2VZhy0YIP6GJoyEeXLEA==
X-Received: by 2002:a17:906:9254:b0:708:cf8e:25a5 with SMTP id c20-20020a170906925400b00708cf8e25a5mr638240ejx.119.1654106179373;
        Wed, 01 Jun 2022 10:56:19 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906694400b00703e09dd2easm961565ejs.147.2022.06.01.10.56.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 10:56:18 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id u3so3391249wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:56:18 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr514986wrs.274.1654106178446; Wed, 01 Jun
 2022 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <Ypb3t6HB1D51+hfU@owl.dominikbrodowski.net>
In-Reply-To: <Ypb3t6HB1D51+hfU@owl.dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 10:56:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiebE8cTjAPy_UXHKBSWrat4xNfeu0Ekaf2joBZ4y3kzQ@mail.gmail.com>
Message-ID: <CAHk-=wiebE8cTjAPy_UXHKBSWrat4xNfeu0Ekaf2joBZ4y3kzQ@mail.gmail.com>
Subject: Re: [GIT PULL] pcmcia updates for v5.19
To:     Dominik Brodowski <linux@dominikbrodowski.net>
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

On Tue, May 31, 2022 at 10:23 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> A few odd cleanups and fixes, including a Kconfig fix to add a
> required dependency on MIPS.

This was also one of (very few) pull requests this merge window that
weren't signed tags.

I realize that pcmcia is small, and no longer very relevant to most
people these days, but I still wish that this pull request wouldn't
have stood out that way...

                 Linus
