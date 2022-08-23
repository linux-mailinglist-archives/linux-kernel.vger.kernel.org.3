Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBD59ECBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiHWTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiHWTqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE09659E4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id g8so9709792plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=/6MgYQynlKjVO5yQ/ZXe7vd/aFxPZ1CaapAzvUa4a4g=;
        b=ikM7qhdIpjbLzfr7suns0qY6EZit4upFDcclekoxK6tByYgIRc1jLEEPVb6RPqT83i
         WoY7jYIligukD49jBrzQfVu2P37v2fwqfdnI/N4YOU0eaHNqobPJp/FngkZXXxZ0w/Ui
         ScXFhPgIIHD/ZyfVsUanwCt3unLFIIDB8UGSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=/6MgYQynlKjVO5yQ/ZXe7vd/aFxPZ1CaapAzvUa4a4g=;
        b=qznFZLPSqEmKpiFeYpsum/byQ7W1R23IDHFYVgpHdPfNKAAq9KNbn5NnCho/19iJVF
         BNTWMuONj1C6nr7qpCdhiPM6/64pBgdRD5NcZajc0ZEkwFrV57lL/pYn0sBn+aJ+5XA3
         btObKD0c4rJhZo5pm/UbEjNjnNJjJAwh6jPzk+y37xbFVNpd3td+8V4wRU4V8Rb33aLp
         PBISjmJwkcQHfJvhz8c9COm1gcLYjPIBPVB2ofZidzxfM7e6AHerlA8LkumHNMK/HtBd
         QWi5gfMxe7A7IyfA4LkLC3+xzEnHjvSd2yMsoEV+g/ylOkeYdbKXJlSZKLKCvclHw/0e
         CpbQ==
X-Gm-Message-State: ACgBeo2lq6l/WAyb+k0Fk2gh4TwzLj89yEj4S4au25RmB1CmMbylURLq
        dfuT1xryNy/laQpw8M3YVAouBA==
X-Google-Smtp-Source: AA6agR4PhBa4xTP/Cmb3RzX7gXe2wQgYBokWSWZsPSyAv0+QXeCgAXxsHtiwuqEXuxSK4dvlVmwU/g==
X-Received: by 2002:a17:90b:3b4f:b0:1fb:5b03:6822 with SMTP id ot15-20020a17090b3b4f00b001fb5b036822mr4539924pjb.87.1661280636070;
        Tue, 23 Aug 2022 11:50:36 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:34e2:c40e:42d3:27e0])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b0016e8178aa9csm10928202plh.210.2022.08.23.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:50:35 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:50:32 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Chen Jeffy <jeffy.chen@rock-chips.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] gpio/rockchip: Toggle edge trigger mode after acking
Message-ID: <YwUheATnV+Iuhnl5@google.com>
References: <20220820095933.20234-1-jeffy.chen@rock-chips.com>
 <20220820095933.20234-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X0qJ2OC1SrAmhSQ5YeKEwvsSCbfVGPh457YYEuPCbRtg@mail.gmail.com>
 <5cb0a457-b667-76e5-d383-6e93457d5d12@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cb0a457-b667-76e5-d383-6e93457d5d12@rock-chips.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 10:50:16AM +0800, Jeffy Chen wrote:
> On 8/23 星期二 1:08, Doug Anderson wrote:
> > I'm happy to let others say for sure, but from my point of view I'm
> > not convinced. It feels like with your new code you could lose edges.

I won't claim to know for sure either, but I'm trying to follow along,
because we've dealt with various sorts of nasty logical errors in the
gpio and/or irqchip areas here :)

> > ...in other words an edge happened _after_ the IRQ handler ran but we
> > didn't call the IRQ handler again. I don't think this is right.

I believe Doug has identified one problem correctly -- that we can't
handle the both-edge toggling entirely after the ack+dispatch.

(out-of-order quote:)
> So if an edge come in between, that new IRQ status would be acked(cleared)
> in the following GPIO irq handler as well as the old one, without triggering
> another IRQ demux() to toggle the trigger mode.

I believe Jeffy has identified another -- that we can't handle the
both-edge toggling entirely before the ack+dispatch.

> Right, so guessing we could somehow move the IRQ ack into the toggling flow
> to make sure that it would not clear the new IRQ?

This sounds like we need the toggling to happen within the .irq_ack()
callback, in between the ACK and the chain dispatch.

I'm not sure I've fully walked through this yet, but would it suffice to
move the 'toggle_edge_mode' loop into irq_ack(), right after writing the
EOI register? That way we're in one of these cases within irq_ack():

(1) no further edges occurred after the ACK/EIO write: the toggle-loop
will toggle correctly, and then we dispatch the chained handler.

(2) one or more additional edges occurred after the ACK/EIO write
(possibly during the toggle-loop): the loop only exits when we're sure
things have quiesced, so future edges will toggle correctly (i.e.,
polarity is correct). We continue to dispatch the chained handler (which
"handles" all these edge(s)). We may still have leave an IRQ pending (if
many edges happen, racing with the toggle loop) and fire again shortly,
but that's OK.

Does this make sense to anyone else?

> And it looks like there are quite a few drivers having this kind of need,
> would it make sense to handle it in the framework?

I suppose it would be possible to implement the above as a general
irq_gc_ack*() helper, instead of open-coding it, although it might need
the irqchip framework to gain a better understanding of a chip's
polarity register.

Brian
