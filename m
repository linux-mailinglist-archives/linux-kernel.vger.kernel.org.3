Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA05A5CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiH3HTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiH3HS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:18:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B50C59ED
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:18:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-334dc616f86so251555697b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=MpEKkG58U2QHlnMaUFyq17zJo7RrLc8a2XhryqGBt3c=;
        b=qHpbBTd+DiMOOKYv3JZ6+NXuPNqx6HDmym/WH/VHmzGftYl5YtLM4LYqdUQ/xUtPLV
         AROfcOYVywU64ZJL4qXCuuZPfuff2/FOqLCRXoODckK2pdfcXzGsYsa7nOBzl+ReJQAl
         FoHFkUuLONXmaiSSyqUlmydvsBeSe5vcZB6YwrhW4M0fzNclzd2TbkZTUJhMraYiOPjD
         q/bIQ+4USeWfUsirfJlM9pYZkW+5KarBuC2lYPBkD7XkIcfY5lmdWFhS8iFdd5nvNOBj
         CmoH7lpxKsnjwjxXLDsehoAfekpykRAucSNW1HtptaQrRDrnnUAemmyOfJSpXOZECcPV
         BDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=MpEKkG58U2QHlnMaUFyq17zJo7RrLc8a2XhryqGBt3c=;
        b=p0WvcuGIQ60MwiiuBIyMonBOF3KS5nVHwQaF79X7DkcvVxssIL9mXOeOFeYnn6rIje
         DpAZhVqChwUSUeaVVGUcf+Cku44joHZrloiSB/WLPZt8vgfBDUuhaGoK2J5F8ShWTqBW
         dCLKvf7GSxYka/Cst52o57fREhHvSmDQZPVTuw5uAJnzPdhPaaU6Ck5xKaNzoihoXAMJ
         Udy0YEeOY+uMtYx9ZESrvPqzrUi81Ycb5vXZEpTlc+5CG0JzjnpegXGtLI4PKT2LbwZW
         lzUYNnRsrjjknsZ/AL3TRHyh6LKeVYZ4WPtnLiFOZ3o3BMkEMnlG7EIUeBO5sNzzz8qz
         mgXA==
X-Gm-Message-State: ACgBeo29HWuefsu23LEH69qnECjMxAZ2qxwIKvHXuURxeIqvLCz45GfT
        J5Fl/ZJ7llFe2B+7uxehhl/ghQo5XkJM4F0PRe+KQg==
X-Google-Smtp-Source: AA6agR7w3M2ZJOl12uwmtMVO0cTCIwI2zkESBmdz5I2uiocO9DkGwUBdHd3wNfriQmYm9jWHEP8KAUjd6FSoyMABcr4=
X-Received: by 2002:a25:bd4d:0:b0:696:489a:3a86 with SMTP id
 p13-20020a25bd4d000000b00696489a3a86mr10172453ybm.447.1661843937729; Tue, 30
 Aug 2022 00:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <696cb2da-20b9-b3dd-46d9-de4bf91a1506@gmail.com>
 <22bc845c-dffc-7967-a542-f0697feec603@gmail.com> <7be3df2e-2250-8542-1707-121373213fe1@gmail.com>
In-Reply-To: <7be3df2e-2250-8542-1707-121373213fe1@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Aug 2022 00:18:21 -0700
Message-ID: <CAGETcx-3AkOjmx+=vwiiYfDc8tGNnSa+MTyEeB92Xgou0zWKPA@mail.gmail.com>
Subject: Re: fw_devlink=on breaks probing devices when of_platform_populate()
 is used
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 7:39 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
>
> On 30.07.2022 09:36, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 16.07.2022 22:50, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> I added of_platform_populate() calls in mtd subsystem in the commit
> >> bcdf0315a61a2 ("mtd: call of_platform_populate() for MTD partitions"):
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dbcdf0315a61a29eb753a607d3a85a4032de72d94
> >>
> >> I recently backported that commit in OpenWrt to kernels 5.10 and 5.15.
> >> We started receiving reports that probing Ethernet devices stopped
> >> working in kernel 5.15. I bisected it down to the kernel 5.13 change:
> >>
> >> commit ea718c699055c8566eb64432388a04974c43b2ea (refs/bisect/bad)
> >> Author: Saravana Kannan <saravanak@google.com>
> >> Date:   Tue Mar 2 13:11:32 2021 -0800
> >>
> >>      Revert "Revert "driver core: Set fw_devlink=3Don by default""
> >>
> >>      This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> >>
> >>      Since all reported issues due to fw_devlink=3Don should be addres=
sed by
> >>      this series, revert the revert. fw_devlink=3Don Take II.
> >>
> >>      Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>      Link: https://lore.kernel.org/r/20210302211133.2244281-4-saravana=
k@google.com
> >>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >> For me with above commit kernel just never calls bcm4908_enet_probe().
> >> Reverting it from the top of 5.13.19 and 5.15.50 fixes it. I believe t=
he
> >> same issue happens with other drivers.
> >>
> >> Critical detail is that in DT Ethernet block node references NVMEM cel=
l
> >> of MTD partition (see below).
> >>
> >> Could you help me dealing with this issue, please? Can you see somethi=
ng
> >> obvious breaking fw_devlink=3Don + of_platform_populate() case? Can I
> >> provide some extra information to help fixing it?
> >
> > Any ideas about this problem / solution?
>
> I didn't get any reponse for this bug for 6 weeks now. Is that OK if I
> send a revert patch then?

fw_devlink=3Don and of_platform_populate() have been working without any
problems for a while now. If your MTD change is causing an issue, why
not start debugging from there instead of suggesting reverting a
change that has been there before your change?

Most of us are busy getting stuff ready for LPC. So, things are going
to be a bit slow. I'm also working on other fw_devlink fixes. I can't
get to this quickly. So if you can debug this further and point out
where exactly it's getting caught up that'd help.

Enabling debug logs in drivers/base/core.c and drivers/base/dd.c might
make it easier for you to debug. Also, you can check the
<debugfs>/devices_deferred to tell why a device isn't getting probed
yet.

-Saravana

>
>
> >> Relevant DT part:
> >>
> >> partitions {
> >>      compatible =3D "fixed-partitions";
> >>      #address-cells =3D <1>;
> >>      #size-cells =3D <1>;
> >>
> >>      partition@0 {
> >>          compatible =3D "nvmem-cells";
> >>          reg =3D <0x0 0x100000>;
> >>          label =3D "bootloader";
> >>
> >>          #address-cells =3D <1>;
> >>          #size-cells =3D <1>;
> >>          ranges =3D <0 0x0 0x100000>;
> >>
> >>          base_mac_addr: mac@106a0 {
> >>              reg =3D <0x106a0 0x6>;
> >>          };
> >>      };
> >>
> >>      partition@100000 {
> >>          reg =3D <0x100000 0x5700000>;
> >>          label =3D "firmware";
> >>      };
> >> };
> >>
> >> ethernet@2000 {
> >>      compatible =3D "brcm,bcm4908-enet";
> >>      reg =3D <0x2000 0x1000>;
> >>
> >>      interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> >>              <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> >>      interrupt-names =3D "rx", "tx";
> >>
> >>      nvmem-cells =3D <&base_mac_addr>;
> >>      nvmem-cell-names =3D "mac-address";
> >> };
> >>
> >> OpenWrt bug report:
> >> https://github.com/openwrt/openwrt/issues/10232
>
