Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB04B1AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbiBKAux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:50:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbiBKAuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:50:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B25F86;
        Thu, 10 Feb 2022 16:50:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsVnAqaQuHQqPUdlUUgaf1rWx30Vhan+lXDxaJoGbSQLRX23SrZGOS0k2MNzfxAaoDAGNGPJUTt+Z+jgb/Y5gT+ldTx2XLxzDQ+A2aPN/erSJZ78qGaH+99suWnn2FtR6ILwbBkIvHEN4Dgs15IlpspX9m8DwgjBuJ7NSDdIhXtW4zWqjwed5SlVH7P3qpVhNh5Ict4NAw7LByYQQaW6fqKyHts/LbvYyV06xVrVvzn4rjkfZVs7Eq4kgHVbAyIUuwsHBFfNZ9xjRorKOCH+6SBo+bNpf5kfnHJ9g08gEFxBeN9VOI0wI8qOq+v7R5QL8IUhkmuGozK2oz6wQtTJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTicmL4ifbBX+NoEpE49NAIRc2rH9xkgfGI85ZRHQ6s=;
 b=IHF76FMRlDY+QtClnlQOYMstXPJKW3ezT12JTpSKqnGNahlaSVkxXWMYv46k99tPjZVr8xSyuM7f04REB2H3+hsgVOEVqAMqe3ckncOi980cQ9ee+JDx/w8wQ5Uy7BzrSnwezJiJf9wSKmQPplxD6ZQq05tYD9ldtLkYuCjKyfnpFHxT1g0+XHf0J4igur3ANxV0cSSJCxLXtYWLF7ugGQzSDWRdSm2cB3va00XtkDvZNZpIU4ExsWnswBpuXSwEC3JZ1DMWxg2tShOEwauNAh0OJVXFa5x7o/B1PCHcRnbOUqzIzPAYEMA08JhwaHSwxLfJSSKTWmIkVvjCCLRxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTicmL4ifbBX+NoEpE49NAIRc2rH9xkgfGI85ZRHQ6s=;
 b=bOjeGpGar1xMR0NuX/BJtr9MnFhBCjNdpzEY2HZ+mx7nq+ByxEWLB0DHjxUBJCr0NGQdJwkhrx9M9sHMGJ0RVrfOK4/vPsL3pe4sA7vwB2omJ7xIgoibFwFywPS9qE+pSJPRJ+EG/bLYk8Mp2439VVm7tepH1ZeXGYqofUT4FRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by BN7PR08MB5569.namprd08.prod.outlook.com (2603:10b6:408:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 00:50:47 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::b48c:eec:fcaf:3379%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 00:50:47 +0000
Date:   Thu, 10 Feb 2022 18:50:41 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: add Imagis touchscreen driver
Message-ID: <20220211005041.GA51878@nixie71>
References: <20220210163708.162866-1-markuss.broks@gmail.com>
 <20220210163708.162866-3-markuss.broks@gmail.com>
 <20220211000103.GA51220@nixie71>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211000103.GA51220@nixie71>
X-ClientProxiedBy: SA0PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:806:6f::11) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742be436-70ae-49c1-ce12-08d9ecf88aae
X-MS-TrafficTypeDiagnostic: BN7PR08MB5569:EE_
X-Microsoft-Antispam-PRVS: <BN7PR08MB5569F7B5B053BEA925C5C97AD3309@BN7PR08MB5569.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26Jyl51h2BCDXKlCee+BH7Bi/MgaDbjGS4cSPuieGRq/e40RXkjz0ZaA12bC7j/liHrJg5DPEdmMXTm8/OS101vItq6gx4O+IIvVz99hfWICibMcZtFy20hHN7iXwQFSr2ajPMmhmSMjYaRIG1qplO6+m3v3HDT0dBGaG1xEVBHaVcEGz7ie43TEncsSUSE32utdR6eAazi1sSSdKZ03kiH6Z1i3gqLsWhr1ONzvFPglwz3/SrmTf86L5i9GVghAUm4dY+NzDn+dvbK9I8sQ8pwrLIqcCe/4nDDDsuDu+KtN+yjjQKifY1tualcP8y8Ojl1EtFSEkuWbsVTaXo9+tEE/RcTOt6q0xhr3bsf9D9z1pHKQfxdAZ/IpTBC0yX9/Wa8M5ud3PbSvZv/fabbMkTGnjGkjxqACFOJO/xyJocYRMV56d0AGzA6B8FY97dqgLXQi9X5Y75CrYxCXLFCT+eGEWnCfEeSqBXb577hrAZiSuxW3kbL9dcWW+xAMNTmxoMeDcHLo/TGsL9qbJGlw72YZojEh4qIkwQZgEaqAHyhOJjcXXbMjSnpYrktJPPED9nBejwI6YyThZc4zEp4o8HH4I+px/nGhq6SafQ2TkDaGwRA8VaiI6LG9JLWdR8x1psoDcr6BpHYsC4d8v+0JCKkgK+K1Um9OdfUBIg8pFCZgMuDCg+Pugso3hZB+UsUVyQZUATRFs5E8cPS3dbrPDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(376002)(396003)(346002)(136003)(39830400003)(4326008)(7416002)(33716001)(6666004)(86362001)(54906003)(66476007)(33656002)(38100700002)(8676002)(66556008)(8936002)(66946007)(6916009)(5660300002)(316002)(6486002)(2906002)(508600001)(38350700002)(4744005)(6512007)(52116002)(186003)(26005)(9686003)(6506007)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twkcKjiBNqHJHHfTG1YYdOxR0DggD9b0EN0GJaKglAZ0bnwdpmlMTNflUDHj?=
 =?us-ascii?Q?Vy7yFcpdmNTlIhRS/RdVptFQBZ7p8g0OSelhXV+0xYpPkwCkpIkJduOspGaM?=
 =?us-ascii?Q?FE9ciwf4KCY1wRE7oidRgDn0M9yPB/QwQXX3LTotE1zx+v9yzNjJaKr1TtKl?=
 =?us-ascii?Q?atQ5y0LoRi4D0Yx168pVdxT4C70qONPRzRO01BnxqZbtX+7uu8damIY125lv?=
 =?us-ascii?Q?qMmL8T5i2f7Gqv44EOSSLI96WvNoAqNQpqd8zA7COEDAXk4fbIVh+6a3imI/?=
 =?us-ascii?Q?lTr7m4+Zr3aLntMPM0+41ymjTKxTexputScaDTrv81DFuVipYUJisNQ+Csnp?=
 =?us-ascii?Q?5nWGP5RlL0eZ7QHvYmu8+NTxyj962/Gv34yJNXUdj5300qaCXUdMqrT0XFEa?=
 =?us-ascii?Q?b6pZsMQUgqHLdzIrVh0tdlNrJVvxsuHc5YrhLBk3n0FUpgXEc1YEvaQA2Hcu?=
 =?us-ascii?Q?OxxG0jwCyjviTLjIsySsWW8B8/Ev3Vf9/xZ4ltwEOfZqhPzrTka3AHLyy5oz?=
 =?us-ascii?Q?n59dDlSafoy42g05XfPX5uFErd+ku2S2lUR90tOKxV3z3qRc1GZl2xNS0Ddo?=
 =?us-ascii?Q?OAEBYJPgaYr2hP+j/laiS3/jSh48iNEvGZPb2k/b03OsjweYcHyRC+w5ccCk?=
 =?us-ascii?Q?1V/rVf3C3RXi7YjsDb1AhGQhYCHVD/ZbXdxSXQsI6zcvVYgxUjMMqR6NUrkR?=
 =?us-ascii?Q?s0qSJx9LiG6dgv+52AYBNvp4uQpz987BOaq2xBZOQp1LR2gjuaIWQ/y/IFnr?=
 =?us-ascii?Q?aH8EEvQfP3e2uZDIXKY3Fg92mZP593hOV7oAnLzSSacYV+KM4EmxME0btyMz?=
 =?us-ascii?Q?gG+wwipthcxlIM3atLj1SHqqGYBjCUK+C5lrY2ePCwic6S8Lb+IE6bMgzC0s?=
 =?us-ascii?Q?fC75jd4xFcmTDKmkJPThGCZSnaHQFEXKdck/9MkdEWIorG4FnnfpXUmHU2q3?=
 =?us-ascii?Q?Ymi5InlQxnZl2RfWPqdHNZ3Tb7RCWhqV9PlTDKEig0Wccy1E/QpRFyq4lQ4U?=
 =?us-ascii?Q?wT5R9lAvklaXigQ1MWt6WqvMaiNkJ8k84OJOxvpAIHepLUCpZJvG3CvPtdlJ?=
 =?us-ascii?Q?PiUr16WcCzB09WrSS1MsZhA5YFm9P0qMhLZyn8AI9X4MSURsunos9pgY3o8I?=
 =?us-ascii?Q?HFfFjGDOWzZSzyv2UADM4mNAQdOMbUyX8cHk76jVElgMzDmwb/0g8BymKe6l?=
 =?us-ascii?Q?ZFl0jFn5lP4UFbMAoipprdtRi9q05K6rwohjsfkuzZmPcXffoGiDKr9424ig?=
 =?us-ascii?Q?6M73iL89gOx8XMd8EXcSXHkH/Jdb7Xn24s3AGCf7O3mh00EJX4HCg57HEmcE?=
 =?us-ascii?Q?D51qymunxBKum7yxa7UBu7ph46Fip31RKP9keoSfPs66P8EIZ3izs98rwUAY?=
 =?us-ascii?Q?xRczWGeu3icxxViVn0nTQvg706VUJaniBvwCe0tzcAWxx7KwXIzzLtG1rK2D?=
 =?us-ascii?Q?e5KbqpjfnXeWmkUCMkaBs9rYSXfosjSLZEdCUxW5x+Nhl0+MZ77UyB0hOQTc?=
 =?us-ascii?Q?zoA6+uxgzqrovdSKYCxv6iH/HnFuXosGdHXMV2Rksz/4709QdxuTLNH7zKs5?=
 =?us-ascii?Q?WOad7hL8s+F3TkWnXrobYht6JORSnCmPZT6HmgRHEWa7U48zJec67gNy2YfQ?=
 =?us-ascii?Q?Zx9FH59Xx1u/ayLmQCllCUc=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742be436-70ae-49c1-ce12-08d9ecf88aae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 00:50:47.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ya8qi/3tzdiAWNPcyF4z8TSB/p5HKozmrVFEQw2qRE3JYg5J4/iKc762Uiin05gvmy32zTr+Vaj2w6fV02dXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5569
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

One tiny correction to my previous feedback.

On Thu, Feb 10, 2022 at 06:01:03PM -0600, Jeff LaBundy wrote:
> Hi Markuss,
> 
> Neat little driver! Some humble feedback below.
> 

[...]

> > +	error = input_register_device(input_dev);
> > +	if (error) {
> > +		dev_err(&ts->client->dev,
> > +			"Failed to register input device: %d", error);
> > +		return error;
> > +	}
> 
> I suggest using the device-managed version here, as you have no remove callback.
> 

Please ignore this bit :)

[...]

Kind regards,
Jeff LaBundy
