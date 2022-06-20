Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547085511A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiFTHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbiFTHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:39:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D5F5AC;
        Mon, 20 Jun 2022 00:39:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g4so13343875wrh.11;
        Mon, 20 Jun 2022 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQ6BRbOQHLpfvLKr06Q8S7QB3Faa2CUcSKR939rmmV8=;
        b=l29k3Nyvu/ZR3QGAXBAUSUtafIFBhDlCToPTbg79AkCQJbRIDCg2dS/klkUQdXdmVt
         GNorIsnbDiZsMnD27QZF2cPb3BJSJfqiMUVrqDvIe/UVy7h68B9nIfnIXrEsUmmKaEJO
         4wnu9eEHGEkAI5qFNQf51T7xDFXF4JTnuIRmXsnlt8tkWMF7ZqJXRwbagJzRAHcpdZq1
         mi313j4kSDBzkM13PWtea7pQFmrkzh2/jQZxrIpF6jMlAhhQb3mwNoVGfH1BX0VUfP4B
         7NgC1cG9keIKi+dZM9d99DS+tTzLXxOuNPoDi4zu5mt+AeJUsCVIFVeOBu2CS1IsTOiE
         Ps0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQ6BRbOQHLpfvLKr06Q8S7QB3Faa2CUcSKR939rmmV8=;
        b=X+2vS/uH+SQauMMyxcpsscqkcsnfWV5+/xw/mJgOeFDzI8Zwhc9b1uz4mgpnnKPkqq
         8mGym2pln07Rj9cJ74mgXwVpJzIqetHbd13u7uo/8RjsF9jVVcBTkf+EEh5cPfeIXCFG
         PLEzzH1R+5qXELEUTDpjIhBlKRrpeiaXsYey7vj21sk/aT72b775r4jqtS9188Tc+wEY
         Su1rJpyXeZQbe1Te0WAghjKCbYKla0SoR9BoP9ZcDMuIMkLVTkzzSFg74tN8cxi5B3y/
         52XhLJCdFbdhcvRpq1LUqEQ1yMwc+RPb9yV01nKBc9pri2l3Oy21+AWCj+I0yVdRiR8d
         vyWQ==
X-Gm-Message-State: AJIora/RFk9Zgi3vhGmkiBbkVaix8LtzUmSAGEy4BZSmbZYMg07IdxIC
        ODwPVyH4yewiipftWHwddoX1rRH4GVP+SJZ2WCgnxeZmQag=
X-Google-Smtp-Source: AGRyM1sLCv5drf3iFZM2xrRkVklVax460Q6mO+V0Utu0i9SMSvdgAT5a+2K9ebvZv306mBShIlnmdhWytn6YETN59Wc=
X-Received: by 2002:adf:fbd0:0:b0:21b:90cd:69f2 with SMTP id
 d16-20020adffbd0000000b0021b90cd69f2mr2648047wrs.525.1655710760603; Mon, 20
 Jun 2022 00:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZm_C=o-rc4a+u_8-pFJtmL_2drwczASMRTqszamrks5Zm_OA@mail.gmail.com>
 <CAG48ez2PVMs-CeLoZtvPq2EeQqOg05mm3AuvEE_pr9Sog0O5og@mail.gmail.com>
In-Reply-To: <CAG48ez2PVMs-CeLoZtvPq2EeQqOg05mm3AuvEE_pr9Sog0O5og@mail.gmail.com>
From:   Federico Di Pierro <nierro92@gmail.com>
Date:   Mon, 20 Jun 2022 09:39:09 +0200
Message-ID: <CAMZm_CmW7pHwfEfCQfXRJPiHOjeGviQunfwxY_1ejrihKab5rA@mail.gmail.com>
Subject: Re: pgprot_encrypted macro is broken
To:     Jann Horn <jannh@google.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why does your driver need to use that macro? pgprot_encrypted() is
> mostly only directly used by core kernel code, not by drivers... and
> if memory encryption is enabled, almost all memory mappings created by
> the kernel should be marked as encrypted automatically.

This is interesting; i don't really know the history behind our piece
of code; as far as i understand,
we have a shared ring buffer with userspace, onto which we push tracing events,
and we must mark it as encrypted when
the kmod runs on an AMD SME enabled kernel to allow userspace to grab sane data.

This is the commit that introduced the change (if you wish to give it a look):
https://github.com/falcosecurity/libs/commit/0333501cf429c045c61aaf5909812156f090786e

Do you see any workaround not involving `pgprot_encrypted` ?

Thank you very much for your answer, much appreciated!
Regards,
Federico
