Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF949D946
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiA0Dbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiA0Dbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:31:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A79C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:31:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so1353743plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRMJPfL0SdlUA7JGQQjBSw0AH6s07oqCQEUd/TBpC3w=;
        b=ERgk+by2NOrioElQxrR9n30LSsNqLx1xgpdw6eLUwxZ4cxVwTTZ85jCKJY1Rjfdmn9
         f2jlNkWWQZyCA2Pak8xGNdy8WYx8DYnxmg5mQx4btafQJ+X013Uo1W9Nlh17wcH3Wmy0
         ZUN+aBEFmWlzvF6qzEdL+ITtOPlLO9hg0UUxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRMJPfL0SdlUA7JGQQjBSw0AH6s07oqCQEUd/TBpC3w=;
        b=NY26sh35Hm1zp8GEc8zGqIzd9WsBQLMXFkjELKUDfOPwew17ySBandWDmwVCtHrTUW
         SsPn5s/HHlTk8RxGuHlPwxmI4wXOBAqHLG5u86FYyX8SD0OvrxAbrlbRkak9xwBAgsb3
         HE+MMfGNyXX78KnGFIcfRAzYDKQ8BzB9zvXRLUHfpMUokLODbdtGzUizgz8a0aBId6b0
         mtgcXqA4axZZU90bWV2caWgS66ffqlcSfC7yDuhLiFpxpo2sKwqUbqgKb8DbmNTYhNpw
         WBTiFhxhBvUQoh+sDfpxiGwPaIqw/oDmGpj+4FWUDBQsPJRmTWI9h1xKb80sfETeTHeM
         iUAA==
X-Gm-Message-State: AOAM532e0PHL0pfLFwU/cF2vObdZWOLtlAf4NpkgO4PW8EmRizWGK/vR
        sd0mSLgPKTegOdoSOVArUKc6XBJXNYK8B8mV/vbE7fVPs5Kq0w==
X-Google-Smtp-Source: ABdhPJxKRT2Knduyi+0+xZ9ujyEdfjCOAaHqxADPRSFHYd5hkOGOPM7Zls/S+pQZS45I+0LR+gB0/NoLEta49bMzqb0=
X-Received: by 2002:a17:902:d512:: with SMTP id b18mr2205929plg.24.1643254301062;
 Wed, 26 Jan 2022 19:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20220126073227.3401275-1-chentsung@chromium.org> <8625876c695685fc5409997403130194@walle.cc>
In-Reply-To: <8625876c695685fc5409997403130194@walle.cc>
From:   Chen-Tsung Hsieh <chentsung@chromium.org>
Date:   Thu, 27 Jan 2022 11:31:30 +0800
Message-ID: <CAMu4cy5onQ2JNKhoLVmR4Nb7Cqv2L59SoE=2Q9CK8bhfPvvHTQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:38 AM Michael Walle <michael@walle.cc> wrote:
> Out of curiosity, on what flash did you discover this?

It's Winbond W25Q64JWZPIM
https://www.winbond.com/hq/product/code-storage-flash-memory/serial-nor-flash/?__locale=en&partNo=W25Q64JW

We are verifying the write protection on W25Q64JWZPIM and run into an
issue that spi_nor_sr_unlock() always return success even if HW & SW
write protection are both enabled.
