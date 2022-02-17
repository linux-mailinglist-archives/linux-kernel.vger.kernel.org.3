Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC04BA755
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbiBQRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243813AbiBQRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:41:11 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF402B3ACC;
        Thu, 17 Feb 2022 09:40:56 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4K02DQ0K4Wz9sWF;
        Thu, 17 Feb 2022 18:40:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645119651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QH+uxp2J6kpD1HokNKgqcYwu1J2p2T1tcY6BL3c2JJI=;
        b=tWMx6MoaUZD0xNqqttpCvHypOW3bPemVIgFcEg9b+EF1Dcu00QWebmZnU0ptkv1EVYs4X2
        SPgZS4F+pEDYw6xQ7TYgyS7BIcafyGYESYfN6xKhbxeg4+nwl3ti+Qqdnj9kD3Wxyd1OIm
        PiE5jGDzflOumX0npgI8HmjcBvUjc3Gu9r/9uCBs5sHeD+elncay5UvO1ruEhEIpL100py
        7Gp6s11xuBr2kgoeOyxshRBhydENqvvBbVKAXrrXz+m5tilWZ2nI/+D+xOs0YHSxsdmPz8
        Zzg4Vj/Gen8Z6q5/K4QpnRH6fAN9pN8byy/2xKJAEidbJ8L9iYzzRBv00Zwekg==
Message-ID: <abfcdd863bb0166a6828c5742bf651eb9409c31b.camel@sylv.io>
Subject: Re: [PATCH v1 1/1] hwmon: (pmbus) Add regulator supply into macro
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Thu, 17 Feb 2022 18:40:47 +0100
In-Reply-To: <15b95695-6fbc-1916-ff39-abf13e989fc4@roeck-us.net>
References: <cover.1645092563.git.sylv@sylv.io>
         <d3563864d03a3d3450cf00b3be05465dc506e161.1645092563.git.sylv@sylv.io>
         <15b95695-6fbc-1916-ff39-abf13e989fc4@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 09:36 -0800, Guenter Roeck wrote:
> On 2/17/22 02:23, Marcello Sylvester Bauer wrote:
> > Add optional regulator supply into PWBUS_REGULATOR macro. This
> > makes it
> 
> The code doesn't look optional to me. What exactly is optional ?

I mean, it is optional to add a supply. It should not cause errors if
you don't. I should probably reword this, too.

> 
> > possible to define a vin-supply in DT. Not defining a supply will
> > only
> > cause the following debug output:
> > 
> > ```
> > Looking up vin-supply property in node [...] failed
> > ```
> > 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >   drivers/hwmon/pmbus/pmbus.h | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hwmon/pmbus/pmbus.h
> > b/drivers/hwmon/pmbus/pmbus.h
> > index e0aa8aa46d8c..38f049d68d32 100644
> > --- a/drivers/hwmon/pmbus/pmbus.h
> > +++ b/drivers/hwmon/pmbus/pmbus.h
> > @@ -464,6 +464,7 @@ extern const struct regulator_ops
> > pmbus_regulator_ops;
> >   #define PMBUS_REGULATOR(_name, _id)                           \
> >         [_id] = {                                               \
> >                 .name = (_name # _id),                          \
> > +               .supply_name = "vin",                           \
> >                 .id = (_id),                                    \
> >                 .of_match = of_match_ptr(_name # _id),          \
> >                 .regulators_node = of_match_ptr("regulators"),  \
> 
> That seems to be quite far reaching. How does this affect / change
> behavior
> of existing systems which so far did not expect supply_name to be set
> ?
> 
> Guenter

