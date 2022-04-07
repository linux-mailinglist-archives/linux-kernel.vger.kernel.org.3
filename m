Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D44F8767
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbiDGSyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiDGSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:54:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10198179429
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:52:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l7so7354960ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/s/dz2/6Hbj/5UtThLNXvWjhjgt6+Hm9DR6vV4CONg=;
        b=rO+QJDYo4qa4mxnut16LDPVa7HWgESnE+x4Rqbq2g2UOsuWrmh31lhxhnpzvoYWWQl
         FrSRWhasf8ZEQY3BNvb7+gh9l99lHrP0TjtzN9a6OE/xjRjG3aclJucJoqYsxSN/3CZu
         AyadrhhfR80zu9y8aAK+sQIQKKd9JIXiTi6UKOjOTYEGyOoG8266IgDy1Zt3n3QbN9L0
         pXR1w3Rq5Gu37DTo/VV5IoFiByzk5f9aWGlV86CNogTN14OJukPMiz+c95aKdP+bm1jk
         QNcvnou1kZZKWBnagB6iFK/D/WJNavHNOdBJIgcLfgUi+6FjrI0Aymlezlc5NfkMNYQZ
         +YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/s/dz2/6Hbj/5UtThLNXvWjhjgt6+Hm9DR6vV4CONg=;
        b=aov+g1uN4t5iR+Va/UqppIx9/P0iIlXt3DC1ccG4vDmgBE9XYqpYEE7ydDBjno5IZI
         6ssEtgeYgk9lIyeXL28kbO/8i/R277lpAE754P0Bd25dWMRkzA7AlS6DStYzQN7qX6s4
         xFl9+ZbmaPuYeBp98R9n+k201QQRL6RBDX1ykWrTXUWulYIvIm3e2c623kEvhyVBpu6D
         rXjAs3qtwWL+wlJtljYLfjcMeWZnl/OyHz94ZGx2fRmPTmAyOMRaCkllX5xS+kpt5DVL
         ZESPOQlZ4xzRaOPf3tGS3IYmOYQMSnK9cplXoZs4SnqnrLn5T7W9IJsR7JSyeaEfdMf4
         IhCw==
X-Gm-Message-State: AOAM532kWfdhchsT62uKkUJumdUUw3XgT4LWEzMpTP/3vabX+0AbxJyM
        Z3ZGVouRPxHzW1weOf4QRVN/Co1wk7NHJPnc37/f1w==
X-Google-Smtp-Source: ABdhPJzgbJVlisvjBS51N0wr4zk/Q8qQ6PPM7JBdbT91ANkpCzM4cQaeLhz3HQmcJQPf/oGBXpcz3UAJWrZc4DTBU6A=
X-Received: by 2002:a17:906:300f:b0:6e0:b38d:777d with SMTP id
 15-20020a170906300f00b006e0b38d777dmr14920373ejz.189.1649357529432; Thu, 07
 Apr 2022 11:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <Yk4DGZfpYbK8dofL@chromium.org> <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
 <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com> <CABXOdTet5ynSXf94qMimobJF4LLzHc89cVbwJ5NuAz8G6jmVdQ@mail.gmail.com>
 <0fdba110-8743-3b2d-cb30-3a89b7cfa592@gmail.com> <Yk8atphiUdlU0gPO@google.com>
In-Reply-To: <Yk8atphiUdlU0gPO@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 7 Apr 2022 11:51:58 -0700
Message-ID: <CABXOdTeAN201fA5FMT1jhOmooNHmvkZPdjnwMM=5j-btovF+3Q@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
To:     Benson Leung <bleung@google.com>
Cc:     Akihiko Odaki <akihiko.odaki@gmail.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
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

On Thu, Apr 7, 2022 at 10:09 AM Benson Leung <bleung@google.com> wrote:
>
> Hi Akihiko,
>
> On Fri, Apr 08, 2022 at 02:03:52AM +0900, Akihiko Odaki wrote:
> > If I read the code correctly, the registration itself happens synchronously
> > and platform_device_register_data() always returns a non-NULL value unless
> > it returns -ENOMEM. The driver, however, can be asynchronously bound and
> > dev_get_drvdata(&typec->ec->ec->dev) can return NULL as the consequence. It
> > would have a call trace like the following when scheduling asynchronous
> > driver binding:
> > platform_device_register_data()
> > platform_device_register_resndata()
> > platform_device_register_full()
> > -  This always creates and returns platform_device.
> > platform_device_add()
> > - This adds the created platform_device.
> > device_add()
> > bus_probe_device()
> > device_initial_probe()
> > __device_attach()
> > - This schedules asynchronous probing.
> >
> > typec->ec->ec should be pointing to the correct platform_device as the
> > patched driver works without Oops on my computer. It is not NULL at least.
>
> Can you provide more information about your test computer in this case?
>
> Is it a Chromebook running stock firmware (if so, please let us know which
> model, and which firmware version it is running).
> In the past, we've also gotten some reports from people running MrChromebox
> custom firmware on older Chromebooks which have exposed other bugs in
> this driver.
>

I think we should be able to reproduce the problem by configuring
CONFIG_CROS_EC_CHARDEV=m on any Chromebook supporting Type C.

Guenter

> Let us know if that's the case here, and where we can get that firmware.
>
> Thanks,
> Benson
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
