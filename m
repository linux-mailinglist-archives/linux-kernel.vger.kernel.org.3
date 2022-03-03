Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30EE4CC984
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiCCW4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiCCW4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:56:10 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EBED947
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:55:24 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id h126so13346274ybc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2ZLddQ3pBdZiXKBj6DvoFfrsQt7JsrT4COg/WlTq9Y=;
        b=LwFEnWrrHyMoDT1FRNCmikb5MOxZp5clQsTTLmty/0c0q24AthU1TBhXRR+DB5Rig4
         186QAr/b4cldoEBaG6DuPCFe89f397Z8KMcYUm3fNd+VJO+wIlJP5gvRkaZsLwUFEV7V
         UzNARgRGZrK/436Sh+Qa1wbUJuo6IcfF3oQA2P5ackgETGCjoPvx4tomlHm3B/PwMsYh
         J+9IyUilCD2ogzFnR+PI+q6onKD1kVuXZW8PAe/xMvwpZ1r10ZeccOMvr5t7ar0cQph4
         S8SFzDKnZO6NueRFSbF1qByyx1MKCugg0dzMyauRO3GscoNFjxOOmRfWNrwGeuN1dDJG
         OX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2ZLddQ3pBdZiXKBj6DvoFfrsQt7JsrT4COg/WlTq9Y=;
        b=wrN1m9x79/GyzJG+nmH5O1SKs75EyBaWfkAZgvbxJ894196Bvy5MLfo53NoqPTyjE2
         dJ126Co3ckR/zzeQqMFU7RIDq6WNQ5rFc/KDcszooC4pssFJHDkUliXyKa4ajWuCcVCY
         B2QpohjCoHqUcSRRHAvWw2HF8Jle3QtT9qibkN4ssWI36s67m4Y/naXKNEl7Gbezl6pg
         UC3UECcWfkMvu8FhwSZTp0yVUxn1u40YffWTY62Y5j6TvU0uM0i+PP8gcl1M0/HNyVi6
         ZfTFbDP3nRb86M+aHMEU/fPrUAjypKiIAkreXLiqm5bQ97VVG9ovqeNhvqsVoXPkQbpi
         0pGQ==
X-Gm-Message-State: AOAM533z9sL5riFjXisxdLzNtVv5Kh1cJuMZMSa1k03s6RlD5Ro8e6bb
        43m2AnFbyNQylx6aOQB4C9HP/1lJaxMR1Gme8+fA/1CP0EIraA==
X-Google-Smtp-Source: ABdhPJxkGxxLfPzvWa5E/ZBU5CtrkiE8he6BXE+3woSzT4pfn4JyqdrVO+DIVdFevj/Vj4yRSKJeDbIyTAylxAISW+c=
X-Received: by 2002:a25:f406:0:b0:628:c29b:5c39 with SMTP id
 q6-20020a25f406000000b00628c29b5c39mr4849539ybd.369.1646348123397; Thu, 03
 Mar 2022 14:55:23 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZmax=QpwnfgOJOR-5P3wTyKegaDn=VvhVOYz_AChc7bw@mail.gmail.com>
 <abdc4d16-b2b4-6343-39d6-9bc48e8be43b@gmail.com>
In-Reply-To: <abdc4d16-b2b4-6343-39d6-9bc48e8be43b@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Mar 2022 23:55:11 +0100
Message-ID: <CACRpkdai4+1NJ+UJxdcEHJjKtccE=LnDyv7pr1pzuQo88-MdaQ@mail.gmail.com>
Subject: Re: Question on expiring HRtimer in-kernel
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Reichel <sre@kernel.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 1:43 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> In any case, I remember few cases where I hit nasty issues because I
> used CLOCK_REALTIME - which (AFAIR) is subject to the time adjustments.
> NTP, GPS-time and so on can make the time tick in a strange way :) I
> guess you would have noticed if time was set when timer did expire.
>
> Anyways, I guess the battery charging should rather be tied CLOCK_MONOTONIC.

That makes a lot of sense, and is what I have learned from the internal
kernel primitives as well, I just assumed the HRTimer was some special
kind of beast.

I'll patch this and run some testing, if it goes away with MONOTONIC
I'll send a patch. Thanks!

Yours,
Linus Walleij
