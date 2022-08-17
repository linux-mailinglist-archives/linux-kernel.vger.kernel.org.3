Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA13C5969A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiHQGfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHQGff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:35:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C367695A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:35:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d5so3950539wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pl8j8nMikEGLv3auuJamJeuxCXOj7rX7d17W0lTlskY=;
        b=IOxuVGEuuWrhB890xfIpMhVaObL/QznrYMLo0MDJU8skANXcLIpC5rM9IZj9P1k1S9
         RTPEAdpwwl4G0dBwPFBLTa8u7oyRnV9YiY1/D/muF5gBw8zwSV/R+RccjDUHj6/ThBOT
         OV4PiVZqQvt1vUIAoHq/jUZDO3oIqeXHxJK/d2FGT6CLpVYrMaQyZqRk17hxWFlq9Ci/
         LO2AmqpVa4X9M7v/2LShjYzdQUVjSQM0NRDLDUGEG8M1tq3ELCylC683JyE9NYHh4sgL
         sHHHwPUJeHmp17fhNCvWy4DcEu9PEPM5zQCcwH05fw+IjbjE3IShAewKoqv8ZRiSdGL9
         0frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pl8j8nMikEGLv3auuJamJeuxCXOj7rX7d17W0lTlskY=;
        b=Fs8uTRCwJ7qK6hv5B0wljQNOv1K6jsVfyKa01LvKQLFo5v7E8T/TLhoojl6lunk/bA
         Cms32IKdziOMN520xA9f8ZT8F6ij2sEJrB6h5VlTCTwKoX1xiuJ6wHYgLEpN5ysJ4S6k
         OsuQIFZlySHrShrLP4Tu/oirsEsyny3ni2FJLWGTxV8dyXWvUVKWqFlg8xp0EFq23jhE
         2sm+tY9Ktq3VQHEGuR4LUAMWEIiQIl5LijCAEF3DPcm4SNKQHNhY76EOhxA6xZVv96je
         vgOtY0G5VbsQDW/mbExbT3a360xdupTWGLbKj7y03ST0NVzS1WjI3fG3vlvOj3MIJh6t
         kd/w==
X-Gm-Message-State: ACgBeo3TY+yM6SYIbWbZLnymf6a5alrZA29OdP+LsT/4a18eUPZO+IFJ
        Wln6rsCeA00TRfX4+LSiKhTMpSqdqdhbkyI4Ids=
X-Google-Smtp-Source: AA6agR4zBXMqxaZAI8I9XcEYwlBHvitoY+sgQ8XMVVj+73mhQTWSmHQhCEcvwzy9GHQ1Z5aLc69TnVciuWCbsk4WbM4=
X-Received: by 2002:a1c:f718:0:b0:3a3:2416:634d with SMTP id
 v24-20020a1cf718000000b003a32416634dmr1114507wmh.83.1660718133588; Tue, 16
 Aug 2022 23:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <1660713867-26921-1-git-send-email-shengjiu.wang@nxp.com>
 <CAGoOwPT1tP-HP+0J1ddZ0Ea+67zzLzFFTeptTpNwkzxRK45b5g@mail.gmail.com> <CAA+D8AP2okZdD0YBWrxKGAxvp014S+R-dUSrPqbQN_ja3U5D2Q@mail.gmail.com>
In-Reply-To: <CAA+D8AP2okZdD0YBWrxKGAxvp014S+R-dUSrPqbQN_ja3U5D2Q@mail.gmail.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Tue, 16 Aug 2022 23:35:22 -0700
Message-ID: <CAGoOwPSgPSV2HOqC=t_NVor8YqxaLxmeDvMf8_j25phsPpcd4g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Remove unnecessary FIFO reset in ISR
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Aug 16, 2022 at 11:29 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

>> > The FIFO reset drops the words in the FIFO, which may cause
>> > channel swap when SAI module is running, especially when the
>> > DMA speed is low. So it is not good to do FIFO reset in ISR,
>> > then remove the operation.
>>
>> I don't recall the details of adding this many years ago, but
>> leaving underrun/overrun errors unhandled does not sound right
>> to me either. Would it result in a channel swap also? Perhaps
>> there needs to be a reset routine that stops and restarts the
>> DMA as well?
>
>
> Remove the reset, the channel swap is gone.

I have no doubt about that :)

> IMO, no need to handle the underrun/overrun in driver, the SAI
> hardware can handle the read/write pointer itself when xrun happen,
> and we don't need reset routine.

That'd be okay then.
