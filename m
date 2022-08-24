Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771405A0346
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiHXVYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiHXVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:24:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CB2C2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:24:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so23706029edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8UmQe9mjyzQMIzAHku/CvBjci5VrIDcuQ8+b3z/8gco=;
        b=fprWR6gke99VgICWutjxM3pyW/rrXtibUK7GGb45qIHnuTR4U3pqQ5NyAoun1nw+Cp
         3QKuXCVIpUapFw3fH6RIgqQFBXuS+1xcCPdlOqndVtIgmLX0ApAu5jUqea8R+J84mF13
         CAnz0koxe/kyuBkQUqTEd/wLRmJxCEEj6PJfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8UmQe9mjyzQMIzAHku/CvBjci5VrIDcuQ8+b3z/8gco=;
        b=6pHqX+Iyw+KToLCnTZBH73BhKt/kmRjUxtX3JcE07gNXyoa2PxtyhslYkwfpfF2x0i
         KMR7R4nUNR+WLIgTFQDH/wMqoupzpb69D9FyJq1i6SMrKK19cD8OjthiEBvlGxZ9Wyq6
         F+xUtfarE934t1pe8xS+koM5QE3WRrVFw8ILN5vKC87B4ECxLBflBTwSd3vmXbr6/AeJ
         qnVY7ohaVgsEdXuv25BcnsqtNSmYAn9G/D3PqNGbEe9KX1saLeQ/BXmnWXppOWufoabC
         rDpqAf/7ztSUwg3TwVBD3Th5mwlTQZN/AI+w8sBNeGu9TpKvukRgIjDKI5uw7Xb40i1W
         OgbQ==
X-Gm-Message-State: ACgBeo1+PWvkwyHSE+nIeJ6wU5Oz0ZZxYJA8qpaGcX43J6gUDIvZZ/CC
        t5pQCmug8PVL76exzzdTdwpXcia2mttYJrUY
X-Google-Smtp-Source: AA6agR4ZA8D1zCNvx4xhGsaWb37kRMcot9p7tjUaLPgFixOtyvhpkvQ3FNceH2k+6BZGJShFumWZkg==
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr730153edb.338.1661376282965;
        Wed, 24 Aug 2022 14:24:42 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id ez5-20020a056402450500b00445bda73fbesm3653063edb.33.2022.08.24.14.24.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 14:24:42 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so1616826wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:24:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5008:b0:3a6:1cd8:570d with SMTP id
 n8-20020a05600c500800b003a61cd8570dmr373142wmr.57.1661376282074; Wed, 24 Aug
 2022 14:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
 <20220823221429.3bte2tgtyniur4wb@halaneylaptop> <CAD=FV=WSSrObW2PthmUL+t=VYJ+mN6Z763pozCQDbOdPtAXyQA@mail.gmail.com>
 <YwVZfyDflFuzFAOX@sirena.org.uk>
In-Reply-To: <YwVZfyDflFuzFAOX@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Aug 2022 14:24:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZTzwROoVtA+qrpy5rrrM2RH3+tZFR0-KFTu79ea4rig@mail.gmail.com>
Message-ID: <CAD=FV=XZTzwROoVtA+qrpy5rrrM2RH3+tZFR0-KFTu79ea4rig@mail.gmail.com>
Subject: Re: [RFT PATCH] regulator: core: Require regulator drivers to check
 uV for get_optimum_mode()
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 3:49 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 03:32:44PM -0700, Doug Anderson wrote:
>
> > I guess maybe we could add the "initial mode" as an implicitly allowed
> > mode? I guess the other option is to implicitly disable
> > regulator-allow-set-load if no allowed modes are listed? Both of these
>
> We should do the former, or equivalently just noop out of set_load() via
> set_optimium_mode() if no modes are allowed.

OK, v2 posted where I kept patch #1 exactly the same and added a
second patch to address this case. Hopefully it works for you.

-Doug
