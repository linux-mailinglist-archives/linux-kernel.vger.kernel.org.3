Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C95A8B62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiIACVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiIACVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:21:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F5161DE3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:21:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b2so12256485qkh.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zFsBSw/BigrLjjgilq/OTnhc9hR2qJ9pTdpXA8ZsABU=;
        b=O5VcbNULS1FWVhLWl5Plv7rpOUqA+/y3850sIEQGcouANWq2a3JkLShMZl6Kir9blO
         wUkOYgIjaxR/D/OEh0yy5rbrZc4xbYioxv5Fd6Fsl1c0ybaQwjEeZb89HwTR2hBqgZsP
         NonVE7Fgqe7MFYaSGLhOenPb3b79qJaanEGMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zFsBSw/BigrLjjgilq/OTnhc9hR2qJ9pTdpXA8ZsABU=;
        b=52lbebn2yqGETH58Sgljk1agpkDgt7AY74pTf3klMe48CwjWpxKaRLrMNOCp5BmoSm
         cQEMwLPQHXmj4biaNhdc+d2K9QIPqV7UDM/CDQ9hMUKRhA4WT8qnUGML8e9pWUp0hHus
         9WChM75BAuKk9dqhDiNR5LjalkvIan0Gatpv/HtZwLn9e4hRbkPvB5WFQPIwbB/4sp/w
         sKg3l9z7nyfCy9Wt7U4Xzmlrgf1BbjU5cTozBKVZ7n1Mvh/yjuUkkgiT9alZ6ntj3CX9
         L8Zrr67P62xJEwa2e838n8JTUHV1pLwcer3KHfxVz/MZXtu5kZMmdLOSyfE5c+jsg2GE
         YZuQ==
X-Gm-Message-State: ACgBeo1iI55SUxrlzZFg2L5sxkxj0coGH6hSCL6yDW9b1MMnTsaKMiAi
        NROGuFipHjWVsiMOCrkkByowHA59vzLZeg==
X-Google-Smtp-Source: AA6agR6dP4GcxlSakJ8l2e1cy8+c54cJdC+xmDth7he+YcUdUPVcQ954bXQpWrJ5LsHvOSvKotkLtQ==
X-Received: by 2002:a05:620a:1a03:b0:6bb:8e3e:8a1a with SMTP id bk3-20020a05620a1a0300b006bb8e3e8a1amr17380854qkb.296.1661998897048;
        Wed, 31 Aug 2022 19:21:37 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006bb41ac3b6bsm11013517qkb.113.2022.08.31.19.21.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 19:21:35 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id y17so5326127qvr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:21:34 -0700 (PDT)
X-Received: by 2002:a05:6214:1d06:b0:499:7c2:a84a with SMTP id
 e6-20020a0562141d0600b0049907c2a84amr13567009qvd.65.1661998894284; Wed, 31
 Aug 2022 19:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
 <CANkg5ezTvzSFLkRWbhMDUqezQXW6996DYVohWMUa+cYwSB+YBw@mail.gmail.com> <YxAQaxQXn2YTN1BJ@google.com>
In-Reply-To: <YxAQaxQXn2YTN1BJ@google.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 31 Aug 2022 20:21:23 -0600
X-Gmail-Original-Message-ID: <CAHQZ30C4-B9ypnsdRqEZCJuZ7QVfaHXaK9f61vTtz_gcvC9EQQ@mail.gmail.com>
Message-ID: <CAHQZ30C4-B9ypnsdRqEZCJuZ7QVfaHXaK9f61vTtz_gcvC9EQQ@mail.gmail.com>
Subject: Re: [PATCH v7] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Tim Van Patten <timvp@google.com>,
        Rob Barnes <robbarnes@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 7:52 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 12:00:55PM -0600, Tim Van Patten wrote:
> > Hi,
> >
> > Friendly ping on this patch.
>
> We don't top-post on Linux kernel mailing lists.
>
> > On Tue, Aug 23, 2022 at 9:59 AM Tim Van Patten <timvp@google.com> wrote:
> > >
> > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> > > .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> > > host command that the AP sends and allows the EC to log entry/exit of
> > > AP's suspend/resume more accurately.
> > >
> > > Signed-off-by: Tim Van Patten <timvp@google.com>
> > > ---
> > >
> > > Changes in v7:
> > > - Rename "host event" to "host command" in title/description.
> > >
> > > Changes in v6:
> > > - Fully restore fixes from v3.
> > >
> > > Changes in v5:
> > > - Restore fixes from v3.
> > >
> > > Changes in v4:
> > > - Update title and description.
> > >
> > > Changes in v3:
> > > - Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
> > > - Update cros_ec_lpc_resume() to cros_ec_lpc_complete()
> > >
> > > Changes in v2:
> > > - Include cros_ec_resume() return value in dev_info() output.
> > > - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
>

> I don't buy-in the ideas from the discussion in v3[1].  Thus, I would defer
> to other reviewers/maintainers on the list to seek their suggestions.
>
> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid/

Just to clarify, you are opposed to printing the return code because
`cros_ec_resume` currently always returns 0? Or is there another
objection?
