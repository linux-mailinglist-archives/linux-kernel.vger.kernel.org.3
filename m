Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F090B59A78C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351227AbiHSVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348895AbiHSVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:11:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E6E097D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:11:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u6so1985800eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2ZCLpvjoj1GGm7cs//SPmYSAgGGUcUNfHeZ+gCJzGjw=;
        b=LxrE7XZuxVe12K3IWTuh+Ua3xTDrHIHIMGddNg60xsnRtZDsRTq2CgXGkQu74rbuoC
         v1i7CisoyDCZUvVRWgVP2TN4Wmf+9+EYClGq20b3zkKGCS6SnlEvQG0o1oCH/pJeUozJ
         euwv3NjKW29EQJfGGkkCRxidpJ294zZ00ymRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2ZCLpvjoj1GGm7cs//SPmYSAgGGUcUNfHeZ+gCJzGjw=;
        b=GF9xietx9BPwQFSL/NCwJTSvnsiNIsyTLWORU5I5CIwdiIdPxAGpxxs6QmVu1Pj9no
         /RJanaq6cwnem8Fv8BGaBPcR9fhv2v71TyBVMqAUdFbLrxuphgiDnWyxZiySCPNuEdw/
         iz9lgLdEc02ApLIkScmXGJqmUk6nta/6e/9vTzG8qryFeTdqfLm/MlmsKxfKIT8pqTzJ
         Qf/D7iU9M1U/0ZmJHr6pcaJ/TxniPugb3fNPrLHKI351tvcMo2V1oYoPB9OJSd0cUbqa
         hGk08ilnzVwADpfXumVqHXZ6enpKPfnG9PPYidaqpaBJXETZiYv/MpoiLzU/iv/0oK9a
         cjnA==
X-Gm-Message-State: ACgBeo0S26+WpCFet6x1drfB9XbqoP0jLZu5OViAdLF/aRxpeMzlkNYB
        i21MKZwAZihBeTQ/SzI/sC9fE/ErdLKzkjSJ
X-Google-Smtp-Source: AA6agR6rytlbq2Yui681ba0gEH7i8JuSyHPq8ZV3RRFy9BrEtq5VqnndHe//Ln1Of++addEhRkj6kg==
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr7497260edb.338.1660943515251;
        Fri, 19 Aug 2022 14:11:55 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id g23-20020a056402181700b0043cb1a83c9fsm3630805edy.71.2022.08.19.14.11.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 14:11:54 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so3042337wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:11:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr8895406wmq.154.1660943514317; Fri, 19
 Aug 2022 14:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <202208191202.5F5A43A0@keescook>
In-Reply-To: <202208191202.5F5A43A0@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Aug 2022 14:11:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjd2EX60OQJgmjQDzC1wkzX6Fb9ypT+AJQdPnNZ3QzZGA@mail.gmail.com>
Message-ID: <CAHk-=wjd2EX60OQJgmjQDzC1wkzX6Fb9ypT+AJQdPnNZ3QzZGA@mail.gmail.com>
Subject: Re: [GIT PULL] execve fix for v6.0-rc2
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
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

On Fri, Aug 19, 2022 at 12:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull this execve fix for v6.0-rc2.

Hmm. I've pulled this, but "fix" it isn't.

There's no actual bug in the old code that I can see. It' just that
local kmaps are the preferred model these days.

             Linus
