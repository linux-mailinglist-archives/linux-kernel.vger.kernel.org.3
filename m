Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF37057A8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiGSV2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiGSV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:28:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90824944
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:28:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m16so21344769edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgjyXYkBaNtEE8jtItSOwzOwdDtGTESi0Gq19caSxl8=;
        b=L0WbTsJOIt15Fy68WqNomCkAE1dCDGk+Wl2/jzpgamWz43DkfxaXTQaO31m8QWJXkB
         8aVagbfz2rEGZAN/TrrA+QGh4lHZL+r4LrLBXtaQCfc2MD6mBArwYXgkKdCpCDfEklWx
         xhkA2sSIp0V8N3mhSDmzmWBYWc6I7ZcIZzAN2ggitahiV+xrIC20Rgxo2z5QqxMLTm3x
         mNkLHVAGByMH9Ot1P9ku83zu+TZg4lpHAONYNMt34TjYAmIaBFM9n0Ss1TV1K3nUuOLr
         ahJjUrz96Jnq/K+QvXmyFyphx6Z+2gWY/BerZ6kjAfaW5jQY0304Gsx/VZ0rC7YgldzH
         qvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgjyXYkBaNtEE8jtItSOwzOwdDtGTESi0Gq19caSxl8=;
        b=8MhpotVMZWaUB0ZMbXUqWV8W51C0FU0hEeVHgT7luxkJ89kACJbWxjdXzne1gv30XR
         K0LLhxk70xJ/zKHbboMtyRr2S3AoT68RJEQTZqTem0MLmkbjXBnFQLUMK6uSX4890eAG
         oAEWISFsOUhs7nSiWh8WtP5VNhoJWAE1zp7khnhCcqO6glqjeQyDIrZwubtmeI/MfMbb
         iAGYvydt+0oMDvOBKEZcozrgE+DNdXt450zoQ3jjmvAiiU3vHtQZGru7OOZ2lo70e1a9
         svxJW3Dcm6/e3ocUG1/GCtv6gXd1XGTGyG08AlpElLL6FByJGRB4HgRQs6PKIL3nfR/h
         W9VA==
X-Gm-Message-State: AJIora+XAyEQt+A24FBZOUOMHuU/I2ozqebvBB4oIfG2qb8AGIY/y48C
        hbqmITJglIv5u6x3ZGa30LltmUW8BlfUAlo631PVmA==
X-Google-Smtp-Source: AGRyM1umRAdSu38xVh0FNmoBhcbLpGnNzTvsXg6DMRfDKwCSMr+rPYTpWKkq4+ed5YerguJa26pzNMxc7uySoCAw/hY=
X-Received: by 2002:a05:6402:4252:b0:43a:9232:dafc with SMTP id
 g18-20020a056402425200b0043a9232dafcmr45670055edb.243.1658266081132; Tue, 19
 Jul 2022 14:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220718050914.2267370-1-tzungbi@kernel.org> <20220718050914.2267370-2-tzungbi@kernel.org>
 <CABXOdTfYAGapjkPxRC4SbKMKEwCWmrF46aEDFWvsMBqaTuCzPA@mail.gmail.com> <YtYsXvi9WfdLFCiu@google.com>
In-Reply-To: <YtYsXvi9WfdLFCiu@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 19 Jul 2022 14:27:49 -0700
Message-ID: <CABXOdTf3zGf+pKFPeCXLeAX2t01Euf9enUUSuHq___Y+WFcWUA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] platform/chrome: cros_kunit_util: add default
 value for `msg->result`
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 9:00 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Jul 18, 2022 at 06:35:42AM -0700, Guenter Roeck wrote:
> > On Sun, Jul 17, 2022 at 10:10 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > > +int cros_kunit_ec_xfer_mock_default_result;
> > > +EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_result);
> >
> > Is this needed as a global variable and, if so, does it really have to
> > be exported ?
> >
> > >  int cros_kunit_ec_xfer_mock_default_ret;
> > >  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
> >
> > Same here, really, only I didn't notice before.
>
> Global variables: I'm afraid yes.  They should be accessible to test cases
> (e.g. drivers/platform/chrome/cros_ec_proto_test.c).
>

Hmm, I don't see where that is used. Either case, even if the
variables are supposed to be used from cros_ec_proto_test.o, I don't
see why cros_ec_proto_test.o and cros_kunit_util.o need to be separate
modules. Can you combine them into a single module ? That would avoid
the exports.

Thanks,
Guenter

> Exported: I'm not sure if I fixed it in a proper way.  They were added for
> fixing https://lkml.org/lkml/2022/6/2/452.  When CONFIG_CROS_KUNIT=m and
> CONFIG_CROS_EC_PROTO_KUNIT_TEST=m, cros_ec_proto_test.c still needs to access
> them (in cros_kunit_util.c).
