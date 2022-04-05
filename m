Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B284F4684
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbiDEUe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392085AbiDEPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D829969B;
        Tue,  5 Apr 2022 06:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7tQemIdpcRBrQ8bTGFjpYFRTMNsOJt1ckqGI8rGNsuLPmh0Xqq9Y5+McdyrcjUTliP5gFyqlL7hAR0SkHEG0nCfS2C6gJwdnDv28v89oETPUzYqwPWRidjxKMzlWz3oPh34/xrnE4e5p9LA1qzzMHCVQBmtGePTKFr/7rM/x/Nl3J6PKFY5O9xAPlAhvZK5VWqz5PAHp0l2pFzmfhzCj6ZPeNKvZ3jR21Ga3XXCEjpqXdwbPfl4Pu+NBm1+NPiXRCkWsl9sfVFuNxjA4NVxTpXZdkNxx5YFUl+cw25k1iM81xjaPBTr+hR+91/1FuJrvfQ6EDAs2mefKZa/b6k0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx4Dc33P5Fo5sIF0XBbjVsXbhTCaIPtH18vX0zQSKUg=;
 b=g8kAC/EY4b1lVNlgyZzxw6xXux91P5vHbSdHKJkrmcna0OC5+k9swZqfmQ4YXPe7Ns0kMSqTs4LlQuS/B9FJxQDcA/+ACGnlyki5oNp/slxwOsOqdDkI+1gRUsr0otuHGgvdn108Fnklp2zmdQPHlz+KaycgkCxsAcvxVhgKeNcA9R70NBDkcLgUk3CnoolNcdyUncDadmE6obqAuYVuzV7c8zjjHWoW8fOOEa70xyf87lmGZhRYKkXn+ogApPzxETTQI1vtFTxzYn3ayM6Q3KYTPaRD74vJlU5ppSUvXlAw2b443QBsxwMmjCciMyqdclKS4gEEFjHEBAl67xoV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx4Dc33P5Fo5sIF0XBbjVsXbhTCaIPtH18vX0zQSKUg=;
 b=OPsaWZhuejhwd0LUL436x/BL2y8YRX7azLRqoTzlhlrU57LyKGAfLKOyVT6kUKyrdlSo+vhn/H3BSQWOm33NqsQ+XSfkAl76PShB8cWZdEDWhQuiAQuLcLaT+dtc7EuP+ptf8jKj3nYjRcvLnf/NWsDKqlKaQbqV/P0DiN60f4o=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:45:52 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 13:45:52 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
CC:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bhutani, Amit" <Amit.Bhutani@amd.com>
Subject: RE: [PATCH] HID: usbhid: set mouse as a wakeup resource
Thread-Topic: [PATCH] HID: usbhid: set mouse as a wakeup resource
Thread-Index: AQHYSG2TMUTOe0FLik6Q66On/waTAqzgwvKAgACP5IA=
Date:   Tue, 5 Apr 2022 13:45:52 +0000
Message-ID: <BL1PR12MB5157F61F1C42E9F9E520EE42E2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220404214557.3329796-1-richard.gong@amd.com>
 <YkvMpWYMhgtDI7aN@kroah.com>
In-Reply-To: <YkvMpWYMhgtDI7aN@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-05T13:34:18Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=aa469624-3297-4bf1-ab16-7c015bc948a5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-05T13:45:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 150e61bd-27f1-4861-a091-d64adec3ba30
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 429fd854-c352-425d-edb9-08da170a99da
x-ms-traffictypediagnostic: SA0PR12MB4543:EE_
x-microsoft-antispam-prvs: <SA0PR12MB4543FF8DC8DDA56ED4A830F2E2E49@SA0PR12MB4543.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+5usKvwU8zjGgGQavveAUfst5Fs5M3TAwiiORCYGXmJjzIH3AZqZcjoBWviGB+EFL3EqbT+M6pMs75/cn3JQQSAclq9fiUxkK/gIDpSKS7riVulRRgR9atNTMUlyCzIUJ2JCUL2DgGgr7Vu2yKcM4R2xzxUqVEyr/57TQ8/fKzaA0UCtVeTqyfwoYvIpUToDZR7FVErFE992dIScbIbhqn4nOkxuyfTmoir3dv5ZknZ30sKeF/vcXHy1NBjLqZGuezISQZJOLUqNMRf7aq6pfy/RcDG4MJZtPhEWjEXNQ6K6fluXFdxWrokCCFBChswqbofDQcKLfkrbjUas3tRJSHN1X1TNK/yzhm+t30t49M1rMrSvyjxiPlx0b3MuojlRN4GdT3KlzzkayDe3OlEjGBZ+1We2WnLhnWVD4b31ME8N7Dr/GSN2zUSFmKhYabsUjkAZI4u3lrNx5+TwMSg2HW5gPZB/7dyJXCqX/b0GSc9lYUMJcEHmbRLE51ky7U/zG7r7ymPFo2hCj8TFFSr+mR+hExTXhS189yL3zdFIHb03UeXBBktm9tkXESbs273je87byun019OkJGatwIrur5J0bX5uklaFpg8cfx/iy16ovpZersQXg/sbUNW3IM4ksy2gwyoyhWRAwWo4xqcvpCglymUZE7OFO8a48YKJdYadgvEm8uIvbH6G7RT/fYXyiLoAZWbbDOPowiC4CQQCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(8936002)(33656002)(38070700005)(38100700002)(52536014)(508600001)(71200400001)(5660300002)(316002)(186003)(86362001)(6636002)(83380400001)(64756008)(122000001)(53546011)(9686003)(6506007)(7696005)(66476007)(66556008)(66446008)(110136005)(66946007)(2906002)(76116006)(54906003)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AxmTXPDIvQqsC+dFjHyWUsxTKIBTEX4RwbawunkaaB9PIdkc7Q7q6VuKLF3u?=
 =?us-ascii?Q?cI7vSdIMVK/uUPi5mjO1uyyjRPwtGZccNa5Yob2qUsfptfg+eZEr/j3OuhwE?=
 =?us-ascii?Q?ed9z/yWRnGUThbH/kYKur1+9gwphv+ltlKPXW6OyuP3F08dYazk6Gn1DJUjy?=
 =?us-ascii?Q?+1mT03F4AvmnIdWvrrrcs54h0NZgoOgfAg4886dKAfrd04DMBTkko6Km6K5H?=
 =?us-ascii?Q?EgfnprJd5+GBirwBKRfbuF2pPDM8OTxwh/4CtYrI2z70PZHcDvM3aClbYmX/?=
 =?us-ascii?Q?01tvFrLUvbfNwAgolNj3dYTmOcks87EbaJuyDGKxRjUGv66QzC/QGpDk4MbV?=
 =?us-ascii?Q?HgExjYcsb5NQYN4tTK89iRV35aOkMHviN5yNG+stZ70xUagcIufy/N2MrLrg?=
 =?us-ascii?Q?X7My2ljA8Lz6Ki0oTnyvCRRyTOOUJeG68p6EXK07RFTzippfsGjZKBVU91rh?=
 =?us-ascii?Q?KRTw2DTm+o2ML3zS40SsQ1Zd28bzEBdZozRhITx3F659lunWUMqg5LUDIbgj?=
 =?us-ascii?Q?I8cthgUzAGhC0J934gD6yuLWtm+AePE3t+Xa2sRZFJAPTv1vdxQi7V4CMpEO?=
 =?us-ascii?Q?tb9+9xbt2di81kWsczHaV/Nq+dn3bz2lzTFZr7CEUqLGkRlWHwSqRvDhUqwg?=
 =?us-ascii?Q?fZUUh6uUnjae/rBl1QbqRKjMLQMTF9Gecxb8rqfvQY9T/3FoJOeW9Gke4Wms?=
 =?us-ascii?Q?5wZPcsGritPq/E/aIrfAOy7ovg7x1DcnslEcBoQbVbro2ugKjy+qmVJ5xtdZ?=
 =?us-ascii?Q?zy3FlT5A8iJvJU36Buw81Spa7VEjSaz2qPg4ExbPwTZsOKgnUbq3Uc+JmOi9?=
 =?us-ascii?Q?20rerqEvixO69kcyWZhzMTSks7u6NGoqe/4QJz3bKVQAtVJ949xOGcHRpk18?=
 =?us-ascii?Q?KThjBExUnS5lDqiwXF7CFJJyZ83OBhonCBb6sDXXZ6TzYyVcG9jxI76uB+62?=
 =?us-ascii?Q?8/I5EXWbHdcrI6YuhazzPPF/1E3pDU6TuY4h6hN2nVBjwdMWaOURSNZyTmck?=
 =?us-ascii?Q?qsW82xbn9MSIVG8jftefv1mTo2K2zsD3aOtErf6g42ioUsElRyxydN42owBr?=
 =?us-ascii?Q?9egVTcFCowz55sf88C/E/TquUw4sfkXLpceNytahnw+NzqWYEgFOmhZRBpUL?=
 =?us-ascii?Q?zNLhovhuuh2wu36cOFENbUkOZ8YS59CT31Pxe2e5GtLkC/UothLe8JmmSQlN?=
 =?us-ascii?Q?wPhMBCcveiqpZuZqLRcCjT+yV3buoRXWHb8ZZCdwk3Kx6F3VpzCivzTnNa+1?=
 =?us-ascii?Q?5RM0KvGUnUKTT0y9e2g3x8z7Dnby/uzOr01hwkaUMUqgiJXIEgoTqS9VWl85?=
 =?us-ascii?Q?LsjmUAzClTe9IC1d2qryoRUoN0PF6THK9oh5ZPJ2vRAOxX0mRwfbPzX3/co1?=
 =?us-ascii?Q?ZbEq4O1C+8ve/uig3i2EqFSB3Weeh0MEpyF48FGD4IdCr+4dZNiAaJfWYQU5?=
 =?us-ascii?Q?ljMoPxMsRMYdM/rRMnpT7HENNawGmggADKPO8wj2YqYLQAdC1XOapw1Eme8x?=
 =?us-ascii?Q?XULUb/wvO7Akv0ZGfgIC9IZOYADAgrTdltmeaf207rnduOkSG565x83cI1Sd?=
 =?us-ascii?Q?i+ZGLzD5CMagtE3cmGl/y7TzZi+cHrXf97u2926kr1xBN/YY2G7wbda5H/Sm?=
 =?us-ascii?Q?SmpBr/ts9/4z2TfLCDxDQWM4q4JpxQY2uwKVV2jRGJGjsQCsqbjiXrzx8V2K?=
 =?us-ascii?Q?lM8JvZqVOwsnWMypUsNvLg7jqgobd0Ek5ckqjSlblla8H8EyvpqkrPrLZJJL?=
 =?us-ascii?Q?rM5tJlFU90qbh1f1eU0bYnWTYa//hctuIda2DP5ORF/8ysP9YB2jI7VlkyBB?=
x-ms-exchange-antispam-messagedata-1: 9XeLi5GwFb/PyQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429fd854-c352-425d-edb9-08da170a99da
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 13:45:52.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHoIwIxFLP5CrfFLOQGj4u5m5UBe555fps3qCkt65WsQUY9OhstXj2LaVDO6tLQK4KEoVkCyNFcWDOBzlZwNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, April 4, 2022 23:59
> To: Gong, Richard <Richard.Gong@amd.com>
> Cc: jikos@kernel.org; benjamin.tissoires@redhat.com; linux-
> usb@vger.kernel.org; linux-input@vger.kernel.org; linux-
> kernel@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Bhutani, Amit <Amit.Bhutani@amd.com>
> Subject: Re: [PATCH] HID: usbhid: set mouse as a wakeup resource
>=20
> On Mon, Apr 04, 2022 at 04:45:57PM -0500, Richard Gong wrote:
> > USB HID transport layer doesn't set mouse as a wakeup resource by defau=
lt
> > so user can't wake system from s0i3 using wired USB mouse. However,
> users
> > can wake the same system from s0i3 with the same wired USB mouse
> > on Windows.
>=20
> Is that because of the huge good/bad list that Windows has for USB mice?
> Or is it this way now on Windows for _ALL_ USB mice?
>=20
> We have been loath to make this change because not all USB mice could
> support this, as well as the "wake up a laptop in a backpack that gets
> the touchpad touched" issue.
>=20
> >
> > To work around this wakeup issue on Linux, the user must manually enabl=
e
> > wakeup via the following command:
> > 	echo enabled > /sys/bus/usb/device/*/power/wakeup
> >
> > The mouse is set to wake resource by default to ensure the same behavio=
r
> > across operating systems.
> >
> > Signed-off-by: Richard Gong <richard.gong@amd.com>
> > ---
> >  drivers/hid/usbhid/hid-core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
> > index 54752c85604b..571dded02b3d 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -1183,8 +1183,10 @@ static int usbhid_start(struct hid_device *hid)
> >  	 * devices supporting the boot protocol.
> >  	 */
> >  	if (interface->desc.bInterfaceSubClass =3D=3D
> USB_INTERFACE_SUBCLASS_BOOT &&
> > -			interface->desc.bInterfaceProtocol =3D=3D
> > -				USB_INTERFACE_PROTOCOL_KEYBOARD) {
> > +			((interface->desc.bInterfaceProtocol =3D=3D
> > +				USB_INTERFACE_PROTOCOL_KEYBOARD)
> > +			|| (interface->desc.bInterfaceProtocol =3D=3D
> > +				USB_INTERFACE_PROTOCOL_MOUSE))) {
>=20
> This is a big change, how many different systems and devices did you
> test it on?  What about userspace tools that previously assumed the old
> behavior?
>=20
> Why change this now 20 years later?  What changed to require this now?
>=20
> In short, unless there is a really good reason now to make this change,
> we shouldn't for all the reasons we never did so in the past.  Oh, and
> proof of loads of testing will be required as well.
>=20
> thanks,
>=20
> greg k-h

A number of other drivers have been adding in compatibility for wake source=
s
with Windows to match user expectations even with legacy interfaces.
For example i8042 enables keyboard wake when in s2idle mode.

So I think what's missing here is to guard this for only the scenarios that
matter.

Platforms from 20 years ago didn't support Modern Standby in Windows
nor s2idle in Linux.  This is a very modern feature.

I think it needs a check for
If (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)

This will narrow it down to just supporting this on platforms the last few
years and decrease the testing matrix.


Thanks,
