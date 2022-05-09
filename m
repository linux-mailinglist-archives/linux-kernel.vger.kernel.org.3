Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E651FBB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiEILyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiEILw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:52:27 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBDA21AAA1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:48:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7b815ac06so141067227b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RD5UBc9Tp8nxPaMy9EtIkwGnYmwjmD8F//1MaTDPdS4=;
        b=ZT7EyveKN4tEMbX9Dkz1rllst2CQaRkI2llk34jeTE80NYlapr/CVm+qZSp2amUWNy
         3sF0B3aDQSsUt8vHz9wRxa9mY4g8Aymj9eGW3a0jXLx536XykNSFvcx+uesq1bbIXBOV
         gE6y41hJfP45iQUXFAKLUmPrJHZ4VEXaY3s8xyEWMHAuMfsgtSdHPB5eFzAZ2/fuEoXO
         UbVS4Ypn2MOaa3xt26SEGmPcG0CAUtyU4q31Rj+wHb7yq4/YPREmEGWTwRanO9Oq5e2i
         0twRqgHTtPXl//9FtJlCwIV4hCEfKFleuegv8YDAh7WMU4QFOBLqeDnI7GK9c4NSksV9
         TCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RD5UBc9Tp8nxPaMy9EtIkwGnYmwjmD8F//1MaTDPdS4=;
        b=LIhFMvDMvrEFzWnCO3oBS38ROZD6+SDlWz5pez4QD1TnUaIGME8sqc/Ni2WB+p5Jey
         xBWNlKMSKbI98Ez0Oc251dMlRzrmA2PO6gbeLLHd4Zi2qkqZ6Z+sa+zKWzmDEjKZOnMW
         8bngKoEKwjuc0KABuk3QipjAfWwnQgnVM+sD1RO8dYSEmifthh0FXlFAZxi985tCNwlQ
         GtKfUTDGoX8fXPYqhG4bNR0kv2wj4+XqvFoxEIhHThnUMsL3ZWLwfldQCETm8BjTO7Fb
         YSQj+YSS0KgtkWWswtYIxh4h6CpF8RD8NrYw6BHM1EUyRCopl8o1LZ6NUjbyUfzW5618
         jSng==
X-Gm-Message-State: AOAM531/zANv3PfLdp87g4t6Fb8kcHG8mDHidMRjTaOkbOfdBIUgznEL
        9d3ErP9DtPwEHzJY79E0rj0VfYvqAZYxXwYf/epc+w==
X-Google-Smtp-Source: ABdhPJzHzWjkwY2TT13Qf2WLxvQu1bcsQfixOklAup0qs85vi7n3/8pWUCANEvn8ywtnFm3S4xH89Fq1aRrd1AD9HCA=
X-Received: by 2002:a0d:ddc6:0:b0:2f8:a506:a5c0 with SMTP id
 g189-20020a0dddc6000000b002f8a506a5c0mr14457243ywe.140.1652096911136; Mon, 09
 May 2022 04:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220503151517.59115-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220503151517.59115-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 May 2022 13:48:20 +0200
Message-ID: <CACRpkdZEeEX6qOxkG0AFih4bMXaFraUFchgOXEKDO9pEh=mGGA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: microchip-sgpio: Switch to use fwnode
 instead of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 5:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
