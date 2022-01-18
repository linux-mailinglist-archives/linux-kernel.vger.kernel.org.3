Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E3B4921B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345084AbiARI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiARI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:58:03 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F1C061574;
        Tue, 18 Jan 2022 00:58:02 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so23271617otc.13;
        Tue, 18 Jan 2022 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FsktoWN11jLWpkTmdexyrutmDTweSqKSJJTsgTRyixU=;
        b=GgvakMAFTEDdlAZ1aGXXD+GOfBvKxscCoMjAtF9pxaDGCe072j2wmSsu3PUgCRkeDq
         RV/MbsqxpUNYZGoZUe/Fuf/bIkNGObOQChg88H0o8crFHmk0ajwnXhp/kACS579PaP5N
         CJkLEdlu6bSN+xRX/CF59rN3qd4S4ra6CozIzM3zScc4WmBhq/e/4beaYb5ea/1uePRm
         0532PAEXIlH6wYIzWnEcT/TbKVap0Oi+6jkHmBq1buKijzYt8GNqHClUigIW2L0+6MYk
         QZrwA4wE4HECxxEU9xjJG7pdnpng4n65M1xDHdizuSw73nyL2J823Q+nvoX9uQKrQzpw
         hCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FsktoWN11jLWpkTmdexyrutmDTweSqKSJJTsgTRyixU=;
        b=U2pksDRai4VNwfqdC1gVIH55WPX+y4MnTL89M1GnP5OcUV7QiOoYt2JO6DaFI1bXKm
         q4uzNOdopkiCv/8ZZsLuFPd8w6fjFJDIEopl+FjwhjDcCYAH1w2hQ11r2iuhan4RolL6
         IRG7DgoztcIlTvMXOIcWiNbkb2BNr1VHtQh3rVWzY/qocQb/E1NItsAnd4fwiTm2+4ga
         VK8UKx+54z8EtLdYmBc8T8RsK7Rnce91W7/db3a0C1Zcqs0eCM7J52kqivJwX4lgIoWY
         WO4JtWwQOMTWyQKckOij3uqKzLgBAj7wS2yC3n+W5HhZYODdWS0JB5LyLWANQC0IbtD+
         QE7Q==
X-Gm-Message-State: AOAM530VHXeMzvB0Wrd2CtAwInipgZXwQ+3PZh0yMpsPYDRXjrz2Y84X
        LCgmK13npOJIzuhIwzqHmDItYbiRe0cKC62+0FI=
X-Google-Smtp-Source: ABdhPJwfhfP3ZzoOIvtdJwn9PzUBulGr/ZtsAdTqJjMDYStI8gE0hdRgSEp3KCRRvjy8ScAfUXak4HokaBQse1ecQY8=
X-Received: by 2002:a9d:d08:: with SMTP id 8mr20315706oti.334.1642496282003;
 Tue, 18 Jan 2022 00:58:02 -0800 (PST)
MIME-Version: 1.0
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com> <1642398248-21753-3-git-send-email-quic_c_sanm@quicinc.com>
In-Reply-To: <1642398248-21753-3-git-send-email-quic_c_sanm@quicinc.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 18 Jan 2022 16:57:50 +0800
Message-ID: <CAKgpwJUpMZTUKRbuWye8Qxjw6odqTS=ZLFLnPfunc=iA79ckew@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] usb: dwc3: core: Host wake up support from system suspend
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Li Jun <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandeep Maheswaram <quic_c_sanm@quicinc.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=B8=80 22:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Avoiding phy powerdown when wakeup capable devices are connected
> by checking wakeup property of xhci plat device.
> Phy should be on to wake up the device from suspend using wakeup capable
> devices such as keyboard and mouse.
>
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Tested-by: Brian Norris <briannorris@chromium.org>
> ---
> Remove redundant else part in dwc3_resume_common. This will not be
> required if GDSC is always on during suspend/resume.
>
>
>  drivers/usb/dwc3/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f4c0995..e7a5e3f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1789,7 +1789,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm=
_message_t msg)
>                 dwc3_core_exit(dwc);
>                 break;
>         case DWC3_GCTL_PRTCAP_HOST:
> -               if (!PMSG_IS_AUTO(msg)) {
> +               if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->=
dev)) {
>                         dwc3_core_exit(dwc);
>                         break;
>                 }
> @@ -1850,7 +1850,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_=
message_t msg)
>                 spin_unlock_irqrestore(&dwc->lock, flags);
>                 break;
>         case DWC3_GCTL_PRTCAP_HOST:
> -               if (!PMSG_IS_AUTO(msg)) {
> +               if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->=
dev)) {

If XHCI_SKIP_PHY_INIT is not set, I see the usb core will help to
handle phy power on/off and init/exit via drivers/usb/core/phy.c, so
if the wakeup is enabled for controller, then finally the phy will not
be power off/exit. I am wondering if this change is actually required if
that is the case.

Sorry for the late comment.

Li Jun



>                         ret =3D dwc3_core_init_for_resume(dwc);
>                         if (ret)
>                                 return ret;
> --
> 2.7.4
>
