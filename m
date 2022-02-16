Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72EF4B81FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiBPHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:46:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiBPHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:46:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55731B9113
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:45:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so5689714pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YN5uZU/PXTIv8VCQfKOIBlY+j6VWjLtTOcNJOL3vTg8=;
        b=rnf3tToHhhQitGcrIbnwnoa0CoYVvTcaCbeCBVedxr0ccBFj8UU5+8bEJDSCDD0uYf
         huTvKykAMUvcNafTRFgjaPBlrbFWJEDeSv6DYlGb4XCYWjdzyriYo7cRZG5E7Mc3HKjy
         2tKZ2dGJeJ4QMe6kL2CDX9I3CnHayrhrifgU+AjIgPJqyNj4AWjUDU08Xw04ymItqG87
         7n/t1a/wUVVpulGl6bz3yMr6LX+e1I/XUXNO6gVrB/PovYxaxPO5ywqUjZnmHEX0GAQ5
         2uTtJuK10liyMpj/4UMoxTRPnzj6rvsaGn770wDyFd3R4GE4v+kNOrqyzRPPfoY2UGSF
         aPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YN5uZU/PXTIv8VCQfKOIBlY+j6VWjLtTOcNJOL3vTg8=;
        b=HqhA+m8o9DTEF5iFXP78cJBmWWANmh02gm2yuai80XTeGgixqjHuDS0f4V4r/UzrqQ
         plZ+M1d3VZvUo+tw/HzSiNxK6Y563Suex2j81XWvbulItTkfslyZiBCVf5KloxMXUU7F
         xAViV7PngVCWYONvumJXFQ5+mG2JwXX85RCtg1rF31TiXsbZh4wY3fHJ+glDmOfk8hYr
         k2uAP8eU4IaI7PK8LR6cUvGvACzPGtopq1E3oGUDhAGWM1W5vFZUVJmmlrCQ5qzR9SUY
         6YjyVwUBkXjkumtkGIR+5Zz1PQqnN8VATJ7ol1JiLSRKFjtWzPBtbaQtnOaxV8+Oq7OF
         HRNg==
X-Gm-Message-State: AOAM533N1WTNwFAk46fISb+CXXLupXM2WMSgS+LHyPdwOCnhPDZDbj+H
        Kfg5tv89unqanxDNrf7YfzaueaZnsMrwYg==
X-Google-Smtp-Source: ABdhPJy55esxLtjCyDQYMn9n9Q1peLEQhuGHeNP8/ie6YsI78JqNRD6qmSLjtdRwCpOvZCJfXvXY7Q==
X-Received: by 2002:a17:902:a982:b0:14f:f55:a09a with SMTP id bh2-20020a170902a98200b0014f0f55a09amr1625404plb.33.1644997553944;
        Tue, 15 Feb 2022 23:45:53 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
        by smtp.gmail.com with ESMTPSA id ip10sm5027355pjb.11.2022.02.15.23.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 23:45:53 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:45:51 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] platform/chrome: cros_ec: initialize
 `wake_enabled` in cros_ec_register()
Message-ID: <Ygyrr1U9JbqHDSCK@google.com>
References: <20220216043639.3839185-1-tzungbi@google.com>
 <20220216043639.3839185-4-tzungbi@google.com>
 <CACeCKacKtJ50b2TuuhcVYPq0Fd0unVJdMuNDk1PLNK_r2JHZ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKacKtJ50b2TuuhcVYPq0Fd0unVJdMuNDk1PLNK_r2JHZ+A@mail.gmail.com>
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

On Tue, Feb 15, 2022 at 09:47:09PM -0800, Prashant Malani wrote:
> On Tue, Feb 15, 2022 at 8:37 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > `wake_enabled` indicates cros_ec_resume() needs to call
> > disable_irq_wake() to undo enable_irq_wake() in cros_ec_suspend().
> >
> > Initialize `wake_enabled` in cros_ec_register() and determine the flag
> > in cros_ec_suspend() instead of reset-after-used in cros_ec_resume().

After reconsidering the 2 options in [1], I feel the flag needs to be set in
cros_ec_suspend() just in case if someone changes the wakeup capability per
[2].

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220209045035.380615-4-tzungbi@google.com/#24739778
[2]: https://patchwork.kernel.org/project/chrome-platform/patch/20220209045035.380615-4-tzungbi@google.com/#24740205

Will change it back in the next version, pardon me.

> > @@ -383,10 +384,9 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
> >                 dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
> >                         ret);
> >
> > -       if (ec_dev->wake_enabled) {
> > +       if (ec_dev->wake_enabled)
> >                 disable_irq_wake(ec_dev->irq);
> > -               ec_dev->wake_enabled = 0;
> > -       }
> > +
> 
> Better to leave it as is, and ensure "wake_enabled" is cleared after resume?
> Will result in a smaller diff.

No, cros_ec_suspend() uses the flag to tell cros_ec_resume(): don't forget to
call disable_irq_wake().  It shouldn't be reset after used by
cros_ec_resume().
