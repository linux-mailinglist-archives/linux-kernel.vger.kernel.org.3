Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C053D979
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbiFEDpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 23:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiFEDpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 23:45:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE24EDD3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 20:45:45 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u3so10545323ybi.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u927xqlaG4+M+ycErvXLDv/hJjpEjGMZ02h0/MOu0dE=;
        b=ehj6NFZQv8BDVJJlJnUvvcDSXp9LpCqfvnmr5AXmU20WA3jQqH6sOl5be/5V6xWW+t
         i6e5y2mRwk2MV3UEKvTcTRXkOUeJZYrrczsFw+5q64C+0kLefCc4fK+oOEk6SmfB4YBP
         kkamPTLmuhJB011WNvofNqiRM5wg40Y+7zX0rei48rYtP3kEkpky6NpnOkPYqmuK7nYN
         oTPwGWjuof4MrzV/WUiIydLaUqeiDYDhhmpboRu0PgShxoo9F1xB2iZ69uUQJ5kfrYWy
         Jnwt0lMMEEKuEqbAm6O/urhy4l7obV+Pmh17DWGaW5a3DJaZVV3+PbaTSg8l6KGLEMX4
         v7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u927xqlaG4+M+ycErvXLDv/hJjpEjGMZ02h0/MOu0dE=;
        b=G/kO7OD1YDf1/C8sPBbiRTQCwjstYftvCWj0EvwnPIdeGbj9qbWcRsPv/aGDzb9Mxc
         lXpZ+ob3faK9O+tiuxmgrl2IECgOfek6gXPqtym9GtHFsC4kSmb59cpSVxMRy3WWUEyl
         GfV9CjzdhTd8ZmjGqgIaZsvVLx9aRdJRxbYHHR09vWR6+it4Q598c1sXSMoBsis9BXGA
         m3k7KjMAXuRXkuhuddJ7IWrApkB7O3T9yfL6CBSlKxMHF6OiFRKwG9W+y34Ks2IaGMP+
         YhYqGO9rZyEEcAI71CoWul4cBQnnEHFbrexdv1oCPdnV23xwhG/9+62Fe7fpamT4X8wu
         vdgg==
X-Gm-Message-State: AOAM5324+aaWh6yNALtJ5B4tFWsyWwJOO306Bjt33Ps1uGgxNfxaDghc
        BXsXHVCr4dYp3v51KiQAaoKifHYnP/ejMiJO5TWSeQ==
X-Google-Smtp-Source: ABdhPJwXtoaNM32RInd5ZTKb8WwYpukxL2Izf1ybTZRPqnFQCNw5sfzLXMWMQyk9Vor1Gw8PdsE5l0dAUAlKBxb7VNQ=
X-Received: by 2002:a05:6902:1009:b0:660:3a01:84eb with SMTP id
 w9-20020a056902100900b006603a0184ebmr19585298ybt.80.1654400744733; Sat, 04
 Jun 2022 20:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com> <YpSFBNfGDpy3rqEV@linutronix.de>
In-Reply-To: <YpSFBNfGDpy3rqEV@linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 4 Jun 2022 20:45:09 -0700
Message-ID: <CAGETcx9wya9L2voMAFBc04LMKcEY97kwVCgdt0MDqU8cjoQKMw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <jstultz@google.com>,
        Nathan Chancellor <nathan@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 1:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-05-26 01:15:39 [-0700], Saravana Kannan wrote:
> > Yoshihiro/Geert,
> Hi Saravana,
>
> > If you can test this patch series and confirm that the NFS root case
> > works, I'd really appreciate that.
>
> The two patches you sent earlier, plus this series, plus
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7ff7fbb006431..829d9b1f7403f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1697,8 +1697,6 @@ static int fw_devlink_may_probe(struct device *dev, void *data)
>   */
>  void __init fw_devlink_unblock_may_probe(void)
>  {
> -       struct device_link *link, *ln;
> -
>         if (!fw_devlink_flags || fw_devlink_is_permissive())
>                 return;
>
> and it compiles + boots without a delay.

Thanks for testing! I missed your reply until now and I ended up
sending out a v2 a few days back. That's a much better series IMO
because it only temporarily ignores dependencies and only when NFS
root mounting might not work. If you can test that too (and it
shouldn't have the useless variable), I'd appreciate it.

-Saravana
