Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD1E55FF48
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiF2MLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiF2ML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:11:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2039.outbound.protection.outlook.com [40.92.58.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C71039146
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmgTP9jbnUBW5hI9zWpPRBHlsdF8UThcZGEG01KVSVbCWOo/MZjpsCk8XsCveRZN8VOjsuAuY6oPC2fO/ulIdrH9hg9o4TXy57FWqRk0LAh4U6LfVFdmmbuxERwqDA37O2mfoCasYsva1ki+uneIwxLSZqJa0JN9Ig9G0nYR1m6hF71P3fqcXLe9EJa/0DVpKWW2JOTOdeW3pq0GyMJtWm9eGF9cgqwWRo6BLEReWKmqeDfQlckJPBU9J7upSv/e1RSA2WyrIU/9DgY2hle6W+oCKt/VVySuH6sjTi83HfKIwrWtYA+SPRN5Trys4BhSAufxID8WbBsBcCwk+f8Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjBrmBhif8PeieNOT0j8tZDy8B8+uOsteXcFBgb4V4Q=;
 b=ZJDOQTA+r40oJl9Xf0r9UJnJVuWwWEifdH/JGY99jkadelxRA4EtcYNfYN+lC7JdcRa3BH4ouBher0H2TIuEf+Gy0cYep+vSkXhjT/10NBo4gvY6IZzgu2RDmdvl9773aEN7Ddi5pJlsq9gligjKOpQmaviM5yfslURr1YJZrEkWQXKl5F/T4VrvYaSHJt7aWkwUUs2ja3Z/D/5ktQkGiBZZ99nm+Tnbiqh0SiTBCXFwnrwgr4g3ZnKgqFYPw8lTNfbyEkpKm2yNX4hQl+AvSOXWj9j7DHyHuT4dh+1WtgKRwWq0BEI2EQmTidp/SJgpZj4GprCg2X2/PFa4Uripjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjBrmBhif8PeieNOT0j8tZDy8B8+uOsteXcFBgb4V4Q=;
 b=qWbidg2iY8uC9aGDgfi8UkltvpnTwIGYjUP2o4kl5Xn1Bcgaowv6CT3HX6bRV4ec6tuqyK+hyybdeGOjkcJ2DuVkhVlE6br4nwpzDiHdikMUnt2C1uuyhDyOE49bL8NnP8ql+M3KMbG211zUoHB6xWHSOdOaT2clOv1dnneIz9kJbVUxG8hTom8ZZV6aHFLUnSui+SNdYIaDJFE5Y8VMbF594Hm9tr9w17goObLjhQIGMn2pbPPSorLICvgnAs07ONiY/TcWO8IYLRrHELrDqIgU7bTx2SWKURYfPhcZASuvBc73hmb4nlzT5ed/u86BVRbV9N1eRurn2H8r7jtFbg==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM9P190MB1394.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 12:11:26 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 12:11:26 +0000
Date:   Wed, 29 Jun 2022 14:11:24 +0200
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, wjsota@gmail.com
Subject: Re: [PATCH 1/7] Staging: rtl8192e: Added blank lines before/after
 struct
Message-ID: <AM9P190MB129916C683B7D8B241EF85D0A5BB9@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <cover.1656402464.git.f3sch.git@outlook.com>
 <f23e5ad2839c238665956f0d552cacd9944b724d.1656402464.git.f3sch.git@outlook.com>
 <f110442f5cceb0161f32c2b942ef7be6f5c5a63c.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f110442f5cceb0161f32c2b942ef7be6f5c5a63c.camel@perches.com>
X-TMN:  [5kcXshQ2gwmOXrv1GADTEhG5++8ldlGT]
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <20220629121124.esmwt6cvppivq6pp@fermi>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498578a5-01fe-49cb-c9c0-08da59c87d85
X-MS-TrafficTypeDiagnostic: AM9P190MB1394:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0g72dUgNvkdmMttsXIOj4jb3PLgI/wVsFopwvF1OYJTeeThlK9EvTvYgGjm6Fvj9ELk/BtfjztQs6TJpbxH/MpYuTpqMGbIipC9cjDSRR+YI7bFTqh+jz+VyPC3YKSJ+scUq+yiwRqPpsNsCFEgRqH44yav4tsL0i01B4tKWtUEbecpNYBT9ZV9kD3AmLZ7hiFbXBLYonStt+VM3rb9gFA4riNVQBpbfwnLS646OHrUp4U/Z9ndVtxcNQDf8RAPDSc5OqXQtSI9xrhNa/r219atw5hd5jN53cWNs6N+iOge8raEh/iHnjV0aNJr4o1d0MkDTNWnARAtmsKRTmHzFadFtOj4vyvSjkV+TxN9UAr5MYADUX4NMcnDaeOz6SrKs6NJnyL5/IXO9ZM98l412VoVJARD9z26w81WT9AfzJPgB05bFRSy/EztEYRknEKuDr2g9VRSJX2RteDJTYTBFndPvIXTMEMk+dkVEkBkdUzUUh81i/7w8s8czAhlNgnqR5jmQGivF0o2+Vs1Vkl6mXs8bOMUJNvCGgRzrTBXXbQbf9zdsioecCEdyvsmqbUbugIKXfN9h//FVpb23VOpynIudz0X/GCd09m05YKpQYPobKxzM4eTClo8q2/D/tIvQouOGKoAoaC8pC1YOT5r/gg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTI1eHFTVHZnSjgwMjJOUHNKZVpJREJLNEtWU044S1FzNWhXOFdHbDViUENI?=
 =?utf-8?B?SEIzdCthY1czUnNLNEJMaFUyeDhvUDUwR2FDM0tjT1haZkJJOGVOQWpvbXdU?=
 =?utf-8?B?VFl0MWFZVHNRdXFUQitjTGk5d3FPZ3E1S2I0cUMyRFVHbURYeGo0K1MrYWNM?=
 =?utf-8?B?c05TeFpmeEJVaFVFV1dMWWl3ZHZGeW5jWXN0ajcvZkJqa1lxVjhtd01ldWRt?=
 =?utf-8?B?ZG8yekpIbUFRNm5vNno2Qlg1S2ZYaGdMdk1PbmlWY0xIWmZzWFVGNTJ3OWlJ?=
 =?utf-8?B?VXFMWm85b1E2UndUSVhuK2xtMkNWWU1peXNIZ0VzTEM5d0QxV25NaG9FclQ4?=
 =?utf-8?B?Z3kxaUIzSCtaVFNNaU1TTmNYTExtaHZEUzZGRjdEY1RiSU1MNFI2aC9oVTVC?=
 =?utf-8?B?azJ2WGhJdlk3QUdQMUZxV1ROMUdubmlJZHhFcS9MdlVRU2FVSnhzd1o3cXhQ?=
 =?utf-8?B?TWMrT3VOcWNGejNlaU9CUEkrSEI3RnJHeGlpWXlTQ3h1ZGM3UzVYOWJsbXhZ?=
 =?utf-8?B?TlhpWjgrNmNsbVZ3b2RRWkczblVKRWFPUnRDVGZXYkpvb3JUS1p2dkZTcHFU?=
 =?utf-8?B?U1o5bU1OcHNpcm1MQUN3ajZnazUxeTgwOHZQT01rVHhMOTg3d0thK2M5NWl6?=
 =?utf-8?B?VC9oeXhvM3Bob05DYWJmWHJ1ckVuNmR1OWZrYnlBWDc4TWV2cnM4eXBETnB0?=
 =?utf-8?B?SUZyVnJpdmZxU2M4K3Qxa3JDTklNVGlGQlRKaWNjNUFZVXVyaUUwWXNvb25U?=
 =?utf-8?B?dkxKVGYxZTFzbDBpdVRicFloVFYwMFRjcEp3TnFNUzJ1TVpFMFRYZHZSWlBY?=
 =?utf-8?B?cFRhM1BYbzJwWDdpTW82T2lpRGF2L2ZWTlU3ZXpvT3VqYk1wdmY2c2ZUamc4?=
 =?utf-8?B?VjVHRjNXVDgxUXh4THFsS3B1MzRXVDIwRHZnM0FLTXNRVWx0bzlKMGVqbEd4?=
 =?utf-8?B?VkI3VHpaZlBnZVRLczJPaWhBbUhlRjRnVXVlOHk0VjJJVis2SGo5SnpsU3c5?=
 =?utf-8?B?TU4xTU1PbVhaeUtjL20yRXNGbUJ4TXNXdzlYaXV6NGp2NVUvSWRlNlNQVHho?=
 =?utf-8?B?U0RCSHZWaW9CSWUwcVhNQVd4b1FJSDgxdFdUMmI1RlZQYUd2OVA4Uklrbk1r?=
 =?utf-8?B?a3pVN3paYjRMUFNqK1QvRGh2N0RQZjhvR3lxaTFrZG54SDNiMERVYzlXYU5I?=
 =?utf-8?B?b2g3bDV6K3ZOLzREWWZ2NnluMFRvSmprSFFsMG9WZjRHVjNvbjFKNnRweHE5?=
 =?utf-8?B?WDVRMEpUTVBKTnlBUndPT3dPSlZqd3hKOUxsRmQxMDhzTmQyZk0rUHZLR3Q3?=
 =?utf-8?B?Yml2NXNUWFIzNnFtR1NWZUx2dWcydG9jMC93a3NCUmlNTW1OMVJucmFGUnNT?=
 =?utf-8?B?NkJNZ1ZHUmtJcWpzOFphUTJQckVnUWg3bnN6MFhPOU5QMTlFNVErR2IyZTFJ?=
 =?utf-8?B?VUFvRWZybjk2em5wY1B1Y0JHQ0svNjBTR1dZWit4ZWsrWVBzb0M1dzR6cnZ5?=
 =?utf-8?B?ZmppWHJkUWcxU2dFWnpISGhUWXFjcmdCQWUwQkErWXJRUDVTd2h0amdlSU1p?=
 =?utf-8?B?UnRubCtKTTFINFNCbGFRV1ZxUUpFK0tuQUtFbUxhTVhTMGJjU2JaRnZNZUov?=
 =?utf-8?B?WDBxRlNSY0MrYlBLV09Hc2c0SEErOFo1NXVnK3hSVE1QLzhCSmRFTlBJdi9L?=
 =?utf-8?B?LzBvM2JlK25oWFYyd2E1ODZnRVpnc2NUa2JlenY2Z1Z3aVA5RU9GeTVnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498578a5-01fe-49cb-c9c0-08da59c87d85
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 12:11:26.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2022 10:58, Joe Perches wrote:
> On Tue, 2022-06-28 at 10:30 +0200, Felix Schlepper wrote:
> > This addresses an issue raised by checkpatch.pl:
> > 
> >      $ ./scripts/checkpatch.pl --terse -f drivers/staging/rtl8192e/rtllib_wx.c
> >      CHECK: Please use a blank line after function/struct/union/enum
> >      declarations
> > 
> > The additional blank line above the struct/before the headers is
> > just cleaner.
> []
> > diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> []
> > @@ -17,10 +17,12 @@
> >  #include <linux/module.h>
> >  #include <linux/etherdevice.h>
> >  #include "rtllib.h"
> > +
> >  struct modes_unit {
> >  	char *mode_string;
> >  	int mode_size;
> >  };
> > +
> >  static struct modes_unit rtllib_modes[] = {
> >  	{"a", 1},
> >  	{"b", 1},
> 
> Please always look deeper at the code and do not simply take
> any checkpatch suggestion as the "best" fix.
> 
> Using this struct style with an embedded length is error prone
> and would likely be better as a simple char * array.
> 
> Also, the existing sprintf use of mode_string and mode_size is
> nonsensical.  There is nothing to format in any of the mode_size.
> so the use of mode_size as an argument is silly.
First of all, thank you for your suggestions.
I did realize that there is nothing to format, but I did not dare to
make that change in case a format could be added.
However, looking at it now. This has not been touched in over 10 years.
So it is probably safe to change that.
>
> Perhaps something like this would be better:
> ---
>  drivers/staging/rtl8192e/rtllib_wx.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index cf9a240924f20..90dcce152d80c 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -17,17 +17,9 @@
>  #include <linux/module.h>
>  #include <linux/etherdevice.h>
>  #include "rtllib.h"
> -struct modes_unit {
> -	char *mode_string;
> -	int mode_size;
> -};
> -static struct modes_unit rtllib_modes[] = {
> -	{"a", 1},
> -	{"b", 1},
> -	{"g", 1},
> -	{"?", 1},
> -	{"N-24G", 5},
> -	{"N-5G", 4},
> +
> +static const char *rtllib_modes[] = {
> +	"a", "b", "g", "?", "N-24G", "N-5G",
>  };
>  
>  #define MAX_CUSTOM_LEN 64
> @@ -72,11 +64,8 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  	/* Add the protocol name */
>  	iwe.cmd = SIOCGIWNAME;
>  	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
> -		if (network->mode&(1<<i)) {
> -			sprintf(pname, rtllib_modes[i].mode_string,
> -				rtllib_modes[i].mode_size);
> -			pname += rtllib_modes[i].mode_size;
> -		}
> +		if (network->mode & BIT(i))
> +			pname = stpcpy(pname, rtllib_modes[i]);
>  	}
>  	*pname = '\0';
Would this not be also redundant since stpcpy already returns a pointer to the new
NUL-terminating character?
>  	snprintf(iwe.u.name, IFNAMSIZ, "IEEE802.11%s", proto_name);
>
Will resubmit later.

Cheers
Felix Schlepper
