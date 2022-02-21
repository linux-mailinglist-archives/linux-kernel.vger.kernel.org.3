Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7364BE071
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356139AbiBULTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:19:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355975AbiBULSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:18:07 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9794E17045;
        Mon, 21 Feb 2022 02:59:50 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4K2K7m3q2Rz9sS0;
        Mon, 21 Feb 2022 11:59:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645441185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ts3xO7iS9U9SfAeEWkQWjBNYwpbAjQ3wgCVSJcLfnhQ=;
        b=HSmc6rvwGLpQ4EZI3D9DVz4jcziDhHphq7t7akXMXy4smHhyuNEEx+brdHvcx2MlptDWl+
        a63wJ16hqlnnfg0EYqiCidaFEECvZ0RDVRGRXe81hvNe4aagXHwUUCXWnpKfDqj5w+Clt0
        ZHLxiji++RYchOYzddkxYeT6AitdkFdaQhWuXvcvcgkqj/WpIQGytYn2RA2uqPpBpPnULh
        MJHX430LKadLGD0ditKPOGAwTxg8zfYZmjsrxe3ymKsSyrRwrz/ljTPSS8LC3fFPrDAXN5
        vsfrx0J3ZRBHV9h9KmFCTJn9tDoAPbyzs1EW38JicQPZtPaQh0PpDevwy1D+wQ==
Message-ID: <f76951929710e6f71e59c5ed10767a5f983db943.camel@sylv.io>
Subject: Re: [PATCH v1 1/1] hwmon: (pmbus) Add regulator supply into macro
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Mon, 21 Feb 2022 11:59:41 +0100
In-Reply-To: <abfcdd863bb0166a6828c5742bf651eb9409c31b.camel@sylv.io>
References: <cover.1645092563.git.sylv@sylv.io>
         <d3563864d03a3d3450cf00b3be05465dc506e161.1645092563.git.sylv@sylv.io>
         <15b95695-6fbc-1916-ff39-abf13e989fc4@roeck-us.net>
         <abfcdd863bb0166a6828c5742bf651eb9409c31b.camel@sylv.io>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 18:40 +0100, sylv wrote:
> On Thu, 2022-02-17 at 09:36 -0800, Guenter Roeck wrote:
> > On 2/17/22 02:23, Marcello Sylvester Bauer wrote:
> > > Add optional regulator supply into PWBUS_REGULATOR macro. This
> > > makes it
> > 
> > The code doesn't look optional to me. What exactly is optional ?
> 
> I mean, it is optional to add a supply. It should not cause errors if
> you don't. I should probably reword this, too.
> 
> > 
> > > possible to define a vin-supply in DT. Not defining a supply will
> > > only
> > > cause the following debug output:
> > > 
> > > ```
> > > Looking up vin-supply property in node [...] failed
> > > ```
> > > 
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > ---
> > >   drivers/hwmon/pmbus/pmbus.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/hwmon/pmbus/pmbus.h
> > > b/drivers/hwmon/pmbus/pmbus.h
> > > index e0aa8aa46d8c..38f049d68d32 100644
> > > --- a/drivers/hwmon/pmbus/pmbus.h
> > > +++ b/drivers/hwmon/pmbus/pmbus.h
> > > @@ -464,6 +464,7 @@ extern const struct regulator_ops
> > > pmbus_regulator_ops;
> > >   #define PMBUS_REGULATOR(_name, _id)                           \
> > >         [_id] = {                                               \
> > >                 .name = (_name # _id),                          \
> > > +               .supply_name = "vin",                           \
> > >                 .id = (_id),                                    \
> > >                 .of_match = of_match_ptr(_name # _id),          \
> > >                 .regulators_node = of_match_ptr("regulators"),  \
> > 
> > That seems to be quite far reaching. How does this affect / change
> > behavior
> > of existing systems which so far did not expect supply_name to be
> > set
> > ?
> > 
> > Guenter
> 


My goal is to make it optional to define a supply regulator so that it
is possible to regulate the incoming voltage regulator.
IIUIC, it is required to set a supply_name to tell the regulator core
which supply it should look up from DT. (see: of_get_regulator 
drivers/regulator/core.c:402)
This should not cause a change of behavior even if no supply is
defined. It would register a dummy regulator as supply instead.

Am I right, or did I misunderstanding something?

Thanks,
Marcello
