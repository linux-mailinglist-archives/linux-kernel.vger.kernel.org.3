Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B594D90C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbiCOAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiCOAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:05:10 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0660D1AF21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:04:00 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d07ae0b1c4so183428667b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBOnam2LmZQW2iGFg9CBW+HsB6A0zqMq1JQjc15BdrY=;
        b=kV6sjpLvuiLYILgw11J6c2F3cs2E6pglb4HQKqoJjPHloObdr+kX2o43qiXd6CwdhT
         atjIXK8dhLnxY4cePB/3W/hhBeYuGv5EEV4Z033tXRgeIdTY7P3a1d4NYAC3YLxn0Oce
         ePk6/3qZpAvFWaOgAtmBhd/m80vrd0QpJ8q1Xsiq4XvlVtzm6MmTRCII1wRbPk8jiLz/
         K4PCHprLOCTacohkWJRrAJ81GB7I+eLOxaSDGMHw7GvGEA/gSOvMiFobg1V3m9sLmYaa
         Ar/graUrTeugI7AMRIR7gA1w3G6lpcazu5UOWkGGaiaZi6im12ZaTHRhNc5KUOsMs+mM
         2u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBOnam2LmZQW2iGFg9CBW+HsB6A0zqMq1JQjc15BdrY=;
        b=j8bceSm49hf/Pp5C+DtX87xkLAf0203hYQAusdVn5LT1qhsBGTS0yJLHOVi9LgE1hm
         oUFyrW5qJB8aGsM+1GT8fPRyG2hm2P0AmUgDgBf3LQTrfcXrKuoFFIvW3uirM15+3zh8
         l2/5BvbYfg+oQsba174UgcHZyEx5vKyJ5EDFn5pEyixLxA1cxCVNNzQlSU4fHY8XXCJ7
         sOlLdqhM3xxEet4rfxjz5M9344ATrWpPw2t67lYz10QOZnqoE8BVreVVRP2mt4GgaXia
         nz0oQeOsVb75HOR9c/h/Xz1IdJ6MFCY5llFSVnxW4r7abS9CbNS0/6nV0dJzgLSu+1uK
         N/IQ==
X-Gm-Message-State: AOAM530BH2Txbdb3dRL5U4xlO++J76JOwWpbWCPznSQPZ3gDxqDBGKpT
        PL8DmAGrtTnCAp8CTT5R5xzX9ijAETCbn8UeFw5X1w==
X-Google-Smtp-Source: ABdhPJwUmMNGA86iugQC3ZrPytxozSLtLfREZBKKlRlmfuMosXaH7HXHMVOD5CEtg7vcd65ZAWzHgWz+UrKe17kgzSA=
X-Received: by 2002:a05:690c:9b:b0:2e4:da22:2a71 with SMTP id
 be27-20020a05690c009b00b002e4da222a71mr15687703ywb.126.1647302639271; Mon, 14
 Mar 2022 17:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220228010103.2725893-1-peng.fan@oss.nxp.com> <20220228010103.2725893-2-peng.fan@oss.nxp.com>
In-Reply-To: <20220228010103.2725893-2-peng.fan@oss.nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:03:48 +0100
Message-ID: <CACRpkdZw9MG-6gphnJqi1R=9YHWffJstxjJHNHu=DrdHYCGsNA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] pinctrl: imx93: Add pinctrl driver support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, robh+dt@kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 1:59 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

> From: Jacky Bai <ping.bai@nxp.com>
>
> Add i.MX93 pinctrl driver
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Patch applied.

Yours,
Linus Walleij
