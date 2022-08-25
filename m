Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB65A0BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiHYInT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiHYImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:42:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B04A6C61;
        Thu, 25 Aug 2022 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661416963; x=1692952963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wV0QhS3VCHRQxHowKxbQI1OMW3ad+l1UDIty8PHXJCk=;
  b=j60/1BdjWA9NVM0aEvUPhEhoxHMTnLIwGuHT60FtVT2yQZuTgQ4goa8M
   BfPF5EWkU0AXuVUL2vW73Ie9t6U/VjOlQcEK8amlRP5iZMM1kpfPUDvXS
   maHYk7CKSdw+X3yhnPoMrj3ptGU+8eBFpw++G1WqJflWhreCEi8n0q6nA
   1iZzMl8DttvaWy53Bx+vcU3M76UzyHSwFg8UCGu85TlqcYRPzNX83yWdW
   1pY9rhwg23TVmUUXlzhGG0+trkbgkbtWcYtTTr1mRd5M0fA7YtrEEyvmj
   pVdWQ6AUR3H0CVURWwdHeNIcTkzTPcQgU3O7HjKObZ44EAxkukZ+43zDm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654531200"; 
   d="scan'208";a="321722909"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 16:42:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eye6uXYl2kiOVugdZ52l9W+Kqn5s8j5fvj8n+fjX7OCGmvowSgTkiOTwObB4z9ommmMz9yCrZb1DHbqOQAS8QuR69JrdipAtMOkHpYlrQcz2IFlsXv3ypRi01jx+X6yJnWE0nLeQ8yhGKj4Ht3kBRRasXjlMx8DHxirtiBEIN2HMN78zFb1GXX7EFNV3Ttu4UpQq8dTGQkeP3w4foOXPnVXQtfSxSLsxTNLmHaQBaQhSY41mLERPeVtTWsKn1CQk9idlSr03J2URpc1s9zCmWA80Hv5CBcWtFcRmeFDyF5qzc3ta1xZJDJ3P5z2XLT+y6waN+44F1E4sER/++ptW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrf532u505Q6tIsNHrRaTmQE5Y5P56POullQfRkAg6E=;
 b=iJTIcPy+4dI7JzN+biw6Wj3al7GSoo7Rep31NE19cI0SArdYZ6zHp382Tqr7EsMf3Axjo91IQY8yVTif+pMofWpswXjm6HCo0xQub6BoQ1xJ10s+UJVkq47YMVXHfMmRxw/1mG9ss2oSxTqJaVQfZmSst7EV864IfK4VDg8JXBwTM3VHh2jjjkKjwVc2tBXBNQYUYf5K5HIFFLOm+fedYVIKj0+kHqg2tTEu6IPpe2q3qBNN2Vxjdu+ey7MRAEdWla2EpMosfUXVfHi/BW0o7ILT8eKNOJ1ExcrY019jC3tIlKTJCSsiVaH9Vbteq460EP3n3CX92k3xKaEf1muqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrf532u505Q6tIsNHrRaTmQE5Y5P56POullQfRkAg6E=;
 b=o2SaVwDGaBglJ+cQUUvAYqop3p0+mgmaPt/8SnCLdBF/1WlENNkAEMPnQv9IPcRNXbzwYy6DZNFYG53ghS1KVG2De+VnyXz+lfm90brW8TVjUNnSg1+dL7CKKZdBd9ZX2uxAU1O1/zb4SZYR75wNU8z3d/oxO9+VERas9M5SlS8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6205.namprd04.prod.outlook.com (2603:10b6:208:d5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Thu, 25 Aug 2022 08:42:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::eca7:e175:b67:5002]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::eca7:e175:b67:5002%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:42:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jiaming Li <lijiamingsofine@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: RE: [PATCH] scsi: ufs: ufsfbo: Introduce File Based Optimization
 feature
Thread-Topic: [PATCH] scsi: ufs: ufsfbo: Introduce File Based Optimization
 feature
Thread-Index: AQHYt5Yd7MdiBMU/V0WwXjppS39zs62/PhVw
Date:   Thu, 25 Aug 2022 08:42:38 +0000
Message-ID: <DM6PR04MB657508E997AD3AAE5BB445ACFC729@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
In-Reply-To: <20220824084633.14428-1-lijiamingsofine@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64d478f4-2a81-4346-2c6d-08da8675c417
x-ms-traffictypediagnostic: MN2PR04MB6205:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZeaNh/Uj4vfmTwt769IKwK2rD4zIcQgnc/IwvbeqCo+NbsE1WFUxC8i+6r0QB54cYC80Tg6bxHe1qz083Wq0F1h2FxnJNwipWRQbHzRWK3MrQjj+F+noF63eioAl4kNvmnexjy7pF/dm2TvvqrERoI5DYbi6rCWzRcbhb6As0n3Xb3ikAGKI25VrUC3+eVI3KdWrfx0bNd/tUpedp4DPOdJQt2sq7vYQdaVRvsMmI2qGUm+GzkYJRUbIh/zIA2ZTejincCRVVsE7emRqtY1PosYmbZXSE+99JXZ0zAXe2YKk5eSotrzISUBO7Zj0ekiKAFurLixjly/iDmGkVMo29nR/AoRlnE8+uHOjUercDixvK6QQ4twpiswSkCg4K68wc8bJFbmIWGh/uSoeXa3iE9PiW4HpAY4kK65zgGKydQo80rnyxHnTnWPfP4Ig2iFs0T+x4EZTFhe8Rts4VqEgJZYuK4xTgOvhHrYkB4rzSkcs6K2Dj6pDIy2l6P892PtdVEP6LOS5BOVHMeNlhETuEpOKhDEpao62RdQoSQlzfew67WRq5vrgK1i9XoHLSkOZ2yr4864TN3oZk5Kn425qWd4zf83cGhUrmuk4hEDGeSi56+3HJ8FsIDvygw6DBswN5fOsV0ZE5gjH8rzXJC91/VOyvqIt35jNaxPByFtiIVcL6rOLyTtO1C2/F+z9t935i01/3l5TqOzsEsSUM+8MH9ggAN3YEvtX3KgdmWZBFiXpET4EWS96ADqifnVidSzPnDR/BDk0c/mhIU6iloaFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(110136005)(54906003)(52536014)(4326008)(66946007)(8676002)(66476007)(64756008)(55016003)(316002)(66556008)(122000001)(2906002)(8936002)(38100700002)(76116006)(5660300002)(33656002)(66446008)(38070700005)(86362001)(478600001)(7696005)(6506007)(9686003)(82960400001)(83380400001)(26005)(186003)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HfJtwL1xXacNHqR3MVULPoQOecPvfEApuLsHyPvdb4dtWkjwifEj3hz9h16P?=
 =?us-ascii?Q?WvTrn4DrprC+dzwcrI6AYnw0jWfYXUpIKju9hHWaVn5nQzrvZDeflpiB7t99?=
 =?us-ascii?Q?Z7xOe5i5LeDkeNURFAqyMvt62m1lPLKra98NRQJI1ql6MZMDN2CtS3zNbORP?=
 =?us-ascii?Q?pmm8SK8dOmaV5sYi7piXjo8fujdx1uiO3CZ07kOvv0T10HFv8Dc44yu5wQkg?=
 =?us-ascii?Q?c8w5cxwqQqvPujwQb5loGkG1MpRzKKlXU3dkZFJdZmvqoA0gUqi+vX9YQf/e?=
 =?us-ascii?Q?mIHKfi3ImATjunRENOskFMsRZFJi5NCH8ICTl7buGuYHkXKwqmyLSFpUiOPx?=
 =?us-ascii?Q?0eBzPyofFfAWfmQYjsJ9rn29PPmxPe8wcrBP2mQ9HxNYIFLA39Vge7SsgVi7?=
 =?us-ascii?Q?MAObsOKNuIqOtj+3Op0HZBaLLcqByvcFHnlYiox2ieDGPUr6Z+bM4iG9KWV4?=
 =?us-ascii?Q?GepcDde90MQHteXlnZk28gJhzaRSuNUmsAyyv/NQJ8DnecW53JmZllaOKrgk?=
 =?us-ascii?Q?WD3nVCTqN8XYwMnlSAW6nwXsC/upOCp6Bb6AYmv/SmExvzmZpYXdkqPMj9EG?=
 =?us-ascii?Q?6w+TTZnYaHHnQ4EYPelk8NNvh/H6WthTLCM7BkVo0R2sbt2+BS1Y87MuFQ4j?=
 =?us-ascii?Q?xKmYK3BRlc+I2EHi0nNtkaO68QVMLudclV93Jcq+SW19skHniEWzTfjRVAkq?=
 =?us-ascii?Q?zmfqhtPJZYNJiVMIEDbYQ3TfpmC2NeVHU1SAJn1rylz8t5ipdjBN1jLaqNp4?=
 =?us-ascii?Q?qXStVX0QHYV8dxcUBXBsNlleR9FPn3NDmXASaPFP52kOfjApwYENYFryfmvI?=
 =?us-ascii?Q?ZNH40PTNdsRrx4jHkCSUaXIMwrD2smNDG616M8UIjLIXxomBZzPhQXvsNImf?=
 =?us-ascii?Q?jOAGpl2XencnqKTj8tI9bcZX+iTS3H+t2X30jUugUFbCBVf0HqsnRhPAjrAB?=
 =?us-ascii?Q?X6ktusl3qLLM36qQnWmFnh2qUvsKHf7AiMQx40vbAtXY/LIchdV6Ypu2wCeU?=
 =?us-ascii?Q?AqjDnbrGaQx8rAz+R/jyy63vF1FzcmpPT4qq+Ongz5p5HxjYant2Twmzxeqi?=
 =?us-ascii?Q?94GydWc8tPtRZ/Tmt9VkIHKlO6hrOCSvJ63iGBUt3fJntnFxMqB53m6I6XPh?=
 =?us-ascii?Q?JjSreTCRW7dQRYsquUN7QiWrQA3QV0n3dqMGq6GlqJBRqS2unhw0GLMolYcq?=
 =?us-ascii?Q?UcFE+jVnxMl4Jq6c8SJSiHARinMPydv8f+m1lBy0LqA3MHLuGoTgPEjVM3vC?=
 =?us-ascii?Q?bgSSlbMa7vhwq2W4TbfP4H5WeGK4vG/WJ+gCE/wHkap+WCBhTBGsC25QtIsg?=
 =?us-ascii?Q?88KFGWgGARTibxAKild9twQ7OXNy6FjqZlYPwdW4qH6X4e9FfSfZEw0QyMrj?=
 =?us-ascii?Q?8W3Co5HDDR/kP2hzDiI90nMIiRjoiTB9lODi8rEIUpvoH0t//2e8t2PP8aa3?=
 =?us-ascii?Q?z2Q17JoftsJxwfEr75dz2D3qlzq5QBwvgL+OuSnfe9d2Cda2A+LFt7xq8GIV?=
 =?us-ascii?Q?PbtZmXA9nUHRRc+dgOjHafetqLuuS6WomiUSzcO2NY+kj5r8CdybfsvncIMB?=
 =?us-ascii?Q?LQTbts3WVSwdJErukf63RaXsvGeIEP5moZOdqI4a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d478f4-2a81-4346-2c6d-08da8675c417
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:42:38.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSxeIG6gJyYxrtzuT8Q3CMVWBCNxS7uhQVtN0fV5+nH6CW1Nrx/qvmZ5do08uSgioo2BMxp6JaXkhltobSLM2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6205
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: lijiaming3 <lijiaming3@xiaomi.com>
>=20
> Implement File Based Optimization initialization and add sysfs interface.
>=20
> Stoage devices have a long lifespan. Device performance over its lifespan=
 is not
> constant and may deteriorate over time
>=20
> This feature describes a method to improve the performance regression.
> The host needs to provide File System information to storage device first=
. Based
> on that information device analyzes the file system data and provides the=
 host
> the level of performance regression. The host then may instruct the devic=
e to
> execute optimization procedure to improve the regression level.
You might want to break this one long patch into a series of smaller patche=
s.
One option is to do it per-functional flows: Init flow, analysis phase, and=
 defrag phase.
In your cover letter you might want to elaborate what this feature is all a=
bout,
And that your design expect a user-space companion that analyze the files.
Which is a good place to share a reference to an open source code that does=
 that.


> +void ufsfbo_init(struct ufs_hba *hba)
Maybe ufshbo_probe to note that you are probing the device for this feature=
?

> +{
> +       struct ufsfbo_dev *fbo;
> +       int ret =3D 0;
> +
> +       fbo =3D &hba->fbo;
> +       fbo->hba =3D hba;
> +
> +       ret =3D ufsfbo_get_fbo_support_state(fbo);
You can save reading the device descriptor, if you would call ufsfbo_init f=
rom ufs_get_device_desc,
Like ufshcd_wb_probe() does.


> +       if (ret) {
> +               FBO_ERR_MSG("NOT Support FBO. ret(%d)", ret);
> +               return;
> +       }
> +       ret =3D ufsfbo_get_fbo_desc_info(fbo);
> +       if (ret) {
> +               FBO_ERR_MSG("Failed getting fbo info. ret(%d)", ret);
> +               return;
> +       }
> +       fbo->fbo_debug =3D false;
> +       fbo->block_suspend =3D false;
> +
> +       if (ufshcd_is_auto_hibern8_supported(fbo->hba))
> +               fbo->is_auto_enabled =3D true;
All this power management control code is not needed IMO.

> +
> +       ret =3D ufsfbo_create_sysfs(fbo);
You might want to consider splitting your sysfs according to:
 - FBOWritebuffer & FBOReadbuffer - part of sdev_group
   it will allow defragmenting files across all luns.
 - the rest per hba


> +static ssize_t ufsfbo_sysfs_show_debug(struct ufsfbo_dev *fbo, char
> +*buf) {
> +       FBO_INFO_MSG(fbo, "Debug:%d", fbo->fbo_debug);
> +       return sysfs_emit(buf, "%d\n", fbo->fbo_debug); }
I don't think the debug info should be part of your series.
Maybe add it as the last patch if you must.


> +/**
> + * struct ufsfbo_dev - FBO related structure
Maybe ufsfbo_ctrl - as it's your main controlling object.
And split it further to ufsfbo_dev_info - ver, rec_lrs, max_lrs, etc.
And then all other members

> +int ufsfbo_get_fbo_prog_state(struct ufsfbo_dev *fbo, int *prog_state);
> +int ufsfbo_operation_control(struct ufsfbo_dev *fbo, int *val); int
> +ufsfbo_get_exe_level(struct ufsfbo_dev *fbo, int *frag_exe_level); int
> +ufsfbo_set_exe_level(struct ufsfbo_dev *fbo, int *frag_exe_level); int
> +ufsfbo_lba_list_write(struct ufsfbo_dev *fbo, const char *buf); int
> +ufsfbo_read_frag_level(struct ufsfbo_dev *fbo, char *buf); int
> +ufsfbo_get_fbo_desc_info(struct ufsfbo_dev *fbo); int
> +ufsfbo_get_fbo_support_state(struct ufsfbo_dev *fbo); int
> +ufsfbo_get_state(struct ufs_hba *hba); void ufsfbo_set_state(struct
> +ufs_hba *hba, int state); void ufsfbo_init(struct ufs_hba *hba); void
> +ufsfbo_reset(struct ufs_hba *hba); void ufsfbo_reset_host(struct
> +ufs_hba *hba); void ufsfbo_remove(struct ufs_hba *hba); int
> +ufsfbo_is_not_present(struct ufsfbo_dev *fbo); void
> +ufsfbo_block_enter_suspend(struct ufsfbo_dev *fbo); void
> +ufsfbo_allow_enter_suspend(struct ufsfbo_dev *fbo); void
> +ufsfbo_auto_hibern8_enable(struct ufsfbo_dev *fbo, unsigned int val);
> +#endif /* _UFSFBO_H_ */
You should expose functionality outside the module only if you must.
Otherwise, make it privet to the module.

> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 2f6468f22b48..9c377c514e17 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4956,6 +4956,14 @@ static void ufshcd_hpb_configure(struct ufs_hba
> *hba, struct scsi_device *sdev)
>         ufshpb_init_hpb_lu(hba, sdev);
>  }
>=20
> +static void ufshcd_fbo_configure(struct ufs_hba *hba, struct
> +scsi_device *sdev) { #ifdef CONFIG_SCSI_UFS_FBO
> +       if (sdev->lun =3D=3D 0)
> +               hba->fbo.sdev_ufs_lu =3D sdev; #endif }
You won't be needing this if you follow my suggestion above.


> @@ -8005,6 +8014,9 @@ static void ufshcd_async_scan(void *data,
> async_cookie_t cookie)
>=20
>         /* Probe and add UFS logical units  */
>         ret =3D ufshcd_add_lus(hba);
> +#ifdef CONFIG_SCSI_UFS_FBO
> +       ufsfbo_init(hba);
> +#endif
Instead of wrapping it withing other modules,
Use it in ufsfbo.h

> +#ifdef CONFIG_SCSI_UFS_FBO
> +#include "ufsfbo.h"
> +#endif
Include it in ufshcd.c without the ifdef

>  #define UFSHCD "ufshcd"
>  #define UFSHCD_DRIVER_VERSION "0.2"
>=20
> @@ -916,6 +918,9 @@ struct ufs_hba {
>         struct dentry *debugfs_root;
>         struct delayed_work debugfs_ee_work;
>         u32 debugfs_ee_rate_limit_ms;
> +#endif
> +#ifdef CONFIG_SCSI_UFS_FBO
> +       struct ufsfbo_dev fbo;
>  #endif
If you would use a struct pointer here, you won't need the ifdef.

Thanks,
Avri
