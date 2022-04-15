Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D8502E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbiDOR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbiDOR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9C2DA8A;
        Fri, 15 Apr 2022 10:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE78F6230A;
        Fri, 15 Apr 2022 17:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC5C385A4;
        Fri, 15 Apr 2022 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650045365;
        bh=T2xdRfkWG7nNM/RZqU/ytJtED300+Bj/aG4zjzKjp9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZH+OdZtuE3tmQdhMbm8jS+TzG2OjOf0Cdx5nUetecJAZqkcx7r69WXw/1a76uZXB8
         PThcRlIRIQfXM16pRROtFRehyzpxZ3K3/n5LmmXvdSVVKLB/djuFuNVZK/KXuT+rXO
         vLj7dw+jV3E/Ncm2fRaCk42RAIpWNGisHLtCaOotpzotT20iCt3QT7JruqY7zeeukF
         FNe2H1Vjse6kCj1YO4QN7CoFcFa0XmtFv7/Yws6qHKwjRZ8bLU0/Pu37eIrDkc4d5F
         WAL8+kI516kmPERSnxVaxilJqYlTwyPGTYEq9IIYTijgBIDyn3+0LHPlnU/GdZ4yDS
         Q+6E5m4bMemVw==
Date:   Fri, 15 Apr 2022 19:04:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 1/3] iio: imu: adis16480: Make use of device
 properties
Message-ID: <20220415190403.220b135d@jic23-huawei>
In-Reply-To: <YlcBTfVdtp7nUhjR@smile.fi.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
        <PH0PR03MB67867FD2A0043F5331D1C5E399EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
        <YlcBTfVdtp7nUhjR@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 19:58:53 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Apr 13, 2022 at 03:25:49PM +0000, Sa, Nuno wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Wednesday, April 13, 2022 4:41 PM =20
>=20
> ...
>=20
> > You beat me to do this. I actually had planned to do this next week
> > once I saw we already have fwnode_irq_get_byname(). Anyways...
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > (I will still give this a test next week) =20
>=20
> Thanks!
>=20
I'll wait to apply it until you confirm all was good (mind you I haven't
read it yet :)

Thanks,

Jonathan
