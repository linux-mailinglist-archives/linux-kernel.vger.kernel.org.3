Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27089510639
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353593AbiDZSGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353590AbiDZSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:06:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630427CF6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:03:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l9-20020a056830268900b006054381dd35so13598671otu.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtLzLFLewrXQHTJbVImCCDYJrynuyEbueRUS2ATV0U0=;
        b=AjrbAV8MeBG1TftKOze/fLl/wHpmQ8Rhq7SRWYnnk6QRX7wdha+JlYrp5O7tTdMzUy
         WqrpM6F+WjaAZwYZpZ2mDTaX4XSFH+e3nzwvRyoi/VCGEQvOsNrYC0eoZTvSLoRw7PaA
         6QSCdsZtqCQElCl5khit+DPERPtXiRGy1ElHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtLzLFLewrXQHTJbVImCCDYJrynuyEbueRUS2ATV0U0=;
        b=mxIXcJ/ZkJ2V+LO5v7rjzWda/IAIiis4e/tPtzDxTy27b49gJIq40ekHqxvlEOf4mV
         dQvkHiRjp/z9QlW4lsUdPTtQ4mw9ncZo0UJKsCXHzSU2pok2TUfgoSpyfwDkAYxYdAcV
         +3r6VFKB4DT2xxkKmmIYK/6pEyEZ5hveg4U4FLmFBQOAFRbTQr+2WDKE2GarCrj/4CMR
         NKbrp1GQqZP5/zLCecCx0iMPoKbF8cexl96fppPF6wkwofC8XUS/rM35BiaFFlO5y85U
         L7+NDY1i9+tfV0cQFhtZb/GlpkCM4hun0XadJKzk+vFK6O+2oTwRGT10xE8yua4dsixy
         mWtg==
X-Gm-Message-State: AOAM530s/y47Csp5FBZiYXyg3OBhH1rTMOpCq52Dgl2NtnQmr9iFwWan
        AsBR7pojW3s4UdyZV9IjlZBeGZH94Fc+pQ==
X-Google-Smtp-Source: ABdhPJy83NMN7nOzhxCWnef7CUTp6YJ8Z3hAH75BE4DKR87rV/78cvj30amXCEorIvhpquOQk8Oh9A==
X-Received: by 2002:a9d:384:0:b0:604:a8b6:eb85 with SMTP id f4-20020a9d0384000000b00604a8b6eb85mr8488259otf.140.1650996186537;
        Tue, 26 Apr 2022 11:03:06 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id d21-20020a4a3c15000000b0033364bde9besm5934109ooa.32.2022.04.26.11.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 11:03:04 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id m22-20020a056820051600b0033a41079257so3531974ooj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:03:04 -0700 (PDT)
X-Received: by 2002:a4a:141:0:b0:353:d3c1:8aa with SMTP id 62-20020a4a0141000000b00353d3c108aamr8682441oor.64.1650996184119;
 Tue, 26 Apr 2022 11:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <1650964532-9379-1-git-send-email-quic_spathi@quicinc.com>
In-Reply-To: <1650964532-9379-1-git-send-email-quic_spathi@quicinc.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Apr 2022 11:02:52 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMkzrqkDdb=y4DpK5Ot=XFtj6aAv7-mSBoGP5rDJZanpA@mail.gmail.com>
Message-ID: <CA+ASDXMkzrqkDdb=y4DpK5Ot=XFtj6aAv7-mSBoGP5rDJZanpA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Select HS mode in device first and then in
 the host
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, avri.altman@wdc.com,
        Linus Walleij <linus.walleij@linaro.org>,
        vbadigan@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>,
        s.shtylyov@omp.ru, merez@codeaurora.org,
        wsa+renesas@sang-engineering.com, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishor Krishna Bhat <quic_kishkris@quicinc.com>,
        kamasali <quic_kamasali@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 26, 2022 at 2:16 AM Srinivasarao Pathipati
<quic_spathi@quicinc.com> wrote:
>
> From: Sayali Lokhande <sayalil@codeaurora.org>
>
> While switching from hs400 to hs200 mode, high speed mode
> timing should be selected in the device before changing the
> clock frequency in the host. But current implementation,
> (mmc_hs400_to_hs200) first updates the frequency in the host
> and then updates mode in the device. This is a spec violation.
> Hence update the sequence to comply with the spec.

I'm a bit new to interpreting eMMC specs, but are you sure this is a
violation? In JESD84-B51, I see:

"The bus frequency can be changed at any time (under the restrictions
of maximum data transfer frequency, defined by the Device, and the
identification frequency defined by the standard document)."

I think that suggests we can lower the host clock first, and then
lower the device timing. And (according to my limited knowledge) that
makes sense too: the device timing is a "maximum" (to some extent) and
we're free to run the host bus somewhat slower.

And on the flip side: it sounds like you may be _introducing_ a spec
violation (that we'll be running the host faster than the device
timing, briefly)?

Apologies if I'm off base. But you did CC me ;)

Regards,
Brian
