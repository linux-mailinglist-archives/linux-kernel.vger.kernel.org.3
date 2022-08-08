Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140458CB7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiHHPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbiHHPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:45:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5E224;
        Mon,  8 Aug 2022 08:45:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 17so6727904qky.8;
        Mon, 08 Aug 2022 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bh9vtqVsqdtuRVtF0p+dDtPg259p3E95D1pLQvcru3w=;
        b=cq0MuZNjL1Iosi7Dw8iy1M0vF630xTIQJG5rd0OZ9lwC1og/efLemVAc6kL8of945S
         fwOEOiveVvwp/2AJ9c5gMx7T29KMzoRYmOXu/LaDOxmLog87EDhQlY6DElzxNFskfNTf
         KWIJ6JcK0rQ6QjQJuJjGA5HL+JaNkGm4xHMu7w6e+QvArlZ6gHDlo4+0iX2YBA+2C7kL
         M3cRRgpfWMypuWLUpnDFGlA6UgxfhC0i1d3/8mEDQQiKvd0kkyfd3CkWWJ28ZsmgKsoO
         oo7kncJO0EjxdVSjxFHvkIYxPRdRtRRkdQ8DPyuC5HqT+SlxJngbo+FaAvC/5Rdq3Ziq
         FMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bh9vtqVsqdtuRVtF0p+dDtPg259p3E95D1pLQvcru3w=;
        b=twgGlGrNrSngSEATXP/vQ6ZHebq8nQKyV/40WxFrw2YBzBRIj6wO+btefewhBzxefm
         PN5K+pXX0ExhR6I7hB5eeMS5kjhPIbJ5yGLdDAECJQcYmne5aRH+3YikO2q2mIwGYh36
         e9ZBnDWbJouZtRTXYQxE6lfjzqAzUF7hKum1dPAZK13BWa9KBW4vNzbLXYdhuvNYoTLv
         dh9VFr/jS7z7dinXDAY/UEm/QWDrgrXagg8V1Nse1M+Zs2lp18+mjIUhEycLydqm3sy+
         6cNs5KwQS29uPSvZsojTx4gV8yIAyESHFpXD8ojjbC7AbFbtYF4ICN39gp4fejtZhzNh
         XrMw==
X-Gm-Message-State: ACgBeo1PLbij1VdqgSGuMbaQiPPJXhHk9k7KPDAIRUk7Nld/tOxYLySt
        ahofx41DsZPeKViHla2LEHrjtdL0UnLuqBXn7MM=
X-Google-Smtp-Source: AA6agR57g2gB91n5cIMA3Ek8b3eQgnUCyxfTNAkdw0qeWOfCiyS4onhObEI0VYeZoPmbgnO4c8BDU9l/aioLaBb9hoE=
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id
 a135-20020ae9e88d000000b006b94a0bcea5mr4324382qkg.748.1659973532761; Mon, 08
 Aug 2022 08:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-7-luke@ljones.dev>
In-Reply-To: <20220808030420.8633-7-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:44:56 +0200
Message-ID: <CAHp75VfvSKbVxFBr759p50ii5Hex5HyE3VTiU+J9t58xGXcjjQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] asus-wmi: Add support for dGPU-only mode
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 5:10 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for a dGPU-only mode on some laptops where when enabled
> the boot GPU is the dGPU, and the iGPU is not visible.

the enabled boot (If I understood the intention correctly of the phrase)

...

> +What:          /sys/devices/platform/<platform>/dgpu_only

> +Date:          Aug 2022

Not sure, I would put September for sure

> +KernelVersion: 6.0

As in a parallel review it appears that this should be 6.1, merge
window for 6.0 is ongoing and this series definitely is out of scope
of it.

> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Set the dGPU to be the only GPU available:
> +                       * 0 - Disable,
> +                       * 1 - Enable,

Since you mentioned the patch is wrong, the rest may not be reviewed.
We will wait for a new version.

-- 
With Best Regards,
Andy Shevchenko
