Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72985A7D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiHaMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiHaMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:37:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109AD3EE0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:36:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s11so18158888edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=p27ll8CtVSLpLMfWeALRUXdWHvLDiBdeF6arG5Pph7w=;
        b=wiLhC7O9iv+1pUBo9BF+Qrb6OCleD/V+QE4yUpyNjMA6pJHXp+pO/FAmC43UHbWW/x
         TJPDxakaNXWEAXeuNM0wXL4g8NB3WwsYB8EsuJ8aGlbIzR+OKC1Cae78kc/6t5ILvjHv
         eSCJQB6AYmZTGHdyEBp12kP8lI0E1PbJMywlnQ/k9TTdgKHRkhKH8falcdITjkPZoPXw
         v4uaqtxmbJXNErFTksjkmGWZd/2NdYmmmLu625O1VZV4V5s/zVdozurdB0R/aJOTpn8r
         jK7KeQALpNlgj68hbdMl2HZRRYpAiHmS2nYFGC+BDB/mPDDgJJEgzEABxXURo1nJeOhb
         TRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p27ll8CtVSLpLMfWeALRUXdWHvLDiBdeF6arG5Pph7w=;
        b=5abqKjeUzwWdfCtzHOAPNrCX03CTy9OtbItRQluw7w9j0msDW/6BE8i8we2BEhSuM0
         VgXjj7uqqGjiUbK5IX3BqhWES8+DvZjdo0gUfx/hhgurfxcdNCtHbxMCsUWM5tHW6fD3
         OtJZjocdUgz/uoyLt8OND5T/qNkgvWaNH1TiyJqhIPyAayDdfS4a4DTs93YhaUE/tOLa
         gHnfz+rN+I+4BW0IRE4FfbkiJmflFr36z6KTduO7MZKOfaI0SAuS+SlG5kms+ghBU4Fq
         mqbwO9F6HjXqjbMrNVUT4iHWtaPOVm4DHKISlDUHllkfq3jFreZgHC5Aii+0cCsi1vFy
         0Y9g==
X-Gm-Message-State: ACgBeo0tfc2y7OTwB1hYvCkkqlTjNdNf+K01TKHIsLe0Cmkh/ABka0dq
        LFfbWi/JBMkMoIV09j/jH3K5jxNi4L8iJ3wtz2AuCw==
X-Google-Smtp-Source: AA6agR54ninAXNMpIyo6FTmW+N42f5mTqy6RjeT5XkAHGh6UPTfWNqAS0AKjDeFW++mbyawDKUFpX1Kn3bAs2zrZmKI=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr24187606edc.126.1661949407977; Wed, 31
 Aug 2022 05:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133923.1114555-1-martyn.welch@collabora.com> <20220829133923.1114555-4-martyn.welch@collabora.com>
In-Reply-To: <20220829133923.1114555-4-martyn.welch@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 14:36:37 +0200
Message-ID: <CACRpkdaPa0CbF2r9RbDnC5oEVdt4vM7O9xg3Y30dekJs3wuwEA@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpio: pca953x: Swap if statements to save later complexity
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, kernel@collabora.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 3:39 PM Martyn Welch <martyn.welch@collabora.com> wrote:

> A later patch in the series adds support for a further chip type that
> shares some similarity with the PCA953X_TYPE. In order to keep the logic
> simple, swap over the if and else portions where checks are made against
> PCA953X_TYPE and instead check for PCA957X_TYPE.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
