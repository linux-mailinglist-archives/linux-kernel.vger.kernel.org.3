Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4B4FBFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbiDKPGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347610AbiDKPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:06:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5023BEF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:03:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so31528070ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3iDWnR4HRse3iuMOHSPZXwIa+ie+fx1vx4WdB22/OI=;
        b=Lmox+OzzNKPaMKIHJewtVmlTgRjchsWwwXlKo04flpnM81uR2JWt3t7uAhjSU2Lxqv
         4FBVmdWQmz7SstReeJMxOvsKO+miR9S8Mt6E102/v2D3A2vFc1nMbDYaThX/nRpbpEod
         y0KhGmNwS3zh5sfJpXqG0em8G4ix1zH4AGW3NiY7KXJTwMl0JwN+gYF3+Azc1LqZizfy
         iO4IGAkiIxkFIZeEFxo0AWIdjsUw4YkZ5OWOulk2VMy4tTL4AapGKitYymfb4/mVoat8
         Tw8XXW9tG/3+T0L3z3Ah538ige3cEWhd/zbWSP3eDl0zXJvOn4qiVSfPtEBZCtqCD+qU
         Seew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3iDWnR4HRse3iuMOHSPZXwIa+ie+fx1vx4WdB22/OI=;
        b=xSjV00BtF/yMsJRY+bukCI1bAit5IRv+rl/vFDgw+vVMH0IwQPOL7wkn4erWQPkBXc
         S+8q+jmM7Q4gjO0AkOERY24DdkrSk79nkrD3GUBdtAJkIYk3sSp6eBTgUcLNGOOH1J2W
         rH7lITkCL/tzJxodY63CJv8cnMNxQqnXH8UnGQP9YTcqHJuLp/efpoiw3pmAMBBOQBL4
         BE9Pi9MjNdO5A5jcgNQxMUAzAM/4smGqW38v0y2F07cGwg4xT3IWoikeMIBQgNFlFl79
         sY3SZ6QYgY1Gg2E3FfdN4Utl7CQ7Q6o92sPcrALC8MBCMPSlc/5iFMiUEKSND5FCuiW/
         /CeQ==
X-Gm-Message-State: AOAM531SFOGCUEVMO3t4j4b7oDL3oQ4FmcD6AXIL/xzMqj+Kxw4WOfwT
        PuzAFLe4s2ViLqBw/Z3J2irX7fbfbOXdEEoiWFstVnRcpuQ=
X-Google-Smtp-Source: ABdhPJx2wE44H54Rp7c2CuNoGo1Ja2LPbFw08fx38Qpb0r9gZzk9LDbZ7PIxZ74ZlXDaf0SXae5+x9MgxDkXB/ggTOw=
X-Received: by 2002:a17:907:8a05:b0:6e8:441c:358d with SMTP id
 sc5-20020a1709078a0500b006e8441c358dmr17285696ejc.77.1649689426227; Mon, 11
 Apr 2022 08:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220328225628.3012397-1-linux@rasmusvillemoes.dk> <YkRPOM9GKo3tlxUh@sirena.org.uk>
In-Reply-To: <YkRPOM9GKo3tlxUh@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 17:59:33 +0300
Message-ID: <CAHp75VdiBqJ_+1eewmgrdGpsYUr=+xLpeH+4B_rS4nDtc-fMYA@mail.gmail.com>
Subject: Re: [PATCH] regmap: make range check functions static
To:     Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Mar 30, 2022 at 11:17 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 29, 2022 at 12:56:28AM +0200, Rasmus Villemoes wrote:
> > regmap_reg_in_ranges() and regmap_check_range_table() have no callers
> > outside regmap.c, so they have no reason to be exported nor have
> > external linkage.
>
> These are intentional API in case someone needs them, no need to
> encourage open coding.

But currently it's not used and simply consumes namespace resources.
Isn't it our practice not to add dead code / etc?

In practice I assume that one will grep before implementing, or at
least at review stage it may be pointed out for a helper, that might
be exported when needed, no?

-- 
With Best Regards,
Andy Shevchenko
