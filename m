Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63454CCF67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiCDH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiCDH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:58:42 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E065D05;
        Thu,  3 Mar 2022 23:57:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ay5so7074527plb.1;
        Thu, 03 Mar 2022 23:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b5JJahJbPSg5PuTw+HrbCqpeRRIjKIFlWzoeU01rKTU=;
        b=DY4pRigayZTq/5rjtD2bjuRYX10CoBCJokMk8l+MP82c190ULI8mFEuacqaLNPAXPD
         g19dQFm0zMVhGKiOsNUY9WJgsc90AJDeeLgEAB5cpBbXEMt6heWnf2gMNbOruuNvF17k
         tXwKAv2lg7nTWKjS4zTcwxp73K/Vbt1z1Gar1VAgmd5Ag6hG/VXjy+dML3IARlgqC2B6
         cGI/FVM8Zba/wkYhqCgAMgtvHPZVw74vWCg4uHmsYZyJaQoCdjis0QGRG8L1OWv6BWMe
         j0uwGPD8wkT83IJ+e+RJJqDuugr6zMJGNHLqy9gJLwrC/UgMPBBtoo1bFd9Z8PQlBUsR
         KiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b5JJahJbPSg5PuTw+HrbCqpeRRIjKIFlWzoeU01rKTU=;
        b=g6Shr8ENbCs+DYD9W6qRgJVrxQaAImHDF+cM7NFrPH4uGMx41gqZXdQGkxdI4lyKb9
         qN8LCBq1l3fZz/uKarhs4ynEdMXdZyCKNSm+OYKFqbptvZePyd1Qy8f2PfDRgTCZia83
         UKnk6INHPC0zTWk7JK0k2jvK5+6cI+ItWxXpBQSPj72Li0XzTWNbh/FC4F5c63qSZX6Y
         ea1GIkquuyJvKi21XH6pqJHHmQqRahAYDU5xrF97zVdWHb5m30LogQeS8V6v/MxybBu6
         WppMmzcDbMvhqVpIwdYTeuRk9Rd1HYr2R75EhF3deELK4qvYOe7t49fA2Lo4DGNHd4QU
         Yt+g==
X-Gm-Message-State: AOAM532UYvIZfteLvtws9pK057J0fWcriYuuORk9nXVH+ZjMcfZZLFCv
        7dXFnUm330UXIRjDIq6FOvE=
X-Google-Smtp-Source: ABdhPJxvuPW+GS4d0R4GqvhhYiQKHdTrokQg6qHNRrkq/DtJ47Gkay/NlA31+zVRMc3ZiLuUSflWGA==
X-Received: by 2002:a17:90a:4286:b0:1b8:8ba1:730c with SMTP id p6-20020a17090a428600b001b88ba1730cmr9376289pjg.181.1646380673939;
        Thu, 03 Mar 2022 23:57:53 -0800 (PST)
Received: from taoren-fedora-PC23YAB4 ([98.47.137.113])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a0002a700b004f357e3e42fsm4936341pfs.36.2022.03.03.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 23:57:53 -0800 (PST)
Date:   Thu, 3 Mar 2022 23:57:50 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        John Wang <wangzq.jn@gmail.com>, linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] spi: spi-mem: Add driver for Aspeed SMC
 controllers
Message-ID: <YiHGfh/4xZRim6Ka@taoren-fedora-PC23YAB4>
References: <20220302173114.927476-1-clg@kaod.org>
 <CACPK8Xdo=krCNVVs5=jiSnmyiPkNPd9Dxxyx0Tv8eUHKR5J3cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACPK8Xdo=krCNVVs5=jiSnmyiPkNPd9Dxxyx0Tv8eUHKR5J3cQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:01:20AM +0000, Joel Stanley wrote:
> On Wed, 2 Mar 2022 at 17:31, Cédric Le Goater <clg@kaod.org> wrote:
> >
> > Hi,
> >
> > This series adds a new SPI driver using the spi-mem interface for the
> > Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> > SoCs.
> >
> >  * AST2600 Firmware SPI Memory Controller (FMC)
> >  * AST2600 SPI Flash Controller (SPI1 and SPI2)
> 
> I've performed read and write tests on the 2600 controllers, and the
> driver seems stable at the settings you have in the device tree.
> 
> Tested-by: Joel Stanley <joel@jms.id.au>
> 
> I've added Tao and John to cc as they have tested the 2400 and 2500,
> and I'm sure will be able to provide some Tested-by.
> 
> Cheers,
> 
> Joel

I've tested the patch series on ast2400 (wedge100) and ast2500 (cmm) by
reading/writing FMC flash0 and flash1 for several times, and no issues
observed so far.

Tested-by: Tao Ren <rentao.bupt@gmail.com>


Cheers,

Tao
