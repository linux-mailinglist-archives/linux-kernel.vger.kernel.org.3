Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFA577E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiGRJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiGRJJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:09:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FEB56
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:09:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so20049631ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mdf5q/qVt50lKlbFg9riuF5UqJk6aS++kMHubLi94hU=;
        b=MyxoSBCz0+4WmzKije06wMMGwlLZnAyOl7DaKvuVIq+B8RQDKReiWmBYgLWrS/REsl
         r9JB5KFrkHjbbD5Y9e0fKF0myB7/l7z0daobfSOEjZkRqILEa4cJj4vH8ILfqblaZHzh
         IK7u3wmNUUziPzBJ/15x85nDjmwc7fqqKdXhL7WqVncz9FyWfrfrmzrMEOJhoZ+CLNWR
         aJOTamW5Ch1XOP3R6aa9FafC7UN7Mvl7sFRvB/fzmxtYAQ1xRfGvokf0+dPOGTIuPbUB
         f4grt/7hizM1GYX6XUscwQaKRqKBXQDaBKq0CFN3UrlZpC8dFhpWViORoUkC88Osv5Hc
         T8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mdf5q/qVt50lKlbFg9riuF5UqJk6aS++kMHubLi94hU=;
        b=n1YjlRyHZn/xpdJ0a9dIuksThvEpYJK4AcKnD0R6xPINPC6AyGEX5+XyepnxxMfNYS
         sYXDAtMXtR3bTmNFjexKORlezLTgT1lgJQc41IHC0ANFD2CPbN65GmsI6CdYJkpn7a65
         lVBek9klPILDqQr8lYa6IyrOaIqbRrN9BU2NOs0RiRTh1Uyu4Q7vLIr/678LRuaehtrf
         nlIutxkNXOKvOoMSh5LTM5E6Q5Oe13hEOX2jy9NsPJ6DUzYlA8+p21uT6qeE3EivNrii
         iB39jgsESY4xbSgMOMeEdAFh9hknp/23MvLG5YY2cNTUo2+Pc4Ba3yhClM4M0kv1JNZW
         VLXw==
X-Gm-Message-State: AJIora8/pDPmmRBC7UWe2cjyhlQbot47o4g8UD7AN4czm5I2OKqt75nG
        Wz0HkXEKCSmmAq+RD+yZa9Jt6RHATVD0ZWUm81dS1g==
X-Google-Smtp-Source: AGRyM1uJqUvLGFX0HYNi7EiX1iff2QTsdFUBsk5ZFgYQlM7pHNjwdtj5TFwxgatScxITOJKZKA/rEeMAD3KXPgHUpfc=
X-Received: by 2002:a17:907:1ddd:b0:72b:49ff:d39e with SMTP id
 og29-20020a1709071ddd00b0072b49ffd39emr25082012ejc.500.1658135379803; Mon, 18
 Jul 2022 02:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-5-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-5-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:09:18 +0200
Message-ID: <CACRpkdaF4UXuiH_4StWZLwhrC8H7Le9rbnRtHYaRLrJ+fQT2_g@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: stacktrace: Make stack walk callback consistent
 with generic code
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:19 AM Li Huafei <lihuafei1@huawei.com> wrote:

> In order to use generic arch_stack_walk() code, make stack walk callback
> consistent with it.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
