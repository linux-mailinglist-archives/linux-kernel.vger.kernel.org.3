Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218895B104B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIGXVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIGXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:21:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507297B03
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:21:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q3so16001198pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J1/Za0Ov5W/LsRfC9drQ1qe/y45jAzIrG0Ow8/Mw3sg=;
        b=CILbz0ay4OUw65DLMQM0qEI8KdpzpfdLdZe0SYtVUe07SuK0iyyQrSmW4zul+WqDoi
         IdRBqFlG+3XdMz7dwfcVGZnkebaYBY4DTeSOSogGuT+lYcoNesuXtin60VQEAIlu1QQR
         Fhcg6DIi7D0RcB5eCzEuDqqDE9zHpQ1nv7Gus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J1/Za0Ov5W/LsRfC9drQ1qe/y45jAzIrG0Ow8/Mw3sg=;
        b=dVOndZIjpuSoR4/mkfFzp6bXWlgFmbbZ5wr2HM9RHyNSRXnktFLTh8h+a+miCaZy63
         Day0kKUCh9m83VJ8YgcR10E4eVkht5P1JIaQEeY7UvjNBHIEvYheC8lT9rk10/mfsdkG
         XK1xo4Ym+kgcXz6OLusZqubnwxlBemBUWTORDiuodRmKTXLvG92JrO1OZKcv4Fi/kCCm
         mg047HFq4efIKo4LGVS2bYiXoMjjWRbxhHhXE1hHAE9cM52aIjRyRtTLPJpN6wfdRZhE
         f8hDYi1xz3VmBXitzjn+QvSgBfjBUa9OWfS2MxEdsNZJScSbAJLF3uc8My5mBSnuZZsa
         63BA==
X-Gm-Message-State: ACgBeo34toIoe2mwzPq5LFcnqmmb5u6aGiteCP+dRj2l6NIBFaAK5saz
        owZiXKZFh5JLwpGYs6FYDMQ1Zw==
X-Google-Smtp-Source: AA6agR62ujqCFxeOt8z80wde3Il2ISPqMvBSP1XidRj9mk/mLmJ4qjABVWRifSR081Kw4WqOUqs3sA==
X-Received: by 2002:a17:902:f542:b0:175:32e0:1e32 with SMTP id h2-20020a170902f54200b0017532e01e32mr6054092plf.170.1662592910545;
        Wed, 07 Sep 2022 16:21:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902c40700b00172951ddb12sm13210328plk.42.2022.09.07.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:21:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mka@chromium.org, jmorris@namei.org, serge@hallyn.com
Cc:     Kees Cook <keescook@chromium.org>, dianders@chromium.org,
        paul@paul-moore.com, sarthakkukreti@chromium.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LoadPin: Require file with verity root digests to have a header
Date:   Wed,  7 Sep 2022 16:21:45 -0700
Message-Id: <166259290380.77851.712633939405429705.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906181725.1.I3f51d1bb0014e5a5951be4ad3c5ad7c7ca1dfc32@changeid>
References: <20220906181725.1.I3f51d1bb0014e5a5951be4ad3c5ad7c7ca1dfc32@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 18:18:12 -0700, Matthias Kaehlcke wrote:
> LoadPin expects the file with trusted verity root digests to be
> an ASCII file with one digest (hex value) per line. A pinned
> root could contain files that meet these format requirements,
> even though the hex values don't represent trusted root
> digests.
> 
> Add a new requirement to the file format which consists in
> the first line containing a fixed string. This prevents
> attackers from feeding files with an otherwise valid format
> to LoadPin.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] LoadPin: Require file with verity root digests to have a header
      https://git.kernel.org/kees/c/d64f3001976e

-- 
Kees Cook

