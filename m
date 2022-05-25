Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CED53430D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbiEYSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiEYSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:34:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748BB2258;
        Wed, 25 May 2022 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653503678; x=1685039678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IP0rNpL/nWntQHbPuZeQulMZoeQhxYIYj3zDP9t4KrI=;
  b=j7s/4N8nUEeNNaS/DtFwSpiNUu6YujaSsG0K4Lb32vtdZSYxS7eK0xj9
   oyk2L9rv5aeD6MRk+ToecgIsCGsSDM+CJ5O5glFF2od1EFqJDflG1eoD8
   sQYNHvdhph61ixs7vJHPay1GNQrpnkPtUHk6NjDv/gKkKkpMn78Eux3KA
   H3Wzh0s+ESJ8f4XIoOZSOQ5KTrYcZ7Z3xwA4lYErOGxkIh7DbHadW96Oo
   07zxOc2HYBZtmC3zWU8KuK+S6O+8y/Bgt9NpgTaU3Bu8CS/crNmTl67Yh
   Ufpegt0sAWyNgWx643iq3+VlIUk0Jal4uYNsd8qPmIbo4vqmo3e8UvDKZ
   A==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="202265676"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 02:34:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv5C+VLKaUPVLArBqZjcm8lc6uzSRtFARFK5q+1PUgxOkI9NP3ird9sq7Fd+YKNAGfJcn449o/yANdoNhQm4koM3qtxJmptYsWCUVtJPXlzqUCFv6ods3aciF7DrsBZaR4IgmGp2ZVZ/lfYNGluQJUuii0xOr71jhgvLz158QfwvDKjgpl1hmAICZI9KmPhwsdfQrBM7RLgjtHiCZlJKW4Ba0cxB0KiL28tSzV1L6lT6St5ypD7ez2JY6N9uDqC98zBN2UFmiPkTaEQrs0IlTLZObhI0yXnM8UTkah6xbirmzD/dQ7f+LUnFbz3CHuQD+VLxCB7bGd7ZrvQzpbuQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAMDiLEBfJr8VbfxXmFmAMmc5MnP5D98HNsfeFAGCsQ=;
 b=j9q7i1B0G9ABuchUUUmX5fgdylDbJL7/8VrARa+vu1ztXwRAiVqu9kW0IwDmE3bqy0k6GrfGvAGpzgDHPaJrksVy6+SGBrLJD5u4SSlv0t5xWN6acofu2MwPgQ8IA2ygHOJqznWMb1ycEYiOIOr9RRruig5lfrepcauAr/omGbr3DIkhAoaSr0pk9hRPKqSWykUWc5fK7F/aDd2us2fyW7ssNmrxcPh9/9bMJd+9wnGzJVtUqGpoG2lUcDapQTwxY/70c5hOioDdnYk0ZghnjDB9sQLZbVlPsuvI9pGOUzsPGJsHitatkHeKkJJ+aTPOrJaKq/go51n19MqUcJV8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAMDiLEBfJr8VbfxXmFmAMmc5MnP5D98HNsfeFAGCsQ=;
 b=CS7E5yBIy4jfXJiStoTs/kirQ5dmPR82gBlm8+t/05C0aKJcgb88FTZ+OrwYM09aZHroKJfSOMWTpAIvre+Dgr3OHj6gDCV5O5LuKlIZML8kBXd/alTU6LKiTEnpI2+XOntbegM2QyrIkNHCKIoNwLdjaSXPKBM3iMDoLyByM9k=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7098.namprd04.prod.outlook.com (2603:10b6:5:243::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 18:34:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 18:34:34 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Nia Espera <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
Subject: RE: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Thread-Topic: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Thread-Index: AQHYcFYp99UCK0BeAUyoAx4mv1ya/K0v5+fA
Date:   Wed, 25 May 2022 18:34:34 +0000
Message-ID: <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220525164013.93748-1-a5b6@riseup.net>
In-Reply-To: <20220525164013.93748-1-a5b6@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59446934-fa2e-41b3-19e5-08da3e7d3729
x-ms-traffictypediagnostic: DM6PR04MB7098:EE_
x-microsoft-antispam-prvs: <DM6PR04MB7098C256DDF16E26ABF6FF45FCD69@DM6PR04MB7098.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0qul0BGoizQrEt/hhQtTUmWNt5RZnBntAPuRcm7qAcMQJnrYHfNxb2GwiaI6QY1t1lF0XnZoLZAd9vv/iWmvD3XR5p/iGulQqtqYMAxzUx/xVicyFqmDCyOK3Vqt14JYhWzmwmZvWXEDqJdqf8ARd0SAwwzSTBHKSp67IuvJoUJLdE7msWc8Jsl3e8cs/hq/bYaYyyQC3sC7xPc1RqkFM5b3OVOvnhFrfIHnQD891Loqmc9ZyPSg9CGMaXg3gVySFHo9ouOdRqJm4bKssa5wCP3iHYlNNH6LrYPpRV1ZX/i1GRPL90EFKDisGFw8HW/3ppjddqOWCujrUqudklV2tFBklshXPg5AA+wkmzxJ5UgonvHrEytFCMlmfZeekl/GKzeJJG7PaZl/szrpct9mLlm+IP5q+GCJ9wjwiBan/bI1EvE7Xvn11wMLWs0N1Q/MFr5shT09FJ2J1FBzLPVMdFWUqHRDCAXbiPficO1Do/AMVO2esvvvvHSsmbaggbzz8v9bPdgJTCgF6CSQyGqXgug8ei0A1i6oWfRhQbomaXlBBK8A+Bnvkri73rUFQxpoLXNkbDUS/g0c3K0X0Xg2O6a++FvKnMqZVepECaRAQe+C6htFPqi0vO903pVtuG3XLwi3U+iUuPC1uGqzNYAJ5XgiSebPrDNJQ3oEKLUxtOgNKrtKkrjidJ5L5llxo/896l6lVrM4ahBhSCruR5yBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(55016003)(110136005)(9686003)(7696005)(26005)(6506007)(316002)(64756008)(66946007)(83380400001)(8676002)(186003)(33656002)(54906003)(66556008)(66446008)(66476007)(76116006)(4326008)(8936002)(82960400001)(122000001)(52536014)(5660300002)(86362001)(2906002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4qg73AVIj7eOUW6w1ZyOmHa6PVLCvKlle17s4eznkDFdfWC3MYRM0OJSIiv?=
 =?us-ascii?Q?pu6R5pwiejRLIpbotEHy1rEBFeq5hUuj7CEzQ3H/GeeHLL+g47vXHzYPoiqd?=
 =?us-ascii?Q?MrY6pg43VjihvTI9LBHl2sUAWaTyF9YDDG1ZHOjgCLgw6COwyPpd/k9nwxdb?=
 =?us-ascii?Q?qiTkTunBORJ5ruoY37vLN1JEuX7BuSCsHsQ3mOx8eft7KhN2kDPEYFCiUGyC?=
 =?us-ascii?Q?2Hd2v7SeZqmky6nqjAA9Tzot6a74mHTq/8XYESI07zzMOUJWi72ixTKkbWbQ?=
 =?us-ascii?Q?MdoIOlX59I2uVIaOpA5Uu+3ooZquRjaXSrWb60/E7R8WNl+y75cPoJ5n0XdZ?=
 =?us-ascii?Q?FPuuFXJ9ReXOJ0SenbqyQwdH3fk4w8+KEwtM9SfEJ8bo0GOeaFFBjUyYrVQB?=
 =?us-ascii?Q?NoSJ4zSdajlijug7kf4MO9ECE+tOb1SXv4LTojXE73PfmQYPW1WNRP8K4Jym?=
 =?us-ascii?Q?73hpIS+WDNV6+VNfpWPO4x0Axjq7Uaf8tUg3L/02P7pDgwRDwefcRbEjpjxr?=
 =?us-ascii?Q?BuQoKwzMqsXbocbP4Dg7+08j/G8XkPP1TwI/7qFmJR8KnykHEAZPKGuuQET+?=
 =?us-ascii?Q?8BVhimRIg1Ej4Wevj88EXDtYpdGGwsQ8xjNk7Hq0JjCGE7PqLzA2Rsydw9BO?=
 =?us-ascii?Q?0K++qSH5JdTuRUXX1AaEyikkJ53BqDSxKeLz3jWKnjU+ruadvsoWmCKbKPGQ?=
 =?us-ascii?Q?udtswGTh6olsTvH49kRMMJP8hFubHfsE9dvO3T/v/mRCIWI+tPG9uThtfjP8?=
 =?us-ascii?Q?WXyb0T5esT1QE3DUF8moPAxsynDH2cdiZiB8AfXvdBsskHEt9yaqKUMQq9+/?=
 =?us-ascii?Q?fid75i46AVxz0p1mqBsIZlTBUSKg3V/JXnXbC6D49zuWWdAt38swB6TNdk6c?=
 =?us-ascii?Q?Tk/BlsuCsDPvSoRJ/LnI7WDJkUlEIMI+t6xEp0j6/dxt2RuN38FlPcRVtAFd?=
 =?us-ascii?Q?OZE9CcxUMNPAZEjeCcUqZdtXA+YfkwqyA6CcIpIO+1LTdz6sdV53IwIYBZCP?=
 =?us-ascii?Q?X4GHOBsqCFZaBtm1ISA9epvRxNQPilBOKkeRC1nE+zGnq6V5WReH7BJ4YH+Q?=
 =?us-ascii?Q?SHxyDKWw5/U8k/pKdKBT0CjAln7wTTjfDybtDoHBa8+pZvrRXQk+k2SQBRFL?=
 =?us-ascii?Q?IUA2dwz3jdxClPCpJcBQREXeBE/z+UGuIKmxjJC7JIGTi2ALlbAUgNpdxu91?=
 =?us-ascii?Q?SVaL7k4KY4gjMeVV5IgaafCotS8X7QPOkLAVrG2kQTLQwHlJVoBqIx5clHN1?=
 =?us-ascii?Q?gYjXAIivFN9K6Yg8bcgk4GWu/7RljbmUPMHi/76pQPN7e02wxInJFOK77S0w?=
 =?us-ascii?Q?iUpj76ILCM24N9quu5tkR2HhNvUxICAuKzc8WfbZE3AoGRFz+mKfOzePs1jP?=
 =?us-ascii?Q?aMAepmWRYXbgI8dwiq+G8dx+YuK9nn7pnjWAlBLB+fBaLU2/H2YAl8eCsRpP?=
 =?us-ascii?Q?ZJiNz6KyfjeKnJE13BlRRCQutQ+IlGWxS8kGwk0yZqpeBiozFJOrupZBj7Ej?=
 =?us-ascii?Q?XdrZPRzX7lXchpGqudd67WH6WXB+xlRb50eVicJGx+nv/w0KoISMZDAofBhR?=
 =?us-ascii?Q?gFtaJwODxBThN1kuHQgVWBJj5o4xazMaHj6OACVzETLK80TolpqICSBKY7kw?=
 =?us-ascii?Q?fR+lEtjEFlbx1K4ZPhB2I5H2F4nPxU3iiDjsNLc8vwTi7EePfZkCizhGYAoY?=
 =?us-ascii?Q?jHOmkeGIrbWLpMCuIuSdqI67WcqBu5beJo7cT1xjhDBTFtB/4izdTjvPbeSi?=
 =?us-ascii?Q?O/o1ZpMIwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59446934-fa2e-41b3-19e5-08da3e7d3729
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 18:34:34.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuaCDS4Cx+bEAQ+Mojrckeq+pTGH6mfksbmXRy7AgYYpJqsUwyz48XQBWsy+E4b5xN2J++sGzYTdh0iO3/bFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7098
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Expands sysfs boot_lun attribute to be writable. Necessary to enable
> proper support for LUN switching on some UFS devices.
Can you please elaborate why is it necessary?
What use case are you running?

>=20
> Signed-off-by: Nia Espera <a5b6@riseup.net>
> ---
>  drivers/scsi/ufs/ufs-sysfs.c | 67 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index 5c405ff7b6ea..7bf5d6c3d0ec 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -1047,6 +1047,71 @@ static inline bool ufshcd_is_wb_attrs(enum attr_id=
n
> idn)
>                 idn <=3D QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE;
>  }
>=20
> +static ssize_t boot_lun_enabled_show(struct device *dev,
> +                                    struct device_attribute *attr, char =
*buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +       u32 slot;
> +       int ret;
> +       u8 index =3D 0;
> +
> +       down(&hba->host_sem);
> +       if (!ufshcd_is_user_access_allowed(hba)) {
> +               up(&hba->host_sem);
> +               return -EBUSY;
> +       }
> +       if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN_BOOT_LU_EN))
Clearly bBootLunEn is not a WB attribute.

> +               index =3D ufshcd_wb_get_query_index(hba);
> +       ufshcd_rpm_get_sync(hba);
> +
> +       ret =3D ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +               QUERY_ATTR_IDN_BOOT_LU_EN, index, 0, &slot);
> +
> +       ufshcd_rpm_put_sync(hba);
> +       if (ret) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D sysfs_emit(buf, "0x%08X\n", slot);
> +out:
> +       up(&hba->host_sem);
> +       return ret;
> +}
> +
> +static ssize_t boot_lun_enabled_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t count)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +       u32 slot;
> +       int ret;
> +       u8 index =3D 0;
> +
> +       if (kstrtouint(buf, 0, &slot) < 0)
> +               return -EINVAL;
You need to verify that no one set bBootLunEn =3D 0x0 because the device wo=
n't boot.
Better check explicitly that slot !=3D bBootLunEn and its either 1 or 2.

Thanks,
Avri

> +
> +       down(&hba->host_sem);
> +       if (!ufshcd_is_user_access_allowed(hba)) {
> +               up(&hba->host_sem);
> +               return -EBUSY;
> +       }
> +       if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN_BOOT_LU_EN))
> +               index =3D ufshcd_wb_get_query_index(hba);
> +       ufshcd_rpm_get_sync(hba);
> +
> +       ret =3D ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR=
,
> +                                     QUERY_ATTR_IDN_BOOT_LU_EN, index, 0=
, &slot);
> +       ufshcd_rpm_put_sync(hba);
> +       if (ret) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +out:
> +       up(&hba->host_sem);
> +       return ret ? ret : count;
> +}
> +
>  #define UFS_ATTRIBUTE(_name, _uname)                                   \
>  static ssize_t _name##_show(struct device *dev,                         =
       \
>         struct device_attribute *attr, char *buf)                       \
> @@ -1077,8 +1142,8 @@ out:                                               =
                       \
>         return ret;                                                     \
>  }                                                                      \
>  static DEVICE_ATTR_RO(_name)
> +static DEVICE_ATTR_RW(boot_lun_enabled);
>=20
> -UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
>  UFS_ATTRIBUTE(max_data_size_hpb_single_cmd, _MAX_HPB_SINGLE_CMD);
>  UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
>  UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
> --
> 2.36.1

