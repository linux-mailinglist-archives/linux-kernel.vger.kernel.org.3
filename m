Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A53501D77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbiDNVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiDNVdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:33:12 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21087765B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:30:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f5so57481ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nj37mJGFxeaaCkwLeuwqWm1g7ahychPhmNkOI5dR3ds=;
        b=SwzM+kDG244qvAlk81Kzb7jv3jo9bS70fWhEtYwXqtm+KXlXhViG7y3/nT1CB3u58z
         J7kXl/3ZGOUj1EHYa2pH4oPGmBFoKhbQuY9dXdT/K1aLSG+uwo7KbSBbNLUHEFAFm1Xk
         JXFfL/BFMbcxJW4CLX0rcWmruwDcONxWX8gpqtwbTnokGfkGnZXVcMH5sC+oGnN9x14g
         Gb+XpWC6a+vv5tq/AR2RFonjnylMv97WlZZ/sHT8xirmgWZ7AP6yX+ii+eqBk25MrMv5
         ZAAqTyRFv5arJlLD4AqBJNT48kUEj16407m5X/BfH+IB3phccmmLwYqukwMhrfAe/znY
         WCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nj37mJGFxeaaCkwLeuwqWm1g7ahychPhmNkOI5dR3ds=;
        b=IJABFx3V2UD3us9gM9OOgA1rP69Qx4jufgaDziegkta8r6uDRoK94Lym3n23aePxgS
         m3zch/UTyoP+hcTzezsp4JZwZKQRIFKujlZSvXR4yyPDMTrMMlHCTb9KQWDWQpTj+INQ
         3l2snQBGLsaIlNMjV62mq7iUEkJf8pRqySTJrlo6CVwYSIgZU4Bzx2VXSWi93wDlXfcF
         fJvRL80U/DBsP5AKBZKfku8uu6BSHkm+P2dRiDs6Fl8H6aS0cgrYZcFxTiEMKohxWTkQ
         XRmahMc6G/YEsSqeloUr5aBzLuUq0ukQIIrm1Q4icrXASpCkz1DdzsVct0/yL/wNAWqN
         0N8Q==
X-Gm-Message-State: AOAM5311UyKi23T8IsQSR2Oybxla1XsdmZ134gqInAQAvi4XeTObkSeO
        euZ1kgIflQmy2A54C4G8fedPBUGd4HgcKXsYLKP1jA==
X-Google-Smtp-Source: ABdhPJxPS2QvyVN47bMyTQZoKgjfDFLroQlH4A7AyIN0YFxZMQTVLkXYHXNZv6tDsX2UV90960wH9W3lFhk2hVuHbQ8=
X-Received: by 2002:a05:651c:555:b0:24b:15b7:74ad with SMTP id
 q21-20020a05651c055500b0024b15b774admr2684739ljp.239.1649971845219; Thu, 14
 Apr 2022 14:30:45 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Apr 2022 14:30:33 -0700
Message-ID: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
Subject: toolchain mitigations plumbers session
To:     Qing Zhao <qing.zhao@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>
Cc:     "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
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

Hi Qing, Kees, and Bill,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

Would you all be interested in leading another session on
kernel+toolchain collaboration for mitigations? Do you plan to attend
plumbers this year which will be in person?
-- 
Thanks,
~Nick Desaulniers
