Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A7509533
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383857AbiDUDBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiDUDBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:01:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328AE0A7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:59:01 -0700 (PDT)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5E223F325
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650509936;
        bh=IiYhDkBxg42hecLjhxZWOT2Ofh69UeO2F0VLO5lZVVw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ob9uldVtuCjJUoxqH6BOVDqFF/5aGkBKTqkiyCElGHZxY1xmbhPr4zEfKamvot82+
         ufjir/oMMdfg5oQR/NUzZr4DY99yoErd/i3o4/ZejuN9Vxdh/0eASzQMdPeWyrdn8C
         5zUJbD0ofw+tQ3DpAscDGSvuU71mkYz9Z3u2ymIsa5CIwYvzwvfe7k/3PCgp0sj5x4
         QekCXJqVaSLmVtCMZpUW1IHDvhKR3L0IncN7VvKi2QsJyZakl/bmRqeQrFkYlvsVSr
         1iWF3r9LOEjakigRYgRVglglgchD3a5N+neNc7rjtBB9l+6xojKf4d/ntl8F17MmCF
         bveXOGAj/UN0w==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-e5bae51cefso1611925fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiYhDkBxg42hecLjhxZWOT2Ofh69UeO2F0VLO5lZVVw=;
        b=qU3Zd0L5kW+5gAdR7gBhRS3gXzFKi6IKV8/eHKSOOs1tcW0q1hIpdHaR1krVkWeP48
         75sQhgHGjdZLV0yYF+niT627OxFLJO1ejDjVcrmJIIRCIXJgC4hc+Y/6u/N5UwtD2nlL
         ID2jSmrh6bhYYMMOrywycafCF7C6SGFsTb4vopzK+NeKQhjBRXN00JUOBAQE4pXLFOx5
         saENrgd5CwDTI2ide8O0sjFOFPZSElo0XWNEmLKkQFZoVSk4GB118eL/5LF8G4FlxCz3
         0PY+5E23+0mbI7Yj+J2JOa7wHf+AbYKb5QAfDNl2OKw7GwZgxpFUoQT48gDp8pYISyex
         DnXg==
X-Gm-Message-State: AOAM5302pdZ5mgk818WSN7n5EWgvr+5PJXRh45CAbp1yltLSmzavVQ7F
        Ogue+hWaM3JKP8kZtwlFXhh1e3RAcvNPdoxRsXqVTj6MO/7YGvF9l1DDW8cqmrhWQ8Cg8hKN6BA
        cAj14KlV5swBdHZWPkM1BwKEr71x8KOKW2Z39qwr3Kd57d4CiHddpNn+Hyg==
X-Received: by 2002:a05:6870:a98e:b0:dd:c79d:18a2 with SMTP id ep14-20020a056870a98e00b000ddc79d18a2mr2817473oab.198.1650509933099;
        Wed, 20 Apr 2022 19:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYILGLtCmKpsBFaOaeTACV/xwcPOnnYnY6uaubtc1tiAiFVCYxzwNiCHEhu1L9CkqiGY6AR5yAvGf42Z1giAg=
X-Received: by 2002:a05:6870:a98e:b0:dd:c79d:18a2 with SMTP id
 ep14-20020a056870a98e00b000ddc79d18a2mr2817466oab.198.1650509932780; Wed, 20
 Apr 2022 19:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220420124053.853891-1-kai.heng.feng@canonical.com>
 <20220420124053.853891-2-kai.heng.feng@canonical.com> <YmAc+dzroa4D1ny2@lunn.ch>
In-Reply-To: <YmAc+dzroa4D1ny2@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Apr 2022 10:58:40 +0800
Message-ID: <CAAd53p5Wwn+HOMm1Z0VWcR_WrTzRvAGZOYg4X_txugSFd+EsDQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: mdio: Mask PHY only when its ACPI node is present
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:47 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 20, 2022 at 08:40:48PM +0800, Kai-Heng Feng wrote:
> > Not all PHY has an ACPI node, for those nodes auto probing is still
> > needed.
>
> Why do you need this?
>
> Documentation/firmware-guide/acpi/dsd/phy.rst
>
> There is nothing here about there being PHYs which are not listed in
> ACPI. If you have decided to go the ACPI route, you need to list the
> PHYs.

This is for backward-compatibility. MAC can have ACPI node but PHY may
not have one.

On ACPI based platform, stmmac is using mdiobus_register() and its PHY
is using autoprobing, so masking all PHYs from autoprobing will break
those stmmac users.

Kai-Heng

>
>         Andrew
