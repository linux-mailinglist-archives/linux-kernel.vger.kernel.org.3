Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96739506039
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiDRXcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiDRXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:31:57 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9A1BE89
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:29:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so16385536oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=fnGr53ll8S7dG883IEeM0scEHRuR6/64FgMBnWIr8nE=;
        b=R+chdkm07WDUmBdNNWTZY4DCcpGBLLK3l1gkE7+beL5tg8tEW0mNPAJlfv3h6VpRqa
         hREevAo2QcF6sO51GnlLz4jjZNvnHfFK7/vz7FgDeiHcJ7ydpJYnIfuIXIdiMO+Uyk9O
         QwXUUDnQ5rMWI5yTPpRQYpi0oXzKIwWfzc4BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=fnGr53ll8S7dG883IEeM0scEHRuR6/64FgMBnWIr8nE=;
        b=fNvTT7ty0XR4pPdEEeNzKS8qbJJMsoZqqHLeiKa9FE51YFqclMFFnXWC+xAy7EYzFC
         JUJp6H6LvPx13f9/dDa44pHBwWIhaoE0p4I8/Igj7zVxVA0s2rYky3Qn60ElPZ140266
         OaA4WvAAmEEsBlbIMjFOawPXS/8uN3yuk7K265JreMuDDbiVt7p7bVze4vsio1xppuZg
         6yisotWKOKjr6SFXAvP/eCQGAljYTQi+mYD+3jAanxe/etStAANnGANXndfqPKN6+WVi
         G1vwAZWh/C5J79MSDrP61PS4wLr1ncx9obQP6ekHHe147Hc3Iz5LbyaSzs7fpRfd1pEw
         2nxA==
X-Gm-Message-State: AOAM531FLeTR4bskxJh2x2H/7exoxpXtZkYlGQk2dBT8JeoYVT2ziRYq
        3Di0mJ6mNnF0Q3dttcScJAF1rRkT+y77Ah5VzYS3kw==
X-Google-Smtp-Source: ABdhPJxMMIspQN15t5a3pLyxGSFKCn1ePl9kulWUC69ipdxaKBN7DSnhvNpkkFk0BeDV4jrv9qJGDAXy3HuVcYX/MUU=
X-Received: by 2002:a05:6808:10d4:b0:2fa:5fa6:e9c4 with SMTP id
 s20-20020a05680810d400b002fa5fa6e9c4mr5863218ois.193.1650324556139; Mon, 18
 Apr 2022 16:29:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Apr 2022 16:29:15 -0700
MIME-Version: 1.0
In-Reply-To: <Yl3ykMvfCaQlQ7t9@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org> <20220415003253.1973106-2-swboyd@chromium.org>
 <Yl3vd4kfgwJXMs/w@chromium.org> <CAE-0n53N1k_b9vWJ84nBdm9sxpYV3o4-FLJQM1HGqEhQsdr19A@mail.gmail.com>
 <Yl3ykMvfCaQlQ7t9@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Apr 2022 16:29:15 -0700
Message-ID: <CAE-0n51PX1SgqiB5vgoOLunkrxiWxH2O=jCCM5gNL97O8Ltt4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-04-18 16:21:52)
> On Apr 18 16:16, Stephen Boyd wrote:
> >
> > Sure. I take it that I can drop this function entirely then?
>
> Yeah, if it's a simple response, should be fine.
>
> > BTW, why is
> > that function name the same as a struct name? It confuses my ctags.
>
> Yeahhh, didn't think about ctags... :/
> Topic for another series: probably can be renamed to cros_ec_cmd() (just to keep ctags happy) ?
>

But then there'll be two cros_ec_cmd() because there's a
cros-ec-regulator. Fun! :)
