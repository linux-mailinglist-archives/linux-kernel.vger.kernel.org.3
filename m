Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9B52ED97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350033AbiETNzn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 May 2022 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiETNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:55:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E77F5EDC2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:55:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-mSqs0xGWPE6wZaF1FGSg6A-1; Fri, 20 May 2022 14:55:35 +0100
X-MC-Unique: mSqs0xGWPE6wZaF1FGSg6A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 20 May 2022 14:55:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 20 May 2022 14:55:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Hunter' <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] libperf: Add preadn()
Thread-Topic: [PATCH 2/5] libperf: Add preadn()
Thread-Index: AQHYbEz0Y2PvIJt5EUyDSqCKvEJ6Ya0nyBWw
Date:   Fri, 20 May 2022 13:55:35 +0000
Message-ID: <de58fd1514d5477aaf144234aa096ab1@AcuMS.aculab.com>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
 <20220520132404.25853-3-adrian.hunter@intel.com>
In-Reply-To: <20220520132404.25853-3-adrian.hunter@intel.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter
> Sent: 20 May 2022 14:24
> 
> Add preadn() to provide pread() and readn() semantics.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/include/internal/lib.h |  2 ++
>  tools/lib/perf/lib.c                  | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/tools/lib/perf/include/internal/lib.h b/tools/lib/perf/include/internal/lib.h
> index 5175d491b2d4..85471a4b900f 100644
> --- a/tools/lib/perf/include/internal/lib.h
> +++ b/tools/lib/perf/include/internal/lib.h
> @@ -9,4 +9,6 @@ extern unsigned int page_size;
>  ssize_t readn(int fd, void *buf, size_t n);
>  ssize_t writen(int fd, const void *buf, size_t n);
> 
> +ssize_t preadn(int fd, void *buf, size_t n, off_t offs);
> +
>  #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
> diff --git a/tools/lib/perf/lib.c b/tools/lib/perf/lib.c
> index 18658931fc71..ecc8035a3ae3 100644
> --- a/tools/lib/perf/lib.c
> +++ b/tools/lib/perf/lib.c
> @@ -38,6 +38,26 @@ ssize_t readn(int fd, void *buf, size_t n)
>  	return ion(true, fd, buf, n);
>  }
> 
> +ssize_t preadn(int fd, void *buf, size_t n, off_t offs)
> +{
> +	ssize_t ret;
> +	off_t cur;
> +
> +	cur = lseek(fd, 0, SEEK_CUR);
> +	if (cur < 0)
> +		return -1;
> +
> +	if (lseek(fd, offs, SEEK_SET) < 0)
> +		return -1;
> +
> +	ret = readn(fd, buf, n);
> +
> +	if (lseek(fd, cur, SEEK_CUR) < 0)
> +		return -1;
> +
> +	return ret;
> +}

Please don't ever write that code, not ever.
It isn't an implementation of pread().

Oh, and shoot whoever put in into (IIRC) uclibc.

pread() needs to use the syscall, you cannot implement
it in userspace.

It is better to have the function missing that that version.

There is a similar problem with clock_nanosleep() and TIMER_ABSTIME
in glibc - completely broken emulation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

