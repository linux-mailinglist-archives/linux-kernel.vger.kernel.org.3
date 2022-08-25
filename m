Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6F5A0C00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiHYI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiHYI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:57:10 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F53A833C;
        Thu, 25 Aug 2022 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661417814; x=1692953814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VVyg3I7PHghheCpl8k3+YDXCSMJ7EmMF6AEsi2N51Ks=;
  b=PmOp8JskYg8/JgdGAis1FelDE4XbEFepS4UmbGvkUna08sEszB44RnMA
   D1WjsQdSNP2Lr5xNfBdU7acHvOpnqio+w0uD50Osr0fozO8VJBT43dcl8
   13bse2m8ghJezX68SSJJx24BBTLa50nWwX4F8XGSIIaRQo92yv/mS3jpo
   BHNRs7QIMGqLCcTLxAJ6XUGYS+tlY+N7eSzYQ/0DC+GqeUbhGHv0SQBua
   srNSkfpW3EVNofUYjyD2cn+ya2at4TeQc6XBu+vAKTPF8uFuqMQULQlGx
   jt2fYSscfe/vtf3dmib+FIRRtmJhXXi6EX96JQRr9TUlRJog/BtGHICB6
   w==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654531200"; 
   d="scan'208";a="210130067"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 16:56:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvI0UIhmx7ggj5BboiccIyhZ3H2AZfq2fn97KimP83LzUtXEyrOOfjSIXyYyl5MQTY3O/JzDyAHBTBms8d8KUxjio7Q6mIOCU6CeywOYkMmm1ShfvB02DmQ/uMlH0JZ01XDTqjieIHyk93KS7W3CO+ZslKXIc1cpq7BK6zKNcykWt4nb/6ZNhRpAp/jDqITN5l1yRtojwUDiJ1YX8L1C93/0plritOb5GL3q6sgvDINATJ6C4TrQyArKm39dXc91X3LG7X1laPYBFhTvKyi9x6CH/4PCP8a1SOcZRsUYmSuDgFOGq3Oe0i//S/AtruH1BO7iMleuVQqrt6iOmB4YHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKChf4hS7U79euBbGNgD3c+25RLaFE2r1Z8olY3eKBQ=;
 b=GcIRXtN6FT3tWg//pulDg6qU1iHXe/CgDr8WelPmR3AT0kAAWbu925w0APMwXVDm5W8pMyFdHfjXI3KXm3uWipCv56A58RlJdNiNJkw0G2pvFM4ovUC5FILirAuJ6hHKtkPKGE7ljTB6bjMzWzjx1StqKNA3iS2MMr5nFRLJtF2AcLda/gJgZypN1bYo48h4ro4UYCnS5GV4L8oewVPQyFlDutqC1EaVoszt5jFBl4FB9kxPb2uhtfCfSZ6DKTKbaU4sJbb1VHRuJzrZEREQFowxiHv3tOkHRGzIINB5kM4ZD9JoCWFmvmEzvaGjRpg2rb6Yai1Q5QUkFGTo6KN2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKChf4hS7U79euBbGNgD3c+25RLaFE2r1Z8olY3eKBQ=;
 b=h2TGXbIfGH/OZQZ0/9s/hO/2rZp0sOcpJDKXovEoPaozu0Ebxb9SDsiDnbunlFCgMvc5EKMReIVIm91fs3x0vchVhO0eBLptz7YVSkFWyahKDXlJD0tPMIci1I9Uv59P+joUv/4xOYpndU5E4jTaKXuEfzLyXnF2uo7MmdP/MGk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA0PR04MB7452.namprd04.prod.outlook.com (2603:10b6:806:e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Thu, 25 Aug 2022 08:56:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::eca7:e175:b67:5002]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::eca7:e175:b67:5002%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:56:50 +0000
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
Thread-Index: AQHYt5Yd7MdiBMU/V0WwXjppS39zs62/UTVA
Date:   Thu, 25 Aug 2022 08:56:50 +0000
Message-ID: <DM6PR04MB657511C55B06E40552C03378FC729@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
In-Reply-To: <20220824084633.14428-1-lijiamingsofine@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1161552-ef12-465b-05cb-08da8677bfc5
x-ms-traffictypediagnostic: SA0PR04MB7452:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvSBhxX26WTVmBHUlenjghSCTFXKFEKOwL2eqTgY39LhJ/M6gGfDYNY90zCN3SP0WBuFUxtCHU4pcklXi1xZ7HR9mr6Y7xVEXi5AyONJo37/LcMqc0zzsjnEsaOSBKS5DN/6jptZ9Mqlb+vVsqt/VqWdp1k0dInBiLARKteI9KP2njpzj5XWmL2ZFkVfYlyTbSBWhEs5K3BqNbnXk2NSOK9u5wCaAWpzixTlnxtnB+bE9gbFEpVQmnyzhlHM7V/4Tcjhhqbrm7S34qARfCoTtiWkNMQZIDSrrvnCqOw8YPoorXjjmaQTV2ai/xjfDMZ27Q+AbKtpODJ7z/cfDIIJlfh7wdi7se77t9MumQsQUlrhxqy1dcW33LFDwVQIz3RQm1dmDk5kEWoV7GC0UtaACzv7s5Yi7O8cldGV/htXPHjdstQFTK2L2LVE3UU97Hc/BsXiu5O+bgf5aLi+f/75Coy40ZdXUCJqf6Du6FcZAEgJC8JWZeujfk65gd8FLAOnJB9hys/ARqMrA8LZ8uf+nTWMzzfMFenLuxL+dy1cekfDXvs5QwU5HptKmMqkO+DaSlBg6OY0yuxu3rIw0fZ4D3gQBufQwkaeT6AzLDvNQH2UyIRVNFAugglzLDqkr4uT1sAq/LK1BzRfmXJseyqT1o7InCWTpKvIcpbxxUW5narK4qj+OCq+Mc3eh/KOTAtY8ZoCNhSO/kBAICv+hrlt6TAxRS7QccspuQU/MkLSdUBj0myg9YmiKPooV2TXeqQJgy31rWQUu31MTrrYn9+E5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(66446008)(122000001)(82960400001)(86362001)(83380400001)(38100700002)(186003)(38070700005)(110136005)(76116006)(8936002)(33656002)(4326008)(52536014)(66556008)(2906002)(5660300002)(54906003)(66946007)(9686003)(41300700001)(71200400001)(66476007)(26005)(55016003)(8676002)(478600001)(6506007)(316002)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pbbn2YXWxerJh7wu8afuVQHlb0b9M66T7pmj09OeSJ79+2SuBXbXpLKd+cY3?=
 =?us-ascii?Q?pA2Xwv6hpo5clAoUc9+Vt5AOueUXpeFbeEiq2QyC/T8ML3yk4BniLnwy1NPo?=
 =?us-ascii?Q?u7cacc9HHXmxp/Yf5MU4r2YMhdfPYQHxbEZEUjwcHXQ7rgNqf/3jOsartZyi?=
 =?us-ascii?Q?Mtbv1S9gmHe9Zogoj7rg3fYEEIKg1MhNAKtJ/ZntO4n4gpaeb18hewczYjIw?=
 =?us-ascii?Q?hFMv5lbDq0NX9kScT3p7XBUk8FyQW8JW6JCyDSKiBgD/WFu5nAuuRca/LTsh?=
 =?us-ascii?Q?XJT8l9pyFomiPLlSbjCHE0NAuR21Oti1ESTHr2yRsiFyc7uJQ1r6S7aUkfeV?=
 =?us-ascii?Q?xQkj5e2/+3/hFOYlCFo1iZ7SS1iipMcQ7zEJbMAV6f6wMvouRGONRgg8H3kv?=
 =?us-ascii?Q?NzCkvtMfbK+dan6zZpVB84z+hSYNr1kxQgUMYadyTj8JOweDUUiLgHK2fova?=
 =?us-ascii?Q?LShvO2+7B7UQwHENoW0IEV4X3tOEfDU3NWVF2KFjb/q5Wu72vE2vmV2ndxte?=
 =?us-ascii?Q?gXRU1K5yb5mHt0KAYoeAyvJmG3ueVfVEcZ0LxLmbmK8RutThET1e2qdVCL45?=
 =?us-ascii?Q?xcyQL4ASpfGHFtEyuU+gHfhnWO5y5TUjw0wmuGkqNo9D3yXild26VPTLnRIZ?=
 =?us-ascii?Q?bQHr0ecBRbtMjrnGSJQaB0R+sdeMbieAdu6A23WAiEBAKvGWPvDrIBXnGPgk?=
 =?us-ascii?Q?GkH+ZEEEZCX6iVXUKo8A8xiBlrgEjoeRqbs1XH00Gb2EAwUFODcFGnsf4gdC?=
 =?us-ascii?Q?GYEGtTY6f3eFA2INz6+3Kqcu5XvbuDoE/aYyQJIhFavqkoGcOYff77ULwRJc?=
 =?us-ascii?Q?21Fe8MvNgRO89D/HOioqZNMZXPDof715d3uTq4HEZxVH/PJ8Bi/VGh2AZThn?=
 =?us-ascii?Q?ctzyapWI4D/4P3bzXCrhriVpdlCc8+Tzl7kaqhF0eW2YOLOgq8tW6uLqpYsv?=
 =?us-ascii?Q?dNPYx67IfKC/BCJTZv+ptvCXRp8x9tRwS+8NsbskBjlyjx6ReM5byoo69NpJ?=
 =?us-ascii?Q?9FoAXo29t3iyshRod3z+QrfQXcgg8oQyqmwXTaT5NGlykJQGDNIoPbCIkzWn?=
 =?us-ascii?Q?/MLi2LhE0SZGTn5ILsDggD6Z5kfAYmwFkSiSUTmr17Ve3OxRqEx+DeNCS6Sr?=
 =?us-ascii?Q?H6NGfNwUCup/LAlKTv9E+Xl3f8ok84rZ7YKQLrzheqX73TABn+sZvu62X8yq?=
 =?us-ascii?Q?tmhpr8SYtjfqid3s22ffXgpM1O3DfjdDAI1G1BeCWz57RY5QY4wOAHjpCZp9?=
 =?us-ascii?Q?00vQPwxBC96VGA7cujml9DsodmnACo395/lJnmdudJrMNp8BEvCPQXzbSrCL?=
 =?us-ascii?Q?afOFVRIKEQ6ZNgmbRa1zeIRuinA+RvO/n4aBZvOsZtHbTls4AtgdcZyZdzh1?=
 =?us-ascii?Q?dBNGoYCsdQY60TxmnmeOFSaxs7PwxKZY6l/circ79lPaiUH3zwaYjEE2heSl?=
 =?us-ascii?Q?d/Q6IjEPaKbhyATMUPQdzYiHLs9Fe6vncDhyZbWHOieoGEFcGpVd7VSk1HRN?=
 =?us-ascii?Q?EaivtX/we21xgpTHV8VtwEbJ3TCW/jgvLfPgbIsncctIcoxPV9ur2HNInQaJ?=
 =?us-ascii?Q?+fgJlzeiH642mm6NoEdNWlUSEz+WXzUrdmpEkuZc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1161552-ef12-465b-05cb-08da8677bfc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:56:50.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5YMWj4SVmRovOxKgSUkeJENsIqL9tJL/s2+4zhjN431Q2ramD7WR8jW2RAjWxj9rzrjW8OKOIlyMJPsU8SAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7452
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +/* SYSFS DEFINE */
> +#define define_sysfs_ro(_name) __ATTR(_name, 0444,                     \
> +                                     ufsfbo_sysfs_show_##_name, NULL)
> +#define define_sysfs_wo(_name) __ATTR(_name, 0200,                     \
> +                                      NULL, ufsfbo_sysfs_store_##_name)
> +#define define_sysfs_rw(_name) __ATTR(_name, 0644,                     \
> +                                     ufsfbo_sysfs_show_##_name,        \
> +                                     ufsfbo_sysfs_store_##_name)
> +static struct ufsfbo_sysfs_entry ufsfbo_sysfs_entries[] =3D {
> +       define_sysfs_ro(fbo_rec_lrs),
> +       define_sysfs_ro(fbo_max_lrs),
> +       define_sysfs_ro(fbo_min_lrs),
> +       define_sysfs_ro(fbo_max_lrc),
> +       define_sysfs_ro(fbo_lra),
> +       define_sysfs_ro(fbo_prog_state),
> +       define_sysfs_ro(fbo_get_lr_frag_level),
> +       define_sysfs_ro(fbo_support),
> +       define_sysfs_ro(fbo_version),
> +       define_sysfs_wo(fbo_operation_control),
> +       define_sysfs_wo(fbo_send_lr_list),
> +       define_sysfs_rw(fbo_exe_threshold),
> +       define_sysfs_rw(fbo_wholefile_enable),
> +       /* debug */
> +       define_sysfs_rw(debug),
> +       /* Attribute (RAW) */
> +       define_sysfs_rw(block_suspend),
> +       define_sysfs_rw(auto_hibern8_enable),
> +       __ATTR_NULL
> +};
Lets stick to the _store / _show naming conventions -
people rely on that when they are grepping the code.
Also, you need to document the ABI.

Thanks,
Avri
