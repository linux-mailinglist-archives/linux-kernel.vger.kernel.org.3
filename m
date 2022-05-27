Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD9535AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiE0H5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348724AbiE0H5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:57:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC0FC4D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXjGNHsKRc6IYc5o9ZJe+4jorDBWXakC0LfLCl9twUsMmiXVnP31P44p9D1rxMWqSCavm0lK8AL1JB2006uBtbrBDDvCihNWMh3b6zLExkiGJmaZ6UYAktNXCfVLMsNaGdAvxPEKYcVHLCnsgv3ojcWlDypNrDet3G5zIRYm5VhkBpMHxp/BYp78yzhRQECXeIuSOdcfKalZJR3nP6xJI6IMz1oxbZGrYho1jKlCLTaPSISJLbIzbtyf2aj/Fh5ur8ooWVHe4i2KPwekEtKdtE6TprKBhcEvSV8uMJ9JMoJDczueBA8x0y1E9iAIgMFdXubFOYMErlzEVE1gIPAghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGEksX6Lz+OtHCWIZF18baqRLSh7ikC3K1CnQsGGFBg=;
 b=iN5lKpNauqpHmXdyq8dl/S7PAO+jVqpDhZEylQANumFAlK7GJN/wMwMszeefYjKO5MGM4fNIVlOgPfb8Ulw6WNyhiMnd99ToLhcX8rJYxLc73uasDgrMtIL83j+mTNA6pELsNYrS1moGFUJOBqJng8widCZqvx0xKVNq+lVZV4AB/aVe3KxAsiV4oMdFkoHxrJDRLUBTxmukIMGc8Xlg4WdtysGq1NCGk0Cif4e7wu/YhA2ge/Bjc4cxKOmb7fooindSWh9G1/UWEsrVE2MaAvxsEFF16eWrxtegA3lg7DfDcZF83XovlkNwJj2khjtRVdigM1lGCD8Qi9gRXRfQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGEksX6Lz+OtHCWIZF18baqRLSh7ikC3K1CnQsGGFBg=;
 b=nsVO4Qdps8r7j5CdInq+aZw1Eg+oBfDJB+ukUvmOBpFhoZbDrHj2izn3YwI0PAfd+ewtJU3rssdKnQ5jQ+UvWmM7sJ4+b2xSwehN0jEqpJvcD9qOISe3eL1cgdXvQuF0QHmvet7wnWtVgwDAvKxSBVqms1KjydXJ6n9+xoKcX8w=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 27 May 2022 07:56:51 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 07:56:49 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
Thread-Topic: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
Thread-Index: AQHYcZ3tJ4Zoo/IFU0+KlIe76VbZta0yWxKw
Date:   Fri, 27 May 2022 07:56:48 +0000
Message-ID: <DM5PR12MB246988B514599DF631847549F1D89@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <202205271546.oV14N2r8-lkp@intel.com>
In-Reply-To: <202205271546.oV14N2r8-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ed5a76c-81ef-4276-9d55-08da3fb673fa
x-ms-traffictypediagnostic: CO6PR12MB5427:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5427769D0D935A78ABE6FBEFF1D89@CO6PR12MB5427.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xgLf75ypkDp2CYFkyxdPFG7vritciKfW3pS6fehPRrJjntDIhUfVjUd26ZlzKr8DjgAPHJuftiMVt8f2EFB+1mzs+72KfwCSA9zXozhzDbBH1H/1RzDM7uA49IUwPgnwKGDN4n1VmYqMqptW2Ds+a4DQtOxTJcRF7tFkLsu7Pf3jfkMW+GYUUic4Mb31jq/xvMVcDZ7Bzfvw5MTVIzdwLyFyH5njc6lOdUL4jEVkS6LIB4l6g8KN01jVbd00ujZ5cH7H1tTrGH/CC6xGOeOJ+cb1iWeeexpnstzQEsCSErx270GHlexi2wsgibzI50VFwsEBqLT6xdyOnvROEIuU577QS5pvg/nY9sIFb6JirmP8RKF1NNoZb4IRUOMJcCOkztSIvrLpeA9fGuj71pKPwcpO5ZsyiXVZrVSjs9BAdfE14qDk+umzOuZk9vN89uj/A1i/7RgcbzlYN13TTxQ/DWBTai/KOXwK/ITo/KvnV5TiZAY7XL4TvOWn1XAvlVBtlG4Jmp/xW/3wAb7FATdldv17+USCt7bHpDFRq/OqetoGolRZK4k1YOu0LePE6fPbWLfxjzqWReTxwEPtexUCJqBJCuup+ggQimd9udkxMSyTownMVQb5BTXlDrGCjtVtHgL8bD0xcx2nYiBJNy0qlzGwvqTWkGBWSJTuIDmL2tbdrBTC2px6R+zI7FwsQXx35eaJ/IJu8IgnpXMLDPGWWMc8/BPQ+zZjVDjMDDbD0Au0N+uFjxjVv98jySCu2wgxs6YgMyCV8EO1/WJpV4pRM/4WSmClaRNMgNCBhesATY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(9686003)(26005)(86362001)(83380400001)(7696005)(6506007)(38100700002)(33656002)(55016003)(186003)(6636002)(316002)(110136005)(5660300002)(4326008)(66946007)(52536014)(76116006)(66476007)(66556008)(66446008)(8676002)(8936002)(64756008)(508600001)(38070700005)(45080400002)(122000001)(2906002)(71200400001)(966005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9f7D4VeclIUFQdIpfdcTYCKbapV0PSnkBUu80se0tINke65PDaBkhhT7vg1?=
 =?us-ascii?Q?hPpGxY+M4mFKkDntjQwna+ZHZkvHlDEWGd5WR7JwO1++L4T5hE8o+xcgmHDB?=
 =?us-ascii?Q?r75f+ab8umO/Hz1IDT4IMl7GsHMIB3wl8ljvykC09xYlfnQ+HeYh6RLh1F7f?=
 =?us-ascii?Q?PV/LDlV4CpZnXqDpFXRnHAvxOrOPBgccUFs19vIYJpRNzCmvGumaDG2kiKy7?=
 =?us-ascii?Q?ZWrfYO++tazRn3ktRE6LK1+QO2w1W5dlJCfWmDA3+Ha7IEDu+FxK8e9M8jI6?=
 =?us-ascii?Q?K5jpjG0ooMm1vmRFasafL2hYWgxqzjYTmuHUPYO0vklw6hxqBeOYRtMxCiPp?=
 =?us-ascii?Q?4Gth7svQ1EBO8FXlxh5FS3J8c+1Wv10u39wrwgFQf+aXYSZQprL8yMQZUvhf?=
 =?us-ascii?Q?AKkkY0uwxhhzoOfGtZExBIbemuRLB9KA+L93/7qZ8h6ehpP9CzovTlyQm7E+?=
 =?us-ascii?Q?T9MO++sGqb65/XCO7h4G+kZDdqv+Ibf09zmeZ/WTs/brF8eQoLUlu27oEgmL?=
 =?us-ascii?Q?KlRj6U+hdOz+p+OXFri/5uMRJZ6NR+xfbXIwdbn21+feSgWBKFcUKlN1/P4B?=
 =?us-ascii?Q?2UPs1Zp6q03r9WscLelR9YVgGqZu/qSFi+vyHiK9A1KKzJ9UFeeDY5ImYhnd?=
 =?us-ascii?Q?02kkGoXpP4pQ0iaeCinIeTvdiz0LIntDEy/qu1H57ITQI1X2ZJj9ozmt3Iy+?=
 =?us-ascii?Q?6/+HAe6i6genHCUIqi00xWAgoT5uVJbeC828yRU2kKfZ5O6VxZ01Ce+0JF0t?=
 =?us-ascii?Q?edskiiiAw9nfh6ye83vN21ujr9Vr9mOxeWM1qzx8OwJQ/4Ob2t7tiYMCkFe/?=
 =?us-ascii?Q?D3q8+IsyRTuIZdaZAPGY0EbSnlnz1SD6M4Bh+pa/qaTvOgaiLHVCVAGekl2r?=
 =?us-ascii?Q?AeNJTAn+ad0xKsTzSHHei9MDoAlinQfVCb++1iCJRAxmkoGQ/poNc7jY+K6d?=
 =?us-ascii?Q?OzgX03DUnC4uhFK3Mt3AKebzfF0l9DdNZ9G1VwMn6yGRAqbHTJoFS0n0HM8k?=
 =?us-ascii?Q?VfebeVOkcHhx2DTTP6r6OlYk92WxzeJibD8QULBRncS2ej7tmI/JpJ3X3VkK?=
 =?us-ascii?Q?Tr61kka1r1fRE6pn/o0bKdms1I/5dPCAJagHRAVyqyjnr7wLWjoyRSVKI3Jc?=
 =?us-ascii?Q?Fxs5kjZnO2yU0TbafazC+pgCNESIAdAY+gp5OCcfLrTWmRoUfSP+zd4Xfdck?=
 =?us-ascii?Q?2Dt9lZ1IOPvyHoxZqIkGDkhdD004JDlVWmBvSizHinu8F+ci20aFZj0x7eCC?=
 =?us-ascii?Q?9863ad1hvowfyq6R+CPRryuEfvhDICXkhDXwj+rghlOM77EhPUIJ5mwNBmTh?=
 =?us-ascii?Q?qq2Qn71j+HHqhrcPI64F8/dXpoEBX5ckgLxT0qB/H7cIDnJdXznakLwuouwt?=
 =?us-ascii?Q?yCV9aStcHV2tuE7pPNBKvWvSIibfgA5tx7SGfWtPhzPObTfbcbT/VrUp2Ew7?=
 =?us-ascii?Q?vH+t9IMgYoyexPDBoO3exfeTLFTvBNNNbnKfFlNflGdM60TFs5alVD6g8lVg?=
 =?us-ascii?Q?EUsRSQkMdT6DrmGGxg7zLNMPh/0RpmCrvgg486jOIWa6P5xGRO1c9U+5AW1T?=
 =?us-ascii?Q?nCJNqpaxCKlxrHkY9gyNMlVrES78xKdRjCXQPgtessrPJ+3tXLNtXRmfJHUJ?=
 =?us-ascii?Q?HGlIJsYHUns/GUMZ8WS3AJMgvkQ4WSaLRAc7xzRTqAL3WXUbo0jrvuXF0MkQ?=
 =?us-ascii?Q?SLLSmHl8L9UsYlTotD19U2tNdrkAmQTj+NHjK4XSJgYxQ+qoRAVp0D3bNKRF?=
 =?us-ascii?Q?Pd1Qg1sv9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed5a76c-81ef-4276-9d55-08da3fb673fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 07:56:48.8279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSDEGPsCoKnSQLzjY22SuBoXqa9xbvrPxCB3WGkSxrkBc3UkbZG6QvWm6QTWtIxokMfylOgPoJV7tq8pHws+EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch was available already to protect against such scenario.

https://patchwork.freedesktop.org/patch/486289/, "drm/amdgpu/discovery: val=
idate VCN and SDMA instances"

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dan Carp=
enter
Sent: Friday, May 27, 2022 3:46 PM
To: kbuild@lists.01.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: kbuild-all@lists.01.org; lkp@intel.com; amd-gfx@lists.freedesktop.org; =
linux-kernel@vger.kernel.org
Subject: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433 amdgpu=
_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disab=
le_mask' 2 <=3D 3

[ kbuild bot sent this warning on May 4 but I never heard back and it's
  May 27 now so sending a duplicate warning is probably for the best. -dan]

tree:   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&a=
mp;data=3D05%7C01%7Cguchun.chen%40amd.com%7Cfc2110078e5c4790337808da3fb50de=
6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637892344114571722%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D4AYyKswjTmjKoNdRpOxWPW2R2o2RU5CkrYRuelaC=
afA%3D&amp;reserved=3D0  master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 622469c87fc3e6c90a980be3e2287d82bd55c977 drm/amdgpu/discovery: add =
a function to parse the vcn info table
config: arc-randconfig-m031-20220524 (https://nam11.safelinks.protection.ou=
tlook.com/?url=3Dhttps%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F202205=
27%2F202205271546.oV14N2r8-lkp%40intel.com%2Fconfig&amp;data=3D05%7C01%7Cgu=
chun.chen%40amd.com%7Cfc2110078e5c4790337808da3fb50de6%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637892344114571722%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C=
&amp;sdata=3DosyRhU3i%2Fdnwcu%2Fz9T0278PTeEFuM%2BAWw8zR43ir%2FhQ%3D&amp;res=
erved=3D0 )
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433 amdgpu_discovery_get_vcn=
_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <=3D 3

vim +1433 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

622469c87fc3e6 Alex Deucher 2022-03-30  1403  int amdgpu_discovery_get_vcn_=
info(struct amdgpu_device *adev)
622469c87fc3e6 Alex Deucher 2022-03-30  1404  {
622469c87fc3e6 Alex Deucher 2022-03-30  1405  	struct binary_header *bhdr;
622469c87fc3e6 Alex Deucher 2022-03-30  1406  	union vcn_info *vcn_info;
622469c87fc3e6 Alex Deucher 2022-03-30  1407  	u16 offset;
622469c87fc3e6 Alex Deucher 2022-03-30  1408  	int v;
622469c87fc3e6 Alex Deucher 2022-03-30  1409 =20
622469c87fc3e6 Alex Deucher 2022-03-30  1410  	if (!adev->mman.discovery_bi=
n) {
622469c87fc3e6 Alex Deucher 2022-03-30  1411  		DRM_ERROR("ip discovery uni=
nitialized\n");
622469c87fc3e6 Alex Deucher 2022-03-30  1412  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1413  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1414 =20
622469c87fc3e6 Alex Deucher 2022-03-30  1415  	if (adev->vcn.num_vcn_inst >=
 VCN_INFO_TABLE_MAX_NUM_INSTANCES) {

Capped to 4

622469c87fc3e6 Alex Deucher 2022-03-30  1416  		dev_err(adev->dev, "invalid=
 vcn instances\n");
622469c87fc3e6 Alex Deucher 2022-03-30  1417  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1418  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1419 =20
622469c87fc3e6 Alex Deucher 2022-03-30  1420  	bhdr =3D (struct binary_head=
er *)adev->mman.discovery_bin;
622469c87fc3e6 Alex Deucher 2022-03-30  1421  	offset =3D le16_to_cpu(bhdr-=
>table_list[VCN_INFO].offset);
622469c87fc3e6 Alex Deucher 2022-03-30  1422 =20
622469c87fc3e6 Alex Deucher 2022-03-30  1423  	if (!offset) {
622469c87fc3e6 Alex Deucher 2022-03-30  1424  		dev_err(adev->dev, "invalid=
 vcn table offset\n");
622469c87fc3e6 Alex Deucher 2022-03-30  1425  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1426  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1427 =20
622469c87fc3e6 Alex Deucher 2022-03-30  1428  	vcn_info =3D (union vcn_info=
 *)(adev->mman.discovery_bin + offset);
622469c87fc3e6 Alex Deucher 2022-03-30  1429 =20
622469c87fc3e6 Alex Deucher 2022-03-30  1430  	switch (le16_to_cpu(vcn_info=
->v1.header.version_major)) {
622469c87fc3e6 Alex Deucher 2022-03-30  1431  	case 1:
622469c87fc3e6 Alex Deucher 2022-03-30  1432  		for (v =3D 0; v < adev->vcn=
.num_vcn_inst; v++) {
622469c87fc3e6 Alex Deucher 2022-03-30 @1433  			adev->vcn.vcn_codec_disabl=
e_mask[v] =3D

But this array doesn't have 4 elements

622469c87fc3e6 Alex Deucher 2022-03-30  1434  				le32_to_cpu(vcn_info->v1.=
instance_info[v].fuse_data.all_bits);
622469c87fc3e6 Alex Deucher 2022-03-30  1435  		}
622469c87fc3e6 Alex Deucher 2022-03-30  1436  		break;
622469c87fc3e6 Alex Deucher 2022-03-30  1437  	default:
622469c87fc3e6 Alex Deucher 2022-03-30  1438  		dev_err(adev->dev,
622469c87fc3e6 Alex Deucher 2022-03-30  1439  			"Unhandled VCN info table =
%d.%d\n",
622469c87fc3e6 Alex Deucher 2022-03-30  1440  			le16_to_cpu(vcn_info->v1.h=
eader.version_major),
622469c87fc3e6 Alex Deucher 2022-03-30  1441  			le16_to_cpu(vcn_info->v1.h=
eader.version_minor));
622469c87fc3e6 Alex Deucher 2022-03-30  1442  		return -EINVAL;
622469c87fc3e6 Alex Deucher 2022-03-30  1443  	}
622469c87fc3e6 Alex Deucher 2022-03-30  1444  	return 0;
f39f5bb1c9d68d Xiaojie Yuan 2019-06-20  1445  }

--
0-DAY CI Kernel Test Service
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F01.org%=
2Flkp&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7Cfc2110078e5c4790337808da=
3fb50de6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637892344114571722%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DFEZiW7nVnlbPvQRbf2TUEbh15BsdY0tRL=
KvWFtPknuA%3D&amp;reserved=3D0
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org To unsubscribe send an email to =
kbuild-leave@lists.01.org

