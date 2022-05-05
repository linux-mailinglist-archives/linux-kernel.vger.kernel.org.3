Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308CB51C10A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbiEENqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379767AbiEENpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:45:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58C3B037
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:42:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so8800234eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sr4Ss5yfaa7IzLIpJOUADGyVDnYifVqgDwzhtvc5Yqk=;
        b=Ap/og4uKYE3XviNHlHnNnDHUwZP/DpMHAgQEZMnqoe1HumMVUoqDjkYTzVHG2dh3l7
         mlm1cetp3drBMEmgHIQk3ihJ5EHeIQITI6hbL2XKWXoSKb5EFMJ3kppGM/+XZGposaIf
         NVY8yoh6w7MDLzb8v5pWTMFc0el9ng1r63u/CGCv9tiMtVN/Zx87a0T9UuNQ5wM6L3/7
         hZ/Ul+gLMSi1EKSVoXXNLyPO8ZN6isUifZkN+u3O94ODMBOfKrOSvbbMqGWNvHvShkzq
         2pOHfVMl8maZJodT7EiNZl8Hk9VJvDgQaulQy7D7xINSmCmw9okZ0V8Z+oMSy/DlItf6
         YkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sr4Ss5yfaa7IzLIpJOUADGyVDnYifVqgDwzhtvc5Yqk=;
        b=cWt5j+CvDAiYPQwOzH/J4S5Y6pNu3e/hvveLNWnZ2dUkIOtU7zAVljfwBIgjfvuCwo
         aJiHbFAOMbB6bkz9cdwUKOjNnv6GecnNgGl9CTXqGLrYcL3kh1+SRc7JnBXweYLodoQB
         iKY9E9vqu00DGCVgmXqPyOphdA3Ivhj30VcGxZK+B7647cKvtGH0aN3Zc3/HORfKEC/3
         zXOdGgrDQaIkJpKCzshnJqEAmKaRrBkulZf2XKWpGUCpfRL1LskPbpFO1T4Hh5hjMcus
         VQCI2c8aSQ/Qx7Ctxzd6lGTnPY4ApFhWm6wVeDMCE+JpyR1B56ERt/aU/vDpjYJHx8LU
         2daA==
X-Gm-Message-State: AOAM53233JSTRGby0X6QjXqhP66m0iRQPbB3wsyo0w2isnOh5mFNEsil
        z9K4bYvEz7KjjTZYKJUN2KQ=
X-Google-Smtp-Source: ABdhPJysPIrodFwBplaq01ISQFO8f3efO8y4iEOVzqn/xijXE0ymwQ5370eO3ob6EdukIyfEhQgDUg==
X-Received: by 2002:a17:906:8306:b0:6f4:314b:4db with SMTP id j6-20020a170906830600b006f4314b04dbmr22375737ejx.226.1651758133103;
        Thu, 05 May 2022 06:42:13 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id qk13-20020a170906d9cd00b006f3ef214df3sm762281ejb.89.2022.05.05.06.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:42:12 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [BUG] New arm scmi check in linux-next causing rk3568 not to boot due to firmware bug
Date:   Thu, 05 May 2022 15:42:11 +0200
Message-ID: <1837825.69bXt6fAuV@archbook>
In-Reply-To: <20220505101032.icqb2hau4dhj3afr@bogus>
References: <1698297.NAKyZzlH2u@archbook> <CAN5uoS_MgBiTVZCRSZyYCH4cnUZD_bHj2+mZu661bFV8TKWScw@mail.gmail.com> <20220505101032.icqb2hau4dhj3afr@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 5. Mai 2022 12:10:32 CEST Sudeep Holla wrote:
> > > > > On Wed, May 04, 2022 at 02:49:07PM +0200, Nicolas Frattaroli wrote:
> > > > > > Good day,
> > > > > >
> > > > > > a user on the #linux-rockchip channel on the Libera.chat IRC network
> > > > > > reported that their RK3568 was no longer getting a CPU and GPU clock
> > > > > > from scmi and consequently not booting when using linux-next. This
> > > > > > was bisected down to the following commit:
> 
> OK I missed to read the above properly earlier. If scmi probe failure is
> resulting in Linux boot failure, then that is another bug that needs fixing.
> Why does not getting CPU clock block the boot. I would like to see the boot
> logs. I considered this issue to be non-fatal and must be just ending up
> disabling all SCMI communication. But the reported issue is boot failure
> which sounds like another/different bug and I would like that to be fixed
> first before we push the workaround for the reported issue so that it is
> not ignored.
> 
> Has anyone analysed why the absence of CPU clock results in boot failure ?
> Are you running the upstream kernel itself ?
> 
> 

Hello,

I'm sorry, I seem to have misinterpreted the original user's messages
as having been a boot failure. Upon re-reading the logs, this doesn't
seem to have been explicitly mentioned. I therefore assume this wasn't
causing a failure to boot.

Sadly the user isn't in the IRC channel at this moment so I cannot ask
them further questions.

I have tested this out on my own RK3566 based platform, and found that
we get the following:

$ sudo dmesg | grep arm-scmi
[    0.247134] arm-scmi firmware:scmi: Enabled polling mode TX channel - prot_id:16
[    0.247526] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    0.247760] arm-scmi firmware:scmi: Malformed reply - real_sz:8  calc_sz:4
[    0.247773] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0
[    0.247920] arm-scmi firmware:scmi: SCMI protocol 20 not implemented
[    1.545441] arm-scmi firmware:scmi: Failed. SCMI protocol 20 not active.
[    1.562958] arm-scmi firmware:scmi: Failed. SCMI protocol 23 not active.
[    1.565676] arm-scmi firmware:scmi: Failed. SCMI protocol 22 not active.
[    2.094446] arm-scmi firmware:scmi: Failed. SCMI protocol 21 not active.
[    2.103474] arm-scmi firmware:scmi: Failed. SCMI protocol 19 not active.
[    5.586871] arm-scmi firmware:scmi: Failed. SCMI protocol 17 not active.
[    5.593178] arm-scmi firmware:scmi: Failed. SCMI protocol 21 not active.

$ sudo dmesg | grep clk
[   18.255901] panfrost fde60000.gpu: clk init failed -517
[   18.686720] panfrost fde60000.gpu: clk init failed -517

The system does boot, it's just awfully slow. This is not a boot failure,
but arguably still a pretty bad failure mode to find oneself in.

Sorry for the confusion this caused.

Regards,
Nicolas Frattaroli


