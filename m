Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91874520BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiEJDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiEJDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:21:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33E15814
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 20:17:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i10so26987609lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ls/SMjFj6heZoySKcqmoqFtaszIPQaljVTG5Re0rH9M=;
        b=EB1ROIutBjcQZmj6LJr9SUFDRILRUz/dzhbYK+KW34P/HGB5VYjQOYia914IABPKHm
         ZB2rJYgCDwhzeTK1YSlNZCVpAtHmbUntOvkPoj0MeZhIc5THiAljwEScvUbZU5unm1E0
         78ioKS9u3eFHR3yEy1e3LjpgEBGiS3yUMMS3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ls/SMjFj6heZoySKcqmoqFtaszIPQaljVTG5Re0rH9M=;
        b=4P/l9yzc+rHePnA+SXfcpD9UCvyPM9HLeDNLKHWakFaSe+GWbLlmC0NxY6poaaLLn/
         yzoxxh8yxy2MbzgeO1jCKC+yOy96ADDbNNonm/a8LsssRYcRBG1oiNteTntRcPIK8iYf
         ypIlWJsXMdB6djj9huGJx7J7qT8ZFQx4gXiIoXsU7OlU0erUVC07SjJc2bQVc36nkIk+
         mC+ckSpwqy2dIWFt7i+549vKSrFYOxZASjyzLJuMR4lyMutKU2JuKIMFmZm9kczGGDfC
         62U/Kuo/C4p9clcycpcW4PGoRVeojJIT4/H47AuUsbJ8aDR77/n3xmCc2tnpco77j/oE
         AISw==
X-Gm-Message-State: AOAM533bbrqRAdymgMDgPZ9WldT6++KO34J/SWwpbFK68svVp6XFcndn
        Io+QDfGPxMN+iikdxaxFaEVHv35ULiF66Bkm1w8fFQ==
X-Google-Smtp-Source: ABdhPJw1K7QAlE5QAiZCLMLRs+tK1ZtQMIflSjgCESXPl/YsTyscWXUV+ShFFygPmv2BiT+hQUxJJ2+IPMYpxQps+Qk=
X-Received: by 2002:a05:6512:3f86:b0:44a:f5bf:ec9a with SMTP id
 x6-20020a0565123f8600b0044af5bfec9amr15376918lfa.490.1652152645011; Mon, 09
 May 2022 20:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
 <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org> <SJ0PR02MB713538E5BBB40CDEF2E050A0F8FF9@SJ0PR02MB7135.namprd02.prod.outlook.com>
In-Reply-To: <SJ0PR02MB713538E5BBB40CDEF2E050A0F8FF9@SJ0PR02MB7135.namprd02.prod.outlook.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 9 May 2022 20:17:13 -0700
Message-ID: <CABmPvSFiAC474WthmMX0nE20UEOxUD5dEYBVbiKh7HOovCnCkA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
To:     "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Andy Gross <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        quic_rjliao <quic_rjliao@quicinc.com>,
        Alain Michaud <alainmichaud@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bala,

When is the estimated start date and timeline of the driver development?

Thanks,
Miao

On Fri, Apr 29, 2022 at 8:09 PM Balakrishna Godavarthi (QUIC)
<quic_bgodavar@quicinc.com> wrote:
>
> Hi Marcel,
>
> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Friday, April 29, 2022 8:24 PM
> To: Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>
> Cc: Andy Gross <agross@kernel.org>; robh+dt@kernel.org; bjorn.andersson@l=
inaro.org; linux-arm-msm@vger.kernel.org; devicetree@vger.kernel.org; linux=
-kernel@vger.kernel.org; Johan Hedberg <johan.hedberg@gmail.com>; mka@chrom=
ium.org; linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC) <quic_hemantg=
@quicinc.com>; Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>; =
quic_rjliao <quic_rjliao@quicinc.com>; mcchou@chromium.org
> Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW =
issue
>
> Hi Balakrishna,
>
> > The patch is workaround for hardware issue on WCN6750.
> > On WCN6750 sometimes observed AON power source takes 100ms time to
> > fully discharge voltage during OFF. As WCN6750 is combo chip for WLAN
> > and BT. If any of the tech area ON is triggered during discharge
> > phase, it fails to turn ON.
> > To overcome this hardware issue, During BT ON, driver check for
> > WLAN_EN pin status. If it high, it will pull BT_EN to high immediately
> > else it will wait for 100ms assuming WLAN was just powered OFF and
> > then BT_EN will be pulled to high.
> >
> > Fixes: d8f97da1b92d2 ("Bluetooth: hci_qca: Add support for QTI
> > Bluetooth chip wcn6750")
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> > Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > ---
> > drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++------
> > 1 file changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index eab34e2..c3862d1 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -219,6 +219,7 @@ struct qca_serdev {
> >       struct hci_uart  serdev_hu;
> >       struct gpio_desc *bt_en;
> >       struct gpio_desc *sw_ctrl;
> > +     struct gpio_desc *wlan_en;
> >       struct clk       *susclk;
> >       enum qca_btsoc_type btsoc_type;
> >       struct qca_power *bt_power;
>
> I am really against these intermixing of Bluetooth and WiFi details. Ther=
e is work ongoing to do some sequence power procedure. Maybe that is someth=
ing you should look into. This is a mess.
>
> And again, we are still hacking around hci_qca.c instead of writing a cle=
an serdev only driver for this hardware. I have the feeling that nobody lis=
tens to review comments these days. It is just hacking patches together to =
get hardware enabled somehow and then disappear.
>
> [Bala]: We are working on serdev like driver for our QCA platform.  We ar=
e in initial stages of discussion, and soon we will start the driver develo=
pment work.
> In mean to stop stability or functional issues we are trying to add these=
 HACKs in QCA driver.
>
> Regards
>
> Marcel
>
