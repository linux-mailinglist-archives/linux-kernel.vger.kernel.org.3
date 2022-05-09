Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3767520642
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiEIVCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiEIVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:02:45 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9932B8D24
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:58:51 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id a23-20020a4ad5d7000000b0035ee70da7a9so2779892oot.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yJKJ2ATgX9mu3/IffO/J0EaKq/jvo17mocUEhwCAE60=;
        b=XSieEDeLW/rwABKUVPDCvXH0w6sECAEnkGHzfrpHucsx1SHRgM/dcBpPOgHjWjsqCb
         leo0ETy5XMaX5kEfyv+oImCvgn/Nr2Cc8dOl33/gdLVYmaNnfeGnl1hjnE945VnzLQv+
         BbtHxr0VqtYXncjJAAbHq+uy1Wp20P5IVOeeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yJKJ2ATgX9mu3/IffO/J0EaKq/jvo17mocUEhwCAE60=;
        b=jINZHkSIR41o8oX4v7UQv2MDu6HXQHybOWzNArk46ZdpGBLFSxNkzAHfJWjWGoDeUB
         ZuqdZkCPJEAVyrhUCgDEtfwOHWZ0T0vJ0YEv/7box7NC19kGowy5E88ceoWRLbOruP91
         oy3NeYEaTXblOya/Zb+pgzatqajK7PNTyI3WSTPzCc3EV8kWakkn3u518YoJ11tleeN6
         FG171/yttvHg5SD+O0fZThpaPc5tk3nMIFy5Ce9YcNlR7ESpaMcghF0uAtHSv8qgjtDN
         aMziExxrg0Kg/Cuo/KFXLAsyr6ePq0zRXdi9maQoxiZPfUyE5Un1zmMUVzLq83M59KmR
         sOWA==
X-Gm-Message-State: AOAM533DmzF2Y9gHNt7Svk22iISyYtGVIzh9PB7YzpLX8AzK/ek2gnfr
        WB8UQzCi28l1T31k1yoAb1/v23BAsGXcgXQiqrn5ew==
X-Google-Smtp-Source: ABdhPJwgrl6Fn8gygCe1A38ovT3ghIsMz7Z+cffAmaDb1TNKssJHWbHAPz8jQeXiKh9qKc+zQcnEutlFHA7Nq+3CFlQ=
X-Received: by 2002:a4a:6b49:0:b0:329:99cd:4fb8 with SMTP id
 h9-20020a4a6b49000000b0032999cd4fb8mr6472783oof.25.1652129930567; Mon, 09 May
 2022 13:58:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 May 2022 16:58:49 -0400
MIME-Version: 1.0
In-Reply-To: <8e472c9e-2076-bc25-5912-8433adf7b579@arbitrary.ch>
References: <8e472c9e-2076-bc25-5912-8433adf7b579@arbitrary.ch>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 9 May 2022 16:58:49 -0400
Message-ID: <CAE-0n53Ou1qgueFZ7zL-rFwsit6XJnYZkRtggdx3XXvL7HWrow@mail.gmail.com>
Subject: Re: [PATCH] Decouple slub_debug= from no_hash_pointers again
To:     Peter Gerber <peter@arbitrary.ch>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Gerber (2022-05-08 07:56:29)
> While, as mentioned in 792702911f58, no_hash_pointers is what
> one wants for debugging, this option is also used for hardening.
>
> Various places recommend or use slub_debug for hardening:
>
> a) The Kernel Self Protection Project lists slub_debug as
>    a recommended setting. [1]
> b) Debian offers package hardening-runtime [2] which enables
>    slub_debug for hardening.
> c) Security- and privacy-oriented Tails enables slub_debug
>    by default [3].
>
> I understand that encountering hashed pointers during debugging
> is most unwanted. Thus, I updated the documentation to make
> it as clear as possible that no_hash_pointers is what one
> wants when using slub_debug for debugging. I also added a
> mentioned of the hardening use case in order to discourage
> any other, well-meant, tries to disable hashing with slub_debug.

Why not add a CONFIG_HARDENED_SLUB option that enables poisoning and
also makes slub debugging not print any messages to the kernel log
containing object internal details? Then it can be enabled in the kernel
config to harden slub and if the flag is enabled we don't hash pointers
based on 'slub_debug' existing on the commandline? And maybe add some
commandline argument like 'slub_debug=H' for "hardened" so it can be
turned off as well if it is built into the config.
