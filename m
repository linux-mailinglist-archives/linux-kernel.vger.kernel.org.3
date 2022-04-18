Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6805506052
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiDRXoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiDRXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:44:22 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B98811C24
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:41:42 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q129so16428158oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=nt67AC/fziRCHZ6C/VwJefCx0UfNr2G59yxCRKYFbPc=;
        b=coV+Xw+7+9GNFz3Ea8saZ3geP/wGaL/zYe71mwbODut3H5PVIvF7edk7idfkOXMCE4
         xN2byexgTFROxOQqvbsH6AZumeJWGwX+Tr5ZdpeBcVgiqq+AGpe2cV+viL4gKMMu+C4x
         jRE/fLiqKbMt7X1v9WHPdXbigUAfMEkFVzVF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=nt67AC/fziRCHZ6C/VwJefCx0UfNr2G59yxCRKYFbPc=;
        b=Ba7YRK8hD5kuczbHEfRHkhz2QiLDCGsuMiH6Qn9OHR1a6pLJDYtqtVRHQajXNA6jLR
         vSxAXWVmxTarGRHdMQHeS/Ez+o1CB6Iryz8ddCz6w/H8pjYPpXXR8Mfb1mXV+N1QzEJS
         Sh3kW32McZ7FFXAFJU4Vn2fn2NR/NSZl4ukpeCcFcviOAWnRx54kzLQI9NFJxj1sqWi3
         O1V+M6yOZby1xeTljgHqa/iMgrpoDzG3s1+aEoTeSwSDpeq8SZe0zmzmYaaX4pS21zSH
         rbfDColEA7dXSdK4XGaywk6qhuNqIfqyCRfjM6Rastaa3q2srxzJDiwCgt6JxEdVwdTG
         r3Sw==
X-Gm-Message-State: AOAM530aWSbgL0RSG7y9ZN3o0CN2Xftp7xU41o6kbRXw45O/bA3zxwA1
        rQA7VbWZ6GMcQ/VsRBH3eNYF6GbHz+vIHqCJohpnkw==
X-Google-Smtp-Source: ABdhPJx+f9x0ppm0dDZ5qHDJlsvPmDghYF7LzT5WM39003dq4Dcv4LSD35Q2evL841DhwiHe+0thBHgV/tswKkbDO78=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr6210643oif.63.1650325301373; Mon, 18
 Apr 2022 16:41:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Apr 2022 16:41:40 -0700
MIME-Version: 1.0
In-Reply-To: <Yl307fUo09z2/M+w@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org> <20220415003253.1973106-2-swboyd@chromium.org>
 <Yl3vd4kfgwJXMs/w@chromium.org> <CAE-0n53N1k_b9vWJ84nBdm9sxpYV3o4-FLJQM1HGqEhQsdr19A@mail.gmail.com>
 <Yl3ykMvfCaQlQ7t9@chromium.org> <CAE-0n51PX1SgqiB5vgoOLunkrxiWxH2O=jCCM5gNL97O8Ltt4Q@mail.gmail.com>
 <Yl307fUo09z2/M+w@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Apr 2022 16:41:40 -0700
Message-ID: <CAE-0n5366tn28yBYXj+7gaKGWqx4pCTrQ-nPWiEvTOERS9R6uw@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-04-18 16:31:57)
> On Apr 18 16:29, Stephen Boyd wrote:
> > Quoting Prashant Malani (2022-04-18 16:21:52)
> > > On Apr 18 16:16, Stephen Boyd wrote:
> > > >
> > > > Sure. I take it that I can drop this function entirely then?
> > >
> > > Yeah, if it's a simple response, should be fine.
> > >
> > > > BTW, why is
> > > > that function name the same as a struct name? It confuses my ctags.
> > >
> > > Yeahhh, didn't think about ctags... :/
> > > Topic for another series: probably can be renamed to cros_ec_cmd() (just to keep ctags happy) ?
> > >
> >
> > But then there'll be two cros_ec_cmd() because there's a
> > cros-ec-regulator. Fun! :)
>
> Ugh :S
>
> I think we can get rid of that one; it looks to be the same as this
> one :)
>
>
> I'll write up a cleanup series if it all looks OK.
>

Cool thanks! Would be useful to change those insize and outsize sizes to
size_t as well. Please Cc me on the series. I'll resend this series with
cros_ec_command() shortly.
