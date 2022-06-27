Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D955CA18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiF0Ro2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbiF0Ro0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:44:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A9BC93
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:44:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ge10so20689708ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=carVd4dz1JR+0LCCRtyImJ45BFUEfe9BTbtzD5h/MLM=;
        b=ftXG5ttg1TKOQsVKDkqKiIqG4371Vvs6o0kr94SrA5lrU1L16ui8r3nvs4/ruX6JXI
         ThSS7jgkECIWLm3IXshjdwfqmuZudV+ItF6E3xxESaxkxZ+bOrUISD9VOnxbbEHV/s1d
         4cBqyguG4MQ1RFK+/GvhHICocK8nc+ixmHEDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=carVd4dz1JR+0LCCRtyImJ45BFUEfe9BTbtzD5h/MLM=;
        b=B8t8sFM5fuOs+WMuKadhrd8BAkg8Ve2/I8BFgUV4TTPtOa2SFLqv6yaVpZz+MLQFXf
         8g16WBYIGdaVN4mYkt18BUIlq6trknd0GnORkA/NevPI2WKoEzds97dDztjqRBRLL+m0
         slCSIt1qNq0fO4BGLht02kbUcAo3JibQGlBy5EQuLVlQpLm3UMlgPb6dejwjHBTGv2el
         UrkJwJYS2eOGLhGjZM6L3Q9N1sR6mTc/v+s8w6/7x67rzFOKSyXRxFwFYf9yLYBw5VCs
         Wz9YIbvQKk7efQd1Th4hoCSNXin4OMju8ddJyVC2hXsGGiE1gSLxBfAXNversFOD2518
         q0eA==
X-Gm-Message-State: AJIora9TtZUK5YcJoX6RQjGVQ/vOVyuijs/MZ+UmJ9PFugqYny82eDQH
        ybO50klaapK5ybRdCJPFntiIE+SK7JPbqREn
X-Google-Smtp-Source: AGRyM1vZ9SKYHRgyw1Px2601JJiTfJxhuir1mifYvBYvmLkBIypi7guaodVE1fnq1/+1r8mQ/Zn54g==
X-Received: by 2002:a17:907:1c12:b0:726:a6a3:751c with SMTP id nc18-20020a1709071c1200b00726a6a3751cmr5583587ejc.683.1656351862186;
        Mon, 27 Jun 2022 10:44:22 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b006ff045d7c9bsm5255217ejc.173.2022.06.27.10.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:44:21 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id q9so14103891wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:44:20 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:21b:ad72:5401 with SMTP id
 g7-20020a5d64e7000000b0021bad725401mr12804822wri.442.1656351860470; Mon, 27
 Jun 2022 10:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220627032209.52396-1-masahiroy@kernel.org>
In-Reply-To: <20220627032209.52396-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jun 2022 10:44:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6MOcm-dPVS8+tGpQ4p+fpfQwx2N1FU-vUMoR8bjFFZw@mail.gmail.com>
Message-ID: <CAHk-=wh6MOcm-dPVS8+tGpQ4p+fpfQwx2N1FU-vUMoR8bjFFZw@mail.gmail.com>
Subject: Re: [PATCH] tick/nohz: unexport __init-annotated tick_nohz_full_setup()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
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

On Sun, Jun 26, 2022 at 8:22 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Drop the export because tick_nohz_full_setup() is only called from the
> built-in code in kernel/sched/isolation.c.

Thanks, applied.

              Linus
