Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7763058F84A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiHKH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiHKH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:26:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224FE6DFB7;
        Thu, 11 Aug 2022 00:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyCO9L/arvtuf6q5q7JWtjcnz6ZiMYrx+qi+hRnpOcVZQxl3gTyvGRBiiDOlJ5i4gWrJrOE2kbA5C21TrRakqz0BvwkFoTVVh9TY8A8ORSilZQGpG27cTyxk3WdrjWGXeQ0nIXYMjjVJ4Xu4lr2KSQvUtSXTvEGfl5lhAl0q1sUL1M0KZlvqY0/s0txMtH+PAk/wUAIBrqHpP7dzS/q9H0oUooROO7TFmHeofrLIONdrVKX0h+1aLTb74Wa1DWXYEDrBLU5Cn8C5NBGE94tSnriInVzGyV2s4wlggjIkM9Ce+DKhxk8rdZvN8hzBwGkb0d+55K7PxhrtKNfWA+YYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmtZ0YPgjR34C0YPwMYtBSgOm671+Fb6M0ZxVC5Lfmw=;
 b=h3knHG1d8LTQ92EL07xwnHopu8XndQDixrqtcP0mr3cKLQW855Tf4i6c9q0tHU8E8Vr5AOloz+Gs7k2DHyaPk6jL+zT9daPLuzA26RFiCJVgmXdFptZ+ROGblLN4OrsiWT+YPqPmxyZocyduj1R5UmG/E7xxGvrN0FNyl4N7vaZhy7Yx6bcj4BESKkHchdlAcadHk1foJcGpsJEJ8yMbnGaSM0m4LxOjsRpRRoHUmLvg6jfnMTPwMC8vDA/87ahzL01ynQycYe5imoPCJQhXFfi0s40Y/qO82GfR1O+1SM2DVpk3/QzoznXg6xCoNADahnlsMxY/UVPq1qbbTlYkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmtZ0YPgjR34C0YPwMYtBSgOm671+Fb6M0ZxVC5Lfmw=;
 b=nAEeEbXhkn+P5fzsF0x2uhogoz/Bic/ZG6h5XAATuhHB0qo/91ysoUo3DwlAP33kxme6Vk83hiODnyqsRsGxYAsj+EiB8LgW2P9cxn44G6pXUGrRYPCUD5oNHQOVV4VocW8QpOp5GK2BJjEvQ1k57aN3zY3kmwMfApjSBcXILdk=
Received: from PH0PR03MB5848.namprd03.prod.outlook.com (2603:10b6:510:30::19)
 by DM6PR03MB4939.namprd03.prod.outlook.com (2603:10b6:5:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 07:26:14 +0000
Received: from PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca]) by PH0PR03MB5848.namprd03.prod.outlook.com
 ([fe80::60b1:a766:c174:65ca%8]) with mapi id 15.20.5504.025; Thu, 11 Aug 2022
 07:26:14 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "dtor@google.com" <dtor@google.com>,
        Marge Yang <Marge.Yang@tw.synaptics.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Derek Cheng <derek.cheng@tw.synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: RE: [PATCH V3] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Thread-Topic: [PATCH V3] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Thread-Index: AQHYrS5JcZ0oNfjd9kKPZtuPd83NOa2pGQwAgAAcoKA=
Date:   Thu, 11 Aug 2022 07:26:13 +0000
Message-ID: <PH0PR03MB58487C980CC7B97FD2A78C7CA3649@PH0PR03MB5848.namprd03.prod.outlook.com>
References: <1660186712-2598-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <YvSDlPTMEBgj3OLL@google.com>
In-Reply-To: <YvSDlPTMEBgj3OLL@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kZWQ4Y2FlMS0xOTQ2LTExZWQtODJkNi1mODU5NzE0OTljZGNcYW1lLXRlc3RcZGVkOGNhZTItMTk0Ni0xMWVkLTgyZDYtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSI1NzMwIiB0PSIxMzMwNDY3NjM3MDYwNDY3NjEiIGg9IlhjUGlyK1hZdGNtSVQwQkdBZlZSTVVjMjJrMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa949498-f2b1-4cc0-b336-08da7b6ac5ba
x-ms-traffictypediagnostic: DM6PR03MB4939:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEtj0l8g8IsXwlUmgXJmu82m+RPZgqWPuEJdCAr3yBYkSxGfPb1BDCvtlW19USUdlrr83eqbnTO6jYSDkYBxfC2FeyNgwBeRTUVR67OzaTB/mAwkdHUW42pvWpkhNW8CmW9ia269XlijhJr+mLJ7zWVuelCb7TlWH9xZXaydzhFaJZL8xh+utsHt5J85PL8TjyUmTi2IkOInzpuhxNj13Xr/fWdker2ysyQar3tj/lkGzdsE6jMkQNlYZuV7tk0GOdtj1Lc9Kva+uvg087PsPOAy/fQlQztmsuty8LGSUrt9A3qyBZ2qljAFBh61U28na4qUv89yA90nZBFSrtg2hkhDvzPyczykdW3DsVMh0fTyE0qcgFXyKRcYvN439I7sTDbPpaaxTWb1Zor1ddZtDRuFeovu12vsttdJ9QOcef6SLdK6MnRZ1qL7fWtdCL7d03BS7lUzq9grE8WNLtJZ2St6in7TSqXd0HhXLry10HRRPbytglRQ5if2YIRqYQjgLS0XJVnwvozDkqPMNUKRbh7AqNUzwuJPT3cm0X6RC4Ggdxjcwm4UjdCuLmZc4VksCkmZrRaFmTgfolQny3I2Cn9j17HXemJNr60B8NHRWuIvKcvPQcjPxJB7PB+dngHOcUQDa/DYJNxOBGR27OLT7rJbnyH5B5+rS5ihdTI2g2+TnawPPK2E8vWjt/6ktoa2uMNadKXi3I35Je0YdApNgEIZZ/MBHGrWL42Fig2lP1YgJEiKE7daHJ5gmbkG4/azjwT94GWn2Jrz8Bxv7dzhpI7mK6h+FKHnNWB4LEb21JMmHoU9KIbQXKG9GunoGz3b3Dk2kWb4krrLnZXeuu7K4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB5848.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39850400004)(346002)(366004)(376002)(136003)(107886003)(33656002)(186003)(41300700001)(2906002)(478600001)(5660300002)(52536014)(8936002)(86362001)(53546011)(6506007)(7696005)(26005)(9686003)(122000001)(38100700002)(38070700005)(83380400001)(55016003)(110136005)(54906003)(8676002)(4326008)(316002)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zNaJjIhI+2yhYURVjylzXuWQhX6bfQLV7uWWFGb2vvwAx9Ui2SR8R3VZZlYx?=
 =?us-ascii?Q?RcjLkTEArkS62XE5PnctUznPbrH0xL+I9nNwB2gJHLqmFXbgax0crravlbQF?=
 =?us-ascii?Q?z6QKA0ZE+E4f3GJkkMOGfkTh1UORHLqnXpSEZLI7sk/+cm+luLp39j+dd6Zz?=
 =?us-ascii?Q?q40Swd1q6gC0uidRGbWhISe4uqHyGMeGAaV3jo0ap7veAksI18xBEcB6qopW?=
 =?us-ascii?Q?NJnvQfRsUD4YpJaZ1p2cgvPAK5TkVzf+0BCw9gsvo58hcFsKc4szhrIIf7pu?=
 =?us-ascii?Q?WpNq1h3IczaG+h2yXP0Dm58qtrL7dbJvsI2cykBrBTf8BjiEtd7js8pVrUnL?=
 =?us-ascii?Q?5XC/JycdEjuc8a3DdHhowm2j8ZxckLsgG5fz9CM0hIXjtcMQmfh1iLCuZPXv?=
 =?us-ascii?Q?C2fq5ym3NelWJMedVTPDelVbAzvADmREcfK+8W2kbKa+l4USqbcw4C2VR3rf?=
 =?us-ascii?Q?Bi0jk/yZcLSp7SHdgmtdGCHKPp5xtjm8OszI0mExK/CcPNcqmoC+Iy6gvZER?=
 =?us-ascii?Q?7H7vt37szA0UizXrkOIdTEs9GuUIPHiPtsQe1TMCXti6cMKRnF+lNTFBkpIl?=
 =?us-ascii?Q?sMi+ARiQqS7dsRWKVj1LHgYUYEukYqRJ7tsyVoGNwNFd4XmbEXJIz8l56aGe?=
 =?us-ascii?Q?UH6I6Og/+cqy7ZAHXKr4TsTtbc9kjUzoAmbnhSQcRgU1AjdzSZYszbmMjDuY?=
 =?us-ascii?Q?5RHIE+70JBFwcGwAjCe6noJu+Wmu4WyD9WiZYH8KlTisjtjjNgunzRfNO80D?=
 =?us-ascii?Q?bkc77vl4dacDzMHozXCdn00ncRLj4+d0xRFv8AQKeuu53BK1Cp+jPzmRrcVZ?=
 =?us-ascii?Q?Apec1YSOU25ycG/87mr3p3TCSVISIhjt9TIJKetksIhv4UQuhZ93JBePxJof?=
 =?us-ascii?Q?JdD2pKtE2lSwPprwJK9PdBE96phQD0DNqaXE8mdfmJRhbdOd4ydZTkoCOhrJ?=
 =?us-ascii?Q?RSvF2hz4h0zNoYvR+S1Xmanpigk/9HtFComFEXLEZ67/QSMgyRmYCOC2vF3h?=
 =?us-ascii?Q?V6jk76EwDXGQ3RkHDsfatSjdWEL+OmlBkx868JhqIPqvq3pfOoA56aeQEwxq?=
 =?us-ascii?Q?OtsVl3zeoCr4zkOgBsqvS1wVuzLrHy6Wyqfjb9EPJfeDdaCb/u/uq9ZOJpI+?=
 =?us-ascii?Q?1Hz4PDCtRaoqXXVChKw0ANRKqyiJFHiOjLiMJ0OmoO4OPMiRvMONYB3PlZJF?=
 =?us-ascii?Q?qHlBZOuizykMzI09+7ZwtIewe5qAlZ5Egb48Qjbcjy/x0rTYnDfzlZa+V9lf?=
 =?us-ascii?Q?lQmM84qv4pELzOLjLZqBoSHXEpQetjzlXweqCUl0ZyeGy5se9igFTDyT1+2w?=
 =?us-ascii?Q?j53RLDtVNuuekIsC+9pQIFEMTvt3U97xxJ56kNI6HQH89TKHVUJfCcWqSQ7g?=
 =?us-ascii?Q?MlTVPWa+59smPYBmVs4Lr7arb3mgTMo005hpY39J0PriZsYv6EVUbc/0obCH?=
 =?us-ascii?Q?w2TcyZHzgTuBdvjyKIxVm5voSjuPUkPf4MnbRQfIvh3eHN65rEz0bM8XEZk7?=
 =?us-ascii?Q?OOJ4SRr2UE/IQ2C8666YX49gBL6KxPKtcZ2hvP0AEy52bmoQpg5CxRnprKtT?=
 =?us-ascii?Q?WwQJU/91f/ewaQtxmhDaunoBw0mrBmDmSvyK3xy5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB5848.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa949498-f2b1-4cc0-b336-08da7b6ac5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 07:26:13.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIIXfl8Io9kNcoqlfew+YKY1ITAq4/6+5vb97/yu6CqJ9nXyZczsdGUwbMO+u9IMhv58eY7erU9OeGX9wvXlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4939
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
	Thanks for your questions.
I have updated the following questions

-----Original Message-----
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>=20
Sent: Thursday, August 11, 2022 12:21 PM
To: margeyang <marge.yang@synaptics.corp-partner.google.com>
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; hdegoede@red=
hat.com; benjamin.tissoires@redhat.com; Marge Yang <Marge.Yang@tw.synaptics=
.com>; Derek Cheng <derek.cheng@tw.synaptics.com>; Vincent Huang <Vincent.h=
uang@tw.synaptics.com>
Subject: Re: [PATCH V3] HID: HID-rmi - ignore to rmi_hid_read_block after s=
ystem resumes.

CAUTION: Email originated externally, do not click links or open attachment=
s unless you recognize the sender and know the content is safe.


Hi Marge,

On Thu, Aug 11, 2022 at 10:58:32AM +0800, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>

I recommend using your official @synaptics.com email address for upstream s=
ubmissions.

[Marge 08/11] Because Synaptics IT's policy is changed, my Linux device is =
not  added into white list .
Hence, I can't use marge.yang@tw.synaptics.com and use "git send-email" com=
mand to send Linux patch file.
After Synaptics IT changes this setting, I will use marge.yang@tw.synaptics=
.com email address for upstream submissions
>
> The interrupt GPIO will be pulled down once after RMI driver reads=20
> this command(Report ID:0x0A).
> It will cause "Dark resume test fail" for chromebook device.

What exactly is the failure mode? Please describe what exactly happens.
Maybe you can also add dtor@google.com to the relevant internal bugs.

[Marge 08/11] Add dtor@google.com into the list of email.
For Dark Resume (https://chromium.googlesource.com/chromiumos/platform2/+/m=
aster/power_manager/docs/dark_resume.md) is enabled on this device/device f=
amily (this should be enabled per board / unibuild family)
It is a Chromebook auto test tool.
Check if the device driver is incrementing the wakeup counts correctly.=20
    Note the wakeup count of the device before suspend.
    Suspend the device.
    Trigger the wake using the wake source.
    Resume the device.
    Check if the wakeup count has incremented.

The interrupt GPIO will be pulled down when RMI driver reads this command(R=
eport ID: RMI_READ_ADDR_REPORT_ID).
It causes that the wakeup count has incremented and Dark Resume fails.
=20

> Hence, TP driver will ignore rmi_hid_read_block function once after=20
> system resumes.

Do you really want to avoid reads, or we happen to signal wakeup from atten=
tion handler somewhere? Is it still valid to skip read if the touchpad or t=
ouchscreen is truly the wakeup source?
[Marge 08/11]
Yes, we want to avoid reads (Report ID: RMI_READ_ADDR_REPORT_ID).
For Synaptics FW design, the interrupt GPIO will be pulled down after RMI d=
river reads this command(Report ID: RMI_READ_ADDR_REPORT_ID).
"Dark resume" test case on Chromebook device will detect one interrupt (not=
 finger data) during the process of resume function.
"Dark resume" test case will fail because wakeup count has incremented betw=
een "Suspend" and "Resume".
Hence, this issue should happen on RMI mode for all Synaptics devices.
This change is used for Synaptics touchpad/touchscreen devices.

Yes, it is valid.
When the touchpad or touchscreen is truly the wakeup source, the interrupt =
GPIO will be pulled.
"Dark resume" test case on Chromebook device will detect one interrupt (fin=
ger data) during the process of resume function.
"Dark resume" test case will show "input" event.

>
> Signed-off-by: Marge=20
> Yang<marge.yang@synaptics.corp-partner.google.com>
> ---
>  drivers/hid/hid-rmi.c | 14 ++++++++++++--
>  include/linux/rmi.h   |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c index=20
> 311eee599ce9..fdaf2c4ce181 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -203,7 +203,13 @@ static int rmi_hid_read_block(struct rmi_transport_d=
ev *xport, u16 addr,
>               if (ret < 0)
>                       goto exit;
>       }
> -
> +     if (xport->ignoreonce =3D=3D 1) {
> +             dev_err(&hdev->dev,
> +                     "ignoreonce (%d)\n",
> +                     xport->ignoreonce);
> +             xport->ignoreonce =3D 0;
> +             goto exit;
> +     }

Do we need to have it after updating the page register?

[Marge 8/11] Yes, we need it to avoid reads (Report ID: RMI_READ_ADDR_REPOR=
T_ID).

>       for (retries =3D 5; retries > 0; retries--) {
>               data->writeReport[0] =3D RMI_READ_ADDR_REPORT_ID;
>               data->writeReport[1] =3D 0; /* old 1 byte read count */ @@=
=20
> -468,8 +474,12 @@ static int rmi_post_resume(struct hid_device *hdev)
>       ret =3D hid_hw_open(hdev);
>       if (ret)
>               return ret;
> -
> +     // Avoid to read rmi_hid_read_block once after system resumes.
> +     // The interrupt will be pulled down
> +     // after RMI Read command(Report ID:0x0A).
> +     data->xport.ignoreonce =3D 1;
>       ret =3D rmi_reset_attn_mode(hdev)
> +     data->xport.ignoreonce =3D 0;
>       if (ret)
>               goto out;
>
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h index=20
> ab7eea01ab42..24f63ad00970 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -270,6 +270,8 @@ struct rmi_transport_dev {
>       struct rmi_device_platform_data pdata;
>
>       struct input_dev *input;
> +
> +     int ignoreonce;
>  };
>
>  /**
> --
> 2.22.0.windows.1
>

Thanks.

--
Dmitry
