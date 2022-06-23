Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA1557D26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiFWNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiFWNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:38:12 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-oln040092072022.outbound.protection.outlook.com [40.92.72.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD9165B1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndYL7iWG1RCFBxjz2AQ1v4KQHGrNYxNtQ9ZuEwFTSi1y9d6mGmzUvPMgP9wOJSjscNiOi9DHCRUwHmJS+dG1GbkSUkr3ouYaDTLLi6t7p3AO7I8cgnIl/cumaHQrH+y4rA1y8WTYVNlq+roqRr2I0F18Suz1krk0zWgVh0anbhuLw9MLWV4n7iyfr6jsfUXHxHDH+DG0Ad6eSqG6mXL2v14tIvm4keqJgJ55682PpltHLklwYfb/Y3/NKqoH1WLVu4VwVv+WsA9wOaXRjUGNbkUV1j/TvRcUJx1oZXi+rOGSXlm1IiR7YwwLh0vjjaOVZpOyuZeEE3WgylO7ztgs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhMSzeAoC6skMxY3VE7Tlkd8j2dOzGLj51iZAXc4wZI=;
 b=Vl9rYqXfaB72LsGc2d+mtWVrnUBfrsLM5IIx8bFxmCmqEKL1ZORFgSsYbrgrv5V6Bdt0aokhI7RHm6PAU8eDDfLwLSvQyOo1NKqhvIvqs8YkRD1N/TQWHIYDulIiSmXmk+5kHdnP2Ejz/tbU7YPgwh0sbYuWG6Odo0eqr9MelJjs7fsRvzDUI7dy49va5WtNND08fFTI7Jb71J89F8x7blelhhxBSHnYEokbHU7GHN3Xew1LHtehOOtwsi8WSD2ch8B0pA1dm3wT26vhO17vwvWzsdX8sauKdwllAQl3YNmLM4XSKzWKYA0mHyBolNlRt9T34SVAFz7kfH1GrJs8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhMSzeAoC6skMxY3VE7Tlkd8j2dOzGLj51iZAXc4wZI=;
 b=h7Ort5TnpHI2rsBp+zS2NIltMnkCbIaDg7CuLtIqBxnUDq8gnW1+daLWt8hVvXUtMDuXjjirhHe4WTlWSU3L5eLvtC+DPX3ImplbbXrCvomoLDK8yr0UbnC8IGmGcx6ZJk3nvYVptJr+ccgTObPGW9SbAHFFSaX9bvM9apx06gjs4EGnf1cKKOJil8pHS8GSbr6/JdXU361J6NG2f55lP8/VGLVkK2sfYcWkZNNKQW3NreUUQaR9JaHmlPiZgpuwf/4keiJKwvfrBYvqgpl7idIg3p1djgjp87K71KrbJ2YwYSsUgHMD6xcQbs2Qj+hxm30CQBzCttSVAKRPXkSvXw==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by PAXP190MB1629.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 13:38:09 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 13:38:09 +0000
Date:   Thu, 23 Jun 2022 15:38:08 +0200
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Staging: rtl8192e: Safer allocation and cleaner
 error handling
Message-ID: <AM9P190MB129937326B2EB843F0DBDF28A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB1299A41E3A9B2F9C0916A260A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
 <YrREqyGC01YIB86o@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrREqyGC01YIB86o@kroah.com>
X-TMN:  [f9zLp/7TuVofL7EsK7OQgoO4/t38h3ew]
X-ClientProxiedBy: AM6P194CA0010.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::23) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <20220623133808.qkxr5swkfc5updqz@fermi>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332bd47e-f2d5-44ed-e2e5-08da551d9cb2
X-MS-TrafficTypeDiagnostic: PAXP190MB1629:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGLHZ3SAuRiPAOC8nDtcv+O3Cf+dWhfrTKNBdraqb/MB0yXv8zrOB+nGuE7BquOKJebqiUr0Nq5sMuN2YMb9xkhDvCuIgbryRUJ6bbMjSXXl2M4zqKGSTlSNxPblfBmFwQ8Ch2XpsOH7dNygYj6pnM3Z642Fq42UEZcb8QEaiknGCHY6ofCil70H0OZg3cYOh/37fElgXKN/JnxutepYjWhOOVOzYkoPXg1ctaZoOPlsckhhkZJvLv+Wtdmn4vPIPr9uBESmH5Qi99NOIrJXxkguGMhbrr/Esb89xlmyPfBWgkEddyjz+cS4xVo90baNr1+pbiL8pDyf1RS+PtqMLWuM9g/GJo9dHVYsSZn2+Js4IgbKQvMS/1I+Sg+uqz3tvJDZrVrGEKgaB4s35xB6HLDNQwMJtLgZT2AUXkz3dizGV10HpnFibdl4bE6Iy+J7XbnEbq4dWeg1sDjBKwwgp5pyn8B8Oc5gTDvlzAsYrZPddXBflTOp8Aouju+vPWWBozD2YJ9TeR1qrDJJK4cwoPwsFFBOe3wIe7rBIifwu9agXiOaZGUs6Ann7ayA/NcYzpvzbF+QJFD2QlDZnjMGExC/eiBFyujBJVkJ4jGO4Xig15T5grZvbAc/JsRz8YgPqSNz3rjhWp6wmX0vy4Z7Iw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qis5RzR0akpIRUd2c0FpNWFpWWNEamoxenk4MjVVeTZRS0YxandnTFRJNDR6?=
 =?utf-8?B?bjIyK2MrTXdFeThRVUtjWVVaRVRzNlZ4Z1BCa0xZT2hDUm5HTW9EcnhaVU10?=
 =?utf-8?B?cG5iVW43d0JORWJYc1cxV29qemNIRTdrenBKR0l4MjV2cTJ4L04xL3dvS25v?=
 =?utf-8?B?K2lPbkVSZkpUdEJHcmY1ZEpXRGVwY2VTc1pSUUR0bkZXL0haQk5tdWhJQUJR?=
 =?utf-8?B?ZDZTM2NtMjNRS2ttZVpWZ3UrNjNqY3ZRZnF3VlhwOGlwTCtsUEhnc0R1Uzdi?=
 =?utf-8?B?cW9ibS9GZUVYQ0Y5QXhSSjRhMEV4SUxKNU02MGpBN2lmSUtIVjhueStmNWEx?=
 =?utf-8?B?bTVyWTVkTjg1djg1WmluaWFVWVZnUnNnY3l3bWtJY1ovQ1E1RWJGcWNudmhn?=
 =?utf-8?B?alFUN3JJenIxa04rbjd3dW1YZFAyendTVFZZS211N3FwcGkya2dXaVlkSXli?=
 =?utf-8?B?S2JmemJnanhuU3MybFdtNkIyNW05VkJsME13U1lCaS9JYjlGdEViaWw2Wllq?=
 =?utf-8?B?eTdMbHlNTFpYK21LSGpZc010azdhTDBMY0xxbEtSS2EwbHQxekRiOEVBZnF3?=
 =?utf-8?B?bXlVdWQ2ZWo4ZXJocXVrTUErZ0YxVm9FR1EyakxsUzhDQkIxUHdIYnBrc2ls?=
 =?utf-8?B?UVpQR1BibmRhZGZheXA2bEhrcEViTEdPTEcxSy96WnBkczBNb3pSR1RUVHNC?=
 =?utf-8?B?d2Q3eE1MVlRHeThKNVBLdEJDMjA5S3Z5RjR1ci9ZbjVxbmxzRDhUNnhVWHp1?=
 =?utf-8?B?VTRYWnhxZnk2UVR5MHMwT2JoemhCNk9vQUlNQmFjck5qeGY5Mk1xcHVyTGlT?=
 =?utf-8?B?R1BESkJGb3NpUEg1U0ViZXI2MjJRSEREcnh4RlZkN1poRDlGNStSM0xJYXA3?=
 =?utf-8?B?RkthZHRIeTVLZnJVWlNBUE1QYmZBVWpwTEUreEZWaHhPT1I5L2NEMkJYZzB5?=
 =?utf-8?B?Wm9nM2hIU21XZjFoNis0dXMzZkRleWNaTVZPbU9pWnhKTE0wTDV2dHN0Mk9l?=
 =?utf-8?B?dTJ2eTRYa2F5QXBMMmNHaDRDY2svb2xWUlBLS090cGdHdXlTbmt6SjRCR1Mv?=
 =?utf-8?B?S1kva3BVZTBPQkFXVW0zQ3JNQUFQakV5VWk3TGx2cmNJUEJwWmJES0tvUnRC?=
 =?utf-8?B?c1ZuMFNTZ0JwdjZicmVUa054Z3ZHNWJXUDhtMTV4V0x5Y1BrU3d6dGtGT0pC?=
 =?utf-8?B?RkxaTmZZUlB0WGhRd01hcFBMcTQ2RUwyWjRIUmlLN1Zmc2hhL3hIZis0aEhk?=
 =?utf-8?B?RFRpR1pGUksxYm1MaVo3TWRPWlltR2h6VjB6Nm5pNXNNZGlnSUR4MUh1UEEx?=
 =?utf-8?B?UGdoSFUwRHd5SVkzbjVlenhmUFpoVFQrQlZtNXJwb1BSVTVtelhzdWVHVGY5?=
 =?utf-8?B?b3hqdjZ2eXRBRk5tMFlxTjdheVJsV25OL2o4UkJMWmdhN2hrQ3dMclc5Tmtm?=
 =?utf-8?B?ZUNJS0swQjIzUFJzc1dWUmpxcHR3VVp2LytHZ1BoNDhXWnlRQVdudXhOSUgz?=
 =?utf-8?B?bnltdHN6Vm1KT1VGc0VFQjlkMnMwVnhhVTBpc215MlZaRENOdXZ6ODFmNk5V?=
 =?utf-8?B?SGZrdDlUdS91bEYwM0xvZkRyKzBvWGdwTTFwL1pOb2JZSTdyY0Q3eEthT3NL?=
 =?utf-8?B?NGZ0Sk1ZOEo5VkJML1ZUWGhuV1V2OENFdm5tc2RxNDE2TkJ5MS91NTV3NUNY?=
 =?utf-8?B?MU1rYzFZN09GbE5mVldFekhrdk1DU2oraW91eGxSY0U3WkJweTNUMTZBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332bd47e-f2d5-44ed-e2e5-08da551d9cb2
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 13:38:09.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2022 12:47, Greg KH wrote:
> On Thu, Jun 23, 2022 at 12:05:54PM +0200, Felix Schlepper wrote:
> >
> > v2:
> >   - replaced kmalloc with kzalloc against memory initialization defects,
> >     thus also removing a memset
> >   - made error handling more consistent
> >
> > v3:
> >   - Split into smaller commits so that it's easier to review
> >
> > v4:
> >   - clearer commit messages
> >   - added missing kfree
> >
> > Felix Schlepper (3):
> >   Staging: rtl8192e: Use struct_size
> >   Staging: rtl8192e: Using kzalloc and delete memset
> >   Staging: rtl8192e: Cleaning up error handling
> >
> >  drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> >
> > --
> > 2.36.1
> >
>
> Why is this not properly threaded with the patches itself?  Please
> resend so that our tools will pick them all up correctly.
>
> thanks,
>
> greg k-h
I am trying... I thought I figured it out with the help of kernelnewbies
irc, but I resend and it is still not threaded properly.
I tried to reply to the message-id with the patchseries,which worked
locally, but I am just
causing a mess on the mailing list at this point. Will try to figure
this out properly.

Cheers
Felix Schlepper
