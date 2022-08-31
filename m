Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B754C5A7D93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiHaMiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiHaMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:38:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334EDC59D7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:38:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id og21so28091325ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Nw0EBkOY83iYP+XsN3p7xZie4SqaMCFMbmxIx0k38js=;
        b=EbrxVY5nmWOEeuFzz8xCaJqiVAvdtpUvBA09CA8hlz6jVkKBBrR/cUoroforFFsHgH
         8CTqzGo6sJLLleJ3EjHWNW7S4C9EqAo1GspjvLhY8kAI7KH6NE3SU88Zhg/0YBD8/cIM
         CAreXFBsW7QgLcRnUd4MXZc8zjptdubpZ4HnrliE5Rob4mZOYDfsHDF8unLHjql30KkR
         x1aayH3bv59OYuOO3e+EpxZrQipMhrTsMThjsrzdpqBp75vSrWDvv0YbeHIaw0asdmh0
         /tX2jReNXg/+GLMwAV1WwNtcn/7lUzkMmHljQ2GeLcZYUN1CC3evGFqk0UiehrPdd0xO
         kVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nw0EBkOY83iYP+XsN3p7xZie4SqaMCFMbmxIx0k38js=;
        b=DorGOWu2JxHvEB0jlqrCq7VwqLg6VntySkGerEMK8ptjm/Pya1vfVKW9Gn6lhbgXaZ
         J+QhHvuOZlu4BEgFWVs4+G3AJKSRAKOzDvjNEFyjdFtWw+++VX5lJRXVWdMj5DyYks3S
         TALw0eFEiZVvWw+UP0b9wpAlVf5mS2lXzgr9rLYnvl6ptk+BuAA6VG0zLT5eLmzeZ93A
         E9hu2791ZAgXbzAPjxen7txx2ydtYt4QGH/z7Zg0R+skHkPkYOI53c+P3DhOqTOhqIJI
         dglGOaRFpkAPvORFBD5ZUA+LLYaA628kw8SJmelp6AFwOHEReCrFuxcZzg66u092jYmP
         uhrQ==
X-Gm-Message-State: ACgBeo3it0/ChKsOHYIOe0rni+STbTZSKhQEVNKT46yTQ85M0tTjpssp
        6/FfffgdR0T27MGBUa9BTjLlnSeUO1xwfPX62pB6Mg==
X-Google-Smtp-Source: AA6agR6oyyPbMlYFtb5NpTtsjpRebaLkWf/bYtJDx2BFFBYm0+SoT8VLAlPWsAw1NQyFyIQ8k9S6mB877Ji41iDBZww=
X-Received: by 2002:a17:906:9bf3:b0:741:6900:61a5 with SMTP id
 de51-20020a1709069bf300b00741690061a5mr11441223ejc.286.1661949497747; Wed, 31
 Aug 2022 05:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220824010605.14256-1-jeffy.chen@rock-chips.com>
In-Reply-To: <20220824010605.14256-1-jeffy.chen@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 14:38:07 +0200
Message-ID: <CAMRc=MdOdeqkRKMdyX2H3QYTeHkL4mrzWD6=tuo=cH46xxKGFw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio/rockchip: Convert to generic_handle_domain_irq()
To:     Jeffy Chen <jeffy.chen@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 3:13 AM Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>
> Follow commit dbd1c54fc820 ("gpio: Bulk conversion to
> generic_handle_domain_irq()").
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---

Applied, thanks!

Bart
