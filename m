Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5EF552E66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348950AbiFUJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbiFUJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:33:49 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F9F25C73
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:33:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b23so6154452ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eAn0mkf8cbbSldcOsHVmdulCChq1XWCHxJvyevA7Xy8=;
        b=p4nsrDQU/HL9kiO/BSBR3lWKcRmz20yfkNdEtRFiNLVnFyObvB+2JDLTEPz7ZfSyAx
         yb8oXPhQwE7wAUNWhTOZJq9rPKo82YQXQT1v57iBWTtjuIlUiGV3ydbeVvOpNV7FIvKf
         uwypx613RgvnumfBL4EjeGiXKXumJD7NYUvRTFWCMTZlqmqFOvPQZB25F4VUc/BlUzkI
         3bNO0DGxMuBeZIB2Pr8Vpxlv1ykqtMJcBaw92L+A25T5Dw2K4bZpnInem7cMn/dTNbx7
         XJx9UovtyH/lBD5ZMglt4lEvpPjY9t9N2PL3lUOYHjaP+i0BTi9noXI9qYHbg9TRgqLw
         BH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eAn0mkf8cbbSldcOsHVmdulCChq1XWCHxJvyevA7Xy8=;
        b=m76mSZofz1+VhHrBKCTv+3AUSSaQmf5dcyhM24KPa7FnjVom/PjfMRvBUQvDa/+SRN
         RAxJmaH3uCqNAewkc0O95wpXnT5LjogpV3Epc+VcDOA/nex2KrxPKre1SgSqo+sJgYDT
         uzhVZWQBhQS2Ow6v5Gxkfraj498FwBtsql3ZFVnqLhQpkcLHUBfHMmMxOCkkNyGHO9D1
         ZtUYcyZ84hDG5YlbAMEZcR/9rEkVBJYa2hvZ4F0FJ4xxhEQKwa0xI3+cqZErhdBARRU1
         iKDIgt/xmEBF/FayglHSWopTSaks3R0JMRicszylOOvNYeNJbkVNWRMumva68ZHdg4oM
         D3iA==
X-Gm-Message-State: AJIora/zjeb9UaY3RPlr91v2dHD1bBhrudRGpIZxy/cakr2xguJSnbal
        VT1zApf9LEjO+CBQ/ipNjMqcxy8YG5eq8DjkmUE4Tg==
X-Google-Smtp-Source: AGRyM1vhoowH12J1zPskShLlXyMV98854EH+GXf+cFtJNMVCeZhPcYPK3u6iSPHLdI8a5bE/oc6mJEfEqdg9mfvyvNk=
X-Received: by 2002:a2e:860e:0:b0:25a:6dbe:abb5 with SMTP id
 a14-20020a2e860e000000b0025a6dbeabb5mr5361078lji.474.1655804025707; Tue, 21
 Jun 2022 02:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-7-mw@semihalf.com>
 <YrCzBzKfSl1u90lB@smile.fi.intel.com>
In-Reply-To: <YrCzBzKfSl1u90lB@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:33:36 +0200
Message-ID: <CAPv3WKd+e5kYz7L0Fnw6u9wcPU6+r54EeEWvJzw8oCyj=m6JPg@mail.gmail.com>
Subject: Re: [net-next: PATCH 06/12] net: mdio: introduce fwnode_mdiobus_register_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 20 cze 2022 o 19:49 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:19PM +0200, Marcin Wojtas wrote:
> > As a preparation patch to extend MDIO capabilities in the ACPI world,
> > introduce fwnode_mdiobus_register_device() to register non-PHY
> > devices on the mdiobus.
> >
> > While at it, also use the newly introduced fwnode operation in
> > of_mdiobus_phy_device_register().
>
> ...
>
> >  static int of_mdiobus_register_device(struct mii_bus *mdio,
> >                                     struct device_node *child, u32 addr=
)
> >  {
>
> > +     return fwnode_mdiobus_register_device(mdio, of_fwnode_handle(chil=
d), addr);
> >  }
>
> Since it's static one-liner you probably may ger rid of it completely.
>

Good point, will do in v2.

Thanks,
Marcin
