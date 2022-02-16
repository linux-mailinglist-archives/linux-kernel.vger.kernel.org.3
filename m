Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78D4B8BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiBPOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:55:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiBPOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:55:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C761F6B8E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:55:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f17so4390322edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuYrqVGn1TXdwN+P98XHhqL2+XquzgdKMr559j4kzX0=;
        b=m7KLBnpGSaAT+kElQbyWCpRqg8l5Xarj7SE9j9Q+Gl2zvdSTaYahgURCT8X5H2Ni2L
         vKgECZZX8XD2Y+QnZUn27ISb3qicevOkHpXjolTw4zvDUEZ72k1XrDUvmMrxR54sLgeY
         n13R9STJnkboF2nq0JYVV0CkTfuV7LwJVNvxNS5xWP5B6cH2rixzqtQf2Cdo2K3XlnwY
         Y3/XG4x8s2oNS9/DZTMyIJntOp4KAtdJtIzNeA4e5c8HhqkwQdzAK+3eH3jMcrW9BiHV
         j3lDpWbx9LLmAtuLKrS+VdGFzIfr2OJ8Hil2kSdMkWrSio4XnljeNfior5cdXBv/M9nm
         55Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuYrqVGn1TXdwN+P98XHhqL2+XquzgdKMr559j4kzX0=;
        b=VXLP6g8245iT3EoSJ93PGGwZB/yV6shU/Q/AcXnE6QtXbtFz/5UBk8vpDWqrLB48vN
         wjPDgE6JoKkoY0AfOzVWTZy7G5ej8dg1rrHHoWPhJhA5NmmUkQ/XaJqPZxuvylMRAVWL
         Ml7W0SB7LTdHu9wd9Apt9k5bjYuvHstxZyRFU8IAcSJn5yKPatRssE5Nn3SjJGx0ZMON
         iWn02W/+nqgxclLYOcuD5Qygeq/iEEySyDId32YUkFG3GYq245VrFU19nETN6MqjBWBo
         Or9Rs439ulAc+SH7JBE9e4sA95FzwoWGmBSDlqKQYgDoAXIgroC/sFJmPKP4pD+LEvLI
         1blA==
X-Gm-Message-State: AOAM531CWJ7LFqp4QRf+f0rKJpNKxn4tLqGyCFUelxBjxJDYJsq0C5Uu
        zf8JMo+EnBgcEbytb+k9DpEBBNgBosfqS3AJgMt/gg==
X-Google-Smtp-Source: ABdhPJzRulNtz/zoAWp3FH3AaM0DWDfR2fpgNtKv4EW2Sx9/HjO3bwTxfgHobgEyuXG7kSkT/MQf3yK3aZjoHeh44u4=
X-Received: by 2002:a05:6402:5194:b0:409:97ec:3bdc with SMTP id
 q20-20020a056402519400b0040997ec3bdcmr3466054edd.314.1645023340859; Wed, 16
 Feb 2022 06:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20220212205048.43862-1-samuel@sholland.org>
In-Reply-To: <20220212205048.43862-1-samuel@sholland.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Feb 2022 15:55:30 +0100
Message-ID: <CAMRc=Me8cmiJSu3dKDgzhKZchSYyC0KmnrLSDL0ckr_uASLv-g@mail.gmail.com>
Subject: Re: [PATCH] gpio: rockchip: Reset int_bothedge when changing trigger
To:     Samuel Holland <samuel@sholland.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guillaume Savaton <guillaume@baierouge.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 9:50 PM Samuel Holland <samuel@sholland.org> wrote:
>
> With v2 hardware, an IRQ can be configured to trigger on both edges via
> a bit in the int_bothedge register. Currently, the driver sets this bit
> when changing the trigger type to IRQ_TYPE_EDGE_BOTH, but fails to reset
> this bit if the trigger type is later changed to something else. This
> causes spurious IRQs, and when using gpio-keys with wakeup-event-action
> set to EV_ACT_(DE)ASSERTED, those IRQs translate into spurious wakeups.
>
> Fixes: 3bcbd1a85b68 ("gpio/rockchip: support next version gpio controller")
> Reported-by: Guillaume Savaton <guillaume@baierouge.fr>
> Tested-by: Guillaume Savaton <guillaume@baierouge.fr>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Queued for fixes, thanks!

Bart
