Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBE598977
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbiHRQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbiHRQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:59:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80098.outbound.protection.outlook.com [40.107.8.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6025E96;
        Thu, 18 Aug 2022 09:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOdi5M3d+FJ21xZ9/RbQtyJo8i6dOfiFI3a2LzZAte99ebeT61dBNAgm5/EEAOG9ATKzGJYJI6QBOHIrqThky/d10GEHi8V6bmU/g2W1VtYsxDC6dX31GPn8cf4GJSPqJL9ysQW8O8V6KcV5QFSqMn4qcbKwAfUSYHfFATPbZQKPRmkIiSMAa02V6NIFjuiApyFQGKQwqro4O8G4UTneFSTToOs2O8RBFdea9b5aqGBgXk4TZhPAFCDw9P3GKUGv83SeHcWFnFbbQG74Ehxmr8ayJDQEjJbzeUwC33qGTtIZwGoWATVDmZK6qKWLpHogODrWXQBHxK8r2dhqr/kMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgsSvOc0foTCjCb1mVKPh5Swi2or5I1mGXgBQUx4tWg=;
 b=UP+Nx2bgrsvrAWts8pyUBzvEiTYXfS7MjXzkQp2lTzFlT2kZhGtAm1rL8eU8maiELapOGgiLv8hyrvnpWz4Y3nXybN+T9/ODVK/fbRASl594RaodBahJXjVND5nwN8/65CxTUycAK+c1Me1Impz2pTaK5VBfj0ekAViOWQcZaxdSenW4vWL7zuo+A/LQj1XSJ9TQfbfx9+1ew0tOo2NVY24Pde3RTcbHdu5IvmT1KHQ5osMo5xVql001GmXcqjP8+Eb7I1LkRODZXXvNFYOCEqcus3tD7wNKJMMprHEGuv/RKNxeoiQYsN7sMDoFHONd/qhtMArHDOXMkpe+xqBrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgsSvOc0foTCjCb1mVKPh5Swi2or5I1mGXgBQUx4tWg=;
 b=G46Ij0YC1rn55tKKzfwPp5eyyqHEwEEfPoRSNSAwNiE2iTT4jnCCpp85qc5WKOkgUKJ0yVsIxuBO0nnGdmwelWVwx6DA53iIpRIx2WeUL+OLmyRqyzZ70YZIMgAzuR+gFmkfmalJtTwepVzyEkb5m75PExzGdrPmJpI/SNOk28Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from DB8PR09MB3580.eurprd09.prod.outlook.com (2603:10a6:10:119::23)
 by DU2PR09MB5456.eurprd09.prod.outlook.com (2603:10a6:10:27d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 16:58:59 +0000
Received: from DB8PR09MB3580.eurprd09.prod.outlook.com
 ([fe80::d946:c6be:224a:5313]) by DB8PR09MB3580.eurprd09.prod.outlook.com
 ([fe80::d946:c6be:224a:5313%6]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 16:58:59 +0000
Date:   Thu, 18 Aug 2022 12:58:53 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <20220818165853.GA53892@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
 <20220624184431.GA4386@zipoli.concurrent-rt.com>
 <20220626123019.GA51149@zipoli.concurrent-rt.com>
 <Yv5j8NQ72KXu60nL@linutronix.de>
 <20220818163126.GA47319@zipoli.concurrent-rt.com>
 <Yv5p2E9e5B897V4I@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv5p2E9e5B897V4I@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::32) To DB8PR09MB3580.eurprd09.prod.outlook.com
 (2603:10a6:10:119::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b829f4b-498f-45a0-3a6d-08da813af1c9
X-MS-TrafficTypeDiagnostic: DU2PR09MB5456:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndDarig1c9y0N9MzJuahOXuWkASxQrEazh3MgaA1WHPYu0eZY+RUGkK0ykjqxfjcXX0YVIfwNepAhisi7EJHwO22hao4xpk07C12IIEiHM4FTFgmI0va25aNhUm4ZDQv5GQcrreQpLqbTNv1SHSxoRek6dleoqBOhb0lrFgsDDYh2OZ79bdQiA4s0waJwCDgaKWZnwroXHpt9w4lYDYNO3DkdGCXuPpJUrvhUeXMzOyBmbiSa3QUEGFHBuEu0u96BwH+92wrkIjnLxAXM5EuB7grsbiN/oUDXDIQwJnagtx/YZ1Ru5LN1ixDejen/YOVBpp68OzR4/RPFhW/gZngK1bmtXdvLBzh0xxOlxbruOGBltwCJq7T5Yk3G7OjEJ1eCk1anGgER6K11QGodCx00/TAPeTT+8JbJZ/SMo3cq6T4pjTycI2EDM7VWVbm7Ry7P8ko9ZmDdGkZ7MnXTRFVzV7ihBeEIgIBB3hx+fJHqiDyOYKYgbeE8GU/GcHT43XstHgxrB/ZIERrcevQd6XOjZz4Q9u2AJSlTGZTBsBTgyxTAXp6HXPN3IUkwUwRoZM5eG4WilAXnXouRpDiOmIWEEQSBtfcz5L+TdaP8HtRZUC3scy8oZ+Bqnd0lj4N3y8iagCvShPdWk29/o6lV8lPfvxx4vF7S0/owrmwVXrIWe24tvDrm56/KhAcP6eh/52tUUtP1lEW1WVf2Q3Mjik7JxFU0o8JTKmi/bpy9rO/iL/YFKUeWLxM1pgFXSfaN3ui/YHNR2om+lyCaOiVc+L6Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3580.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(478600001)(66946007)(38350700002)(38100700002)(6916009)(54906003)(6486002)(66556008)(66476007)(86362001)(8676002)(4326008)(316002)(6666004)(41300700001)(186003)(1076003)(44832011)(3450700001)(26005)(52116002)(6506007)(4744005)(6512007)(33656002)(2906002)(5660300002)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/y2aFGdZ1AiDX3Grf0Jvachiayp4gDYnM+aWNrxi2YR9hNH03PpOPpN+oMbb?=
 =?us-ascii?Q?MXQgoA5wwBUefI8iQugDxVP2Mwss+KOQitQqw/ozeJ4rIeTJoueOiNQwRIxB?=
 =?us-ascii?Q?5cf9yxRuVc7wlf1I9NKtrAlDoZNpFIl7NxWXtKvgYNoDF0WBkfNn1tR/DdnC?=
 =?us-ascii?Q?o1buaUyny0+cetZblMO43SVqx5JikRrDDb9VsWbahnM3a/rAVk9KgQRSwGRj?=
 =?us-ascii?Q?Z6gmlMAkTUID6XwuNEZ5BrS6DfuE2Bn0oc9kbGTSoegu0uxlsE2CerHR/h3j?=
 =?us-ascii?Q?ga/wFKnor+nCboWYAmzBeXBjADjELcRtbKlfE+QvoJlTPJPdxJZat/tNuseH?=
 =?us-ascii?Q?TaO0ByorL/knKiye+womNqIiaoehl+CAnS3YKAIrKwRjZLZ4fIwj37yqKBUF?=
 =?us-ascii?Q?zPKVgvd4D5vVZ+YKapovIgswPGTlHxWgkbJnsvjewYfGEcdq4kLa+T7y+dY+?=
 =?us-ascii?Q?ASM2tcdxlsvoqVZchg/bC/vRFoJBh8LwsnOp7o/0lwmwAveZzeyRK4X/BKqe?=
 =?us-ascii?Q?C6LIC1Cqqdt4kFTVTYzM4FMKUuIKQFPrhyh48IH5b8AIE/uxBzZgFk4M8a8c?=
 =?us-ascii?Q?w4ULZY7c22csNuyiHc8x4cHYOMUa+jXwdyKaciDdaRqUzdxGOg7Bvqeqeh5n?=
 =?us-ascii?Q?C20qfiyrZovixZqcHpWRv1SVGWAw9j9kXUKtImUzKrEy2ioPmW41pHWvthMt?=
 =?us-ascii?Q?LCgH6CqAyNWZHgD+jmC9aB4JXl3jTKunFRseqvvz/35Na47X2gAr0ekPc6qc?=
 =?us-ascii?Q?yTlKETov6u0X140Zw4sHMOpQbGw2dbAXPpYy/DdvTfGpC9kUhSVCgqKpaL/y?=
 =?us-ascii?Q?zPMZexzeTRfqj81QR90APiBXsYrOLmdv6VkVYCEmIENoe0nvU/gJbA7VJ3e3?=
 =?us-ascii?Q?SQSZ8PLAZq6MFYP1YD/IO5d1pPLbkoK4NycuLm/CVSOZyWmCouDCrC7RnX8J?=
 =?us-ascii?Q?+wT63hCAcVtvlL+wOpPkTDgf9SqB48ylgOuQwhU5SX46BEYL5YkVVpDoqIA5?=
 =?us-ascii?Q?4frvhz/7TbVRYjlc/BczTA4jvVnn9puBrtI73Oeef9wdDxCGO9LXz6p/0fYR?=
 =?us-ascii?Q?+v1/0+p1859KT7Gu+0inAgcpW4oZ7SqMbqSgwJ8eFelJZE2FF8bhGzTr9yJU?=
 =?us-ascii?Q?lQRKeV4jONO03iXRvPsjNk8B3t1vgeYG08BII6KGc1mle2hHNWJ6LNlSBtTa?=
 =?us-ascii?Q?K0p0hOgslzm9BmXEOfCzgEROeJ4/AH4nUTIw3Ec9a92oKxhmvAn9AEGJcEKK?=
 =?us-ascii?Q?8UdGI5LIw1fRqMhBDRgJ3vB87yWRk/4vXg/A8ytqOTCQhdBSPAHvR5QExG49?=
 =?us-ascii?Q?vyOC0N2zUVzTOYlOv5yWtFnMSYAgwTFViR5GXc1ksH9WxryAFyigViyBaUR3?=
 =?us-ascii?Q?x5r/Pxfc/USqA5M6SnWbAIroeUg8K4WDc+roGZK/d2bWNjF54sojbh8aq8yR?=
 =?us-ascii?Q?bIEI706MA4J3HaR4TMJAu1+wqCTcXMUZLl3AcuORKlRZu1dDxwj2Pm/RVsqQ?=
 =?us-ascii?Q?ijtB1mlhb2CZd71FSXgGVNQWob+PpqVbUIcH1UqIzUVJjKvMsGTl84HNHv81?=
 =?us-ascii?Q?RkOj6/M/4nQBaFouAAfoLCYhrF8KLiL7vU1t4I7K7Hb9e5TlLjmw4hzy3rrM?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b829f4b-498f-45a0-3a6d-08da813af1c9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3580.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 16:58:59.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMVRpCkqc3Z4VUWpDDR6V+2/Z9Kf95IO2u5IveXY4pPJguNOhc1Zocilnoq1DJf11RQlpQvSAr8SjZeL4ghv647DnE6S9N4ZtaYoUhRofIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 06:33:28PM +0200, Sebastian Andrzej Siewior wrote:
> Hi Joe,
> 
> > I just verified that 4.9.319-rt195 has this fix.
> 
> Good to hear. And the v4.9 series was the only broken, right?

Yep.  Way back when, I eye-verified that all our other long
term rt's, starting at 4.4 and beyond, already had the fix.

Joe
