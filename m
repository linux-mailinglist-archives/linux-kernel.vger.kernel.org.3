Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6159FC48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiHXNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238802AbiHXNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:53:50 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20084.outbound.protection.outlook.com [40.107.2.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CE6979D3;
        Wed, 24 Aug 2022 06:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqiskPdFZNY1IRnVgogXXdjiDoIRs5vS2qhg7W5Wnz6tN7M2/iqasu/jqK65MHe+PlrBCR1opK107Dzyv8CGoFz+EPMdPluWkQBAKpfZ5XHz+jBbR4ynj1xQ5W2/KX9i3w+Pr5ND82n5VLBGsOoH4X4OkYTeqyhu2odt3FdvYrl95pXI9gouh+IVxiopD7k0N0Ybqfwxn1xaleRVY4Q8QwdWTOKmwOvyJlW9gv8tqgsjTb7aeJ9nr3d3N9N0DkobJlF2OsOyxsMOg7bmylpNa/IuqfhwJgUJ5nqokHJzg0JRAgVWwttP03opuTEeVJaFqU/ytCyP68rsc+kJnnK11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad/eUbJg93oxIdNKxTQipRIQuz574bbBoEPIhLryg1A=;
 b=fVnd5gPS8T0mWIRAcfLbi1l7stYdYrsVoHa3xkClh1EFO9yZAqPWYwTBty20XoI0K7WuRRxoZ4QSJifTcFJLsNJtamKt/k9gUjnb3MYdjnSOct40uok8USLgK9NgFRoYMKi/1E1793aku6Wz4ljHWoT3UVuqHM5ZR3di0A2hVTrs0ehTI0LnMzSeV4CHhj9/zwovZCcVfPz9Axx3GKvWAF4qBpR5V/CYpTbtfF08SIpSV7lF5clbyhZaNCx4vSwtSzknpg+TATeziZRyXWEsDxcN6Hbtx0pWUrSFdQikYvR/zLuqcsmUy2J4Ft3Y3E93sCfXU4VOvSStz4b31qFTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad/eUbJg93oxIdNKxTQipRIQuz574bbBoEPIhLryg1A=;
 b=Ju8KSnZS9iQFbq5WKFolPk/6ov/nYM7whFD4FizwxYMsDKelQ+9FXHrZ7FBjdurkw744+3VlQ2rcuyGO7MhYqPSs02Du7J+2nRaD1X5BXIihga47LjuEEOlgKSrbLqKnMyJO2abXTXLSusU0v7g/S8cC3WrkkCNyoY5xUgbR65yyqSGRd05yhoOqPT+HIsowP+NVSEUZgqlKqhdbtZ4WZjVeApwlJFaaIJQSqi6hz+nbf/ZzLdiOCEKC+484HDXH+FwSHP84kmc5a8ODfHZBUXOUZurn761gXzhIcEQjfMPb9KXO+qnAGbrsxyVDZKFvtJ0fgJXs2/vOYeJxCd8NsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB4700.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Wed, 24 Aug
 2022 13:50:41 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 13:50:41 +0000
Date:   Wed, 24 Aug 2022 15:50:38 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     simon.guinot@sequanux.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220824155038.5aa19495@md1za8fc.ad001.siemens.net>
In-Reply-To: <YwYjXzsSHNe+J3aO@76cbfcf04d45>
References: <20220823102344.17624-1-henning.schild@siemens.com>
        <20220823102344.17624-2-henning.schild@siemens.com>
        <YwToilxquEZGqzQD@smile.fi.intel.com>
        <20220823165459.143e1c30@md1za8fc.ad001.siemens.net>
        <YwYjXzsSHNe+J3aO@76cbfcf04d45>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8374d61-c017-46de-45aa-08da85d7a213
X-MS-TrafficTypeDiagnostic: DB9PR10MB4700:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUFHnYZDz662IRnwPkPZePEtf1dOnnjNhjB+FHGXbs31GqrqeMsEFfl92X6iwsXymVLPEXNIu/kuKYqrtA/TVUvNaa+eL0YgKRqtxXRKmoXKIYNII20Rc54d7mqJ+SdxGNJIupa2pMzTmudOHg/WqHafe/vvql06TQN0dJFeFH1dN88NddNwHA8EQtFk3ce9SZyLRRc8kCg1mF9+bMj7T2MACtnltst2TUTwjngGfWE+ZUOq983WSWQjVFnaWTWSL1xFrS97HXNYZHz1t7VfgDUGo1CZGtj1p9HGlDja7RZQR2gBSWxPaJ/ZzizfjRBLmo1CvdHMc0rh2EvPSSUa7XD0GF9Yi1nbNGnFD1PtuJub8q5d17Gm1YpWsZZ5V0NsgMaRd0cDyoAqeXRcA/a0QC0ZdvJUT7v8cIcT/YuCyE1T3bgeliveQzFb7ENJIbqTxZXIv+WdOg1q0syPD2wf+924vlWV/xsKLkhs6gL0Hn3s4ynWNeP9CgUzmE4TQPY/8tV1No63Y+jdA1f8QoimkSMLXeZkscStRMhRS25eVPv5Ug4jpmvdNyFxXQAmffNDEQsxRpvm8n9UQ9XpbZGRiZ9C8Zba7sL3Xsz4R2f8dh8ch2x7LxcWhS7pc+Hv5d5dnYm3h5q6cz1YgqoMTvuSHXiyLp5wbmu0l2z3tZSuVOUvXI9lTSlS7ZYOCGNtc49cG1XPesqWoKLAQt9buBfgbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(6666004)(6506007)(9686003)(26005)(86362001)(82960400001)(41300700001)(1076003)(186003)(6486002)(478600001)(6512007)(4326008)(66946007)(316002)(54906003)(8676002)(66556008)(6916009)(66476007)(38100700002)(7416002)(5660300002)(8936002)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGTZyZ0DUSD8U2DhSw13GXhhjLY7wpAENlvL5DfhLTckGTGJIYK90g3+OAxk?=
 =?us-ascii?Q?nN+vJSjd0T28wAn6k7zX1QrWxu42vk7Z6kRxG4ydg7vY+IZxJvvM7+6nMpEi?=
 =?us-ascii?Q?+9z3Yz3tt+Bv7K4Gx8FRGN9Ig+8JPv3eT8r+Qw0vuVWGgZHqrgRNKhUBjAtc?=
 =?us-ascii?Q?POWk8fEDTjqkoPksi/Lk1ZTCMBjsMzk7H/gZDedVt2X+V1SVeE4BE/i+tSod?=
 =?us-ascii?Q?6qPDE/uNYdsZI6KtiOr/Wtf8RyOgGK2ATFGZFudfGbr2KDYMy85wdTYETPfp?=
 =?us-ascii?Q?M8eT2ZKo2giBP+zBc9ctbRFVnFHTZlyFYLSha3DWBt1yiWhtCQ+kZhtwavQx?=
 =?us-ascii?Q?frrDgHEwe6Emnz/HAH9t1xVYoQUqk56+V1UPgnThuDGnBrGCh8djcVvULyRS?=
 =?us-ascii?Q?cBTjZBDyOF9R8yJk4BLKZaZLGIAITCcW+CRgju+2saZ/dW0dv15s7qAL7+nu?=
 =?us-ascii?Q?W2KTPmjZA8DWrBKnE4z0y+JPW0sxDmYf6OZSrvowKEc3HqLBCRMBxwiUSBDJ?=
 =?us-ascii?Q?R36vnjbWNVApQU9vN+/ak+kEJl0VPafm9HFQYSurku1a2uTgcpY3DhGMwyk1?=
 =?us-ascii?Q?cT2lH2JruJtZCHPbxfiuy6abzLdoPpkI/vuiZVorGvi69rMrADK/Z0/vdQN7?=
 =?us-ascii?Q?svqymohyMJCZ3QeIDMQGWt9hFXTdUHFcEePj/1GV0HpwRQQkC5WBaoEHeqMm?=
 =?us-ascii?Q?KWgo1DzFQKX1pepO196lBiSdSP4Ai37ZgfeKetXbB8d+tUObJ3XjBXfFFlRa?=
 =?us-ascii?Q?k8jkBnMbjtjnHV5IW0DSkRSfIXtIQLENF4Vx6uSz680ORSXCft3TTKLIdzUV?=
 =?us-ascii?Q?X4JL+2eb3XQisCzLJ2dATax1bPuOCLZFe26Cok4rMYl1y14lDSr5L3KDZwgh?=
 =?us-ascii?Q?KfAuMlEUlXIOCcFKy0BniB7fg7nv8xrTFzrw/merNSkBCagZ1sOHZBdCxhHB?=
 =?us-ascii?Q?72C7IEsnQygLXmqaXUgDEcAdiK/Y3zjBH1kNFmCw85hSO6L6j29JV15o2Zht?=
 =?us-ascii?Q?IWdfU4NY0euXVKZ7SZzfsgPSarG/O4tGGWBbTsBB9x9sIXSIEInl0k0QNjPd?=
 =?us-ascii?Q?6mUdxVOHhUIptlzcmPJXfXqOQEDv+F/ofKz/V9QR3AGiH7h8KLbrdRZlB1ZF?=
 =?us-ascii?Q?eNp7LIXCIu8vTU8qNsaX/l1Mt4sf+sSTAxuRvKx2XeBQ3YKwvArKG4/t/cjy?=
 =?us-ascii?Q?A5QeCuYIBKt8KV4udK+bEQowjBeIwuvfZcwvCiNbxMQ85kppOk5daL9iEgjB?=
 =?us-ascii?Q?EN+4lEjY/MtewFPT8DsilEynOI4OqBb4EbAlfzduqOkBUxQaNyCFmo/X1BWS?=
 =?us-ascii?Q?KAL0bEXwmoyLDwZl48hC7AuzR/DGsAcE1i+1xk9L+uHuw8u/ob4sqwVBH/on?=
 =?us-ascii?Q?2f9w0axu52jYQyeRPG4xw3rWsHw3Ik2d/Yrkkq5iHqwMyKjDdj7I64wGDKaz?=
 =?us-ascii?Q?kzIwSBNqFUdB1UJVZooqa5pm7/NnLqONXLYD8RcHY798rpAR5xQhQxDmVQPz?=
 =?us-ascii?Q?lxVvRAKc6063UeNKfzf3kDDYqK6cBWRZfhwfSbl1HwzaBMN5qGyGcjlotZ8m?=
 =?us-ascii?Q?hkWGtlNMMAeqgZc5h5rYDRrKcq32sMhg1L3ZYWbCfZSMVngvwGXopiOAjboo?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8374d61-c017-46de-45aa-08da85d7a213
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 13:50:41.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCmzx9EKxjnpcGx8qrjY7jsD4Kxx0xJj7qvBtBL9zJygKg212TdqnG/+4r9GIMONBqQMRkEpPTKHwe0SbC5G7bm9lMWcpxY1Xke+srKjPMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4700
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 24 Aug 2022 15:10:55 +0200
schrieb simon.guinot@sequanux.org:

> On Tue, Aug 23, 2022 at 04:54:59PM +0200, Henning Schild wrote:
> > Am Tue, 23 Aug 2022 17:47:38 +0300
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:  
> 
> Hi Andy,
> 
> Thanks for this new version. It is looking good to me.
> 
> >   
> > > On Tue, Aug 23, 2022 at 12:23:40PM +0200, Henning Schild wrote:  
> > > > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO
> > > > chips are very similar to the ones from Fintek. In other
> > > > subsystems they also share drivers and are called a family of
> > > > drivers.
> > > > 
> > > > For the GPIO subsystem the only difference is that the direction
> > > > bit is reversed and that there is only one data bit per pin. On
> > > > the SuperIO level the logical device is another one.
> > > > 
> > > > On a chip level we do not have a manufacturer ID to check and
> > > > also no revision.    
> > > 
> > > ...
> > >   
> > > > - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> > > > F71889 and F81866
> > > > + * GPIO driver for Fintek and Nuvoton Super-I/O chips    
> > > 
> > > I'm not sure it's good idea to drop it from here. It means reader
> > > has to get this info in a hard way.
> > > 
> > > ...  
> > 
> > Let us see what others say. I wanted to keep this in line with what
> > Kconfig says and the oneliner in the Kconfig was getting pretty
> > longish. Hence i decided to shorten that. Other drivers also seem to
> > not list all the possible chips in many places, it is all maint
> > effort when a new chips is added and the list is in like 5 places.  
> 
> I agree with you that we can drop this line. It was already incomplete
> and the information is quite readable a few lines below in both the
> define list and the chip enumeration.
> 
> >   
> > > > +#define gpio_dir_invert(type)	((type) == nct6116d)
> > > > +#define gpio_data_single(type)	((type) == nct6116d)    
> > > 
> > > What's prevents us to add a proper prefix to these? I don't like
> > > the idea of them having "gpio" prefix.
> > > 
> > > ...
> > >   
> > > > +		pr_info(DRVNAME ": Unsupported device
> > > > 0x%04x\n", devid);
> > > > +			pr_debug(DRVNAME ": Not a Fintek
> > > > device at 0x%08x\n", addr);
> > > > +	pr_info(DRVNAME ": Found %s at %#x\n",
> > > > +		pr_info(DRVNAME ":   revision %d\n",    
> > > 
> > > Can we, please, utilize pr_fmt()?
> > >   
> > > > +			(int)superio_inb(addr,
> > > > SIO_FINTEK_DEVREV));    
> > > 
> > > Explicit casting in printf() means wrong specifier in 99% of
> > > cases. 
> > 
> > For all the other comments i will wait for a second opinion. I
> > specifically did not change existing code for more than the
> > functional changes needed. And a bit of checkpatch.pl fixing.
> > Beautification could be done on the way but would only cause
> > inconsistency. That driver is what it is, if someone wants to
> > overhaul the style ... that should be another patch. One likely not
> > coming from me.  
> 
> About the int cast, I think you can drop it while you are updating
> this line. It is unneeded.

Ok two voices for doing that one fix along the way. I will send a v5
and hope nobody insists on me fixing the other findings in code i never
wrote.

regards,
Henning

> I have no opinion on the other comments and I am OK with the rest of
> the patch.
> 
> Simon

