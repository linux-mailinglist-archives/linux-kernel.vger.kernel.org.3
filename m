Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755A04714DC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhLKRKT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Dec 2021 12:10:19 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22123 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231455AbhLKRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:10:17 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-247-eq8bvMF0MteGtsIhqlpYbw-1; Sat, 11 Dec 2021 17:10:15 +0000
X-MC-Unique: eq8bvMF0MteGtsIhqlpYbw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sat, 11 Dec 2021 17:10:14 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sat, 11 Dec 2021 17:10:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnaldo Carvalho de Melo' <acme@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
CC:     "irogers@google.com" <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Fabian Hemmer" <copy@copy.sh>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Unbuffered output when pipe/tee to a file
Thread-Topic: [PATCH v2] Unbuffered output when pipe/tee to a file
Thread-Index: AQHX7S22lFcMQTUX3UOhS5fSvE+CQawtiIpg
Date:   Sat, 11 Dec 2021 17:10:13 +0000
Message-ID: <8edd3fd7b40745b6bf96cbb6438fcc65@AcuMS.aculab.com>
References: <20211119061409.78004-1-sohaib.amhmd@gmail.com>
 <YbJQAp6/gz4kHdi8@kernel.org>
In-Reply-To: <YbJQAp6/gz4kHdi8@kernel.org>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo
> Sent: 09 December 2021 18:51
...
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 8cb5a1c3489e..d92ae4efd2e6 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -606,6 +606,9 @@ int cmd_test(int argc, const char **argv)
> >          if (ret < 0)
> >                  return ret;
> >
> > +	/* Unbuffered output */
> > +	setvbuf(stdout, NULL, _IONBF, 0);
> > +

You only want _IOLBF (line buffered).

Otherwise you are likely to get a lot of write() system calls.
Even multiple ones from the same printf().

Although it can be better just to ensure there is a fflush(stdout)
inside the loop.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

