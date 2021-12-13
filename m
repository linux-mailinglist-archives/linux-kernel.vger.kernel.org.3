Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3050A472219
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhLMIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhLMIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:07:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D113C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:07:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf39so17137031lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t7I28HqZkghwhrZHUUn8NTs6S2RHIB9DZcJNWAJhWMY=;
        b=LsPD0SMXwIxCEt2/4UIgZsDZrNe4V0blMahA8x5TD9u6LNdX/B7HLHJgjaDZB2W+Lf
         27xi8EEABBVYYe46DBgxO5teRmuRxdA7/jCLfi5rKwGJ/OC1yDtBfCgujGmhk0ocNgbT
         tHmyx7lAijk5czUiSrfrAH0okKQjGKiI13yn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t7I28HqZkghwhrZHUUn8NTs6S2RHIB9DZcJNWAJhWMY=;
        b=ZeZ1tgWIs9EV+OsLWAiIQdK0nkpi76JY00eI3t5JPlBE/ndVPxPnCv43pX8mSDLdge
         AzkNXQvfi6mxeLfN3YUtf1vfzOfrxFqraw+AZuxevcuaDm4+Ss2Ml3OZ2aVXbqr0rbHx
         uau/ARUUpLCV4PG1LjegfWbB6JMaMqbNDPaS4OZcZ6oqQ2yI8oHUt3CbBkMCaLwcasWh
         lhutAdNOJmdHJn0nVGSTwM8uZv9Q/8iNau3C0AGM0k+vI9ZZ0zpGKcnyvBpH8unYraOC
         BIoTuRZXjNz1wmLay4VW6mn8SLHbMyvnRZP1wtFLh3pP1nN+nbWIWQwNttq0nNrqgq61
         hsSA==
X-Gm-Message-State: AOAM530fJYejozi5LPhyWVZq5ui2EH1sJmn4B+63/8xYGx8WgJNodnZ8
        x2/eI0YMJc7BpHg+UTwTrUkEQW95DhGAyui+JiKdiQ==
X-Google-Smtp-Source: ABdhPJxLqEqJrlLZ0L7uWkbBqzn0qyqaZrw47K03z1EWMg8G5E4XhaZHaJHlOy1JBY2EVegaQZJTj487DMrNj11SLgM=
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr27458632lfg.308.1639382820385;
 Mon, 13 Dec 2021 00:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20211208185211.40682-1-jose.exposito89@gmail.com>
In-Reply-To: <20211208185211.40682-1-jose.exposito89@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 13 Dec 2021 16:06:49 +0800
Message-ID: <CAGXv+5FpmRyPXUB523+v9=tZ+3_2YzvS7qMEn5Dc5N8rfs5A-A@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Fix memory leaks on probe
To:     jose.exposito89@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        ikjn@chromium.org, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 2:52 AM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gma=
il.com> wrote:
>
> Handle the error branches to free memory where required.
>
> Addresses-Coverity-ID: 1491825 ("Resource leak")
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Though the bigger problem still perststs: clks registers aren't unregistere=
d.
