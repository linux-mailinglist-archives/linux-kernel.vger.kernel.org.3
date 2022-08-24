Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722159F88E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiHXLW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiHXLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:22:21 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E86555B;
        Wed, 24 Aug 2022 04:22:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y19so5868697ilq.9;
        Wed, 24 Aug 2022 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6H2VCsroSwSsOLzUIr02/aGqdyNOr0x+cKsTlTDmAA0=;
        b=eiIo6d6uy+0dwAXj3EjHaVAu4zFtq3v/3gRH1ubXYl80iimBeVcT8pAGWQKMWOCJuX
         E+7f18DINDNVsQiHJmdzTNKwhfeE51yiZa9o1Hxm+uV4XJJwnVoe2OB9ZAuidoLeXOH6
         jq074poFgm+lvwveJqpzBPD8HccBIyndV0ikYMy+SG/PjJm94pD6J5yRNDntSSXx9a99
         RhyagH3MwqHBb9iwZOBavHuOPinzXzXW9wCv39Kdui7q746cDVxq3wwBrrB4KQs9obyL
         YjfrhTGUWMCu0h2/fKGO41IZYhi3IBumkw0S/Io0YaW0J017+UftwTtHa26qFIIrMe1g
         +BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6H2VCsroSwSsOLzUIr02/aGqdyNOr0x+cKsTlTDmAA0=;
        b=I+jApSbPXQw+Elt6YTrzdxhpWFilYxtiWksj6eJqlpgRoIytiLW5uVNdwbI4o5vL90
         Nfc1+Pcd8rKHLCxV8wrqdbyoIvQkp57okGk6VdEJMfPh9uqc/+hFBm00NISTPmEK/2s/
         ibxyBKt1TnwC826qlZ1aKtSKP7Al7RjdjcWTlpeSLaf9LCbTS+kr3fKq5YUgcrQU4IAT
         8si8yULwws1bccWeHTu4Siksv3z6pLt/bPB4fkuWEI0t19rjpyDeKxGT5qCVATGmbxVe
         K/v/MbF6q9wQxKaRPyXIZdizgJ3J5aWhsRtwkpLjf/x5iE+BBsqGLcKk8DAaXeCk3X0i
         zdyA==
X-Gm-Message-State: ACgBeo3gdtCdIovBwKIpZtDR6Y5LaS4vqWfCbs4rPoAqdq2IV1/AO9RM
        tPLI1G5zEpLMLO4T9wBsPXzdrTeNr2QlYXaHv4w=
X-Google-Smtp-Source: AA6agR5BpXLO61wS45MEiXcvDBq4DkMt5K0/2ZJw8+Cg7gc798me1DZ5O7mcPgfyHk1hRhflEO5i1L8sN8B4nv/8+o0=
X-Received: by 2002:a05:6e02:148c:b0:2de:c3b:91d with SMTP id
 n12-20020a056e02148c00b002de0c3b091dmr1884602ilk.95.1661340139510; Wed, 24
 Aug 2022 04:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
 <20220823182758.13401-3-khalid.masum.92@gmail.com> <YwW9dBW/0TKHPnC1@kroah.com>
In-Reply-To: <YwW9dBW/0TKHPnC1@kroah.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Wed, 24 Aug 2022 17:22:08 +0600
Message-ID: <CAABMjtHg3Fe3QQgdDd4p=b25JWHKVFtibczLhk1hG0idMyrJhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: ehci: Prevent possible modulo by zero
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 11:56 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

>

> Odd tag format, is that in the documentation?

You are right. I should have used "Addresses-coverity".

> You only ever use likely/unlikely if you can document how it matters
> with a benchmark or other way to notice the difference.  Otherwise let
> the compiler and the CPU do their magic, they know how to do this better
> than us.

Thanks for the important information.
>
> > +             return -1;

I noticed. The function returns -1 on failure, everywhere so I used that.
I guess making them return correct error numbers using macros would
be a patch.
>
> A real error number should be returned here if this was valid.
>
> But as Alan said, coverity is often wrong, and unless you can prove
> otherwise, this patch isn't valid.

Got you.
>
> thanks,
>
> greg k-h

  -- Khalid Masum
