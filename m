Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3658588C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiHCMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiHCMqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:46:38 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C671B797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax3vzuJ0QJnsOcBP1/lUMc4FUysn6d/jenbs7TbM1ko25BG2aZzUmsHsFM5rulCpMylIjeBHQOOMdpXxI/jutQ02NOE+cBP6H1FFJjx34h1hF8zjFGpAISjzPzv8UJQskdPTccLMFNsvOhJnqc2tBk+PTFLXNIutPiE4tBgfjFmXkrBrr1CmmSZ/4TbGjJ1AMeUW7KTHNuKDYqIi8Jdkj8nMY5nvgmT+FAT9GT6je6BBliGsWFdJlMR+9ioGJCKpLWEdxHLaoSYFrnyEKBrpKO8Zvc39WDvSMijSv2IF9c/k8zmoYwq/+RKlNtO3xpd6LVYY09O37s0xg6XQEYGc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FebyW1PXznZCHzRTDqW0BiHcsu8Hkryy1xrCCnV4gFA=;
 b=j7ozOc2XnUHQ1PB0dL4XtKvkVPYXH5RBu8hJePbhwJJbHM4n9zNad/aoBjR+BblK7gfVKCihCCBYlIvQHQAJ/nbBSu8QwnTZfJpKHNIm78tzFrE14qZ9Ogp/moPwRaVVEPbYeP1TLFwC8ZRNYf5apc1eAbGc39IZxkc5gyqTFffojvfDVOtlvWqYTtAuCayhNh8CSDje5iHCdp4QzYHQ8BJKIv9/joq3VgW2JZdWkhehVsPxK2N+lBurh0yyEnhiZgR9bPGjPp/cRKyQKyKoCro8KkMztwnoa2LEzQ9BdJui85URn+HsLl5naEEFT9pe0WWsCy9NJya566fwD3XtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FebyW1PXznZCHzRTDqW0BiHcsu8Hkryy1xrCCnV4gFA=;
 b=XNj7NRRVc5R2zuru7ZL6fD6gxo7tlg+wbOFYn7902QfiQJni4JAvPuhLvQsR9Y9AY9LjgIBgowH4gfhNNFKER/1pgQarVmJu3wdzpbCI7a9kJfNkH3pcNAxMd1uF8pHf1GL8NN6EV/4N4+XksbTRNAvxy9/eaL12ze7qyPmu+cE=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by MN2PR12MB4845.namprd12.prod.outlook.com (2603:10b6:208:183::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Wed, 3 Aug
 2022 12:46:32 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec%6]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 12:46:32 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [RFC PATCH 2/2] driver core: add compatible string in sysfs for
 platform devices
Thread-Topic: [RFC PATCH 2/2] driver core: add compatible string in sysfs for
 platform devices
Thread-Index: AQHYpzRm77x5Zzp4lEiUHCnw9SPHoa2dG5sAgAACk1A=
Date:   Wed, 3 Aug 2022 12:46:32 +0000
Message-ID: <DM6PR12MB30827E57AA6000BDC5AE6FEDE89C9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <20220803122655.100254-3-nipun.gupta@amd.com> <YupquKhvLR7zAwa/@kroah.com>
In-Reply-To: <YupquKhvLR7zAwa/@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-03T12:47:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a32953d3-31af-4a1b-97d6-fdb9367d80d4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 283a45d7-5a8e-4f62-c888-08da754e317c
x-ms-traffictypediagnostic: MN2PR12MB4845:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 65BQS/n9sqPSWfj7uwtJH1ZAT26sArgw+qF7kTEdMOD26qtvXsOOglU0OoK5Y8buetun/dRweZd5pk/Befn6L485IAW9FpEdZ5Gmeei7OrSLLd/4e03QZUKbyA29huznNvGzyQFUuFZc4joaK6wOncY42BT+wEWlJOQw+2/d653ycC/eAj75rde0okFRAbTLw0Pv7PZB8HoAYb4mAP7DmARDqep6QCvaOapn1nlIML02sm/uGoNfv6fFF2hZ9VDV8N6z5KGDk6xZZ6I5fXJkEFv9H8PNHE82lm6+1EuhIcPHT/RJqSv7YlNzlAyjtC1UjLKfl/YNgvpqt6PMSsIxeWTafxWvkDzyg2cqVHB0kJ8Zvj5I32/8uLioUkkTWOIMlO7ppE8FDTgDdTUZYKBsYn+vJNnOajBAZwaZsZ53kkABaddknsCyYMh/dso0ezsglJRTueZwVkv+HHA2uDWf99aY0j45+SU0guKwH5pKsRdd3ZDpgRorfroiYKeWA2RYDqqkK6Oug05aziOtWVHZ//0I00gTXIWHpxgJL5krnZoLS/rraQTJKHTuqhaZj9kO2S9dUtlUvjuxYc5GVYRdlZ0NWQlhVCecvuF8giLrm7f1UjQN75AvitNJFEtGCnofw6QfO/RTd+RCxntfKhuv2KgDlQr08iuzVmP118MBH7G/zFL9LxCP0g3TnQcFKcPDBeaUBxIbPJHctsEnMURRbUQsl6iFxoBFX3lF3XE+YQh5glzpKuyWyL+BzhwfYfjbcugWLVXV6zmMb0/fbsc3aWReQ9ZLcZ4WUY99Z4C7qiXfbm55z83x/H+B5vBq8STr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(76116006)(71200400001)(6916009)(316002)(38070700005)(478600001)(66946007)(5660300002)(66556008)(52536014)(8676002)(54906003)(4326008)(8936002)(64756008)(66476007)(66446008)(55016003)(86362001)(83380400001)(122000001)(33656002)(41300700001)(2906002)(186003)(38100700002)(9686003)(53546011)(26005)(55236004)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzkUAbUZequjv3hWwCQ3J8GrwUSctqqcUvZwhlPRkU+GksGY7lO1/WEAUsjD?=
 =?us-ascii?Q?s95IHw8jqboe4dc6HmPvoo7GcelPqpqXL6H0atzsRGJ/X2Vl7oE/OSlXtYTu?=
 =?us-ascii?Q?lmmU5gRrSrlvQGyT1nYgviYleGK0AHemFhh68S4LiaR9MIDRMrADQrz/iWOF?=
 =?us-ascii?Q?LybBWKcrLwdXHXZE+Ku0Ea0ykG48CmmXzv1yedUe2b5QyhkQAxRs8U/GftlO?=
 =?us-ascii?Q?fqndMy6ruQnEp23SmA5LC5cKo2UbEI3XZX4nYog4/KJhdpD+SFCaQUUaTCAj?=
 =?us-ascii?Q?4BFS2LYxvwVDXB4KhW8vJAS99+CXmY18U0M/qcGNnVtNr6Mor6qhjFg/fZhY?=
 =?us-ascii?Q?y9XesbF8EjMA6LZqOd+AQGn/oKxOaJZvVEPnazTmh7EsSzwHtgFujXR2nRnO?=
 =?us-ascii?Q?1tgmtMIIB2UKfGAlOmBDno/+gDaJXoW3FxjynJRV2ZQKJ/Q9Vl0H//8G2A/U?=
 =?us-ascii?Q?2LLQAf1S/vVpFT5YcEEnpCwR4KmNof6ro/Ft5y0diPV/iWUraOkZOiZJiYgO?=
 =?us-ascii?Q?1h1YIPXs1DTMZvA+AyjrmA8DnbsNiV6iLbUlhXIfYaItdHhBYqYkbZSQpZqO?=
 =?us-ascii?Q?J8/vOaApR9JTCGLdjhgQuygLYB6kLKtXuBBgRhASd8OLCkm1Q7Cleg7eMKX2?=
 =?us-ascii?Q?d0JBYai/z87zbvjbve/jFsM8ag0Pll7EADU0CQSzDNRsqhDFhI893hyzHbnz?=
 =?us-ascii?Q?VCkRdQ1ux9s36mfonUou5n8QW9wyxovjfCUE6IwHLcYILQmwRbzi3JT/C91a?=
 =?us-ascii?Q?AA01O8/AxY0jg3K7ckBeBswsEyixdNUXlGq1DTCT4CfGNznmv2ET3c9Rt69r?=
 =?us-ascii?Q?NPUcAQBF6Irt8aibx1uwmd7JVAld4WQ5FKo+NKF8qGgA8n+rMxdwT/ewYN0C?=
 =?us-ascii?Q?Mym8qRvnMhFilkRsWg+G/5te6ehStg36gljGJRvai6tuYeSCEVXlanfF6BYw?=
 =?us-ascii?Q?uPjmeBLw9cPIghhaiMjTklbLBSZTrjK1AD1oXfaPcf2uXfQWhI6/0kccqlvf?=
 =?us-ascii?Q?6/lzMNfnirNH9GQkFZOgNOJMpoYL7oMIYXcMnssjyvLXzybJb/9CC8U6LFVD?=
 =?us-ascii?Q?CHaDp2oiMGvkDpUulpXnD9q2kTozIFqJXas84DCKXYw+/R3NTp+RX0KHvK07?=
 =?us-ascii?Q?zFgI1QTMKBF6oaSFbndM8d/SnAdqNpgJuj2nLWB9At8Cmhs186hRDpOEcIEb?=
 =?us-ascii?Q?4qH8v8GkjmSkgM9P6AA3KsjJQBtSVFmMTjXsb9iCDb7KX8BgbVv6w1jvBRA9?=
 =?us-ascii?Q?keoM0qVqC4oJ8BN7E8GknSv7cxsdVQqn8pFGwfiLwwiDYL+OfKKkg2HU8FB5?=
 =?us-ascii?Q?FXIyDC9bw/3ds7+9JGSFNCJA8qoZPujevrs6vAC5XeQ9tmRnFfN2bGzaKFzw?=
 =?us-ascii?Q?7SN1keAoiUA9z7Sip9MZXIU7VoBXsGzHSfMh6UnclBvSIyG1yvHf/QYoxUqI?=
 =?us-ascii?Q?/wIRHyOlnuzgoL3YnLlATbji7MBlYqyQ6Rmp0xtwWgnJlXvvOKbS9rS4oBlU?=
 =?us-ascii?Q?57RlqmO6XzXBUh0cEizNenH4ulFoSbQjQ+evY3Ap0ENhDcVp2ZoDfDjWzNzn?=
 =?us-ascii?Q?iPQt7Hz92RTMWYxHKRw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283a45d7-5a8e-4f62-c888-08da754e317c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 12:46:32.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBZW1XUtFMD1o8JlKZLI+dwpv09IxR7XI7OzxD19kRfM/J3atplhmcewZ6YOXe+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4845
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



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 3, 2022 6:02 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> rafael@kernel.org; maz@kernel.org; tglx@linutronix.de; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>
> Subject: Re: [RFC PATCH 2/2] driver core: add compatible string in sysfs =
for
> platform devices
>=20
> [CAUTION: External Email]
>=20
> On Wed, Aug 03, 2022 at 05:56:55PM +0530, Nipun Gupta wrote:
> > For devices registered dynamically using platform_device_register
> > API, this patch exposes the sysfs entry for the compatible string.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > ---
> >  drivers/base/platform.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 51bb2289865c..89949f88a0a1 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1289,10 +1289,25 @@ static ssize_t driver_override_store(struct dev=
ice
> *dev,
> >  }
> >  static DEVICE_ATTR_RW(driver_override);
> >
> > +static ssize_t compatible_show(struct device *dev, struct device_attri=
bute
> *attr,
> > +                           char *buf)
> > +{
> > +     const char *compat;
> > +     int ret;
> > +
> > +     ret =3D device_property_read_string(dev, "compatible", &compat);
> > +     if (ret !=3D 0)
> > +             return 0;
> > +
> > +     return sysfs_emit(buf, "%s", compat);
> > +}
> > +static DEVICE_ATTR_RO(compatible);
>=20
> You forgot the Documentation/ABI/ update :(

Thanks for pointing. Will be adding the new sysfs entry as part
of the documentation.

>=20
> Also, what happens if there is no such string to read?  Why are you
> returning 0?  You should not create the attribute at all then, right?

Will be updating platform_dev_attrs_visible() API to have it visible
depending on if the attribute is available. Yes, then we may not need
this check here and would be part of the platform_dev_attrs_visible() API.

Thanks,
Nipun

>=20
> thanks,
>=20
> greg k-h
