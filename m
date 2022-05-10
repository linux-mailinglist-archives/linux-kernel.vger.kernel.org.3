Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F42B52144E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiEJL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbiEJL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:57:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF240284921;
        Tue, 10 May 2022 04:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuQh11Fd4dKmMjOEGtIsmReJuGww1rKT2ytEbZpZbB/9zrWYAdA7jqAxub22iMN32LLr3rXxCWUDoseuyom5KcNuhJYmlry/mIebwmlGjlaLOu1V+CzFMJh76ybXd4+wCyGw+Ovnbz2u5mzfF++1HC7ilqnrBRXgr/Z874a2di3yJGtb5eq6s9iHsX19L3oIHdDQ9RjCiD+tBZv95ubJva/VlQnCC9PbtSRjLk17C8sCDM8z6e49A0iLw/vidTC8Ia6akxq9VgeOtMHRCdHklQY2Q+nYDgeY3a0BpuezPQoS7GmHHwo58NxI/Cxqk3rC3oHPGBdbEu/sqrFiemH3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omMlwAnhCTchfOtvdyouvQJqAbnZMVJ/q7HvgFzSMBk=;
 b=HybK6U+bmR8LM6rfKVp7gV1MdeqibFcH6VKmnmrs+n+BXE27UeiHrsPw3RJRpIR5dD1jGZYGmCyebfdnVp2kHWpJ5jnKj4iB7hpHO/ankhqMuV3XOqhBodTZqbnXjSgQSfLvzoh/U/qX1nNjIBU9QfcQ+hkKDSW8TE9dAQrxPhFXxYpf3yhvG9xw2FoJRvKCVWz95ceV6LtuNnpaOdhFM+QlbTWO58VJygv7oe6xCtd/TWqZARqVRW5GPoefklya3yr55ekED0Qo4JBSdRNk3hnqwzJAhz/TT1Eicx+b0gN+3RuhuLGuDrOiloaru30PqjHvj/OQiJO5iMkrMy4rMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omMlwAnhCTchfOtvdyouvQJqAbnZMVJ/q7HvgFzSMBk=;
 b=DhWcNQVfKVS6nmpiGMl6+/C9+UdL5zo4BCSs2Ux4Rk242IWM8YvQeq1NT1/Y7vBOBrau6UR5yuGApZ8tpkqlowB1+5b5GUH6HCv+Kx7IZNW55vvWHQHzkNzrXZfe9esS1TRgIK2/BQRvyWjVx2f6ZfpNEK3kDJqDIJseP7a64JA=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by DM6PR02MB4091.namprd02.prod.outlook.com (2603:10b6:5:9f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 11:53:37 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a525:6e3a:42d5:255b]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a525:6e3a:42d5:255b%3]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 11:53:37 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        git <git@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] tty: xilinx_uartps: Add check for runtime_get_sync
 calls
Thread-Topic: [PATCH 3/7] tty: xilinx_uartps: Add check for runtime_get_sync
 calls
Thread-Index: AQHYW6ErQ7FqpGCLDU6R47eTuYGS760QzEKAgAdEs0A=
Date:   Tue, 10 May 2022 11:53:36 +0000
Message-ID: <DM6PR02MB6635C3E7DEBAAA146D3DF440AAC99@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-4-shubhrajyoti.datta@xilinx.com>
 <YnQ4lxfJUGe4TyFi@kroah.com>
In-Reply-To: <YnQ4lxfJUGe4TyFi@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19fa14a6-be48-4157-a673-08da327bb7a9
x-ms-traffictypediagnostic: DM6PR02MB4091:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB40916B2A18C84E46B321157DAAC99@DM6PR02MB4091.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgptYQHJWY8JkPcg5q3537M5x0weCJ1X047V1pfOfR9nvpDKfp0zYy9RtTp2RbCany8mOxgq/G4aZGtE+FydyC/UwA7lJuvjbNU/m7tO8OevGD20E19cAiZ0cYVr8D3Vrsdwj7nBMriVtQvICUdq1hX7wMJ1UzdZpjsPaNECcpV2tBFGZRigmXrmFWUsHeD7sOFfI15ACaChcMv36hA4sGxcTQgrHMY8cP4AT2UK9iuQVaABpZfpJYCUz3SvjhQ1aj9WD+0dcoa58lRNwI3aYZ7J5WEhGgMK8WM28zapJsXUAnzU4ejAFSXSm9IP8xmZmi1tG9tpixps7M2kHxlhyct3wag1xEp7H0s37Kv3rlAAsRa+EAeE6GZElN3TV9TaQ97ARxaP2JD8MVDIEa58OcylrScw8Fh27+VUH79Jz3TzuJZDEy/qewkRguAcNaqXmqOx9469i6OFdLmNC2WxAZgsRp5fCGYuu56XcLt0jPX/zcDufS3xAD9K4Y1YulFPycvnTwfynRRNGlLD7ZrpNCyDlcf0KsjwIEppWDhE+nC4L37wxLX1Uqz4ojwY1I81IJBCQj15yPvfIO8zgOtNWv7s5wZp+4t+1mZEGa3YUPd6YvsDpmOre6VuCXjQJU4u1Hb8aQ3R/aKMGUUMI1K3pM3AdeNcfWRK7/pZdsf+ConGdOrql7PyoA5IfVa4eXKnayWGfklogCCEg/s8TzkjMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(122000001)(83380400001)(55016003)(38100700002)(38070700005)(71200400001)(9686003)(26005)(8676002)(76116006)(7696005)(4326008)(66556008)(64756008)(66476007)(66446008)(66946007)(186003)(6506007)(8936002)(508600001)(53546011)(5660300002)(316002)(54906003)(6916009)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qtdlUNjh4Oj7sHDwXeqIN68QPRFgqaDUwqG8evoZPEfI9TY18RlWrw5Ho5a1?=
 =?us-ascii?Q?SYdMv5zc7S4iQYVgATwTBc89pynnDbMey2qbGn44qUuubqLxqK1HzM5SPtnB?=
 =?us-ascii?Q?APDXA69fQfXNnoQgCsu/cyWWp+p4nWRdbhGdk5dxsYERkH+EUHNtMJ2KouA1?=
 =?us-ascii?Q?IWssJZpJRPiAWLPHA3QJPDKlrglzLr5oymebhQfzjY1RwKvambWIcek4hyoe?=
 =?us-ascii?Q?jkESAH4TOeOoPpQ8loXCfNxKs8U7k23sInu4skXaSsKlivlzBuClpBzLqLKU?=
 =?us-ascii?Q?mUuC942TG/C2zHVvustBqMApIb1lswoCkkpNO4HdTh4kcAxKxPDgOBnNVs8R?=
 =?us-ascii?Q?RRZmE6cFBcqZJKiBXufnyiFM4lxxzDwT2JpQCLZT6vFbS7T+RkMSR7jJFWNC?=
 =?us-ascii?Q?+BqB482Eivmy3SD7DvdTeiFTU3RdylwXXlWDFo6TlIF2fndE14yNhcqbdrV2?=
 =?us-ascii?Q?M7ClUe976shL4LqSJlhTYHl+XQWus1Sy0ljbQOc+8avLCRJh96tPIqg1rVDk?=
 =?us-ascii?Q?kWPA+qujCaxFPlQ+MMJXXc2R66AWdQtvJGE/p7oVHGONUeOy71V8hMM8pqzz?=
 =?us-ascii?Q?mP9INpE5oAWDDbIZXSymijHhHcpUOEC5dsJuS5rjnK+aOY2K+/t2Hwu0/zl0?=
 =?us-ascii?Q?J6Si0peG1q6AxVTsys0FgoT/kpnvLsqDjxhXtTFg0iBZHi0Of4dcJRJU9teJ?=
 =?us-ascii?Q?j7k3A82PdG/z0MOY2RR0IQWAdd31qMc3Oa8Y3JtHvQIPzO3C/AOTQAULQMkl?=
 =?us-ascii?Q?ahyWf9s8kylpCNhI4QwWJUUL1ZoHi4eyd+RVOXAJmSdi998ioglY9HpX4uMJ?=
 =?us-ascii?Q?obt+QvjLTcYP6ROAQaFJaibS3MXwqPQAwZXUKEwnOTaarJEsWW7JJ9v1uL7A?=
 =?us-ascii?Q?b7/i5BRsExdZ6CaZs8VJzqJJBV2/z2Nn/F1c3+GDharnhTd1dye+pOnK9QCJ?=
 =?us-ascii?Q?GWRLQKv5Tig2BvawoOLoSrD7ypG8lAjZdP1joEwLYGc9t9WEwQAykHnLA7nE?=
 =?us-ascii?Q?jCOVV/aBYD3e8WHDu2DxFD5gA9Wd31WdyyJ4aK686JawvOC3K6dYX9PyMAvu?=
 =?us-ascii?Q?pvCI+TIMGFgRlywCUE5LDfqxmgcAzx8VHcVWqCMJ52vEF6PwSXvI2v+0JHyf?=
 =?us-ascii?Q?ddokOis/Ib9FOW3Jzp7oPblTXZepCwhlYWDHU3TORlZ2AivvfIHlvW/Jlv1i?=
 =?us-ascii?Q?fm1sSMXOSkVp+KBtxdb+o5z22gaHUNnFUlSn4jxxJIitXnmWgL2WCB2Qpew7?=
 =?us-ascii?Q?EwT4Cw+t2nMp4/1WhO0BqoYoyWPRD6MuGBSrnikTOI2yqR20PlUigmjD/VoX?=
 =?us-ascii?Q?y0t5vcec4thNqDRXAVCiXa3WHVU4HxnvmlJTPXi8O9GVSh0Y8YAGGo9joCZX?=
 =?us-ascii?Q?ByaS7C9kGtt4KvEQ0gILMjocd/+iqV78NivWXD8K9AjbMdmATjt4ZBKKrQ77?=
 =?us-ascii?Q?oUsucFsBzR51CKyI6ouYDlOsPjheTotZuNkua0+m2fiYJ9qga2iJ2i/U0Loe?=
 =?us-ascii?Q?qC6TErEjrwzUft5rqBnGYtnLqZhLDaIoNOsgszGEBFcUq5Ot4WWr1siQOtak?=
 =?us-ascii?Q?RnO2YFcLakbbJHuTdZu7uDantUaG4l3PrtSlncNt+MgNRhgVTnkizoG4gDZy?=
 =?us-ascii?Q?TihKuhCo2o53QkUiMKV/IfWE5MLvtjN88QqarrVQwP5y2HK+NjamhpIicVfG?=
 =?us-ascii?Q?SJ4OYTPUbuJ7dij3ltBe594/77dQRy8CPAG2Pf4lhrxIvoseKNYOgviZwmZ+?=
 =?us-ascii?Q?Hvk53qfOLA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa14a6-be48-4157-a673-08da327bb7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 11:53:36.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw3gJuaoHdD09yBrt7GupNK2dQFrWs+barVtC8J+nM54JlD5WPyjYz3r/WWbncN5OajujbIOESuoSnYfXGPfqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, May 6, 2022 2:21 AM
> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-serial@vger.kernel.org; Michal Simek <michals@xilinx.com>;
> jirislaby@kernel.org; git <git@xilinx.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/7] tty: xilinx_uartps: Add check for runtime_get_sy=
nc calls
>=20
> On Fri, Apr 29, 2022 at 01:44:18PM +0530, Shubhrajyoti Datta wrote:
> > Add a check for the return value of runtime get_sync calls.
> >
> > Addresses-Coverity: Event check_return.
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 8f15fe24a0eb..868f4e587263 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -1100,13 +1100,17 @@ static void cdns_uart_poll_put_char(struct
> > uart_port *port, unsigned char c)  static void cdns_uart_pm(struct uart=
_port
> *port, unsigned int state,
> >  		   unsigned int oldstate)
> >  {
> > +	int ret;
> > +
> >  	switch (state) {
> >  	case UART_PM_STATE_OFF:
> >  		pm_runtime_mark_last_busy(port->dev);
> >  		pm_runtime_put_autosuspend(port->dev);
> >  		break;
> >  	default:
> > -		pm_runtime_get_sync(port->dev);
> > +		ret =3D pm_runtime_get_sync(port->dev);
> > +		if (ret < 0)
> > +			dev_err(port->dev, "Failed to enable clocks\n");
>=20
> So you just ignore the error?  SHouldn't you propagate it back upward?

The cdns_uart_pm is void so we cannot propagate it upward.

>=20
> thanks,
>=20
> greg k-h
