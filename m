Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A720D50711C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiDSO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353577AbiDSO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:57:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFDFD3E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:55:03 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e2fa360f6dso17771489fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XfHepYw+eFDu4Y2GjQzYxqYQe3l3yCNETgfJfWtfEn8=;
        b=mixj2xeVA11NAQnkbsI+dJXBIaa6QQ5iSC6MLy+w2fOxHiEmQgDhlLwEJWHyD9l8J6
         /5E5PxLKpuoi1fB2GFy9Z9ilBSpoWgmZ4TMP6a08rkD++ADh9xVdoQcC8y1RGWp/rlPv
         hzPr+aTqT6BfqZog1Eth/LCpls7qr1CbZFc38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XfHepYw+eFDu4Y2GjQzYxqYQe3l3yCNETgfJfWtfEn8=;
        b=2hUc+3a01+uX1tZ0ZgHS+F+bCqV4Qg8ePUbTn8ErJcEemmKnfaXe9CaTfcohtByYyb
         sQbmfU6UA4cEDzYFLO/XFlpvl6z2+zoDpQvonWap/73BFBo4vpPOCAdbDCfWlV8DyrpM
         QL0/fh1GGjSikeZIrV2NhHEs6XB63QD6ogAkV5pgQVFMVmn/pCF1rKHCFcNeAJIlusyP
         K6Z76vnW9Z0qPfCKwjnFSDAO00AVzGHVclDCTWatqyTfdNNDOn9HjgqF/2RqaIutLY3p
         zH187EvGrPtV/z9IJYEcyKxgreyGjusHXe52h6K44pfAi/SzUsWmGUS7niof7Pyt4d8u
         rCkQ==
X-Gm-Message-State: AOAM531V8+06h8r/uG7a/5qea19DI5mdbhLchypOjCL5Pz6PsWg9XjBe
        Nap6dVt5rfA+5wKn6rEMD9aJBPc6Rk1sDDhyre2VKQ==
X-Google-Smtp-Source: ABdhPJzq4NiF1OxjHN/pxYl61Pc4EGrB6vaPpfW7dATfuy1l83k2YshuDNFMFnJZrwGySdplgTF1XUnOYvYGELVjq3I=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr6827263oao.63.1650380103245; Tue, 19
 Apr 2022 07:55:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Apr 2022 07:55:02 -0700
MIME-Version: 1.0
In-Reply-To: <Yl4Au/O/am/ZbX9J@chromium.org>
References: <20220419000408.3202635-1-swboyd@chromium.org> <Yl4Au/O/am/ZbX9J@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 19 Apr 2022 07:55:02 -0700
Message-ID: <CAE-0n507D9W5BFfG2vXqN1cqvnrQKLbLw7YejGb5_kH+7X62sw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Only register PCHG device if present
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Benson Leung <bleung@chromium.org>,
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

Quoting Prashant Malani (2022-04-18 17:22:19)
> On Apr 18 17:04, Stephen Boyd wrote:
> > +             retval = mfd_add_hotplug_devices(ec->dev,
> > +                                     cros_ec_pchg_cells,
> > +                                     ARRAY_SIZE(cros_ec_pchg_cells));
> > +             if (retval)
> > +                     dev_warn(ec->dev, "failed to add pchg: %d\n",
> > +                              retval);
> Tiny nit: Can this fit in 1 line (100 chars[1])?
>

I'm matching the style of other lines in this file (this is copy
pasta). I'll let the maintainer decide what to do.
