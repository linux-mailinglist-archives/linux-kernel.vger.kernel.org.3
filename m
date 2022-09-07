Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F925AFC6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIGGbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiIGGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:30:35 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00076.outbound.protection.outlook.com [40.107.0.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F89BB6B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFaeiChXHBOIFb0MofoWMVWRLmytcc/PLvrTuJHogvBpj1snaVHbEPsuxQqEz/aDl5Ko77jKSIMbHX0luHNfyFJLkx7tC6o6ltulmmxF9VVpGPjkre4A2cWb5/mEIB5h2BtSM6L+MN+E8GpZQqqq3SN1kbNW0iTvdZlbj1Qst0mqirEX/ZEpTsiXM0ArMGDC7jJPL9N3oQUivv0BoxNnlN5I8I0OnPjdIspt1aYJoiL461StjFNy9+TrTZgHBz4Bt+azN1biTg5wNLWNaMAQFziL+JRhc4lG6ELnxZWgJkSMRqIiCJxWHWXq/WFsI7djYUFQPqoYc5mkw/+tSj4aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNdQg3iwuxp6Al1VERFT2CgxKzNmj4NZJRAcjCYEi04=;
 b=IvITjqaXGIfCIFIt0H38E4PYu6XOmD3bRBtaYLcERKGPocbSwcHCsHUFh7AkpEBczdbO29+1ISBwx0hGdSIxdGCwLX/iq66Hs1DerCBcbryvkAXvPvnPOJJ9nuaU70Jxv21T6HTCTkqKGU4d676xBcbUySTROfw++7Ha71qSJUlIORLNA9ez06hRzts53JwnfVY+rWlMjoo2v22Pgou7+iO9kEvDhN1fZubBPxms5by5Wcd1MqooGGUAP//0CPj0AXYiyEOuvb9qldY5FxC3d4xRYM5pOnM+C4JXMZyS0HORcmST8W08vJ0zlmW3lOLJFBmFE8EOZpnNDu9kPL8eAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNdQg3iwuxp6Al1VERFT2CgxKzNmj4NZJRAcjCYEi04=;
 b=mOkUAKd70ofh59iY/mItbYtr1019e7fNRhBrObb1k7qfMnRotwPDZmCAfZSLQGlNVdqxYondptmaXFIcgdtdcscrAuYrlp0JvefejoaBqh6bZW7vCFDtfIGsppawEfG1QQoxqw74pxf2xrstaFsBZ86pyzo5x+Xta6jCUT5SmjkBC3tEd0ItAgP7JnRTmieMSziTwCZ/v2S4gMxl3Pw6G1zCGsXqFZvXvP/+jK93YK0Al63kykiMf7F2aQ39C4VpR6sXg8nQFM4smJWGEgV3Q0oRj1SDSx6ZQJZXlHH+DbX+yJ6/5dDe4KJdRa3T8Z3XK/Ot7gS8JEGUIu94eWZ8gw==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by DU0PR02MB10014.eurprd02.prod.outlook.com (2603:10a6:10:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 06:30:23 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 06:30:23 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo63SfrOAgAAxaoCAAOUoRw==
Date:   Wed, 7 Sep 2022 06:30:23 +0000
Message-ID: <PAXPR02MB7310EFC70B711ECB68206C3C81419@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YxdQLY3RWRRuFMKd@kroah.com> <Yxd5oc9/Bz32YFtu@kroah.com>
In-Reply-To: <Yxd5oc9/Bz32YFtu@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR02MB7310:EE_|DU0PR02MB10014:EE_
x-ms-office365-filtering-correlation-id: 56ec7dfd-bdf9-45ed-3a2e-08da909a71db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWeXKsSzK/Oki2ge53ePAuPg9kWrr4+in0aO0mf371j5dWTods0plfZdcmlMolTfL2NP2z9V6721W/xpVl8YRSHhKu1l6o6tyCJATe+nV1X9PoZ328gRQRKKE7rNwGaS/xQkJqeygh4ap2pjNZQDgu6G3E8/M8cAjAZKpZjn/PfLnXXKNgZxpm/duzZrIx2X3085DttEB79Z/2eruzX2wuCWprfYXcabpcQCJwSBnQafSqrJua6mymI2cZhJje7o1PiBsTzLaV4YECdsKhe0DTjGWzgjp0ybVG1m7FeATntsmYH0Qoh0x9AhegF0k9SUAOu4KJn+AmMZ0pJCKBCZf9OX0PnhJsxyVVmqQMhk7PI2w+3huoWm2jUH3SdS6HG2xl6BWxYBmXyO2Ww53FAdwvWnuwiGivnAmSmVd3EtAAIUOm9cIVGnzFcFkC/ojic0O8unngyh5EXaLE+s5mfKDrVRK0QfjQnMe0V+IHx7x+imiVdkrT/nJxV0imVVIhlYy683vsn1vD4xXDumc63IW2EcjXRXVLYIHfMrWK82vt7/XC2U9jooRUA0piiEHnqmNV0gf800ZbWI7+eUHGSaeE7FlHbV5eg5YIfydO3vpAAzQxkqd7OfgCwOkPb54xqrNQ52EdGSD7YjZlwMqjnCFU1czO0eTMWarGUjALtf1eyJfbloUGx0oENDl8A1R8U8ekAHWPJJh2YAlN+3tXfkn7TAxbY/DCZB9ZkXnqXjfV7VGfeNIoSeZp9oXDw/YqHNB1AU2QHCS3GU/o13b5c1PA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(38070700005)(82960400001)(122000001)(66946007)(91956017)(66476007)(64756008)(66446008)(4326008)(316002)(66556008)(8676002)(76116006)(2906002)(54906003)(83380400001)(38100700002)(6916009)(55016003)(26005)(5660300002)(7416002)(52536014)(8936002)(9686003)(186003)(71200400001)(41300700001)(7696005)(6506007)(478600001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nNHQBD6PrIbQGQ8rhpZt9FaXXRE0MyM9FeZSba97cUXWRpb9Z7Njs4X0SG?=
 =?iso-8859-1?Q?xhMJcBYUFMrPeZ9QT11tqsLQ62IsnpTVfIxXSCvV0XGtHW8JeXwS567qZK?=
 =?iso-8859-1?Q?ddoCT7dMXfvMqonEKGzrUtpo/3TbQQbbKKbBBCQsBbhhP9SP8HAyF1vOn/?=
 =?iso-8859-1?Q?fMyN1nkNhYzdU+zdpFaIdwzo+y4fQZ80J3HbLtOtKeXawHG/JCQ/mm8Zpi?=
 =?iso-8859-1?Q?MPZQQzcFMXOrTOa0TgvCfOxxJ6OMZ+VhZfyZz02q4Y5fULuUKdHKu215M5?=
 =?iso-8859-1?Q?XJNCjp0RcSoTGGyu8xrqYnLyv2a9nYN6Ct6WFVzm6DUntwOQQ9lBD67otq?=
 =?iso-8859-1?Q?41LvszaXTYPr2z/BBT3H/hGJyajwdH+hFhAXYG2pD3FEg96V2RtemI68tn?=
 =?iso-8859-1?Q?wOtkUhZCG7caaln4sv7LKnozPf0HB9/hFAXHhImXr71nFbUH/hmOWupV+e?=
 =?iso-8859-1?Q?uFcIz3U/6eZcQrBBmtaEd/RpbZKlpi16sgMd6KiDrAajTrrqJ//bUjBGCX?=
 =?iso-8859-1?Q?7KoHdEKUHW9ijKoTSB6VjoUkJwQwxxSnj5iY5c6IUAuribEJ3BFu0/RLNV?=
 =?iso-8859-1?Q?Co+QJMYWAgjtYasFBo4GePlYq7aYkkXjMhH8CyeHR9PnDsWICU9wM+2rF7?=
 =?iso-8859-1?Q?8SLmRPs3tN/E3mFbt2VqMPcUwBXpmMDb/XfYXuB/8W1WvRzbc3iKV5dB1+?=
 =?iso-8859-1?Q?Oi/hELH6d0LOr8qscqiT1iA+QNw1QqAFRub7QKMI4yd8lkdC1rgiphlVsV?=
 =?iso-8859-1?Q?lXTGXRv6QZRLHbvJ3+8U6ZnjMTKKUOY6ibhpf29cbQetuew81QVoaTHU/A?=
 =?iso-8859-1?Q?sgjgWADHPflOZHLwOvdk9f4BQNzArgmASopmNHMy6GMVuf/LvV44B49h4C?=
 =?iso-8859-1?Q?6WAXwe6cXGXCMTcSFUwleNBoa/8uELNXxtOK4lXKL6c4BL0u6I7nhjSbXB?=
 =?iso-8859-1?Q?sJ4ZZdpdPB5bi4nY5WBsN0Y41zl7YqyO78D+ohIxrBKfkN00u4LuIZ9Pjn?=
 =?iso-8859-1?Q?ETGLxaaYUrpM5d6gi6QIz9h62iXg3BFcSEbVGpxO7k7qPtY8bXO5aUJ7mi?=
 =?iso-8859-1?Q?RxY84loAwpeLLiMUhiHwHeZ4kDwd+ylF5aAL0oV6djV++8FsF4p20bxu0G?=
 =?iso-8859-1?Q?lSQE6+r5FVGYrHPbBZcPJdS6StfainQEbiDOlstmsZpuRy5FnWjjWYc8h5?=
 =?iso-8859-1?Q?JB26bOb7OnceH8cm3VMtCqah1oQtwvuKt9KRQW4Yfo+TzXcTwJdKP9ETqq?=
 =?iso-8859-1?Q?KxWezIvsjzkDkBaeIzl8ojyhgbyszLaW1Ut8EKr+h35nU8ROwiZ6iViHTV?=
 =?iso-8859-1?Q?wJ8n0niGhrMtHm2LYIWqgj5Z0OwNOAMPiXDdOdQb1+TWu1yWwRPFp+APZM?=
 =?iso-8859-1?Q?ZOdg7ReFS+eyXC40+NN7bijYEP0KhAQG6IfNZbBvbDn9fe4BZnvS00Uie2?=
 =?iso-8859-1?Q?zXPpagVYftk9OEfzweJLkzBPEkqQ7H/tTBYXL3PUa0gZLDD/YtVgzh91mQ?=
 =?iso-8859-1?Q?R8ojrCsqoJCeJCZRabvIorTBPQ51eLi3CQm+RnWDSeRT4J6ijSWjBuWlIN?=
 =?iso-8859-1?Q?gQ7B+9Mcc/ggMXM4RWblZC8MGf7HPqt7c3y/iu9NnkvL0/dEdUEy5SeQB4?=
 =?iso-8859-1?Q?GJibBgirx06Zla8a+CwoB5HBjWvV7QdASI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec7dfd-bdf9-45ed-3a2e-08da909a71db
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 06:30:23.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XbOSaDsdYK1AfzxWtC5pOql4JsArJpM1s28D3NeH+DBUQyYunuyhvaNNeIKmrOKEvlCDdk0wf30o8j4udFs6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Sep 06, 2022 at 03:50:37PM +0200, Greg Kroah-Hartman wrote:=0A=
>> On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:=0A=
>> > --- /dev/null=0A=
>> > +++ b/drivers/virt/vsmp/Kconfig=0A=
>> > @@ -0,0 +1,11 @@=0A=
>> > +# SPDX-License-Identifier: GPL-2.0-only=0A=
>> > +config VSMP=0A=
>> > +=A0=A0 tristate "vSMP Guest Support"=0A=
>> > +=A0=A0 depends on SYS_HYPERVISOR && X86_64 && PCI=0A=
>> > +=A0=A0 help=0A=
>> > +=A0=A0=A0=A0 Support for vSMP Guest Driver.=0A=
>> > +=0A=
>> > +=A0=A0=A0=A0 This driver allows information gathering of data from th=
e vSMP hypervisor when=0A=
>> > +=A0=A0=A0=A0 running on top of a vSMP-based hypervisor.=0A=
>> > +=0A=
>> > +=A0=A0=A0=A0 If unsure, say no.=0A=
>> =0A=
>> In wanting to test this out, I tried it but this depends line is wrong,=
=0A=
>> you have to set SYS_HYPERVISOR, you can not depend on it otherwise your=
=0A=
>> code will never be selected :(=0A=
>=0A=
>Ok, based on the conversation happening on the staging list, I took a=0A=
>look at the code here again and have deleted a ton of it and added a=0A=
>framework for you to add some sysfs files in the hypervisor location,=0A=
>but this is NOT where the device/board files go, that's a different=0A=
>add-on patch on top of this.=0A=
>=0A=
>Here's an updated patch, much smaller, and hopefully simpler to=0A=
>understand and follow.=A0 I didn't touch the Documentation/ABI/ entry, but=
=0A=
>if you run this you should see 4 sysfs files, "version1-3" that just=0A=
>print a single number, and "version_length" that does some i/o and gets=0A=
>the length that you wanted to use in the past to show how to tie this=0A=
>into the device-specific information (and not have any static=0A=
>information.)=0A=
>=0A=
>Feel free to build on this for your next submission.=A0 And if you have=0A=
>any questions about this, please let me know.=0A=
>=0A=
>Note, I have only built this code, not tested it, for obvious reasons :)=
=0A=
>=0A=
>thanks,=0A=
>=0A=
oh wow! thanks a lot!=0A=
I'll try it and of course will learn from it=0A=
=0A=
Eial=
