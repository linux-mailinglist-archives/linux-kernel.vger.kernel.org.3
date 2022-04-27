Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B151111A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbiD0G13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357060AbiD0G11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:27:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA49231C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlIOO532AdHlZpCFBB5WwcNYpHQPisEFlgEBW/GGuemNiauikOlMYxtPy9FKl3xd4q5jZww46mFRYDwZTnx0jXWxDshkYZagRp5ZdMiA0J1RXYI1Gnh1FjWCl4w5dRQ72INLaYtkRAbcvOn9RYv+QbjLVqoBqdeANO0VVL3S1qw5rtgBtcn/BY7sXPc7uJsvUV0lkZGY5k8quZXkK1/G1OZeYAHAECcpgVOUBCPZwDFRuNRVyVi+tEUkQIcU7F4IICxyXgBz3eThOLhX8e5XeotM8T1ZbnLkN9qU6pntqefo06covKr1O77PmHl8JxnDQ2H6CJ+cQcu2QGGr1c0tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjalfdIbI5NHg6O/Y/aQ2JuvU9UTHxo77i+QIHaRqMA=;
 b=YgZJDJO5znKHZdF1RapIHM1SbgaM71vl7fZwPe/6UIvLv9BGzUHxyxHZ3POtpBjDQ8ECOnEMfzmAqiuDe0COAdheS40WO85CvFhpEt0HoZHFkwuGrBCFVfZgNnrR00JEzUiQT6Edib0tzcKwc5BefRWnodSfbagSNCiolgtXOhCYz0dQWWLtQ0b8CvZd+c0e+D8XUZFcQW+49fnMlB66Ebmw4RvZE4faQZjpJ1k/CsfOQool2P5cmrrnUHQk8i+Qnzqsbe/VsDigz2lK5w1WxCQNXm3ohoO1jZa1vMiMKKrZDsU3Uz0ujE1VBP/iAH/bXtSegCPu+c7444zme3CdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjalfdIbI5NHg6O/Y/aQ2JuvU9UTHxo77i+QIHaRqMA=;
 b=iMVgujXPkmXle6HvfZ0G5mWtPYjjn9IDdqcr91afoS3vx2Cmbx2xBdbn7qjA+SMq8sdmjtYOahIJLMk0ieGblh/cDK5a3AVls4gd9s9YlsxfAvFuNQwoUt5leC3MuO8e7pW68ezWC47JaPVUYheZqFbcVyaGwzJvmIVtndv26Mw=
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AM8PR04MB7954.eurprd04.prod.outlook.com (2603:10a6:20b:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 06:24:14 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::2c34:9cb0:d4b:33e8]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::2c34:9cb0:d4b:33e8%2]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 06:24:14 +0000
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "arnd@arndb.d" <arnd@arndb.d>, "mst@redhat.com" <mst@redhat.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>,
        Ashish Deshpande <ashish.deshpande@nxp.com>
Subject: RE: [EXT] Re: [PATCH] Uwb: Nxp: sr1xx: Uwb driver support for sr1xx
 series chip
Thread-Topic: [EXT] Re: [PATCH] Uwb: Nxp: sr1xx: Uwb driver support for sr1xx
 series chip
Thread-Index: AQHYMiAz39p3qrbPs02DlLTQ7fxo/6yz5sAAgAxoGICAAB4xAIBDLASQ
Date:   Wed, 27 Apr 2022 06:24:14 +0000
Message-ID: <AM6PR04MB6407537BDB702B3D8C2BC73A8FFA9@AM6PR04MB6407.eurprd04.prod.outlook.com>
References: <20220307123732.2194907-1-manjunatha.venkatesh@nxp.com>
 <YiYFlnPzpK8mrLxq@kroah.com> <d0343411-f95f-e550-da69-2fdb15106312@nxp.com>
 <YjCHNlC2Xc1QoTzQ@kroah.com>
In-Reply-To: <YjCHNlC2Xc1QoTzQ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fd575a5-a0eb-4e67-b8cf-08da28168cec
x-ms-traffictypediagnostic: AM8PR04MB7954:EE_
x-microsoft-antispam-prvs: <AM8PR04MB7954568AFFA3094CD48C2BA48FFA9@AM8PR04MB7954.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsN7+iWpNuw7DNt5U7sf7poGny139dsbybS315meJy4GRG9FAGms/NRJrN48vdpDsjLg2RrjAM0wiXqWv5HE10GSwWiV+ynKY42nQ61JdfxPmupthleNTrfeMi17yhsxsV9TcizftlKD1UkkhNlcqdmSVUdt4VsCkuCdrlJhVkdKgYsE/HMqZ+hn0E5GJ0PbaMzemKosQGzCIf8QN3g8q1bKMT9y8jvprycSaAKWwJSwrLjh8OWVAnkrC0Tfk9ssFWO9M1D5QAAcafyH0wrCf447xKeVeQ9JTKbx43kQ4E38jbmAYi3qed1hJmZd6yPbFfSyOtq4KjsblRODwG9Qd90q3h7AaCX6k5UJ5ExGDrqHCyTyEveuvf3p7ASeHMP6jcSlj8dLzgyMCpUYSN5ZI7jeLJG+mk/4JsUct3LWNBoSvDT1nwdroFN4UXjFirSef612mk2PMHwhYRlRUuPnnt/rkKeV3pOSv9gVop7cXCCKMQY1pw1y86ZqJ29lByidlVPAvvIsBqvab91XkYjMUNYli28JC6BuFtDWMnH/lrkY1yzX/xwFukLKFsvn1wbuEwsy8z0gngsU93Vuub+oo0uiScAu/z2sB76UwCwB19MPPgZMnsgTxiNLRGAoubLYipWoeMuaY4G+2bcghntO/dPtfgXq1NvkY699aU9t4rzzDZcrxze7N8eeryTrbbSf99TjU7Bk5p6KJgmdod89w3FFSudWbywIU+4reyXNscUHR95F98eCpA3Ry5Yq/ZeDBASkTmQV4nhk7wk7nNmFWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(99936003)(83380400001)(186003)(6506007)(55236004)(26005)(122000001)(38100700002)(38070700005)(66446008)(6916009)(316002)(54906003)(53546011)(44832011)(2906002)(33656002)(55016003)(64756008)(8676002)(4326008)(7416002)(52536014)(5660300002)(66946007)(66556008)(8936002)(76116006)(7696005)(508600001)(45080400002)(71200400001)(66476007)(86362001)(32563001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5TVabgKmsQ7TR5J63pfZMNa39H3n06FtdGAmTRovvgPGeVkG2R4wP5NMeM9I?=
 =?us-ascii?Q?UcEO8JUtEtILW4vSHZWygkWjKzl5ZwCWnpFDlmygNGap2d/t/XXr7GCgXRUF?=
 =?us-ascii?Q?130HhDwLCZiLUTwo20V4TpvrGexmU+nFNP2ktSM5pNRQa6DlvB5+ug6Mz6/G?=
 =?us-ascii?Q?uymHK7/CDKgNHYibkwR6KPQaKemPzZ+rmXoFG1yhw1/TxgUDe+lJ2HhMIEgt?=
 =?us-ascii?Q?BJK4ge6Vafkr7k1NlC4UQi3c1v1oKp4oVDtC5rccjg86x3Tr9IFGOs55ngAa?=
 =?us-ascii?Q?+HAHT1AulRxso69MmzKdcnMYqYsed22pfbWbmfQVY7c/FX43zYAkItt07Jhp?=
 =?us-ascii?Q?lXPb+XCSIdhgJVrU6zxRsMihjhaBwTQXgAK3MXhOgj9ndt6rdLi312Aya2oQ?=
 =?us-ascii?Q?gWxnPGTkKZ35wr25dTCDoBzkqEK/iGwDm/rjLWfuz8EAjgaagdpZx6I/Ruhs?=
 =?us-ascii?Q?fp6S/6z4qUIH2vhnK5Wdi9DDAlI7WxOi+Zri0RhDtAZt6xQpoTmXGk5u7+AG?=
 =?us-ascii?Q?Mrk9XudHEe32/9aLoksDyZw/KDmwuhbEN7XBHI3WPeQCJ/utjtMGq6zWQZEI?=
 =?us-ascii?Q?T1H+BIO0XL1ZguCbjyuWQ2M4YX1osJHmfP9tNprelhmydfKbF6G6rk1rqEns?=
 =?us-ascii?Q?n9RecQNmeFfiQ3DIngWTr8dqCd/et3rjKuKxgUq6gabhBPnB//LXNLNyW72N?=
 =?us-ascii?Q?iciNez16Pee2oaKKQgc1KBBZ46BfhrTkFWrsp3VgGyKtUMnbfMaLIkdWkkP4?=
 =?us-ascii?Q?fvU/m+3usOYswQBYE05h1g7syTK+va/m2dQ53bODGpxjsjYBkDVkF7gJu4Vy?=
 =?us-ascii?Q?mLHVwyo8GXGRhzK/7DULeMbM7QbwBjbCYxn1PtSXV2sAMG0+dtSh58cUjSXq?=
 =?us-ascii?Q?RiOyTbqV71r8VMMrO++/SagEZbSY1VbFmkInphSk6OvrqEl73wzjEkGPiHq3?=
 =?us-ascii?Q?XJ0FeV71a+IlqZQ2olQQpdcK7eNYtgD6UJfnrLUwOi6BBUkYfXkHSmwmQE0W?=
 =?us-ascii?Q?KWWN4m5FCi2ukNEqIVSQHd6drvkjbIDAbJHIa0c8iADDysdET7c0GFQfKG2a?=
 =?us-ascii?Q?XIhgEKpC8+pQNkA+lFrFGJG0Al6bcpGKoMCuxwrBwHusMBHicQYj+bQEKZGT?=
 =?us-ascii?Q?o64Ck6X0FUtKqDeBhNbLzQ7og87A5N1nd4SYWnM5WhXN3OxpYAzCtXxPDvfy?=
 =?us-ascii?Q?NQUfTW+XUYLI/gbL8IC7g+i+ONe+AuwqTr9BG8SyshsBm8f9b6qLhHzVkgan?=
 =?us-ascii?Q?qdfmxvwyyxp/PXobEdA0i981c7zmaorkXjAy3XK3K9q4mPptoioOZbzzCU6i?=
 =?us-ascii?Q?iosvY+T85EnAa59cSY3P8L8Mjw1W4i2UJRh0khwQwqySjyy1Y8IOkNwCKrSf?=
 =?us-ascii?Q?mO+syuWeEPV8fH4KhVo4+F8+7YAIIjT8uGxaxuCMALOqqjfY4j4BdIUJjHk0?=
 =?us-ascii?Q?/ZpmJ1D5g1GkTeD6xPa8Y+FtRBut7r2Jzi0+c/dzSVkjlmgbfuOBBwVvAMbJ?=
 =?us-ascii?Q?T8jOynEbJI0SHROzQ2c3bG8b+9RXxqbjTEJM6BdAkTcudrS5H1bsMD6nxxg5?=
 =?us-ascii?Q?uo++727X62XjDdtb4eJZj+IMT/O+/NVka39qYx4C+hVPDqHmcMhQpmSoPZmg?=
 =?us-ascii?Q?mNOrczB8OalV//lPzLbYFh/CpQ07v5ZejDsZT+kn3i+vBz0Il9xf0qAt96vt?=
 =?us-ascii?Q?OlNjvlMGjsKseUL0wo8TKrk22JwJYYxvvlrPk3DUDVrRW0c47VMveiP9IHBc?=
 =?us-ascii?Q?tCka3BZ7r+BbxoB5AoI4m+tlDbayL8E=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_071F_01D85A2D.82ED2F40"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd575a5-a0eb-4e67-b8cf-08da28168cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 06:24:14.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecWVuC9wWHVm94ZMAXw4Q3vhTd0iyShGk+3WyCAL+Laa/IS2qYGYSVzKyKT5M1oJAsuX7aXfYlT+B/NQ4TzrRsj9KxP6N2asVywj+DK50D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_071F_01D85A2D.82ED2F40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Greg,

Thanks for sharing your comments with us and apologies for our delayed
response. 
We have done a thorough review internally and would like to put forward a
proposal for your consideration.

1)  In our next submission we will define the kernel/user API clearly with
kernel pre-defined IOCTL macros in the uapi header file and follow the
standard IOCTL rules.
2)  We agree that this is a simple driver which may not need a dedicated
directory under Linux/drivers so we will move the driver to "misc" folder.
3)  We can also share some applications which show the usage of these driver
API's from the user space.

We would like to get your preview on this thought process to progress with
our next driver submission.

Regards,
Manju

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, March 15, 2022 6:02 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: linux-kernel@vger.kernel.org; will@kernel.org; axboe@kernel.dk;
> mb@lightnvm.io; ckeepax@opensource.cirrus.com; arnd@arndb.d;
> mst@redhat.com; javier@javigon.com; mikelley@microsoft.com;
> jasowang@redhat.com; sunilmut@microsoft.com;
> bjorn.andersson@linaro.org; rvmanjumce@gmail.com
> Subject: Re: [EXT] Re: [PATCH] Uwb: Nxp: sr1xx: Uwb driver support for
sr1xx
> series chip
> 
> Caution: EXT Email
> 
> On Tue, Mar 15, 2022 at 10:43:47AM +0000, Manjunatha Venkatesh wrote:
> > >> +     sr1xx_dev = filp->private_data;
> > >> +     switch (cmd) {
> > >> +     case SR1XX_SET_PWR:
> > > You have custom ioctls on a device node, that's not very "subsystem"
> > > like at all.
> > >
> > > You need to define a standard user/kernel api for this subsystem, do
> > > not make it "whatever the device wants" like this currently is.
> > >
> > > And where is the userspace code that talks this brand new api?  We
> > > need to see that so we can properly determine if this is all working
> > > properly.
> > Currently these ioctl calls used for handling proprietary operation
> > with respect to SR1xx chip.
> > corresponding user space UWB code is proprietary and might be shortly
> > will be available as part of AOSP release, till that time not sure can
> > share user space code outside or not.
> > Still if you think need the user space code required to evaluate
> > driver part will check internally and come back on this.
> 
> For obvious reasons, we can not take kernel drivers that add a custom
> user/kernel api without any userspace code that we can see to use it.
> You wouldn't want us to take such code anyway.
> 
> So please, fix that, otherwise this is not going to go very far at all.
> 
> thanks,
> 
> greg k-h


------=_NextPart_000_071F_01D85A2D.82ED2F40
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
AS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049TkxBTVNQS0kwMDA1
LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1
cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFz
ZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIYvaHR0cDovL253dy5wa2kubnhwLmNv
bS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05Y
UEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxk
YXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERD
PWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0
eTA/BggrBgEFBQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlz
ZS1DQTUuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCXkrEk/n54wjg2JrtcnTKg0LPqXzR1CR+L3OI6
4anIZ8etcCMkKecXBWNVGjTEBzF+WrMeLQdupFJrZnntBqibo1+1cM1DOG6QkG1n+kq7JDRsl4Ty
jHWp6v1xuV+4QwIkKHURPiePWpanLrGRiUSYosUDoh4Sc93LFb6gc8PSYe115oWVYeMjWhnnl+Sg
LMXlZ6DtPU/lOO+wjAG7VW4Q9zNUtoDPLgobOZRulywDgkEc2qDHSvmYneia+OMDeLiCtgtazTMx
lZvYHOYvRtQRoj/P/Zu57jhRaBncmbkEKKdVwFddNEhzUoeY8wyO6IMEXVIYycd2jaDxZoe/UFRS
MIIH/zCCBuegAwIBAgITLQAHTNY9heLFOPC4lgAAAAdM1jANBgkqhkiG9w0BAQsFADCBtjEcMBoG
A1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYu
MRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/Is
ZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNV
BAYTAk5MMB4XDTIxMTIyNzE0MjkwNVoXDTIzMTIyNzE0MjkwNVowgZoxEzARBgoJkiaJk/IsZAEZ
FgNjb20xEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgN3YmkxDDAKBgNVBAsT
A05YUDELMAkGA1UECxMCSU4xFjAUBgNVBAsTDU1hbmFnZWQgVXNlcnMxEzARBgNVBAsTCkRldmVs
b3BlcnMxETAPBgNVBAMTCG54cDY3MzQwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
p7zXO6Xoj+J9wqA4JA8F5Im0yO25omqi0gPQnLONC50qyK5UvkMOdQuLKXNGrL17YiQTZ8eC60j1
cwrauplXCP0X+g6o9s37Zij2uyW0CJN6wO5vvxagPrxRUUmK0GcQS+7R54VPnmv6gddxZyZ1hR1t
YaQOWDjFHdikN9ftfHZoiPPrzKkyKfqWLnzaPg5+w7jeTsMX9bn5plCYL6gLr5NfwxyXX1bfzQXs
iZpnFkSmNE1zQ6lQyFs468skEfXSLwzfnjD8kNKeS42uWUoU+QOBQKH+piDoCiORxSE9uH/2SLGz
lcjHuDQVVG8Rc9eNq9VBCRXTlSCDKBmiokrelQIDAQABo4IEHjCCBBowPAYJKwYBBAGCNxUHBC8w
LQYlKwYBBAGCNxUIhYLAfoGO9FWG7YU4guuZS5qSVj+F5opuhLXhfgIBZAIBOjATBgNVHSUEDDAK
BggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBSAwDAYDVR0TAQH/BAIwADAbBgkrBgEEAYI3FQoEDjAM
MAoGCCsGAQUFBwMEMIGUBgkqhkiG9w0BCQ8EgYYwgYMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
LTALBglghkgBZQMEARYwCwYJYIZIAWUDBAEZMAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwCgYI
KoZIhvcNAwcwBwYFKw4DAgcwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgICADBVBgNVHREE
TjBMoCwGCisGAQQBgjcUAgOgHgwcbWFuanVuYXRoYS52ZW5rYXRlc2hAbnhwLmNvbYEcbWFuanVu
YXRoYS52ZW5rYXRlc2hAbnhwLmNvbTAdBgNVHQ4EFgQUdH4BRLKqLMTKyMlAAYTawrUaIeYwHwYD
VR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNVHR8EggE9MIIBOTCCATWgggExoIIB
LYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1OTEFNU1BLSTAwMDUs
Q049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
YXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNl
P29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9odHRwOi8vbnd3LnBraS5ueHAuY29t
L2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3dy5wa2kubnhwLmNvbS9jcmwvTlhQ
RW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIwgf8wgbsGCCsGAQUFBzAChoGubGRh
cDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPUFJQSxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9
Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29tL2NlcnRzL05YUC1FbnRlcnByaXNl
LUNBNS5jcnQwDQYJKoZIhvcNAQELBQADggEBAIWDtPl3vqfcKFS2gAim5XDqwJCsCxOZa5mmK/Vt
w24BwnWwW70GekjvhLB8PztMeH062TygwPEinQWs2hzkI+3zx+aSXKZ9DKNbAFTpgE8er/oOHxdp
InmBKbUc6bKyhoL375CqXFKmxURMBrd8Br6E2oohwiaXXrrF0xwpRvMJnmwOWJqjWQ8Ylfkk2vw9
qxljFjmJIwoFg8AcZSUUZkreafnQD1J0eX+uFJ0rnFGhhm0I0jaH1U3UPQzYXHQ2z4pqPUgQnKSH
cBoxU7I6BAsmYD28hrMz4rExkDduHu0TjjW+dIWZRC++mf2BzxKu/dUZMsm/ThrpWN6r9QHgUIEx
ggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwC
SVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3Jk
LUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJ
kiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAauTLON50nAGANuAAAABq5MMAkGBSsOAwIa
BQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDQyNzA2
MjQxMlowIwYJKoZIhvcNAQkEMRYEFEhRwZ4iF1SV+aQXTDIUnZJtXe14MIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCGSAFlAwQCAzALBglg
hkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQxgdEwgc4wgbYxHDAaBgNVBAMME05Y
UCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UE
BwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2Jp
MRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTAIT
LQAHTNY9heLFOPC4lgAAAAdM1jCB4QYLKoZIhvcNAQkQAgsxgdGggc4wgbYxHDAaBgNVBAMME05Y
UCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UE
BwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2Jp
MRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTAIT
LQAHTNY9heLFOPC4lgAAAAdM1jANBgkqhkiG9w0BAQEFAASCAQCl36FOzMTVyyPs8J12kcwZ67QD
JrHbpALz0HvVq+7d/S1yEJZWqBKpxTD1hrr0cVIkaBCPR2c7aDe8Px416haz5tCYz6bdfkYx4lJ5
dyP3mJ5JxR/6MKTCFEO/5cwdzxhKD/SLfIyU5o1Q/P3360o8bzVEoulvG0xzF2+NshXds7iOiIyW
aHis1SZ2z4yKwFIU6CvIzEFofo8UXp6A1q/F3gFBui99dXeymMFd3Sg+qqGMqLw3QvIV7lK1cPr8
yQ/Civfx6XC9gCDWFC8+lfnnYgxAq91iQrOAssPx+DThcI7Yzfw7PkFtnP5EoFq0EvuOsO2Tw9GO
Sx00xHIXSySvAAAAAAAA

------=_NextPart_000_071F_01D85A2D.82ED2F40--
