Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A05846F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiG1UHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:07:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E57479D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:06:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so3485248edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=b99vshAhGChh3A9VDnm6KS29Pg4yAPwV39WCn0DHyEw=;
        b=j/cVnyPJc3NbVdA6KozIiXB7d1QQk+XXmRNE0ZX9Jr5ze1E0ZnY/NdUc8lE2pzXYHK
         T0jUhZs+w+0Rdv0Ke7Ah2OmBDArPN9qCD2CvffXu2uKVOU1h8HOBkyCChfnrD2nfS7e1
         g1n0sndpcyCYQLwBxOrKsGhccrjtnd+evojNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=b99vshAhGChh3A9VDnm6KS29Pg4yAPwV39WCn0DHyEw=;
        b=ecpDhkPJ5rpMUH6QIMBE0FNkMgGGzC+UfXoFQmfCHBXSt0KNWRjaXhkLjfBAl6fHRF
         Shk7B7ojt/l0QVvQyAtnZ+9Eo4rDKqZVDzBAz8q3i+5IsM/yuyNLrz/Xf8SntMCuQmiw
         Ne++LQe0e1GOUwqBrsz3mVAyIROpZONWAVQzCe172kW3t5peikdm6/An2tvIFNKpN1+g
         /nFZSyXtItC4j5t7RaaU0uKQ0qR0loVlF8lQmjtmWuqgsIPzzt1vGF7ujjUcCQYp/vz9
         yYJCNw1SqbvW9+2lV7xeRLwR6wJGXBgrq8XJ7xPMKxubEIchBkJMkrAJKL5GB50GgHxh
         kxvA==
X-Gm-Message-State: AJIora9Ji7DQxd3dbnhfYt27biNpsJdfrUhhtja+txjJXZeEmmCME8Ao
        kACANxd1FTYPRAyXBD8sm0As1NkEW5i7luq2
X-Google-Smtp-Source: AGRyM1vA1NKL4rGiriN/ma0xZX/Zn6+WIfLIBRd6uXH0MLcGGOuUj/c8cvX1esKrKRNyDnSVLHQBPw==
X-Received: by 2002:a05:6402:27ca:b0:43c:2a52:a90f with SMTP id c10-20020a05640227ca00b0043c2a52a90fmr557907ede.328.1659038817755;
        Thu, 28 Jul 2022 13:06:57 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056402291800b0043b7917b1a4sm1235159edb.43.2022.07.28.13.06.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 13:06:56 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3163104wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:06:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1e0f:b0:3a3:191c:a3c8 with SMTP id
 ay15-20020a05600c1e0f00b003a3191ca3c8mr292036wmb.151.1659038816119; Thu, 28
 Jul 2022 13:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220728105005.v2.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
In-Reply-To: <20220728105005.v2.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 13:06:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=BbNDW3R0bRoJNrOz61KSop4NorP-6QQKYHVu5wnTMw@mail.gmail.com>
Message-ID: <CAD=FV=U=BbNDW3R0bRoJNrOz61KSop4NorP-6QQKYHVu5wnTMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: document zoglin board
To:     Bob Moragues <moragues@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 10:51 AM Bob Moragues <moragues@chromium.org> wrote:
>
> From: Bob Moragues <moragues@chromium.org>
>
> Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> Zoglin is identical to Hoglin except for the SPI Flash.
> The actual SPI Flash is dynamically probed at and not specified in DTS.
>
> Signed-off-by: Bob Moragues <moragues@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bob Moragues <moragues@google.com>

Something is still messed up with the way you're sending this. You
don't want the extra Signed-off-by here. Maybe try again for v3?

-Doug
