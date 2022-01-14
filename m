Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9748F2A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiANWtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiANWtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:49:04 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80808C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:49:04 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p5so27729984ybd.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iH8M1cSOUeO09U3PbhjZOe6YSKdsdnd0RAx9cUeRIZQ=;
        b=cmdDc/EuCN0CvuGVlYKFPXxzX6mME5geBFQ9aBXV0k6eY3CS1cHCqKs1ThdFs+1bGO
         D6LrIIFLZsqlWbXqZf+v+0AjZyf2AqSeyrRoYLkdazF91D8oDvifwre9D6Lm3UmmfbUY
         Ncw3f5ykDq6/VilTvyX0Iwse6qi89wB9Q+qn1eHP//aQvB6GWOs7IYXvYTHaqXG/8are
         jf3V7cUS1lq84KPddJAlPZWbCntnnT22WUXqjN74MEJOJ4sZVmlwIeGE+QgiCpgOn7rs
         Ebuj4h2akBe1hXf2hTAHfMhnXac6BvrSJ7zormw/7R83+IuoZ9WNkza3bKTEOY+jCFE0
         5K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iH8M1cSOUeO09U3PbhjZOe6YSKdsdnd0RAx9cUeRIZQ=;
        b=zZBCdaDCdUi/YWwknqeym39fzjYtXVd3IEo5uhZWYs9gi8+XUluiGQPWd/kvK96wgV
         Pd0TX4382uh1ULd0xdOqJgNk5PTIMRmKq5MTMpHFPfw9SnsXgsFywKimALpdmBssXysm
         ajBWzGXdjBP9AO42REzYb6OujdMh4xuIRGvqnKR0kOYIh0UqIWdAHeWuWeN2l5eoy+p2
         S3WM22+ar/KjEo8daADgeR36srYFavxCHt71Ip8g2sZaHw+b/ZVnf3AYTFc20tEF658J
         W4xB/L8vNO9gXrokfy7hX8qSqg0JnF0F4hQoxXnmTTUsFSWEc+61eiiT3negZUvcvRZ/
         /pZg==
X-Gm-Message-State: AOAM531Eb6L2yyQxIX4sXAtepQcx8LKV33uOpO/pS3kbvvLJBZc1KanF
        WyPkuih6sDhssITlI9SRAqNEc1bf7nv+Z98rWPM=
X-Google-Smtp-Source: ABdhPJylBwax+Q8KXEqfe6Mc9sU4MVI5do4YTfV6j7olCjdkq+KGm5PrcLAnc/dxhV6L3D0fb9qhWeBz/7VI03Czm24=
X-Received: by 2002:a25:a283:: with SMTP id c3mr4050285ybi.490.1642200543731;
 Fri, 14 Jan 2022 14:49:03 -0800 (PST)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 14 Jan 2022 17:48:52 -0500
Message-ID: <CAMdYzYquceSBrOsvO8rW9wmJA_RO=HSwv_waVoS=0hsP414T-A@mail.gmail.com>
Subject: [BUG] device_property_read_u16 reads out only zero
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Evening,

I seem to have come across a strange bug with drivers/base/property.c
while expanding the new cyttsp5 driver to handle device-tree
overrides.

With the property:
touchscreen-size-x = <1863>;
The following code:
u32 test_u32 = 32; /* canary to catch writing a zero */
u16 test_u16 = 16; /* canary to catch writing a zero */
int ret;

ret = device_property_read_u32(ts->dev, "touchscreen-size-x", &test_u32);
if(ret)
dev_err(ts->dev, "read_u32 failed ret: %d\n", ret);

ret = device_property_read_u16(ts->dev, "touchscreen-size-x", &test_u16);
if(ret)
dev_err(ts->dev, "read_u16 failed ret: %d\n", ret);

dev_err(ts->dev, "read_u32: %d, read_u16: %d\n", test_u32, test_u16);

returns the following:
[    1.010876] cyttsp5 5-0024: read_u32: 1863, read_u16: 0

This was as of 5.16-rc8, using the
gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu compiler.
I honestly am at a loss here, any insight you can provide here would
be appreciated.

Very Respectfully,
Peter Geis
