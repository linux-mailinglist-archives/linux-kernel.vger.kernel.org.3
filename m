Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9BD4FAAD2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiDIUmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiDIUl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:41:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E256228
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:39:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n6so23504484ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rj6n+xEBXXPl5+jHyLqq4olpc++X7yvL2JIU4TtB+nY=;
        b=WGlSXBkiCGwBRi6oaQQk96LJaoisI66TOj4CjjqBzpVNtscsSTO6WppODq5eMAwad0
         66qvCigJ/DmAEU9EMGTxgszKDdLNhqbZ20Vq24FKZXWdBQ73jN2DQjttysi9IVFFCIxD
         r5E4lnNpmirBbLb6U4UlN7gZ5OKTUUe/4OzBJ5/NFbjnP3WRTTzSZbII010pShsOPjSh
         2sxPkIwY0/DjCz8bY2ElZLTa/EMFXPr/nKKr+snpNBqiE7kJspRCxDkuYqIhTLRBAG7R
         fc85v0kpZrYGdXMdNEods4LE9MWfGrR8RhIxYJday2V/BblHVwZ9okBLD+l4y+6HItzb
         g7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj6n+xEBXXPl5+jHyLqq4olpc++X7yvL2JIU4TtB+nY=;
        b=2n+zzLhnuR/s/X5JN8lSTmqQKaNe9G1q4+J9m4fkF2g3aJd9v9iqLw7Vda0EzSmB47
         TVxjylorQ4ffN5LfqbePKL7J/Q7UCmFQOHLOytrKONWmDLXVpfaJ57xyxs3DMOEBfhKi
         IrbfwBh4MUMPmzF8I5rPRE0K9YQ3KTp+R0tS3WWyhpYgrSLvo21ogkw5z5Jlq0Xc7NF7
         drilaNLQV8tENl7uYfK8ptcmI/b99euxT09ft/PFSFW5Dj0a7bS651htu7P5Z4hsVGoX
         Cc0SvVsismd/Bgy3kqZ0VfRiHox4rRJKdmKX0qiHPDCW46Grshvp5fRJgf3Zu4zmgKqv
         xtMQ==
X-Gm-Message-State: AOAM532A+GxCAWDOaNcD2inqFfQQ6SsVjsVCStbDBYnfK1Kd7jpZtsJY
        +acSZI2TRso0zcp9Pl3xgbX9dWzdBpArsum8Cu2SDw==
X-Google-Smtp-Source: ABdhPJzOTqsPsxztXtBKlpkCDcCm/R+awcp/VH6kw13YLxyZDQ/VhgVfkvsP4n2fs823IPxIWHS4fkQIOe6C5aKYkSw=
X-Received: by 2002:a17:906:5d05:b0:6e8:40cc:1a99 with SMTP id
 g5-20020a1709065d0500b006e840cc1a99mr12126682ejt.734.1649536786243; Sat, 09
 Apr 2022 13:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 9 Apr 2022 22:39:35 +0200
Message-ID: <CAMRc=Mek7kGFHh3Rgp=KY6Tu+giiAFXgBqaW2zBJv7vYw7CSfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpiolib: Embed iterator variable into for_each_gpio_desc_with_flag()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 8:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The iterator loop is used exclusively to get a descriptor, which in its
> turn is what is being used by the caller. Embed the iterator variable
> into the loop in the for_each_gpio_desc_with_flag() macro helper.
>
> Suggested-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, this entire series, thanks!

Bart
