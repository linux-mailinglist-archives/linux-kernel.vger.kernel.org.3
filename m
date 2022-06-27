Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC855DC91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiF0J0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiF0J02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:26:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09F615D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:26:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a13so15528269lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEv1nUU1jY0pKLJwE3iPS1IJafi3TY1+3l/3atKLKaI=;
        b=TTJLwhtvbsqhadefjMNFeCvqr5u2g7+axGCHFhgO6zBrdslsceTGKxOzqpzJm63qTj
         9DivaoruBYpOMU92umBbDhndB/J3OO4Luat0oDQGuWt5uKP3FcaMASiMt4znEPU1M0hY
         6XAEiJLOj2L2/i+M3CZ8M+Jf5jVuuBD84iWc0Rzelo97HF5o1dWlo4EkxQeBIrly5TRy
         hI5zcBS5R/oLDiy+RgL8sx9/vLm7sP4mLFoJFVMj5cqAQIASYJy9vVK8rI1hSeLg2sKR
         Pn0omSpTBCiW2X8RXAxrabQbtqdYvifmJnalstYRpUiyeb14wE2emLo+ZxFMc7O0W/RR
         iz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEv1nUU1jY0pKLJwE3iPS1IJafi3TY1+3l/3atKLKaI=;
        b=FrGgbiWR48XdUfVFwGWFa930aYbaNbC0sjjnsaUoIn9YTotC3+GL8wuG79eslC+bTJ
         dQhSkd9uQYr/eU8UMThusjU6zUhrvrGGDd+h1TbCc+7Rd/SkgglV13DqW7ot/YpoMb1S
         8AjL4jMR8ALk4hbE9YeCtzPd9xOE6wt8WKPDBez/TCrWkHyqley6uKqS5XuuZdozmdSy
         1u2qMJzzpVlIza1X0ZmQK2l1FEt/Gtm424RSm+Yu3zPOy5Qr0luZJNOrfNflUdEwhiJo
         ia4IQhuVWpn7f+c/uTo73cxiPjF1r/3YOQBs8SOzWXjxHjsnrUp0lhQEvXARejm5M2kB
         q7GQ==
X-Gm-Message-State: AJIora80iTFOkHPehgHEN9oIdrKpy/xcAhgtbvbVfr2+PTZG67jMh+K+
        X57FArTcidNPsUjory4zw5CHLLAPPY1lN9XtldaUJg==
X-Google-Smtp-Source: AGRyM1uMwQheM1Hw5sD1YXx+j/fteeazXfa3yOo80Os4o3hX01UZLQ8H8Xos0EbwpcCf6zujPujZ+LWkev49BjH6NrQ=
X-Received: by 2002:a19:640e:0:b0:479:5347:b86e with SMTP id
 y14-20020a19640e000000b004795347b86emr7420410lfb.563.1656321985863; Mon, 27
 Jun 2022 02:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220617014308.4001511-1-windhl@126.com>
In-Reply-To: <20220617014308.4001511-1-windhl@126.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Jun 2022 11:26:14 +0200
Message-ID: <CACRpkdYD4PVMLt9TLk+M8BxGkW5uDmeU61BN7UL1xhVkf3g27A@mail.gmail.com>
Subject: Re: [PATCH v4] clk: nomadik: Add missing of_node_put()
To:     Liang He <windhl@126.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 17, 2022 at 3:43 AM Liang He <windhl@126.com> wrote:

> In nomadik_src_init(), of_find_matching_node() will return a node
> pointer with refcount incremented. We should use of_node_put() in
> fail path or when it is not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
