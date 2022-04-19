Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9CB507911
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357251AbiDSSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357310AbiDSSfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:35:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6D4131C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:26:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r189so12876736ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mruETChJ0+tCEUKHTvZNud81HPLW0aPJc6Xrf5tnGg=;
        b=DsydkwpauFoZTteJsIEF/bGMn90fgQ9Nl47j1EELbxIjezLoZaBSF1/6UiUAJ0xmTZ
         /rj1G5jk60dBo4UVM2DgPIR6Vvan/PqzmeB6xOVwQeeE8PYz2WtSq1McY6N65diPpefa
         nAXHC1F8wbCTiYkwaIc8RZnhHY25UEX7C0bnrr/xJ95MNOXRvlc0YXBKz0duc1XPV+dW
         44AkXitfLvlHw2fzAtfAmQe+hCRMaIfProSkZ1Ok1LmTPwUfIZwFjyenRj6afmw4QjFs
         QE2OTQDnzWvTe1fb7XOp93EUJvVWXPYnf62b/6t+FzTu61oqhNT2ln41XNrxF0swOiHJ
         bP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mruETChJ0+tCEUKHTvZNud81HPLW0aPJc6Xrf5tnGg=;
        b=MarIjsZS7cdziRrRbr6ZbvP/KMfmSOGvJsCzVGj0q1Kb5QoQS5jJSmIsIlCAFANgkJ
         qjh1jKNiP7roCrTmMCCpAaONkpNpZ52nnUunT2UV+64BF6gS8SWkgIJdIgVk5FjGPCQQ
         6+p5+SPwNQcjRsiWYeeVBm7wnBnjt0suW+YrYbS05vHB05JQ8sEvuOIuVJEarCU9PVBA
         mvNIpCcwgeL9CIvEDkeI9X43BW07MxyQ4kkV2nDz3giAERINcmyVoqXBTQ2YWksjKWC8
         uKo9mAvZAcFeicvQQDXMD93+25xImuv0gxwv0QDFYZ0PdnwJqEiT2SIPV+U3rs9/FJCw
         x9bw==
X-Gm-Message-State: AOAM532NwrVIzlkoQC+OL/O+4Y5QB2q9YOaXkK0NcZ21um/dyZjzei4M
        eq4nksw6qzx8aj5Hg2/SEZFR8iREYrtwXAdJcTDHTQ==
X-Google-Smtp-Source: ABdhPJwIvBSWGeaTpciFQdI7H/y4cHsr0V/oV6NhWT9Ndt5EVDGgE7d9NetVo5AN6D6ckF93iOwY98PK6jBB0w1E5J0=
X-Received: by 2002:a25:d08a:0:b0:641:daac:ff82 with SMTP id
 h132-20020a25d08a000000b00641daacff82mr16009141ybg.643.1650392797011; Tue, 19
 Apr 2022 11:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220419000408.3202635-1-swboyd@chromium.org> <Yl4Au/O/am/ZbX9J@chromium.org>
 <CAE-0n507D9W5BFfG2vXqN1cqvnrQKLbLw7YejGb5_kH+7X62sw@mail.gmail.com> <CACeCKac83uiwdAf2RWqc9DxEft2+BSBn5Kp5PMR23UGKJyk5KQ@mail.gmail.com>
In-Reply-To: <CACeCKac83uiwdAf2RWqc9DxEft2+BSBn5Kp5PMR23UGKJyk5KQ@mail.gmail.com>
From:   Daisuke Nojiri <dnojiri@google.com>
Date:   Tue, 19 Apr 2022 11:26:25 -0700
Message-ID: <CAC0y+Ajf2GTG=ir=gu9T5Q1TXBHMC5qzzA_MEzWAvW5D71Yv8g@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Only register PCHG device if present
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch v2 looks good to me.


On Tue, Apr 19, 2022 at 7:59 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Tue, Apr 19, 2022 at 7:55 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Prashant Malani (2022-04-18 17:22:19)
> > > On Apr 18 17:04, Stephen Boyd wrote:
> > > > +             retval = mfd_add_hotplug_devices(ec->dev,
> > > > +                                     cros_ec_pchg_cells,
> > > > +                                     ARRAY_SIZE(cros_ec_pchg_cells));
> > > > +             if (retval)
> > > > +                     dev_warn(ec->dev, "failed to add pchg: %d\n",
> > > > +                              retval);
> > > Tiny nit: Can this fit in 1 line (100 chars[1])?
> > >
> >
> > I'm matching the style of other lines in this file (this is copy
> > pasta). I'll let the maintainer decide what to do.
>
> Quite a bit of that code predates the char limit update, but OK.
