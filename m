Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00E359EA60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiHWR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiHWR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:56:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AEA41D0E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:00:29 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-324ec5a9e97so390966977b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3dQyigqDySUcnNz+kI5C34gtlF6MAv3IrSZUE3ZzswU=;
        b=Q5raPWzg01QQ8b+RC93TmhU7VQi6OaROc9XODIa66NwvXNLQoRJfbs2XNBpQ9OsLT5
         XFx9/CAfAVTZL/RsJ4WN/WWpqTBo6DEWOdg6thWz6poiaPAjtf1uKVhCOOPtujtOaBDn
         loia6T7GVu/y9PlUju3lYuPQkKnl8NyRdPaG0tZbeDkiLTK35y+o70hlK+iDC244Cnex
         nOdfGSrMA3NZST8xeu6h6gMdN5HaR4i7GPlc+ctTzqLVK/ay0H98/CRPufHGGvJl1Rq3
         44ePZO+ikO+ITfB1bsnDQ1GaO+X/2lDq875P5iOW33UXTV0E6AxYorUCgusHji+VMF/V
         O+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3dQyigqDySUcnNz+kI5C34gtlF6MAv3IrSZUE3ZzswU=;
        b=Pi0I1jkUor2YZa5oe9WIrjF94+xIseZnKkXo4QifkZO9titN+mvk59I8Fnj62HTDio
         /e3RAIsineaCZlPli2eaS/FDfhDkmxbxa5npG/5G8Q9B4VlSNE16EyjhAs7kWoMDeiLq
         R+vSncVAtXfa+9fjcqC35xHWBClNkrJZF3Rs3QHiEJ0YtOJJ+9lq77tDAGnLjjnKQuQN
         XvHNYzUIFsiNtxNoqtMJ/vmB6bAbzd0sDQbWZ6KE/ibf2f/2we5wJ+F7rRdLWd6AKt8w
         vew4PMzM7uySOOl/wezWhiA/hMR8AMxFVJXAyfYRkucfAYQEFfwgqhrYmtx7rMKMqZ89
         X2bw==
X-Gm-Message-State: ACgBeo3xr7J+0thHSRsURzjH3nbsNvee6ziHunjOHm9P5AlcEO0sDZj9
        U38YknTNAq/vHL7MHB0sXltLGBNpoc2Rsr9U3bwVcw==
X-Google-Smtp-Source: AA6agR5EYC9PSySqyvuhEwP4rGhe0NxC1ENen2hEqZbLD/v8D5dxCWvpD+wgaxFUM6KI9puS4IdrfU0TAy9dXIAqu9w=
X-Received: by 2002:a0d:e003:0:b0:338:59fb:2123 with SMTP id
 j3-20020a0de003000000b0033859fb2123mr19854641ywe.357.1661270428610; Tue, 23
 Aug 2022 09:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
 <Yv27K4+rLfskcQdm@google.com> <CANkg5ewGUcWagRNOLfbRx8hLqgX+FfdYGB5Qt7tO5=zicGBVDg@mail.gmail.com>
 <YwRAL79BN2d/A0V0@google.com>
In-Reply-To: <YwRAL79BN2d/A0V0@google.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Tue, 23 Aug 2022 10:00:17 -0600
Message-ID: <CANkg5eyEzEpGtO_ZyQrCauX_xLR=9Z9B3jbLsHxTSPK=xk4awQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     rrangel@chromium.org, robbarnes@google.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Mon, Aug 22, 2022 at 8:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Aug 22, 2022 at 10:21:47AM -0600, Tim Van Patten wrote:
> > On Wed, Aug 17, 2022 at 10:08 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > >
> > > On Tue, Aug 02, 2022 at 11:40:08AM -0600, Tim Van Patten wrote:
> > > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > > > .prepare() and cros_ec_lpc_complete() during .complete(). This allows the
> > > > EC to log entry/exit of AP's suspend/resume more accurately.
> > >
> > > As what I commented on [1], the term "host event" in the commit title is
> > > confusing.  Also, as this is a cros_ec_lpc specific patch, please change
> > > the prefix.
> >
> > I've updated the prefix to "cros_ec_lpc" and the title/description to
> > indicate that this CL moves when the host event is sent to
> > .prepare()/.complete().
> >
> > > [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid/#24934911
>
> I'm not sure if any unclear.  "host event" is a terminology for CrOS EC.
> The usage here is confusing.

I updated the title/description to "host command".

>
> > >
> > > > -static int cros_ec_lpc_resume(struct device *dev)
> > > > +static void cros_ec_lpc_complete(struct device *dev)
> > > >  {
> > > >       struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> > > > +     int ret;
> > > > +
> > > > +     ret = cros_ec_resume(ec_dev);
> > > >
> > > > -     return cros_ec_resume(ec_dev);
> > > > +     dev_info(dev, "EC resume completed: ret = %d\n", ret);
> > >
> > > cros_ec_resume() always returns 0.
> >
> > Yes, it always returns 0 today, but that may not be the case forever.
> >  While "ret" is not returned by cros_ec_resume() today, it's possible
> > for it to be non-zero and someone may update cros_ec_resume() to
> > return that status.
>
> Does it really need to print if `ret` is always 0?

Yes, we should always print the return value in case it changes in the future.

-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
