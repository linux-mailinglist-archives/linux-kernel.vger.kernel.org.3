Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD158DC4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiHIQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHIQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:41:44 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF22B483
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:41:43 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id cd25so2376588uab.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kmy485he3uISIluyiVIEsi8lmY91clYY5CTzUMEMN/4=;
        b=Jb1dsSM012O9PV1T8zszE0zNxuOGIQJww6PHDomMkGVCSIG/0xbjFDx/tKkBbTTf0V
         rNRB+KPXc3/7NcPXaXw4+cp19IQoq9MBJTzKpIR+tKXBV31Ba5YMEKrY+NrVxGZMa8Q9
         udfijqxw8BD6Au+D+SIYSaFiEhT+5t6ZR2ByTh7XmLtKQoeZ0d8DnlOhIew3vsmIqvGr
         QXszl6ZTub/Qo4KtI4PzknQNQZqnuXcz5bSOjvVzHIaqbXpcAej/4O4S96kKv5hwdQyK
         NlLdWo8r5nYrgQOBdv8Uc0cLlSEUbHTkoUZs/qWmJ4yBYehjZKvQCH4P4eHDahxwZvgu
         tFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kmy485he3uISIluyiVIEsi8lmY91clYY5CTzUMEMN/4=;
        b=DAXZT5HJvjS4Ww+wmkfJyw7o/MSps8BACe8HuNYb4KIhRtZd5F5ccRaNNizyI0XpTL
         f9tggE6zCxNm7EQVmnzWjlpEPq4Y0psWLLNh28oFbzSpUjwoRMHosJA5uv9bjV6V1S/x
         nzUqrYHQ6b9TGUCuVTcsgxi00vPEld1MKVRRfytMmU8YTFPJeJRM5Lyj+OlNQwbTt/40
         oLobb2Eimnu9J/ZFr3Q5+0KonaNaFUMeAGEUnspY3i5BEPQziIOTqqY4tc8KXWaw3Zmq
         v/FtTYUEofN1vHBPLqQbZ3c6NBnZQhWyRFrPxlZ+M8051989pM5wJFekDtMMOCIIV3an
         6cHQ==
X-Gm-Message-State: ACgBeo1slGUTEQGR3EfPlu6twBO8njetitVdJ6iv9oaJYVe6dTXsVRas
        ltoMPCFkzcPsZoie6CmUltob+z8yI8FrZiTifWHhww==
X-Google-Smtp-Source: AA6agR75qJL3WhFtU6nk1fFYmsc40QN+aW8evUh/W7MmmGQEuE91lJlOgcBE16AcLr8euiDZ/z0aUqfbqoYXlZlP8VY=
X-Received: by 2002:ab0:67cf:0:b0:341:257f:ce52 with SMTP id
 w15-20020ab067cf000000b00341257fce52mr10294711uar.109.1660063302205; Tue, 09
 Aug 2022 09:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220805214734.1937451-1-eugenis@google.com> <875yj1x0k0.wl-maz@kernel.org>
In-Reply-To: <875yj1x0k0.wl-maz@kernel.org>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Tue, 9 Aug 2022 09:41:28 -0700
Message-ID: <CAFKCwrjVaOdrGktxVHLCDPyJSRjZ0B3FHTGsb3PXMULL=dw9rA@mail.gmail.com>
Subject: Re: [PATCH] mte: Follow arm64.nomte override in MMU setup.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 1:50 AM Marc Zyngier <maz@kernel.org> wrote:
> How comes such memory is being used? How comes it is in the linear
> map?
>
> arm64.nomte is affecting the use of MTE feature on the platform. It
> doesn't guard the use of a MTE carve-out, and doesn't allow it to be
> used in any shape or form.
>
> To use this memory, you should remove the MTE configuration
> altogether, as you cannot infer what the CPU is doing with it.

This can be used to enable MTE in TZ but not in the NS memory.
