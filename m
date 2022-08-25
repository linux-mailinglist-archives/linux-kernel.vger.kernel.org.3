Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0825A1094
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiHYMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiHYMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:33:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69398B2DB4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:33:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d21so19896588eje.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mrkgyGGtG0jCfP1J/Gr+LuHZyy102jnVtkJW4o5/K2U=;
        b=a2Hx/pby3RqQVZ3lXhAV3SRnPmT+K86WrrkAi+DMK5IBicJ1T3pVTzg7KuOxngrM7i
         I3Cy6mpc7/So6EQh07ASDIGl9/WW2KpPLc9QdffpxXBPsZC8FAsc6fnJx03LhffWK/sz
         0CZZ5skMt74mGN4yumGfogm8bbGuZAvjMZagYf5yBLOfw4PDOhjiWHfVnvfzYRk9zMMB
         4vTplAyYn0OWY28fcgIQD2+sjAnJ1K5k0qyU6D299laQAfFHDZkHXAZJOAz6WxXbTlu6
         wuUCN6ZjJ7xFwJ+RvoPO27YZcdqi7FNriXol+l1HOtiz0uh/mRWc3HfaalyqEdz3/s43
         95TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mrkgyGGtG0jCfP1J/Gr+LuHZyy102jnVtkJW4o5/K2U=;
        b=pe4vyyChTMhSV10sU1cEHzVVz1ToZ7D2W/w2VGoLE/s2LpHwkxY/R6V3YE+42ZoV4U
         UD37u9yp1tgqMavHW/DrnOlmsLy8NrKdM8+uqdarinbwUoiYxhRM1V4K1QiAm/aaquDZ
         tqouXQSc90I9somheioSolYI3N5AiCxnerpjdd7MUnfNogysFN/fbcWAhpdx6qXNMdW8
         YnvEnIGr8khxmmDY5gK7UGEa6heDahJ+obQpHgKlSD4rOd2ULa9RMMsE7VeXtSJa+lN1
         TS30r5kFzlk+BKYf7iWmgsdb/f4I8hDM3RRbUsjJzq2pZV1HOc22pxo7VjobW/pr6rdb
         kr8g==
X-Gm-Message-State: ACgBeo0Rrz6mpFfkOi/CMVO/Q+1f/niqEMySis/pCUlXTVwoNgMQfhJv
        60sTT1VpRfbtvZ5GEnAGcPnqAXS2jg6HGxCkVppnqA==
X-Google-Smtp-Source: AA6agR6Y6aMNqLvf9WqNGvXBiKIOeakFImIcJi3RY5vbXejOHjkUjqois26pyvHKxFEw75phZeuE6OVe2QoXM6s96zc=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr2435316ejs.190.1661430797685; Thu, 25
 Aug 2022 05:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 14:33:06 +0200
Message-ID: <CACRpkdY692EGPuTCbmr-rmpPg3BkGQBWtxA0cseGgOHrgsMRmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: add support for SC8280XP LPASS LPI pinctrl
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 1:38 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> This patchset adds pinctrl driver to support pin configuration for LPASS
> (Low Power Audio SubSystem) LPI (Low Power Island) pinctrl on SC8280XP.
>
> This IP is an additional pin control block for Audio Pins on top the
> existing SoC Top level pin-controller.
>
> Tested this on Thinkpad X13s
>
> Thanks,
> Srini
>
> Changes since v1:
>         - removed unnecessary quotes in bindings
>         - remove lable in bindings
>         - fixed gpio pattern and removed an extra line after alt functions.

These patches applied too, same comment, if any further issues appear
the easiest is to just patch on top. It's nice to get some rotation in
linux-next
for these.

Yours,
Linus Walleij
