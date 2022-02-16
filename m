Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4734B85EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiBPKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:36:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBPKgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:36:18 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFEA2B9A3A;
        Wed, 16 Feb 2022 02:36:05 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s1so1597257iob.9;
        Wed, 16 Feb 2022 02:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKJipsq5oe0ZDTEuY+K/upzTvFd2Dsp+kTmSfYWHazI=;
        b=oB2OvesgzInGIl9/ipqAc83wTh84bdMDXTbti2s/RMWD7Yiaav3MxOilkBjJyROqOq
         m1OXPDMSixt3+1Jo6RQAUc/mH65M416o76Q4aXyVCFbv7To0jcn13xt3mJhlfJFZJRwI
         lDyFz7n43fLsrfaTC34ZTkFyYvTzXMrn12U/+L/cLU/9dB3dnjA5r07osvpbBlzMhnxK
         rY4OgFkI0SV2BvPvLg/o2jXh0k9Y5Tly6svLF5rqLvPTNab6Ob1uM3fDLgo7/+500nIS
         kZskH1LCBfqsXH8TFSGzlx0+mKy5rnE3fjExDVJOJgT7om7RMOjBGeUNrdtvVWNpBbAj
         kVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKJipsq5oe0ZDTEuY+K/upzTvFd2Dsp+kTmSfYWHazI=;
        b=oQUoKoOZpl1LVGKcT6zWEbdAazCL7nnOvpdNSheK4cNSaTRJkUzrsJKqadeACZHAia
         kwLWqGqCIOxefjfRI7EEF1Q4q+ubnV5Fx/0uoVDxfAiKgBOaarrEq9i6mTtRoxHzjAdi
         DE0LA9k7MDZCS75ZhVewBOjyh9EgDRuH0UrzGkwzYT95LnpvTq+2vjR1IXutFDj08g2p
         5HZQMlOT9XtPuzcxdmfZS5QGtcxe0sM4QqS9DCGaqbV3mHsNnQOBSpJFb/bSvchb7ZFf
         b/uGha0Aaws+kxnpe+/WbEu0eD4Tgoo4TqWynZXt5lcRtBT3hWZr3ZSxZOyUtDBwIkph
         3EXw==
X-Gm-Message-State: AOAM530qu1kvWlDZz4EGC9Ad2tagO323HXY+DA4LRKb6FFuZjOz7Jcxw
        VaS7KAw4Ss1MCk+PZAxrMO04uMg5XvKO+99QlT8=
X-Google-Smtp-Source: ABdhPJy+nlIuQg/qsfdwCrU+DfJGfoNKRMgf768wo5rWiOwJvwmOAigC+H4fhh7OneJ0TUqJSwNX93shHmq0ywG7gNI=
X-Received: by 2002:a05:6638:1117:b0:30d:1e9f:26ca with SMTP id
 n23-20020a056638111700b0030d1e9f26camr1300117jal.256.1645007764490; Wed, 16
 Feb 2022 02:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 16 Feb 2022 11:35:53 +0100
Message-ID: <CANiq72njcv_MYfTYycMqarEgN0ujKOSvT6OfQxW-kN6FDb5MRw@mail.gmail.com>
Subject: Re: [PATCH] printk: make suppress_panic_printk static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
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

On Wed, Feb 16, 2022 at 4:20 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> This symbol is not used outside of printk.c, so marks it static.
>
> Fix the following sparse warning:
>
> kernel/printk/printk.c:100:19: warning: symbol 'suppress_panic_printk'
> was not declared. Should it be static?
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

It could be good to mention this is based on -next.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
