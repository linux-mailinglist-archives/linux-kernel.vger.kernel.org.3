Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FF575503
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiGNSaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiGNSaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:30:09 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93E42AF2;
        Thu, 14 Jul 2022 11:30:07 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id l11so4616325ybu.13;
        Thu, 14 Jul 2022 11:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0+bILqu9jQVoYb8CF1e/89i5yu39wGWofBIgq96ox8=;
        b=IaiSotiQwAF/6Hcu8GmlaNcJPPAYZw2QoBoD+x0nJoVJtEuuJtYC/1KHjSwZPA5O7p
         Ve2XIqyDVpZK3d64bFjw1opfRo/+9BvVmz2JK57NGdroLRQyk8D4YwERvGVWU5ugaqla
         JrUpjxIHIHjhrUhD3U+qAWbIa0KCEh0qiL7Zkjvl4NxQ43Z18eKqQA57S25NYJIMEcOE
         zpOF7zcnQF6HaSRgRtAaEgPkfemcuM23Q96TwiWQlHbwZYN3QJ08Lk4JjEaxqZsX+VvW
         7tjGonWE9/HcAGeAKIi2pNtlleZKXzhcBHBTI+9obIKFZnkdVo6IkcTLyQ8AVUgfnqRr
         69/g==
X-Gm-Message-State: AJIora9gh/XU6AMrsy7ZgAXzlFqQXzTEtFxTv7tuv7Cq4S7mCAx9Zvxd
        7hFs9Qg+VYnh5hvmBL4pvg381hcsx2nIYhjmFM+AkQkQ
X-Google-Smtp-Source: AGRyM1shh0wh14uRaOPlkqUQrcl3rlcOa8Nn+Hxf76DosO6El2PLRyopbfiHMLJ236C2z0OweXpeuAb8g4jrEBlYi+s=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr9720865ybm.482.1657823407268; Thu, 14
 Jul 2022 11:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220707180953.605246-1-wse@tuxedocomputers.com> <e67b965e-60a2-516c-9aa9-ff98a9645ec5@redhat.com>
In-Reply-To: <e67b965e-60a2-516c-9aa9-ff98a9645ec5@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 20:29:56 +0200
Message-ID: <CAJZ5v0h31uy6Yp3iyoZN1HnE6AWibyYVm1b8rUy=K0J0y3h-kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: video: Force backlight native for some TongFang devices
To:     Hans de Goede <hdegoede@redhat.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 7:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 7/7/22 20:09, Werner Sembach wrote:
> > The TongFang PF5PU1G, PF4NU1F, PF5NU1G, and PF5LUXG/TUXEDO BA15 Gen10,
> > Pulse 14/15 Gen1, and Pulse 15 Gen2 have the same problem as the Clevo
> > NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2:
> > They have a working native and video interface. However the default
> > detection mechanism first registers the video interface before
> > unregistering it again and switching to the native interface during boot.
> > This results in a dangling SBIOS request for backlight change for some
> > reason, causing the backlight to switch to ~2% once per boot on the first
> > power cord connect or disconnect event. Setting the native interface
> > explicitly circumvents this buggy behaviour by avoiding the unregistering
> > process.
> >
> > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > Cc: stable@vger.kernel.org
>
> Thanks, the series looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.

Both patches applied as 5.20 material, thanks!
