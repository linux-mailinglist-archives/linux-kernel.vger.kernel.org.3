Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F938598C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiHRTcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiHRTcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:32:07 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9596CCD515;
        Thu, 18 Aug 2022 12:32:06 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e4so1927397qvr.2;
        Thu, 18 Aug 2022 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZHL1SaOfTZwhkFNWux6oDTIukBmh5Rw8CgMxZD3ua8c=;
        b=AbDJN9AxMRmLZ8JJ5l8Y2eM4TbWOABWiFeE7GhdkEIgIqFUMYJy2B2Qjv1RxJOI/NE
         SqCFXmz76ZwmkiIdLoar1f4v2m+EGuQVo6Rad74wqzowd9QJseuPLkSgQcfTFSJZB+/Q
         xe9b8NQ7SSmI9GbVidHVYt+aEr2VsTPPAzLnjCFUmpD7+LuwCn+Oyv78IXMndIMnOPTk
         R1/E8prTrloSVsZ7p28BT3f4H7oDwTxupDslBXFxaVZ0tRc7HMKeDNoE5YfE3Ibu3JU3
         cRsTG9w62moOn3VnNTEimtVMbRX4vBlx5cvCSelb4CrNyXoR3uywVADvMWvqgJ8LRxsz
         LaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZHL1SaOfTZwhkFNWux6oDTIukBmh5Rw8CgMxZD3ua8c=;
        b=rlUYtooTYmjNnasxl+/RsoBcq8QDvZXyrgFyLo9mJCjjN9+i9Yre/0B9dK/Ta6Jf+z
         OXeehmnkZz/HwoZdPtDLftwTcKQMhuy8/G9YKWJTyfeM61SAP/pCjLmpbm2jcXA533JB
         hQ88POi+buFgdlWi+t9fPAIr+rzTu64KwkruE16SfwIScTb369vfvEbdHYhUHgwzOAkJ
         3vNcQNk3xgnmVbWTmxqFgDkHqFvAMNNPo0DYoUazGw03m9Mbt489hAzL3S/LZlS0AU1M
         LJcmEzgw+deHMW5m6aKgDyf+MQRvxVOQ4aT6CzMqqHoCG7e+Y/MkLsSSVv5NPakcW95q
         mglQ==
X-Gm-Message-State: ACgBeo0MqOILt0H1SklgyLo/RbI3+hj/LFOl33Z4ZJAzox+IddDRb44Z
        Eg1tSeWl5QOkUg9lEml4c2f24FkIT904HcNbipA=
X-Google-Smtp-Source: AA6agR7DsUyIy8z9pnKhTv4DVJV1xfIJ7l1QotKfRYP+mLCNG8Km1SnaZo55f7x2s5XPILlKQimFdetU1yHZbHXY8zE=
X-Received: by 2002:a05:6214:d07:b0:476:c32f:f4f4 with SMTP id
 7-20020a0562140d0700b00476c32ff4f4mr3873033qvh.11.1660851125672; Thu, 18 Aug
 2022 12:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com> <1660649244-146842-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1660649244-146842-2-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 22:31:29 +0300
Message-ID: <CAHp75Vc4vT==hB=svhDBhSpNFCQXwzZ1RMxy4mQspFhmSjQ03g@mail.gmail.com>
Subject: Re: [PATCH PoC 1/3] ACPI / PNP: Don't add enumeration_by_parent devices
To:     John Garry <john.garry@huawei.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 2:33 PM John Garry <john.garry@huawei.com> wrote:
>
> For ACPI devices with the enumeration_by_parent flag set, we expect the
> parent device to enumerate the device after the ACPI scan.
>
> This patch does partially the same for devices which are enumerated as PNP
> devices.
>
> We still want PNP scan code to create the per-ACPI device PNP device, but
> hold off adding the device to allow the parent to do this optionally.
>
> Flag acpi_device.driver_data is used as temp store as a reference to the
> PNP device for the parent.
>
> A note on impact of this change:
>
> For the  hisi_lpc driver, for the UART ACPI node we have a binding like:
>
>  Device (LPC0.CON0) {
>     Name (_HID, "HISI1031")
>     Name (_CID, "PNP0501")
>     Name (LORS, ResourceTemplate() {
>       QWordIO (
>
> We have the compat and hid string. The ACPI/PNP code matches the compat
> string first, and creates the PNP device. In doing so, the acpi_device
> created has physical_node_count member set in acpi_bind_one().
>
> The hisi_lpc driver also creates a platform device serial device for uart,
> which is the actual uart which we want to use - see
> hisi_lpc_acpi_add_child(). That function does not check
> physical_node_count value, but acpi_create_platform_device() does check it.
> So if we were to move hisi_lpc_acpi_add_child() across to use
> acpi_create_platform_device(), then the change in this patch is required to
> not create the PNP binding (so that physical_node_count is not set from
> PNP probe).

Hmm... The flag, as I interpret it, is equal to "the device in
question is a peripheral device to the non-discoverable bus, such as
SPI, I2C or UART". I.o.w. I do not see how PNP suits here. So, from my
point of view it seems like an abuse of the flag. Not sure the current
state of affairs in ACPI glue layer regarding this, though.

-- 
With Best Regards,
Andy Shevchenko
