Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB66F5B0929
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIGPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIGPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:48:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780717A75B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:48:40 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q8so10975969qvr.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lzpRMN6w3iYiB3sZ9MYq6oInOU5vUpE1BADsOiRmqjU=;
        b=I9W0bKjLgunzSGZRX1ThnuV/MEbkicDWvQL83f8Ra1IkksPVDsr8EI8K78Kg2DDvBZ
         D1zs2QnE97rVAM/2jPvgk5G1YTaexnupDWdjEXTJ826KqkJAs31wTp9P8KxbFjCG6ARv
         PXgNanGBS0Yhv+VMXBibPM9Dp47Id7HMogfF7O7IgPRS0OObbWf45hK+MtkqfWW/CTd3
         y+MCaeOQpwGOezQLU96N5p8kWCYqKN9E47H7iqi96RjXIgtwdrt9R541mQiBbslSyXk7
         amD9mEtwcj8THrwS5lf0VDxJb3s+QqAJTw1iAcBkGfe11CNYltoYHGcidgu48UxzNwRl
         7e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lzpRMN6w3iYiB3sZ9MYq6oInOU5vUpE1BADsOiRmqjU=;
        b=01M61eKLkK7NyxYJaK3Tr2fte3wJDhefa+NJyTntYoK9kRb6HZ6qnaKcu0nLDItOPR
         HpJP+HLmw2aH27pgdUiX0AyO0g2N7jxhaJY+nodGR32KLYC7R4w0OkdtvMaaRuIfXvnC
         Kv5ulrkkuX8KzNaiVmb0VYN/36oENjvHEOZ4yHhM3G50DHC7g97hrDqPRxRSUGXzItTw
         KPLQp6JY91A3iY+RFSV/RCGtHSM4enc/w6yKNpQWAL5cEZ11IR8U+X9pJu+27qEKm0/Y
         Tm/vcuffBxkAcMUhnZaDzzbVFP7dsMzzoZoaKMxAQ/4/xKBa4gMkVcQb80P7lMmJWtjk
         Z56A==
X-Gm-Message-State: ACgBeo3NlkkfhGwoayhUo3xLQQngrWCP4ZwZf98oKNW1KJU8XPtqSyE/
        60cDaZthe/eVu+Fbqf4ev/Mbg1Nz4xUr7FPkVYs=
X-Google-Smtp-Source: AA6agR4ISNlLiqADrS2D08cMTxRve5NkJIe9MjHS3y5FscyHte6S5XcJajKSWFZIF4pigA0cW5t/J2+b5ubnzoT7drk=
X-Received: by 2002:ad4:5f8f:0:b0:4a9:b75a:e33c with SMTP id
 jp15-20020ad45f8f000000b004a9b75ae33cmr3594902qvb.82.1662565719375; Wed, 07
 Sep 2022 08:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220907103041.0a88d5c4@endymion.delvare> <CAHp75VdzgWfQ=7nTvYmuxWMaPH0weF=Bzj+AEqsEhyQNeH1XHg@mail.gmail.com>
 <20220907172146.72460eda@endymion.delvare>
In-Reply-To: <20220907172146.72460eda@endymion.delvare>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Sep 2022 18:48:03 +0300
Message-ID: <CAHp75Vf+PdP2AiLOHYnKUWn5KDgvy+1poBHjHZd0hnJKTsGHtg@mail.gmail.com>
Subject: Re: [PATCH] firmware: dmi: Fortify entry point length checks
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, Sep 7, 2022 at 6:21 PM Jean Delvare <jdelvare@suse.de> wrote:
> On Wed, 7 Sep 2022 17:52:10 +0300, Andy Shevchenko wrote:
> > On Wed, Sep 7, 2022 at 11:30 AM Jean Delvare <jdelvare@suse.de> wrote:

...

> > > Also fix the maximum length check, which is technically 32, not 31.
> > > It does not matter in practice as the only valid values are 31 (for
> > > SMBIOS 2.x)
> >
> > "NOTE: This value was incorrectly stated in version 2.1 of this specification as
> > 1Eh. Because of this, there might be version 2.1 implementations that
> > use either the 1Eh or the 1Fh value, but version 2.2 or later
> > implementations must use the 1Fh value."
>
> Good point, so maybe we should accept 0x1E and treat is silently as
> 0x1F (which is what we have been doing implicitly so far) for maximum
> compatibility?

At least the previous comparison covers this case, if I'm not mistaken.

-- 
With Best Regards,
Andy Shevchenko
