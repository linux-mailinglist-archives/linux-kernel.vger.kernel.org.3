Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A333584310
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiG1P1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiG1P1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:27:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5866ACE;
        Thu, 28 Jul 2022 08:27:15 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ef5380669cso23033577b3.9;
        Thu, 28 Jul 2022 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m19x5GgjL6UYGLO5pGx+8cW4vPm+cyuRwfchr+o3/60=;
        b=U/+D8kzsAw3UK/Iwl6REQhCOogRmlIHGFdJTCCvWXrAGuSS1hVTCnI0IZCaNzGtWAU
         X422BlF1rZOBOF1ORYEoCk/qne9c0/vIp7lJHTVGsuNkGIBCO/OgC5/ONGZixI4Fq5WU
         mQ/7CIERcEBOtXaWty87xojbkmPny2NkG4c9niiqSdrw+ZuY2gC6Rhkr0rUaKryvmH+Z
         CREykZ2FRMgsZYixDxhNd0x+S3WobSTQxkWQLwZF1UD8uDC1Ed7I49SulcfoL3Q6U6Dp
         LYPtoVu9GLjlKCWZCtXZZc9ABkSjzFQYTBdXf7KAT65iZZfnqtHov5VkBCzc6pZq3rcR
         jdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m19x5GgjL6UYGLO5pGx+8cW4vPm+cyuRwfchr+o3/60=;
        b=PRd9HsgJvlRbfimt9qTZr4+XjcVdTdJe3AOtg3pnHuHJKxOi/LKq5rkmUJrOF9n8kV
         sOPZKHN62zYo6p3aAZC20YO4pf+yJ5R6wxeJwAsK+UV8ioAnGvgMo/1S3cDAn6/qVx8a
         6qz9fen7+92648ij1i06YP6ykkQHRySXYYuqIeTtxIBYBFt6hp4aNPmPz8s88yFR67Bh
         p5eO1Y/aRG3lCOx09KMwcmfkKsKDnyGQYlLMB/GyRDYCMvmVp9/c6K1GP1KcPFSy//pB
         H6jGD0OEPlu0BiKwXhafwr8wyKrwtKbQTY/PZ8JTXuBRf55ZDw/mriWppeq1nd+dGFYG
         MyEw==
X-Gm-Message-State: AJIora8EmFcnc3gfztU/1q6cmil2ZyXsoDeT8SwyaKFSPIrsNtFHosny
        eEg0iWS9RShXhNZH1om8MvC0+GgL5kBM2BA23K2diMaKdG4=
X-Google-Smtp-Source: AGRyM1tLnqiPHDgHJROI4wdiF5Op1SZz/4SPA1Y7Or2IbhRW1yMX0efRCNxRKiA/eHsCKQeXMJlhUgmdu27oz8AfVOs=
X-Received: by 2002:a81:6ed4:0:b0:31f:611d:92d1 with SMTP id
 j203-20020a816ed4000000b0031f611d92d1mr7781654ywc.36.1659022034388; Thu, 28
 Jul 2022 08:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com> <be60acab-7dfe-6841-b176-4bd1e875d52e@birger-koblitz.de>
In-Reply-To: <be60acab-7dfe-6841-b176-4bd1e875d52e@birger-koblitz.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 28 Jul 2022 17:27:03 +0200
Message-ID: <CAFBinCB6bJbK2sx+oyCjo97Sv2=ywnCi_4v+E76f78DYMNqJkg@mail.gmail.com>
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
To:     Birger Koblitz <mail@birger-koblitz.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, sander@svanheule.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Birger,

(sorry for replying late, I missed your mail)

On Mon, Jul 25, 2022 at 10:19 PM Birger Koblitz <mail@birger-koblitz.de> wrote:
[...]
> > I stumbled across this while reading the driver. This patch is untested
> > because I don't have any hardware with this controller.
> I believe your fix is correct. In the meantime, more information has been
> learned about this hardware, in particular, newer SoC versions and the possibility
> to have parallel IO and hardware which uses different chip selects.
As Sander pointed out (thanks again!) there's actually an issue with my patch.
I just sent v2 with a fix for RTL_SPI_SFCSR_LEN_MASK.

> I came up with the following patch for supporting this, and it achieves
> what you also propose:
> https://github.com/bkobl/openwrt/blob/rtl8214qf_merge/target/linux/realtek/patches-5.10/317-spi-cs-support-for-spi-realtek-rtl.patch
> It is still is a bit rough, reading it I immediately saw 2 things that
> would need to be fixed, but it also improves e.g. that RTL_SPI_SFCSR
> is now configured independently of what u-boot did to it.
Your patch actually addresses an issue which I have seen with RTL_SPI_SFCSR_CS.
Since you seem to have boards with these Realtek SoCs: could you
please clean up your patch and upstream it (splitting into smaller
patches if/where needed)? That would be a win-win: upstream gains
improved SPI support and I won't be confused the next time I look at
the spi-realtek-rtl driver.


Thank you!
Best regards,
Martin
