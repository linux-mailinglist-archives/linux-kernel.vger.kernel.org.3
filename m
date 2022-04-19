Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9950713E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbiDSPBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiDSPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:01:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F43B012
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:58:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j2so31595149ybu.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG8kQ+XIcj/kxQkqKlX6Of1DGaCLk+DsEI9aRIpWeLs=;
        b=Oy9TvaCS/0qIZZ8t1TL2LJxxehNvhY1VAoqRcmRrlCdVK69gizdMFSGDeZiX0xLCOf
         2KcC7dEOo6dIqoY7Z3aCU/K+5ky2qwleELsn/kkkKEgDhWUXVGKy6Nq3RKuutKo2UkCM
         vP4RFdEK7kzA6azj/1KzhyiPNPwQ1YXsTxuq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG8kQ+XIcj/kxQkqKlX6Of1DGaCLk+DsEI9aRIpWeLs=;
        b=jhKby4VvrMHBPf5j5eCdIkNmvSINV+y3JKMXUIelWs44j3nKL/yWD+fZQxuQyZL6bb
         1j7Tic5hIrJGUFybtFgy2xwlGMVq8L44VtnD/CSMR7XNHgI3Hv7+/VeVAxghvIYOGoI9
         4ViYD01lzdCYmcxfcOaiPrPPVVkNGcqGSOlGUwiV06h+uO13c/u1kp4699RyzORPz2g/
         yb26ZXUe2NvfEA0/jj/tGWBqqt2z7OXCjmWL7LD/QGZpqdu5+9j+lNU6GxffKzNyGAVX
         KlfD/Oi5tTUNAj3l5ED3eKQozdnD/ZpDGjAAzRB9vXzz0Ix4epEeJk9gbyHV8fCUnKDj
         qJZA==
X-Gm-Message-State: AOAM5319hwxol9Qke55cVIBy4fzISA4RHlpMJDWBtCb7HdMKhGJAQMGp
        JlJq9xWyjh+zvdQQSn7oi9c6ShEyzAlTZZXZAybXYA==
X-Google-Smtp-Source: ABdhPJyvxzwabX5yi+4hLlFDW7j672aGNtFoJ1IdyVEymCiqxg7DCHw1Bd0ZglILn50oMoTJO2soBbS5WmSx/OFgbVs=
X-Received: by 2002:a25:3258:0:b0:641:d47c:8321 with SMTP id
 y85-20020a253258000000b00641d47c8321mr15399843yby.294.1650380337072; Tue, 19
 Apr 2022 07:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220419000408.3202635-1-swboyd@chromium.org> <Yl4Au/O/am/ZbX9J@chromium.org>
 <CAE-0n507D9W5BFfG2vXqN1cqvnrQKLbLw7YejGb5_kH+7X62sw@mail.gmail.com>
In-Reply-To: <CAE-0n507D9W5BFfG2vXqN1cqvnrQKLbLw7YejGb5_kH+7X62sw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 19 Apr 2022 07:58:46 -0700
Message-ID: <CACeCKac83uiwdAf2RWqc9DxEft2+BSBn5Kp5PMR23UGKJyk5KQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Only register PCHG device if present
To:     Stephen Boyd <swboyd@chromium.org>
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

On Tue, Apr 19, 2022 at 7:55 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Prashant Malani (2022-04-18 17:22:19)
> > On Apr 18 17:04, Stephen Boyd wrote:
> > > +             retval = mfd_add_hotplug_devices(ec->dev,
> > > +                                     cros_ec_pchg_cells,
> > > +                                     ARRAY_SIZE(cros_ec_pchg_cells));
> > > +             if (retval)
> > > +                     dev_warn(ec->dev, "failed to add pchg: %d\n",
> > > +                              retval);
> > Tiny nit: Can this fit in 1 line (100 chars[1])?
> >
>
> I'm matching the style of other lines in this file (this is copy
> pasta). I'll let the maintainer decide what to do.

Quite a bit of that code predates the char limit update, but OK.
