Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90155571677
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiGLKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiGLKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:02:41 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C3AB69A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:02:16 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c89111f23so75919627b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vZMV8oO8pCweKFytCi1iyECBfJ/cRqo4N+xWIgMCDg=;
        b=hlrceuddbxzhswflQp//3s+I0oedn19qUOus6S6+DajiBapdEKXfWCc0/B/7yXYSgY
         H3chfuWXi6d0wp2fBskXlohHwpBjlgwOr8N9bqlyrgNMss8c8BQvaO8lF2EdHvcjEmby
         +Zg9Ue9ufVjye1/Hlk3S/6u8avsCFZWQlEuDmpV4Fc7yAGyQF/6K5Fx/3RR1qixl+gu4
         GtRn7C2uq/lFklL55SMy3FLPQWKlKctPS+OY7FDCernW8MhECQXIOy1iDGdeeqjrInV7
         trPURKzs3TCV3dI3KY4Zidcm8jWMsuO78gpCPd6Kojarja28uYOxU5ozdBzW8RiYJKFC
         muTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vZMV8oO8pCweKFytCi1iyECBfJ/cRqo4N+xWIgMCDg=;
        b=5vCP2qnQ0qzoHzimtttFJsKMgHeEH63cwgowVfqhZOrQ4YsbkYz0DbpYRzQhI7YjNS
         hKtU+k7bwQx2hajB4BHkr0Jh6RJe2uqCLMQsazUk2vaII+D8d0hFmeJXz6Op9WV7jFcu
         zo7N+0lxUJT/X6Iut6Mba2glRyMLS3HzV0v088/9Fj56J6o30n/G1jOMbKM1jjoAWxbV
         a5lyl3gaXwzlIIoptbCZ5PCpU3CE+DdFFDuNBUyoGl8epMiePqXyDBnHd1yYPj9o5WG2
         CfEaQYddIzkklke+NVoOpmn9dr70XkE4TIJEpbH5/ZHHQaest0sCYMsJdDv9t0awu9Nh
         UUhw==
X-Gm-Message-State: AJIora/Hk5n32LsFj4MNzk8BKUqe+hnQO1tYNq8MBpI6hSm9ufGsXfPY
        +KzHRTUwoKfNff7+tYyKTkEgFWr+qUuqicGiBqE678BRFdIDcg==
X-Google-Smtp-Source: AGRyM1tX9LHWdFnOx6PnMAodo72U2Y4oB407lI+eIJm82vFHZ6VJuGwFZ2w4XCkG/HigS+UJenZjYCGxr3cgr7QqwpA=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr23759980ywq.18.1657620136053; Tue, 12
 Jul 2022 03:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220711095219.36915-1-andriy.shevchenko@linux.intel.com> <87ilo2r8np.wl-tiwai@suse.de>
In-Reply-To: <87ilo2r8np.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 12:01:39 +0200
Message-ID: <CAHp75VfjsJG0+Tgzb=QowNcS3yTEZNs0vd_LAq7P9rNxtHVAfA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ALSA: hda: cs35l41: Improve dev_err_probe() messaging
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
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

On Tue, Jul 12, 2022 at 11:35 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 11 Jul 2022 11:52:16 +0200,
> Andy Shevchenko wrote:
> >
> > Drop duplicate print of returned value in the messages and use pattern
> > return dev_err_probe(...) where it's possible.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Applied this one, but postpone the rest three patches, as there seems
> a build regression according 0day bot.

Thanks and sorry for that, something (mis)happens, I'll test it
carefully for v2.

-- 
With Best Regards,
Andy Shevchenko
