Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964294952FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377264AbiATRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243820AbiATRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:15:09 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A19C061574;
        Thu, 20 Jan 2022 09:15:08 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g81so19732779ybg.10;
        Thu, 20 Jan 2022 09:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yT9EWMbXP3RpUqS/+1Dk4Xv8nRloB/d7Q7cHoePCJnE=;
        b=fa3ZYN8+fz5YzTQKAWtvk7h1sj8oC1aulkN8mEFZ5sm3P0dELvjUg2NaNTA/i0nGxk
         +3N1pP2ksmeit0EXA5ESsz4LVeh5yKR3v7msZwIPNItK0RpUyNDuslOTVSOQ1NiGfCcR
         +/xttfAvjnmGUJS/KOMaL8vnSDfZI1v5sOQMFnUlxaW7E4k+7u2ZaYKyKyTXu/xtkBjT
         IyCaaFR+skv2ciOHLi4sHQjOnl6t7Z9537inBQ6nMRD/qCOZDPNGdTskI93atmJREE0R
         Ev2VQuda3siBav0PuCP3vgx3Rzxcdi7zjI1dStRpviLhEU4YVJtBCojJ1VpDTSChbuMu
         RSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yT9EWMbXP3RpUqS/+1Dk4Xv8nRloB/d7Q7cHoePCJnE=;
        b=vzAqfcYq+Mblnttruy9mZW8TYTuzngMPehHXu3U5AbyUzO58D8xx+4BBa+kc3PdxB5
         SR8eC7ji+gKizh58GhbSvTgkpm3GhA+UnBm9Z5NwfEJSX4I6aLMd84d87MnQA02W9LYW
         EGXhd4IwX1Y2LnJlsa6yw0Q5yM3q3GL7XQFkHfD+/JpUR8S4Kp2Brla3dk8rsWHqATZj
         7R/9sL52wj1snBJSW6rtitz19EZFUEnURCh1evJsPQKIxWRgjig47sX16sGVoES/06qB
         swK7THaGxnsPJos5T42M8Aas1lyMIBS1vkn/zB2H8fS8QLL14zVtqSpJ/F+KvLRdYWR0
         hwig==
X-Gm-Message-State: AOAM533Cr5W5Fz9p1bOs77Br/u3gHF0m0o3bXKR2Foe3QzWrKAxx20yV
        bftc2MEs26qbB8dPUwKt8gYJkSaXWC9vjvAX1AmkpdJQ6Lk=
X-Google-Smtp-Source: ABdhPJzc4Y20EzjdiZVWoekW5D9g0NzOEhOYrbRg+LeU73fGt2mL90R25QRXcjd6M0f/xvFFDRbW5Gv53WEBJUHY7hI=
X-Received: by 2002:a05:6902:150d:: with SMTP id q13mr24253821ybu.355.1642698908078;
 Thu, 20 Jan 2022 09:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
 <CAMdYzYr+UXU-x=OakdHnOzLe1e4Y0xdGR-rybsmpLCMGbsWwXg@mail.gmail.com> <3e87ed0a-8b79-006a-dce6-62becc9906ef@theobroma-systems.com>
In-Reply-To: <3e87ed0a-8b79-006a-dce6-62becc9906ef@theobroma-systems.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 20 Jan 2022 12:14:56 -0500
Message-ID: <CAMdYzYpT8BUrukUozRSQDHgiQHMPbS5GtV7huL4xFFRsdxw0qQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:03 AM Quentin Schulz
<quentin.schulz@theobroma-systems.com> wrote:
>
> Hi Peter,
>
> On 1/20/22 16:06, Peter Geis wrote:
> > On Wed, Jan 19, 2022 at 8:52 AM <quentin.schulz@theobroma-systems.com> =
wrote:
> >>
> >> From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com=
>
> >>
> >> There are signal integrity issues running the eMMC at 200MHz on Puma
> >> RK3399-Q7.
> >>
> >> Similar to the work-around found for RK3399 Gru boards, lowering the
> >> frequency to 100MHz made the eMMC much more stable, so let's lower the
> >> frequency to 100MHz.
> >>
> >> It might be possible to run at 150MHz as on RK3399 Gru boards but only
> >> 100MHz was extensively tested.
> >>
> >> Cc: Quentin Schulz <foss+kernel@0leil.net>
> >> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-sy=
stems.com>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >> ---
> >>
> >> Note/RFC: as opposed to gru DTSI, max-frequency is used here instead o=
f
> >> assigned-clock-rates.
> >>
> >> AFAIU, max-frequency applies to the SD bus rate, while
> >> assigned-clock-rates applies to the clock fed to the SD host controlle=
r
> >> inside the SoC. max-frequency does not interact with the clock subsyst=
em
> >> AFAICT. assigned-clock-rates sets the clock rate at probe, regardless =
of
> >> eMMC tuning.
> >> Technically, the Arasan SDHC IP supports silicon-hardcoded clock
> >> multiplier so I think setting assigned-clock-rates as a way of rate
> >> limiting the eMMC block is incorrect and max-frequency should be used
> >> instead (as done in this patch). Otherwise the SDHC could still potent=
ially
> >> derive a 200MHz clock from a lower rate clock thanks to its multiplier=
.
> >>
> >>   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3399-puma.dtsi
> >> index fb67db4619ea..a6108578aae0 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> >> @@ -425,6 +425,12 @@ vcc5v0_host_en: vcc5v0-host-en {
> >>   };
> >>
> >>   &sdhci {
> >> +       /*
> >> +        * Signal integrity isn't great at 200MHz but 100MHz has prove=
n stable
> >> +        * enough.
> >> +        */
> >> +       max-frequency =3D <100000000>;
> >> +
> >>          bus-width =3D <8>;
> >>          mmc-hs400-1_8v;
> >>          mmc-hs400-enhanced-strobe;
> >
> > I don't have these boards nor the schematics handy for them, but
> > wouldn't it be better to simply switch to mmc-hs200-1_8v?
>
> Thanks for the suggestion, I just tested, by removing mmc-hs400-1_8v;
> and mmc-hs400-enhanced-strobe; but keeping the clock rate at 200MHz and
> adding mmc-hs200-1_8v; failed a basic dd test.

Quite understandable.
I more meant it may permit you to reach a higher clock rate than
100mhz and thus possibly a higher data rate, for example perhaps
150mhz would be reachable.
For example I would do a bandwidth test for hs400-es at 100mhz, then
test at hs200 and find the maximum stable clock rate.
If 200mhz is stable enough to probe and /sys/kernel/debug/mmc<x>/ios
shows you are in 8bit hs200, you can adjust the clock rate through
/sys/kernel/debug/mmc<x>/clock without needing to reboot.
It will speed up testing.

If hs200 permits a higher overall data rate than hs400-es, it would be
worth making that switch.

Always,
Peter

>
> Cheers,
> Quentin
>
> > Other rk3399 boards don't have issues with hs200 at full 200mhz, and
> > as I understand it hs400-es exhibits stability issues on most rk3399
> > boards.
> >
> > Feel free to disregard my comments if you've already tested this.
> >
> >> --
> >> 2.34.1
> >>
> >>
> >> _______________________________________________
> >> Linux-rockchip mailing list
> >> Linux-rockchip@lists.infradead.org
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.=
org_mailman_listinfo_linux-2Drockchip&d=3DDwIBaQ&c=3D_sEr5x9kUWhuk4_nFwjJtA=
&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3DO=
Tusi9XARCbef1Ba5t1gv4_LqRkOaxFY3UtvYky6NVLpeiziqqmdOJ8-R5WXWFNr&s=3DxBnqhBu=
20rxvu_V-5EhXyA_yNxcJpa4Dq6HO2Ow3Gk8&e=3D
