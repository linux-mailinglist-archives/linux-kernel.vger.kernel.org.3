Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F8487EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiAGWW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jan 2022 17:22:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28093 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231148AbiAGWWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:22:25 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-251-JoaqXrwHMNK52GUaJf95PQ-1; Fri, 07 Jan 2022 22:22:22 +0000
X-MC-Unique: JoaqXrwHMNK52GUaJf95PQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 7 Jan 2022 22:22:21 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 7 Jan 2022 22:22:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pintu Kumar' <quic_pintu@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>,
        "pintu.ping@gmail.com" <pintu.ping@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
CC:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: RE: [PATCH v2] sysinfo: include availram field in sysinfo struct
Thread-Topic: [PATCH v2] sysinfo: include availram field in sysinfo struct
Thread-Index: AQHYA/GqnIwLmHPdn0+moS7Mf5DX3axYIclA
Date:   Fri, 7 Jan 2022 22:22:21 +0000
Message-ID: <19cce51e24584c2a8090b618c580a0bd@AcuMS.aculab.com>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
In-Reply-To: <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
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

From: Pintu Kumar
> Sent: 07 January 2022 18:08
> 
> The sysinfo member does not have any "available ram" field and
> the bufferram field is not much helpful either, to get a rough
> estimate of available ram needed for allocation.
> 
> One needs to parse MemAvailable field separately from /proc/meminfo
> to get this info instead of directly getting if from sysinfo itself.
> 
> Thus, this patch introduce a new field as availram in sysinfo
> so that all the info total/free/available can be retrieved from
> one place itself.
> 
...
> diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> index 435d5c2..fe84c6a 100644
> --- a/include/uapi/linux/sysinfo.h
> +++ b/include/uapi/linux/sysinfo.h
> @@ -19,7 +19,8 @@ struct sysinfo {
>  	__kernel_ulong_t totalhigh;	/* Total high memory size */
>  	__kernel_ulong_t freehigh;	/* Available high memory size */
>  	__u32 mem_unit;			/* Memory unit size in bytes */
> -	char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */

There are 4 pad bytes here on most 64bit architectures.

> +	__kernel_ulong_t availram;	/* Memory available for allocation */
> +	char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
>  };

You've not compile-time tested the size of the structure.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

