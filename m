Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC75A7AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiHaKGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Aug 2022 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiHaKGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:06:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE55CCE2D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:06:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-zfC0P82QOX2JlKwNgIUxvw-1; Wed, 31 Aug 2022 11:06:12 +0100
X-MC-Unique: zfC0P82QOX2JlKwNgIUxvw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 31 Aug
 2022 11:06:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 31 Aug 2022 11:06:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mika Westerberg' <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: RE: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Thread-Topic: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Thread-Index: AQHYvR7hhZ9AKc/e/kub1hx9cJ7M7a3Ix7VQ
Date:   Wed, 31 Aug 2022 10:06:09 +0000
Message-ID: <bce5d03cd5ea4aa78ed679399dde0759@AcuMS.aculab.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
 <Yw71GqF5x7u16yom@black.fi.intel.com> <Yw8rPW39Vif4yVAf@smile.fi.intel.com>
 <8989df1c-8fa7-be27-c2f0-e528604e474a@redhat.com>
 <Yw8uiAv95LbBh2FD@black.fi.intel.com>
In-Reply-To: <Yw8uiAv95LbBh2FD@black.fi.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg
> Sent: 31 August 2022 10:49
> 
> On Wed, Aug 31, 2022 at 11:37:21AM +0200, Hans de Goede wrote:
> > Hi,
> >
> > On 8/31/22 11:34, Andy Shevchenko wrote:
> > > On Wed, Aug 31, 2022 at 08:43:54AM +0300, Mika Westerberg wrote:
> > >> On Tue, Aug 30, 2022 at 08:11:54PM +0300, Andy Shevchenko wrote:
> > >>> -#define VR_MODE_DISABLED        0
> > >>> -#define VR_MODE_AUTO            BIT(0)
> > >>> -#define VR_MODE_NORMAL          BIT(1)
> > >>> -#define VR_MODE_SWITCH          BIT(2)
> > >>> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> > >>> +#define PMIC_REG_MASK		GENMASK(11, 0)
> > >>> +
> > >>> +#define VR_MODE_DISABLED        (0 << 0)
> > >>> +#define VR_MODE_AUTO            (1 << 0)
> > >>> +#define VR_MODE_NORMAL          (2 << 0)
> > >>> +#define VR_MODE_ECO             (3 << 0)
> > >>> +#define VR_MODE_SWITCH          (4 << 0)
> > >>
> > >> IMHO this one is worse than what it was.
> > >
> > > I'm not sure why. Here is obvious wrong use of BIT() macro against
> > > plain numbers. I can split it into a separate change with an explanation
> > > of why it's better. But I think it doesn't worth the churn.
> >
> > FWIW I'm with Andy here, the VR_MODE_ECO clearly is trying
> > to just say 3, so this is just a plain enum for values 0-4 and
> > as such should not use the BIT macros.
> 
> Yeah, enum would look better but the << 0 just makes me confused ;-)

No idea what that code is doing.
The values are all used to initialise a .bit structure member.
So maybe BIT() is right.
The _ECO value isn't used at all.

Deeper analysis may be needed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

