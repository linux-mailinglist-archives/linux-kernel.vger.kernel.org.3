Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAC583CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiG1LJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbiG1LJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:09:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332F1DA79;
        Thu, 28 Jul 2022 04:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpCc1JKPP9tisnWNeNpt+DpqQN7OVI94eQBV3+tt3qu74TWqNxHvdre/PDeoaVPBK+5Wv24KUXCKSvqesVsHf9PW+UBQSPD/CMVXWIldY3FifoeBNlE+GAvdihl5OSYW1z/G5oWEqRf2bGG2FiUjhVXSllgRHJFeIoF5G8FmpU9OIM7v4Oh4glCrWilG8kTlWryPor7ekaGzlYWP3sIY+Xi6jW2XxbBgQzunJZK7HH2Tjgvj0oqSBhkNpivl8RrjiTRY8L0O5RcKq/M2nBFE8wxBdnWU3ZeZRG7PjR+dtkGiauBBsmS83KA9xaR4rJPIJQEqCbIFUGnTIaHTfb+mAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6stJh0qFk3RdWAwHxuPhMmaXWpbwtehoDW2vQLp2rM=;
 b=ib+NQgEFun7Pw3k2x+cdpyUhLcyN02SaucclfpnWO6EcN/w6q4EIq1vbi2+3P7EglP9CFZq6qsJUfoyTw6jPGmDSXxSSQFMGLRf81HfoYix6khIlSJztJtzL8WMiMqxAN48cONo6aWLic+to1l4tv9TJKtBB9BwmOD9nC6SrtIFJKKL6MxfMigLL+9Q3p6SZe2jyRVhzpe2WmRCpClusuI/Z4DQfr1Q1+qugdUEXd0gPWdwwOGjORS2XKFYQV62mbO2fH4INwPjDyOk12RER4oyRx7j7+XrWV7tNO29rpE6Ibv+RAaRJzT0gKxT9Px1n7kjFu1ygtayp38M+tmHqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6stJh0qFk3RdWAwHxuPhMmaXWpbwtehoDW2vQLp2rM=;
 b=NmBwh2Elkzcvj+I8B/Th0Muaw826HCeUSjC+krUCElDHmm5gMdvnEAb32nv5GAWvCRIRXWmTrMp6zGod8lK7i1O5Z97eHLVsn1KY88a0Ey6pdm+2uqcPEtbhrWfEvu/TlHny5B+Y2yeX5gcVD8gvMoadh/3qGekF7cPNdW4ZQpc=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 11:09:10 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43%5]) with mapi id 15.20.5458.019; Thu, 28 Jul 2022
 11:09:10 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "git@xilinx.com" <git@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] tty: xilinx_uartps: Check the clk_enable return value
Thread-Topic: [PATCH 2/7] tty: xilinx_uartps: Check the clk_enable return
 value
Thread-Index: AQHYW6EqMuz43OxJzkuolr5SveuHGa0QzCCAgINhhhA=
Date:   Thu, 28 Jul 2022 11:09:10 +0000
Message-ID: <BY5PR12MB49028F76B4701BA309913A6181969@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-3-shubhrajyoti.datta@xilinx.com>
 <YnQ4e7afL/ghGnA2@kroah.com>
In-Reply-To: <YnQ4e7afL/ghGnA2@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-28T11:09:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0510c3ec-8586-4c6c-b7a4-d6fb74a96283;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f4796d2-09a7-4b25-5418-08da708998f8
x-ms-traffictypediagnostic: CH2PR12MB4056:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8t3QSHeM9CPOxjzKfOj3QjDnan/83SAUPj+SWnRulbm0TAYHSUfw5sByP+yIYj/Cdz50fLK8ryiu5snM3+tjk4X9Hv7w7AQXTFKgyc7DrCpsOvdYfESib8PnAito/mIZBBZw8/cbsqY/itum6if8r18EvCq0p4sqp3Otcm6qyV95T46yGNdObYowmfmcDQehpLhCDyu3Llu8pDZYKPgri+J12P0HnRm+35Wbe3MHVNkgiY2v4ArieUK99+NZ7tk03pJAeW/36xYhRtay9AOYgz37FpeAYFpU/ynqlpRMygNiwb3DVUo7UKzqXoJN5nJhPdJ7/B1rl10Cjst9ys3Nlz1ui5jblBokNnP1psLLV0a51mptJp2rjpigTGGWN/tj0Q13r2V4EW4hM8YKIPqh+czyt8wMZLfb6yTD6HoomzbMP4PkC6lTJAK2Wx+wXE15xmZFtYJ3w51f34wbmxHKhGDmnIzJRJgIgioUiuBfsFyVg5MkoxaQGVAzCWHKow7QfvRbQJKmwqP7wB86HnyL7ZQN7OIycky1/rEZ85ZwTOQiaN0Ak72xePA4VnINU7MW8Zw5uoHag3wSzchj6r3tqgvIqRH4AVP7MrGkgdcbk79DD9aaGWf0zln8eUSuJXpZcsJ+Y3g+Kkc3Px8W70iUvbVzVk3Me35lYqtDfzh/NriyjexMAOXFng9S0UGTEPR65vW7CVALFnZ72I3hjh7wJP6fdE0QssARKkQaS+WEVeQ/1DABGJALKebLanBTJQV/L8BrYDw9i2eNdY9tw+Th4aLczL+LyM3bWXgCLY2rHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(26005)(53546011)(66946007)(122000001)(71200400001)(76116006)(2906002)(64756008)(66476007)(41300700001)(83380400001)(66446008)(4744005)(38100700002)(33656002)(66556008)(110136005)(8676002)(4326008)(55016003)(54906003)(186003)(9686003)(478600001)(86362001)(8936002)(38070700005)(52536014)(5660300002)(7696005)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yPmZR8czTwsE2HpkuPn2oMzcrdtwfVlkhiFWkCQfuOyDgLYGZ2YUj7oogNI7?=
 =?us-ascii?Q?Q7TQTymodAeWDE8QmpPHeGQPLRKMX3Au+NU+O+Mhur9Wys7PQ+uy2owRtDDd?=
 =?us-ascii?Q?YHT3mG2VfEEUQJhQcFxrTx6tNzApi+i+nDHYAIxr0ueOuc7BkbtXQuBvlTOG?=
 =?us-ascii?Q?ibDSW+zYfE1eI/xr8uVO6mGJg5uAoQwDH8aZk+IkMR3TI0lxf0tULkU2RgFz?=
 =?us-ascii?Q?9YzsX8GiDPKYTTlNApKSmR2POnqgqtJ+A9SG1iebq+fIUCdjWCHWKI9IdIsu?=
 =?us-ascii?Q?8wz5IGxFD0day0xc3hUilWfTdy27BNiG14yG3H+MrOJATsKqfFWzDY0O8fWp?=
 =?us-ascii?Q?MauLJvXwqoZc/hnnwFs5Lqeiu/mT0A3vry9QS5mMTDwd253MHdgK1OEI3fgX?=
 =?us-ascii?Q?gdpQ7Gz/eu3f/J4tF3LvnZe/rE7XgT88nnl9eaV55GBqA+kaQf6LGj1BY1DT?=
 =?us-ascii?Q?jIVuycxuT3cWH720CNyuyiUI28MFlwlvY8FSAYnW6QamJSjs/85ewasG2uow?=
 =?us-ascii?Q?V2PXJ5p2dLsK6/Qfwt4y7/bLzlqprwecbbL5SZBM7yu7GtvJbGk7Juk6zpSI?=
 =?us-ascii?Q?xJXRhkxcgwJ2zZj9KekXJu2MRAcXAusf7PYXIriTN0InFWKD4BnnNvwVF9HK?=
 =?us-ascii?Q?cR80sJGYqjMNcCyVh0Rs64cPkz7SjA4rELvOavF26simPzI+QvXjYRYj7YyH?=
 =?us-ascii?Q?/rQO2+tX8U6gosFb9try1OGL65MNfvUU85zEp5M6QHYjtBfqhY32QUJRwG5v?=
 =?us-ascii?Q?3MEQeOSzo81KumJxYt3VlFl29wyaW0k5vbSJaJW5bX0B5eeN3GXnAdOxtnNq?=
 =?us-ascii?Q?gvER8s5TIWw/jYfliVtJWfJuxpUZKNFPUrpGRTP0ym+oznDTbpEmLPX7fSYm?=
 =?us-ascii?Q?e6Km6ChRHdWqf5qZnSTHexWhujt9eAA8Scd3JIxE1NrEhbNZcUqAvY29jwas?=
 =?us-ascii?Q?iUhWHWMiKyEYxXyeOT2ZpYOQlgkqzrlWhLqUpVTp/9l/+qYiykDrR1ivd9Zd?=
 =?us-ascii?Q?5hZSL4wl0j4gaJkcgw+RgZ1mi51agneStKKWjTuwlue8hg8FuArO/GcHUuEs?=
 =?us-ascii?Q?UXAxPPOu/FrudSB/zRmk+UBOJQha6yVZx4IGVfIwYX4oSwthkuzirZbyMjmH?=
 =?us-ascii?Q?0zehoLTTEbjRuDslURPuVCUomJp1Y9zYSVcy1QVolrcAziCLCNyXxSp2SXGk?=
 =?us-ascii?Q?FFT8c51TN3s0XrxdNOA1/I4odaxJZMTet9xIVCzfzWBuBKgPne91glMSOTI4?=
 =?us-ascii?Q?gQ188+FdZWbD8K8CAy90A/DKi7q2GMT/I3s//0lvgqsyom1i/HsREIB2Ftzx?=
 =?us-ascii?Q?GSCQHM0EIgu7sgfncsyIPjabr19SsffgrKn1RnzOnuQO75IFnP9xtPw3FUuB?=
 =?us-ascii?Q?Qui0NcJ45Mbj1Hr7MdxDYQ5elmethTb7jNu4N/VHBh6bOXRT0k9x+Q1HtjqJ?=
 =?us-ascii?Q?AzXVhGiDn6NQ58/oTDe7SHagFZP7+O7b4FM9hnrFoqGuHLkNgIB3oiS/wYSG?=
 =?us-ascii?Q?MBBB4ldUl7ViHtOys7MgiQm+Bt9j5Z4wvRylXPtJ5VtDpT4o5wgFjIPaLeAu?=
 =?us-ascii?Q?tnwuQKp6dla0bCkf7/c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4796d2-09a7-4b25-5418-08da708998f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 11:09:10.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3hX0XHxkV/abPoqaMGyKLZ9AWMB/HGqSTzn38GmFoZ+rBg9qSQAxlM5K9Zv6a0RBMjgu7Is5zaTMgqFovi/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, May 6, 2022 2:20 AM
> To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Cc: linux-serial@vger.kernel.org; michal.simek@xilinx.com;
> jirislaby@kernel.org; git@xilinx.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/7] tty: xilinx_uartps: Check the clk_enable return =
value
>=20
> On Fri, Apr 29, 2022 at 01:44:17PM +0530, Shubhrajyoti Datta wrote:
> > Check the clk_enable return value.
>=20
> That says what, but not why.
>=20
Will fix v2.
> >
> > Addresses-Coverity: Event check_return.
>=20
> Shouldn't this be a covertity id?

I could not find the warning in the Coverity that is run on the linux kerne=
l.=20
Somehow was seeing int when I was running  locally.

>=20
> thanks,
>=20
> greg k-h
