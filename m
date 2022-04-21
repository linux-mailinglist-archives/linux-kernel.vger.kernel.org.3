Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD355099B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386195AbiDUHwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiDUHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBD1AF2F;
        Thu, 21 Apr 2022 00:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F016261B6F;
        Thu, 21 Apr 2022 07:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B79C385AF;
        Thu, 21 Apr 2022 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650527348;
        bh=XtL+3anNJRhWOAUuNxErGEglp2qD/anNUiavImUZHSc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SI6N8MLwQTi/OcfLRqaIbOWpLPAMJQBKpjNIHGCtcKl3DD8PVnvMmhsDEUqlR1Lus
         ijmWsDNl11yvTWQOraEUxNHvcWKVb4GNEdT6Fw4raqIHKf0XZ77g0qaxDXG+JYfL7R
         Zg14HRoH4ZDpkFTKy04n1nNnBFsC0Psbkg+f0gdN5ivSizLqRI8i0jeHcBClfgE37Z
         mdl7box1eAQsd9gasTSzXmLPf+orNsh5zt9ZG2F88V6PwHFZ+8nrtdMFNcK3zn9Q0M
         xP1k1BUiPOPifBGUY0w4JZuxYZsVDYgYaD1UzL9Y7+Qqa8uqZET7wW7fl7gSdMScYk
         LXF79XdsCh00A==
Received: by mail-wm1-f49.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso2783837wmz.4;
        Thu, 21 Apr 2022 00:49:08 -0700 (PDT)
X-Gm-Message-State: AOAM531Mm7wNXaqtVuwXdfXcZd91j8pRm/0i87/IGy0QfwGYvDheNEKe
        NhyRJXeYj57I8Ne0C4h9FZI57FFVjBwiE7k41fo=
X-Google-Smtp-Source: ABdhPJypuC7jbZN67qXyjmmFNWvxuABrK2IojedrMlrL5Yqv356sc3UpIArFOPSqMrdEiOwiEgmPKU7mdySJIdIBwDI=
X-Received: by 2002:a05:600c:4e4a:b0:392:88e1:74a7 with SMTP id
 e10-20020a05600c4e4a00b0039288e174a7mr7345266wmq.174.1650527346456; Thu, 21
 Apr 2022 00:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-3-hch@lst.de>
In-Reply-To: <20220421074204.1284072-3-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 09:48:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Y-z+FQWbZo+r_-SGa5D0oJJbKH-YQkk73uG+TOOUKKg@mail.gmail.com>
Message-ID: <CAK8P3a3Y-z+FQWbZo+r_-SGa5D0oJJbKH-YQkk73uG+TOOUKKg@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: remove dmabounce
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove the now unused dmabounce code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
