Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C855FC77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiF2Js0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiF2JrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:47:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE13D1DB;
        Wed, 29 Jun 2022 02:47:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so26905078ybu.13;
        Wed, 29 Jun 2022 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmOXlCPF2PKnBhpQ/luPJrSUkqjOxGD13NDVBnopNTk=;
        b=oDeMmnlCMTQvwXgm78D0pQRHhja+Ivd+N2hnel6/zhLoaRW5etlOls2REHUUBBbxiU
         6l5jO+KyaLfcVkIx9mK5+THqtbCE14MXYjrmFL3sq/H+6dwhLMQO80vCeAz+zoyQ6tD4
         /sWVN2VSVQiH58CXv/s/btxvwH9NpB+wLdHCiYrGdZSp1lqQHEe94WrDw6VCsh/tiS7K
         NipsDv97v242DKFzN3XNuoV1K7QUj6cBVQ6l3X+zme3htAyNlxEQ1M0ZiBiezEgSY5kH
         I2NkpkIjtahsqUm+/nZluwhgZxbvHL7ojm2Waao7yrYgQ7tZmB7WJKTeQ2RkU+nrkOtf
         Fcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmOXlCPF2PKnBhpQ/luPJrSUkqjOxGD13NDVBnopNTk=;
        b=mEmVMWfrJlomOm5nVbd/vyNgJbv6FhC1fgEmrGzCFHyiGgVhLUye642z3x21X5H10U
         sZDO4UdjAP8In/iSjLxZyNG92tsPExX2Rifhh0Fwej0ve0qq5Wh4OhXgBK72m7LMr+4t
         Om5JeRxanN9pfmWp6xnQzeUeLwYXDlzQzOPwmmh6sMN2qfDO/XLm3DhtuhDPTjcfOLwO
         L/Rp+X5Jvx2DjT+detlAbcMQGHL2Au7DsgFWgRnl9wZ6+Y2EH4KLixN72LQG1GGM5l3/
         EmxZowcX7VS0MxTenqitrBmmzKWshaZipAGqCMoLYwpNbiOvAgtL3ItNt3FX3AEYTf1u
         2iLA==
X-Gm-Message-State: AJIora8QpoDmEAt8Wn/5cVyg5sq1oyZ+YrgFdfIV7tbVxZXHTZB8mX33
        CI2LmQb3GYJIzrULqbk1wVtevqig2Vp8mdjcMpALsaKsyTmq+zIQlto=
X-Google-Smtp-Source: AGRyM1sCbYX6F5EQnDbOdSwxx4LX2Emni3Xa+5wghs4B8uexCocrG6wMB0Y10Gvfw6NCcvdJhV5sqqKPrCnk4EpsKxM=
X-Received: by 2002:a25:3383:0:b0:66b:6205:1583 with SMTP id
 z125-20020a253383000000b0066b62051583mr2289015ybz.387.1656496023486; Wed, 29
 Jun 2022 02:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220629021304.21725-1-chunfeng.yun@mediatek.com>
In-Reply-To: <20220629021304.21725-1-chunfeng.yun@mediatek.com>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Wed, 29 Jun 2022 12:46:51 +0300
Message-ID: <CAB=otbQ3L0G6NYvFwBe268auGG3iS6shk9z+SpgKrkLthn-qGg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: f_uac1: add interface association descriptor
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Julian Scheel <julian@jusst.de>,
        Yunhao Tian <t123yh.xyz@gmail.com>,
        xin lin <xin.lin@mediatek.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
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

 On Wed, Jun 29, 2022 at 5:13 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> From: xin lin <xin.lin@mediatek.com>
>
> When we want to use a composite device that supports UVC, UAC1 and
> ADB at the same time, encounter that UAC1 can't work when connected
> to windows 10 system.
> From the online documents of microsoft, "overview of enumeration of
> interface collections on usb composite devices", it recommends that
> vendors use IADs (interface association descriptor) to define
> interface collections.
> After addding IAD, we can fix the issue.

It is incorrect to add Interface Association Descriptor to the UAC1 function.
The UAC1 specification was developed much earlier than IAD was invented, and it
implements this functionality in another way - by describing number of
associated
interfaces and interface numbers on Class-Specific AC Interface
Descriptor level;
see *bInCollection* and *baInterfaceNr* fields of UAC1 Class-Specific
AC Interface
Header Descriptor in 4.3.2 section of UAC1 specification.

This is already implemented in f_uac1.c (see where *bInCollection* and
*baInterfaceNr*
are updated), along with support of dynamic capture/playback endpoints
enablement.
Adding IAD to the UAC1 driver is duplicating that functionality and
isn't supported
by UAC1 spec.

On the other hand, the USB orgcommittee switched the approach of
interface collection
definition from a class-specific descriptors level to IAD in the UAC2 spec.
So why not use UAC2 function for the same purpose, it already has IAD
implemented
and is supported by Win10?

Thanks,
Ruslan

>
> Signed-off-by: xin lin <xin.lin@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: modify commit log suggested by Greg
> ---
>  drivers/usb/gadget/function/f_uac1.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
> index 6f0e1d803dc2..8390207bc513 100644
> --- a/drivers/usb/gadget/function/f_uac1.c
> +++ b/drivers/usb/gadget/function/f_uac1.c
> @@ -71,6 +71,17 @@ static inline struct f_uac1_opts *g_audio_to_uac1_opts(struct g_audio *audio)
>   * ALSA_Playback -> IT_3 -> OT_4 -> USB-IN
>   */
>
> +static struct usb_interface_assoc_descriptor iad_desc = {
> +       .bLength = sizeof(iad_desc),
> +       .bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
> +
> +       .bFirstInterface = 0,
> +       .bInterfaceCount = 3,
> +       .bFunctionClass = USB_CLASS_AUDIO,
> +       .bFunctionSubClass = 0,
> +       .bFunctionProtocol = UAC_VERSION_1,
> +};
> +
>  /* B.3.1  Standard AC Interface Descriptor */
>  static struct usb_interface_descriptor ac_interface_desc = {
>         .bLength =              USB_DT_INTERFACE_SIZE,
> @@ -259,6 +270,7 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {
>  };
>
>  static struct usb_descriptor_header *f_audio_desc[] = {
> +       (struct usb_descriptor_header *)&iad_desc,
>         (struct usb_descriptor_header *)&ac_interface_desc,
>         (struct usb_descriptor_header *)&ac_header_desc,
>
> @@ -293,6 +305,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
>  };
>
>  enum {
> +       STR_ASSOC,
>         STR_AC_IF,
>         STR_USB_OUT_IT,
>         STR_USB_OUT_IT_CH_NAMES,
> @@ -310,6 +323,7 @@ enum {
>
>  static struct usb_string strings_uac1[] = {
>         /* [STR_AC_IF].s = DYNAMIC, */
> +       [STR_ASSOC].s = "Source/Sink",
>         [STR_USB_OUT_IT].s = "Playback Input terminal",
>         [STR_USB_OUT_IT_CH_NAMES].s = "Playback Channels",
>         [STR_IO_OUT_OT].s = "Playback Output terminal",
> @@ -1058,6 +1072,7 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>         as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
>         as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
>
> +       iad_desc.bInterfaceCount = 1;
>         ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc->bLength);
>
>         if (EPIN_EN(opts)) {
> @@ -1068,6 +1083,7 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>                 if (FUIN_EN(opts))
>                         len += in_feature_unit_desc->bLength;
>                 ac_header_desc->wTotalLength = cpu_to_le16(len);
> +               iad_desc.bInterfaceCount++;
>         }
>         if (EPOUT_EN(opts)) {
>                 u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
> @@ -1077,9 +1093,11 @@ static void setup_descriptor(struct f_uac1_opts *opts)
>                 if (FUOUT_EN(opts))
>                         len += out_feature_unit_desc->bLength;
>                 ac_header_desc->wTotalLength = cpu_to_le16(len);
> +               iad_desc.bInterfaceCount++;
>         }
>
>         i = 0;
> +       f_audio_desc[i++] = USBDHDR(&iad_desc);
>         f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
>         f_audio_desc[i++] = USBDHDR(ac_header_desc);
>
> @@ -1217,6 +1235,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>                 }
>         }
>
> +       iad_desc.iFunction = us[STR_ASSOC].id;
>         ac_interface_desc.iInterface = us[STR_AC_IF].id;
>         usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
>         usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
> @@ -1302,6 +1321,8 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>         status = usb_interface_id(c, f);
>         if (status < 0)
>                 goto err_free_fu;
> +
> +       iad_desc.bFirstInterface = status;
>         ac_interface_desc.bInterfaceNumber = status;
>         uac1->ac_intf = status;
>         uac1->ac_alt = 0;
> --
> 2.18.0
>
