Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF94450DC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiDYJPB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241575AbiDYJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:13:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA709CABA1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:10:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-247-8RX-Qv7WN3KH32ORjUBsfg-1; Mon, 25 Apr 2022 10:10:23 +0100
X-MC-Unique: 8RX-Qv7WN3KH32ORjUBsfg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 25 Apr 2022 10:10:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 25 Apr 2022 10:10:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guenter Roeck' <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>
CC:     "linux-fsi@lists.ozlabs.org" <linux-fsi@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "jk@ozlabs.org" <jk@ozlabs.org>,
        "alistair@popple.id.au" <alistair@popple.id.au>
Subject: RE: [PATCH 2/2] hwmon (occ): Retry for checksum failure
Thread-Topic: [PATCH 2/2] hwmon (occ): Retry for checksum failure
Thread-Index: AQHYV/9Rz6RE0zB8xEyMzjBr24t9/60AVjug
Date:   Mon, 25 Apr 2022 09:10:22 +0000
Message-ID: <44d4f10249064a28b6cc461e7cbdd402@AcuMS.aculab.com>
References: <20220321153112.12199-1-eajames@linux.ibm.com>
 <20220321153112.12199-3-eajames@linux.ibm.com>
 <20220424171816.GA749761@roeck-us.net>
In-Reply-To: <20220424171816.GA749761@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck
> Sent: 24 April 2022 18:18
> 
> On Mon, Mar 21, 2022 at 10:31:12AM -0500, Eddie James wrote:
> > Due to the OCC communication design with a shared SRAM area,
> > checkum errors are expected due to corrupted buffer from OCC
> > communications with other system components. Therefore, retry
> > the command twice in the event of a checksum failure.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> I assume this will be applied together with patch 1 of the series.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter
> 
> > ---
> >  drivers/hwmon/occ/p9_sbe.c | 28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> > index 49b13cc01073..7f4c3f979c54 100644
> > --- a/drivers/hwmon/occ/p9_sbe.c
> > +++ b/drivers/hwmon/occ/p9_sbe.c
> > @@ -84,17 +84,25 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
> >  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
> >  	size_t resp_len = sizeof(*resp);
> >  	int rc;
> > -
> > -	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> > -	if (rc < 0) {
> > -		if (resp_len) {
> > -			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
> > -				sysfs_notify(&occ->bus_dev->kobj, NULL,
> > -					     bin_attr_ffdc.attr.name);
> > +	int tries = 0;
> > +
> > +	do {

Why not use a for() loop?

> > +		rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
> > +		if (rc < 0) {
> > +			if (resp_len) {
> > +				if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
> > +					sysfs_notify(&occ->bus_dev->kobj, NULL,
> > +						     bin_attr_ffdc.attr.name);
> > +
> > +				return rc;
> > +			} else if (rc != -EBADE) {
> > +				return rc;
> > +			}

No need for else after return.

> > +			/* retry twice for checksum failures */
> > +		} else {
> > +			break;

I'd break on the success path after testing (rc >= 0).
Saves a level of indent.

> >  		}
> > -
> > -		return rc;
> > -	}
> > +	} while (++tries < 3);
> >
> >  	switch (resp->return_status) {
> >  	case OCC_RESP_CMD_IN_PRG:

Probably end up with something like:
	for (tries = 0; tries < 3; tries++) {
		rc = ...;
		if (rc >= 0)
			break;
		if (resp_len) {
			...
			return rc;
		}
		if (rc != -EBADE)
			return rc;
	}

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

