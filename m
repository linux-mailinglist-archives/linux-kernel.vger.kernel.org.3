Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1622050B57B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446827AbiDVKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446824AbiDVKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:46:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE0BCA2;
        Fri, 22 Apr 2022 03:44:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r12so8169473iod.6;
        Fri, 22 Apr 2022 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9mOgppXNPhWimJqU72s6fXNPCFcDPkPEDHvzrtAfbic=;
        b=ENmreVhV8u52bMxntoqrAwWBbM5PCO0r/Nol68a0fAE7eZaW+4ofl96ZmogULhu1zV
         DNxIaQcf0wmQVDjly5xrv2Mt48m/jTwNjIuwuAckSntilFAysopuuumDYulXX3FHv6mj
         VhADvhep9wK2tGVynosU+YD5wneIpN8/+Mj+X7se+8JKa2Wv1K7gi3PF2jxFwehZS9F9
         +yBpmbiBtzkq0V+4qa3KMlScOSfd51XY77gdCMM2ZKppK0x+4ED9imCXzD4J8w3+vpha
         worW7C6dcCsEiC+eNZQLZ0cTbB2bKQ6tHKO9YLH8QJiD/+/EA1bz0fhh5ie1NtkhqReG
         DBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9mOgppXNPhWimJqU72s6fXNPCFcDPkPEDHvzrtAfbic=;
        b=vDLLG/GxOkQG/1z1mBCzVzDbQAhSVX8WkboS0ZoWDMSCXdG3pEg0OdZ1c+0PRR7+tq
         T9J0w+S5ESJslJ94n2M1OlSZ/awlwHbWReQEGabNP1oLVP3i2H6XtZ4dtjyY8XYsAbw9
         oPl0oGz4unihexwLjdnWV5x5iUUCYT926A2e/WpNy+RO5NLI61dOsHI/dTp2NZGj8oOe
         bJpwWsQ6YmK+QVmlZg9I7JJZNXSIQMCHtA7aHdky0IgKuv/Erv1fNImkCo3YvJnQlr2m
         j90XQzCzpys8chwHHArAUuCmCxv5VmidIoKXJuG3jJgLfOz2HolzYaVPqQgUBIRpg3vY
         vUJQ==
X-Gm-Message-State: AOAM530Q6PI1z2XA5nRPt0HgA0h4we+eL+AxsT1xWobB3ZsaYsDwm8gS
        KsPPN1E7SjK6UkzpCNASFHMtu5YMc8BxKJHUdXOgU/U84ERcUWQC
X-Google-Smtp-Source: ABdhPJxuHA+ovPFyGpEEbXeiptBOygU6YMacm73aSaQQzN5jKfKaI7hqdDVB2vUOkzAAfaoiFekAI7Pm86w4RHS54ng=
X-Received: by 2002:a05:6638:213:b0:326:5c30:494b with SMTP id
 e19-20020a056638021300b003265c30494bmr1874609jaq.42.1650624240131; Fri, 22
 Apr 2022 03:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220412122524.26966-1-surong.pang@gmail.com> <610871b2-1707-dfba-868f-4ddecc4d554d@linux.intel.com>
 <CAEDbmAT=fZ-kpn13sW4KjB9RuFb_6T4j_eripR54NZ3UciZfqA@mail.gmail.com> <d6df23a0-6539-f955-5241-5cdfcaa4eca4@linux.intel.com>
In-Reply-To: <d6df23a0-6539-f955-5241-5cdfcaa4eca4@linux.intel.com>
From:   surong pang <surong.pang@gmail.com>
Date:   Fri, 22 Apr 2022 18:43:48 +0800
Message-ID: <CAEDbmAT3SoSsEmTkELSYoykGN+AuPgi2N11V2YwKuaC3nKMEmQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] usb/host: Let usb phy shutdown later
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     mathias.nyman@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson.Zhai@unisoc.com, yunguo.wu@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> @@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_device =
*dev)
>>>       clk_disable_unprepare(clk);
>>>       clk_disable_unprepare(reg_clk);
>>> +    usb_phy_shutdown(hcd->usb_phy);
>>>       usb_put_hcd(hcd);

Is it ok to put usb_phy_shutdown before usb_put_hcd(hcd)? hcd is
released at usb_put_hcd.

UNISOC DWC3 phy is not divided  USB 2.0/3.0 phy clearly.  Yes, it's
UNISOC's issue.
It UNISOC's dtsi: phys =3D <&ssphy>, <&ssphy>;
If to shutdown phy too earlier,  it will cost 10s timeout to do xhci_reset.
usb_remmove_hcd  --> usb_stop_hcd --> xhci_stop --> xhci_reset  -->
xhci_handshake(&xhci->op_regs->command, CMD_RESET, 0, 10 * 1000 *1000)

I want to know this change is acceptable or not?

hcd->usb_phy =3D devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
Why in xhci_plat_remove, just to shutdown "usb-phy"[0], not to
shutdown "usb-phy"[1] ?

Mathias Nyman <mathias.nyman@linux.intel.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=
=8822=E6=97=A5=E5=91=A8=E4=BA=94 15:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 22.4.2022 5.10, surong pang wrote:
> > shared_hcd might be freed already here, but hcd should not be freed
> > here, because "usb_put_hcd(hcd)" is called later.
>
> To me it still looks like this patch calls usb_phy_shutdown(hcd->usb_phy)=
 _after_
> usb_put_hcd(hcd):
>
> >>> @@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_devic=
e *dev)
> >>>       clk_disable_unprepare(clk);
> >>>       clk_disable_unprepare(reg_clk);
> >>>       usb_put_hcd(hcd);
> >>> +     usb_phy_shutdown(hcd->usb_phy);
>
>
> shared hcd was freed even earlier, before disabling the clocks.
>
> Thanks
> Mathias
