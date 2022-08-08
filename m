Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC258CAAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiHHOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243177AbiHHOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:43:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572C6371
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:43:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cr9so3337939qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oaVtHfpevo8t+0aLmvJM1EHv1DaWWIOLr3FwUKL7Uaw=;
        b=RP+0H07k3myPmtX4QHDE14d47vxsSEe/I5kiImjVlG7JT/yrgj+hcMU7Dct8lNTHxC
         Jvz0KnIzFTQ7UGXw23EkGivoLLP0+lTeRP8MsH/OwvvG8CwDukTfxivuKl34TfPzyb6A
         I8VKJmtImShdqiOHJApsjBV+1sxBa7cEejygccie5A0mk1XMUPUZecWJ5q2ysitlJ/sn
         e/1oFQU9YIb4KlQSM8X3+IJDsegusLK0whi5FmXgpzif53Kg5pz1s2P94MoSyJDN5HkH
         Kx+tDqYLdvZia1hCyk8u/LWq6cPUeMRGz0MNqkjVz9Y5lTwtZV78uVZ+bXxAdsiNemeY
         xAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oaVtHfpevo8t+0aLmvJM1EHv1DaWWIOLr3FwUKL7Uaw=;
        b=CM31JGI1cdfMBBFXP/tA2PkndJ+UvvExMdlJdwI2tf8R/V52LJTlXXU5suNvCqxOXF
         6jALmhHEPJwvfXwFGjUyG0Ux2ygrme2XljNemCYmgfnM1T8sUlvWXEr9bTW0XhdQWFpQ
         xOjNZKwG7taIduYRnJiyaxyeHBtyuIkKt7pyAsG89/DEEwsLFuUelJSdcKnpDBhSXpCk
         1D5lEw5C877qmp0EIX/CfaTlyef/Hu4Ud1joi785/sZ8F3fYurC2X7f2fPodamQVGOql
         D3BjT1Fv8OTHQ+j/MjdwMVnRVT2adLTFOHt00CfI4dt6bRtPf/79MnUzZ1mecGta56NL
         34/A==
X-Gm-Message-State: ACgBeo1/CWJOwYXm/lGSplMVmNoxRvI/a11rPelfUrtjSO4GupMh+ieP
        +RJKbmdXDmPa3ynPhJuJTRmlw5t96COxr85MGa0=
X-Google-Smtp-Source: AA6agR4Wk8rxBTB7A22XJ1hxtKWXMKtx5WPElhAwxga5LJdg2gp00a6i6a4SWwy4Y5CY+tA/M94LmLtyShOLw/irn5I=
X-Received: by 2002:a05:622a:14d2:b0:341:9fcb:79a6 with SMTP id
 u18-20020a05622a14d200b003419fcb79a6mr15947823qtx.195.1659969785313; Mon, 08
 Aug 2022 07:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <YvEKgkhRWCKtXdD4@sirena.org.uk> <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
 <YvEUJ12TmgRaR4Ub@sirena.org.uk>
In-Reply-To: <YvEUJ12TmgRaR4Ub@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 16:42:28 +0200
Message-ID: <CAHp75Vd_wks4d4HyFQpWWUQO-DPj7bmm6e66LSZ3F0+O6fC6bw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 3:48 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 08, 2022 at 03:41:48PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 8, 2022 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > regmap_mmio_attach_clk() prepares the clock that's passed in, we should
> > > undo that when detaching otherwise we're leaking a prepare (as we do in
> > > the explicit detach).
>
> > Why do we allow the user to avoid explicit detach? What is the point
> > of having that API in the case we take care of it?
>
> I think just for symmetry so it's obvious that error handling is
> happening if people want it to be.

So, the only user of that API calls it explicitly. Should I rewrite a
commit message somehow?

-- 
With Best Regards,
Andy Shevchenko
