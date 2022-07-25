Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C165A580497
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiGYTlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiGYTld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:41:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C32140DC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:41:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id c131so21897682ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyXBgvw8a7RACZb2rtfcsCeOcLD/UgLIb3Y6mjqQA6E=;
        b=EzZuB8j7SIjJwSM5k4eg8OcGGEFloLSrKlbUR9iuFawW67W40cpq5q3t3HzDL0ud14
         go5BAnP8hJK3fZBT/qJXj9OMR9MjRu9lAFbdfCDfVokU/1ksRJ98wlReXsk7fLWhZuTd
         HAZiua5m6KopXWBqeX2hTr6/VElxoo0Bl8m/y78jJSCUf+jzP3v1ZAq9CdmDiWwtFHX0
         9uMGjYhzNqv+SgE/HNiWEIcitfOH7hj/M3MZluqJFDcDEZIrtCRcYx6bQ47cEq6NgRAP
         6Lok6AXfQzrqv2rr2BQp17+IuLt98NVcL5vilOtOTIjl2gS8blgEuLXGNV1DrAMJ2aNS
         EBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyXBgvw8a7RACZb2rtfcsCeOcLD/UgLIb3Y6mjqQA6E=;
        b=wziZoMRhuo97Nu81u/rf0tRZhTmkhoVKcoan2BQy+m+boyWox/Mm99NzhfF2pf9oYF
         SE7hTgLPfRQChFmPEQzSr+dXqiyNnSNkXJ3J8qeROTO9nRzUHpdPHiuDU5A143VdOLzm
         1dFa5z2sIqUsR6DQYhMfueRYGvVt3ib6N2zQJOxXlq1ZZpM6m2Qtj5FDXkX+8ujugusu
         cWf139b6tD1Z/PYyNMhhFSOYtX94FVRvzl4ix6Pa5LrZzyuvdn5mfJSpJamlK3The9hV
         kSctsydTmiSnk+H1NlTTWt4ccP34GiglloJeB7i9UbvICmGlvw8HzbRtPZXNnStpiVoz
         KXDw==
X-Gm-Message-State: AJIora+l2GEGtGbTr3FajmdbiKRy01Lo0WTbqgN+sxkUylckMi4CjUn7
        oyP1LVlUxJFFQ2YfwOsT5FjdPvuceu6+xYecRP4=
X-Google-Smtp-Source: AGRyM1sVMXFjNTqctjcZYh95IEJaDvFMBwZkvxODAvQX3LCXPZIq9zfpwZw2trNQYgU/O2Hi4wHhLYx6irc0/wmWmco=
X-Received: by 2002:a5b:d09:0:b0:670:85a4:aab3 with SMTP id
 y9-20020a5b0d09000000b0067085a4aab3mr9723774ybp.182.1658778091428; Mon, 25
 Jul 2022 12:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220705021526.281441-1-windhl@126.com>
In-Reply-To: <20220705021526.281441-1-windhl@126.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Jul 2022 21:41:20 +0200
Message-ID: <CAFBinCDVX4pNHdEQSnypT6K-+FoO3_HsA0u4Qc6cR3hGHH7=3g@mail.gmail.com>
Subject: Re: [PATCH] phy: amlogic: phy-meson-axg-mipi-pcie-analog: Hold
 reference returned by of_get_parent()
To:     Liang He <windhl@126.com>
Cc:     kishon@ti.com, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 4:15 AM Liang He <windhl@126.com> wrote:
>
> We should hold the reference returned by of_get_parent() and use it
> to call of_node_put() for reference balance.
>
> Fixes: 8eff8b4e22d9 ("phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI analog")
> Signed-off-by: Liang He <windhl@126.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
