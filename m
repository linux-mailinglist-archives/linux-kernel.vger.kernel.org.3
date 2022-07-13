Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE56572E22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGMG25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMG2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:28:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E610BC;
        Tue, 12 Jul 2022 23:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yikpp47xDBHjq3KcvGKLGLgds64PWJhcAukaiyDkIpLkM8DIfxM9vhCVj+l01okwtZdCsCTmosVxU7gMNsTHtDJrjmFGI8O07LIr3Fmg7zkGpbYmEsYiqG6Dg11zOwVKpfhkdGtdIsQ6v7y/5xI+MCIHFCMkgojXMKdw6s+SqoslL/3uve60UHiRlrcgsvAGTWoSXQgdbKRD7D7PmriZKF4uR10ie3xybAKVUE60vdomQQ/GKpXy/O2H8qiQv4JNSM16nxyod0vEW3aC7RD6VmNaLN1/k567zPJbRh7HK5Nkpue5GEnn+HpVfvkXRhLVaZX5eyBwa1QQKgQ3Xo0ETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz0fkrCfiB8iIRmM+g3c5RgdfbYzayPfNfoh04vycd8=;
 b=IuZp8DjC2AfrZS84Tgx/EgZIdGcV2wCZrOrIQXMjG/5PGegtGhbrh2Zi6j1ql7RXAu1tZiF5DJ1REDVnuzCBWVMZg2D25WcPxXOJzs7ipRmMGvoMST9mrDOFdkcxTbOCBB+255wdkPzD1QHxCBMuhPDwbFH0WGS24Y4S0leQ5+AnbT7jZhbppFzutYNbTuKfj9z8xjekyhS5G3emWeY6a1uFvLb8nQGSE1deI7LIcWvW+TyTk9jzZGMzvN5S0gkencqSwSXyyoCqwKx3hmoPwGyU9Hu5jwSdEO141ePqBi2/hsbnbdjFeug7u69YqrZT9avLj/dkoGZ6thGwi+Se+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz0fkrCfiB8iIRmM+g3c5RgdfbYzayPfNfoh04vycd8=;
 b=Ee8EVGCEqKAbM3dHUzhwB/eYP1Vsh1Q8fBxOtr6sHkq2ukhMW0QNJqnGqgDx2Kyh/bnWAmm1mTQHs7E8WFkZc8JF7QlK7APw48qV4wn2GqBmlUo2cb3f/yN7zmoZ+cpHt73eQY91x8uw5PxAJG7F6JlQlNksAmEsxwBtMemKWpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB5993.namprd04.prod.outlook.com (2603:10b6:5:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 06:28:50 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:28:49 +0000
Date:   Wed, 13 Jul 2022 14:28:45 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v16 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <20220713062845.GB2788915@anxtwsw-Precision-3640-Tower>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <0bd85140-f006-8b29-0a43-500733f1654c@roeck-us.net>
 <Ys16lEvhVSSSRMP7@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys16lEvhVSSSRMP7@kroah.com>
X-ClientProxiedBy: TYCPR01CA0180.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::20) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97e98d6-d41a-4f92-fc7c-08da6498f27e
X-MS-TrafficTypeDiagnostic: DM6PR04MB5993:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYTBF0AUKHAJjZ37mNEbQ9dir0KmCHczzuZFkrB2Et32Gj7WMHr7kfY4GOpAq3BmSldHy/5G+mB8M2aCzi0eXvhj4x8T5Zc1eppu/Iet3ckd17zEymeyQ7xaCLSQcq5MLW1ci0iktcdbjh5VRNUTljfTzuIG8hxL2f3ZWzQBHrJcXNtpzQxAR/r2QnieMURbc7+s2YztQMzlWzWwMQh10rwMXPIt9QpWmxkGzSfmsB7qHyNqZoZ64Y8bIZTc2fk3WihxtZXbEKMQd9eG3bPOhSGY0mX1mxOLNtlUYarGlJILrmJWCHf+yGuvMA4irogTm75geCMj07SuxzKG4Ki780rQv27cD28Hyr+v2kqWJ0RXZOYVvNEnJB+xp1K2t1jgCJnNxxC31sN8EW1/C0raD2NCkL+gh5qf0XCHQbtECjnVZr5/bqpDxq0VN7leHIqiTDOR9z6iDbzCdbxd9bfq9Vu6YIv8vbpWgbb8kRfWMAJzcsISBjITQKU4I/tbK8kOnuVEo9+wDzms0YbmEvDH+qKlACA5UQXl7/iWsZDuJEP/kape3VXqB7me5nOakRco4MALhEb3iAiDjWyD7zY/gShjg/qNabFusQ823Me7EeGtghUztQHC8pubR2T5PV/7jSIKvpJ1ofhw6bqa3r+aataMxz8ww+3IIUJbKtSlVJMSp3UPM4amnXWLoKhbpCbIWlvx4N/IhiBwqAh+6IdpSBhD0uQQpNq/Ic4D8QSQrSfo5ihgAXek02swifDLPXwRtYQkzERixq46l8AQviZpGmn7wZq27BdfHFFMgT5izf8ES2PPaTDQUdHUfU5KOVaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39850400004)(396003)(346002)(376002)(6666004)(8936002)(186003)(83380400001)(38350700002)(33716001)(1076003)(38100700002)(8676002)(66476007)(110136005)(6486002)(2906002)(4326008)(54906003)(33656002)(66946007)(66556008)(316002)(52116002)(5660300002)(53546011)(55236004)(9686003)(26005)(6512007)(478600001)(86362001)(6506007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQkaPdtIi6R27Z/s6qUUzZtIEJI2TQs3o5MBTNR3fhMfeX43HMfudmWsdcSq?=
 =?us-ascii?Q?I/VTdU/NTmZPv3C758n4L9pDIW4gJxqWLGlHmJvW+3LmCYIU48COE9i7u+/n?=
 =?us-ascii?Q?8M0wFQW18xUPHqg9dLwr7PFUD/SQMpE8t8c35Z6wsahcgWGrAuK7XZSM8XPw?=
 =?us-ascii?Q?x0I0cM9sT0a2hdEbrTLf93PG/iDC/BtOPnGpziHvVxY5VDpSiCW59nWvPtgG?=
 =?us-ascii?Q?mqIoGigL7K2SV39OpcrM1B0vWoEX4bFSRJGBmwhTg9B/1hFxeqCbVc4Cn1m3?=
 =?us-ascii?Q?hsaHcMB/MYSLdnmQXnckbRTK6mUfBA0M0fBiFDHVe3G7QUTXv88sv0+ugmPX?=
 =?us-ascii?Q?/W4M7u4U+lR+4UnkXxDVElgTkm1RbdUATdY/N48HCSx0EcUWvh9XL/+EZleP?=
 =?us-ascii?Q?wpRjsMDapPJsd8bY/iPQFZzfSZZHpICjcdpvkUakPb41mNPpAScZEdDpg7rB?=
 =?us-ascii?Q?PChw3iy/DyMobz9DRE4kGmd0sHjs82Bp0g0ZcpLNTyLl2dkjsOmt8Zh0TUlX?=
 =?us-ascii?Q?0UnbismVgcHN6Jxi4cOgfhxJ1wVdn8wI+W52+/Wb37Dwf+hTRuhwcYEFEcZi?=
 =?us-ascii?Q?vNsvhplihDCoc1ISTnTbiEj+mZb61EJ0E9YkRmakOpxIeQw1xewwGp/LJI/U?=
 =?us-ascii?Q?LeCit+MSbW85gb6OZgRgmDEm65js6wb6wSJAji3dqZxCfCzccKM+ASV6Shdn?=
 =?us-ascii?Q?SX3gpXFUIra5FHArSjrOfPyJW7+1sAfb2qDFdAlk8kD2fjdzCUBEoExjsGiV?=
 =?us-ascii?Q?oV8J+m/94fVHFgH1lJMZqw5JPaPaolqaJR/0a+mmtk6IBYfpjGu5Y3DRQcb9?=
 =?us-ascii?Q?9ZiJiMuEoKg0Xg49Axuuaf2jYOzdfUH3LrlVkm9Ap6D/az6kTkoh6xRD8oX5?=
 =?us-ascii?Q?9Xd8qQviYiraS4rSfG4xPldzMgju/fhqe5HzjRsQlbU59v6lRDtEok//ObV4?=
 =?us-ascii?Q?fhsg/DzOTj6UhqRtnaFe074rF4ldvyofXsqr7btHQK9WpR7FtKy9Qz/hhX/Q?=
 =?us-ascii?Q?4yA3S5c+9oQhE6IVxBLEPbetEi5w9VWpIcqNk3QbIKVkcwgQJlxFruaFNsAg?=
 =?us-ascii?Q?RDzciTjYVxpv95bs/nfiw19XMY0EAgjfj2T3yXRlwuMwMpyXa1StKVM2A1KL?=
 =?us-ascii?Q?ULmrovvRfgV8TJYTXHytToY/xlEchZVMumVzuGuBbowrZa/yEUTJZVqx8HcI?=
 =?us-ascii?Q?HUcezDopz1fKOdiylQ3chbkIaFaZSI2VFJU090xNXu7KOXZ9ZYGrnMJwJv76?=
 =?us-ascii?Q?iDHU7ecKYfqzxgIcvCO8ISmKcYV7o3bYgGkhYTw1korp69NVS50xmwNarSwW?=
 =?us-ascii?Q?lfr3g7qo0OczjGZ0LFjPyYITgOgDW1Xf1LXroPrsmOVBOzJb+jAOwji6XCo5?=
 =?us-ascii?Q?M8warD4ZdyM59LJAfMhNFo9B2N/UCmEaXR+wsPBemn8WigJoSz5wjck+UwbN?=
 =?us-ascii?Q?YHNevtgIYhqwjP9oMKqVJhnCVudqd2GukjHlEVV5QBtLsHdnAx646h8LYyDU?=
 =?us-ascii?Q?5aqM60iMt+24LkmJ4A0Av1NrsZ4WynHdKkSPut4nzece202jHKHXQst7y+YV?=
 =?us-ascii?Q?Dh0i5C6akbdLP5It/rUqVlfTmEonxoH0tGO5GvjM?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97e98d6-d41a-4f92-fc7c-08da6498f27e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:28:49.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKhIJ6vecNhUKOys+qw77nLLWU31FylGZ7DqUIjeG7nEFUaWn55XTfe6So5YseDi1IMzv7dM1NFAihhYCiAxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5993
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:43:48PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 12, 2022 at 06:31:22AM -0700, Guenter Roeck wrote:
> > On 7/12/22 02:05, Xin Ji wrote:
> > > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > > and a port controller (TCPC) - may require that the driver for the PD
> > > controller accesses directly also the on-chip port controller in some cases.
> > > 
> > > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > > 
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > 
> > > ---
> > > V9 -> V10: Rebase on the latest code
> > > V8 -> V9 : Add more commit message
> > > V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> > 
> > We are now at v16. The change log has not been updated since v10,
> > making it all but worthless.
> 
> It's also already in my tree for a while, so I have no idea what this is
> being generated against :(
Hi all, I'm little confused, do I need update change log from v11 to
v16? There is no changes since v10.
Thanks,
Xin
