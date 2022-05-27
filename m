Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8E535F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351212AbiE0LOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiE0LOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:14:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB835B3D4;
        Fri, 27 May 2022 04:14:33 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R78wPW013608;
        Fri, 27 May 2022 04:14:14 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gaf2ru7yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 04:14:14 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RBEDOr006274;
        Fri, 27 May 2022 04:14:13 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3gaf2ru7yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 04:14:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9cn+MS7svzPQ03WLgnx7+OWVAfWUW2XTA9/KRIkyHF/Yrm74zlnheA+T6HqmKjmGgIYDnysaXjZx+VRHeVr4wV6xUwa2jk7aBqI3E080r2aAiU0p7qvATMt1XHTwQKjow/xfKSB2nS2yQQ1JWEorj+6HnESd8oZv0a1DQ///mmy5i6yBG73OgvXW1EbzPZgLy3BZ4XNM+lL2BQ+91W7Md0q0WFDNnGHQrb7ccA9OrQkr5mfp9e/iQEKlCg5rbzZjVtrIgPCJKvoOqfoSgZO1zJ4N8C23vkaRKrpIqiLftuTvHFWUWAd6xo+QbhbI2Rvj7gU6smmXcAOe4Frnpl8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pdvwcf8K4L6MG376d8SWmnIWl3EcQ5Kilr+VxQDM3o=;
 b=PIN4Kuyk8pCdz2rKUYJozHY1hN6MdBYzgmxd7uH0Bd7VrftfynnTJAsqV5vQYp1GTrqMt7L1YE0Qv5XdK7BOgFWE492LTyr0sfEzA8eau3Zc2gUwsIJXE4aKqaLhuwiYWvnLM6wjrevuIQbe/CegOHpgP1oGHo3TOcK0nsjCbf7DenR0EWyWQ4izY3cP745gSAvOhjHA8XlVZ7RPk5/QB2OXGFOCj83hP3CtzA+J0arLx7EXiNC3vLyU/vIQELZ8CZwRnj+Wvwr5MErhf0HwNEr3qSl2AjMl3QQ8HhEUolXJ1onEWKwlPuT3tiedW74nUk4tpjJLBnKt+TX5w0vVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pdvwcf8K4L6MG376d8SWmnIWl3EcQ5Kilr+VxQDM3o=;
 b=E6Q0zuqMnRnuvevCRPqJUVL2fxmPga0fhyWnhbTW6rNv8ODiIWvmXdNG1lEGfKfyJlLp2nGCHhCQBygtEZH68HRnJNSJj+1YwgQjOBDopL28PFM93xFsN7XAUQC2TekuTEbuH20Wb9jfi+z6mWkbPMWQ6ecwjtWR98iAO8XJBUY=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by MN2PR18MB3590.namprd18.prod.outlook.com (2603:10b6:208:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 11:14:12 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::e4ab:7780:fb1a:8fda]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::e4ab:7780:fb1a:8fda%6]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 11:14:12 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Arnaud Ebalard <arno@natisbad.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Harman Kalra <hkalra@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Thread-Topic: [EXT] Re: [PATCH] crypto: octeontx2: fix potential null pointer
 access
Thread-Index: AQHYcZ+WFeoConjOvkuT00xCknB1x60yYbgAgAAVDHCAAAgrAIAAEtEw
Date:   Fri, 27 May 2022 11:14:11 +0000
Message-ID: <PH0PR18MB4425583674C4EDA9F8266545D9D89@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <da89ba20819ad3ca6b99f9ef056f2bc1b076dc6d.1653632699.git.sthotton@marvell.com>
 <20220527081928.GO2168@kadam>
 <PH0PR18MB4425FE9F1CF5BA4B7F981F94D9D89@PH0PR18MB4425.namprd18.prod.outlook.com>
 <20220527100402.GQ2168@kadam>
In-Reply-To: <20220527100402.GQ2168@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d4bd26d-805d-4419-6f22-08da3fd20708
x-ms-traffictypediagnostic: MN2PR18MB3590:EE_
x-microsoft-antispam-prvs: <MN2PR18MB35904D659AF621DE9CE8ABD6D9D89@MN2PR18MB3590.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7NfJ9kZYQw/mt55wtm9o9/YKk+gcBouXU7ShTMUniT+hU+XiJGmqxDUAOm6bVH8mbX9B/CfukjztrbstuWOf/skr2Yyq1SCaPoOT9IQWhD10cRSm4IEqDJE4MH0I7leox2T/Sy0zCoer/WgDJfMveEB+aqBNvyOzsBFSyPpvYlbpi7whzRUrnFXlRQb3KIkWrkoCBGkGoV4gUi9Zi3DSsZi4FSM47IrIU8VAX5IM6S8nDgGsSJrmvMqHAXJzNu6TtCENafIpNnEPkQD0RuB+ZxJOlXXdqfL+H+yBJzavQkpsjn9KL4VrBwDUG23KxL/LxoMPCuibCkFi+QRsPv55krti3xJlasOGhBRq94/d1MHMQLyjPRp+hQNfuTENDMPT3fNUTJWiFE87AcuHXrhGMcHbxz+qtO2zc3FUSddBONvnetp2HW0fcuuTO3n0YFBNhHMtcBrmckZUL0iVVNJL+L9DIr8aBw/7a8PFtwDiCpcD1/OVKtvbWfIwcjZVed979kf9QqulOiGLaKkqXHuPj5l0bOfH2lmaBUzsRyLQhX0mdx4Gs78ANpHU0StLYiPYm3R1xoO9h0P5jO4PKT/oMVS9AzX2L0u9yHCNT7okSlNQMwrYH9dTsjKcTm2vlEd/8tbeNnvKmzyKEgXkNOGoB2LzkRK8NA/ILNioVi6yGUAm15Jc5MjjnmodUAXrk945Oz3hEVscaNtEy5soS3hUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(26005)(9686003)(7416002)(186003)(83380400001)(8936002)(5660300002)(86362001)(508600001)(6506007)(7696005)(33656002)(52536014)(4326008)(66946007)(55016003)(76116006)(66556008)(66446008)(66476007)(8676002)(64756008)(38100700002)(316002)(38070700005)(54906003)(122000001)(6916009)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rMW8YXWEyO9owIXNBTjpSBpExSkwsYD/h9HqKC6p+PZvBr9qDAu39L5gZx57?=
 =?us-ascii?Q?UjBSay2vJzJ/UinkLWr+0Ybglf9pnYgU9Jn/c0l2FZySnUdr9E7o81x7nJWE?=
 =?us-ascii?Q?NWREjetB0UE8f9nwC+CLv6hW6pZZo9cOxZUjtbCEfRHki/OWggWt6qi2NXty?=
 =?us-ascii?Q?z8Xu/KwHcYZFnqi2f1TkD7TBOPcYFUaRfKUOCqk3pvhgIhdVMb0hMeyxdAON?=
 =?us-ascii?Q?WCA68UDZUwOSAElkLuXnhrBCSfBsSk/pGdFTj2XhXRR7NtS5NHH7LIhu66ug?=
 =?us-ascii?Q?Dq8LxDZkfIrblDTEJGApfghSaJOV73BcUwZyS8nKtxepVnyr114Fn6VGm7yn?=
 =?us-ascii?Q?3ugb4mBtzzPx7Hv8d2dzQ0Elhmjj/tDPInBLXp2bAPEFyXpl7eCWQJ8zi47V?=
 =?us-ascii?Q?QJRhTJ+ucnMbnC6Vpc0t+0nvUGxiS9OwTJzIHppSIuVp0Ae2rwFYIez9hdd4?=
 =?us-ascii?Q?lF61w/HToBmrN6cyeKAT4rUu5Q8b2GBX7U/ycK6rlx8ABUvmkY8NVZsGazBY?=
 =?us-ascii?Q?AzOZYP+OnfxVtWYMvpie/ISe7Gb8zpLyrvdj2EiAfV2Uc4K5hZ4VKn3EAk3r?=
 =?us-ascii?Q?HGP2fYLyepZLFIjAhedwPuatvTKjh8vFqfMW2/x4oJfrC11HebrO1cdgtzQu?=
 =?us-ascii?Q?mbN+9a8xPZUQf0SLgRABE3xKBhfAG5MjMP7ps+rAvkW86tk5SYv1Ih4qWJ/o?=
 =?us-ascii?Q?d+B8UO2UOvWdvHyLBtH/WQOqxFRXrN/pGl7f1Z1wDyMo5faBUgF8tztnQ1eF?=
 =?us-ascii?Q?E/0bn69/+7CuDYhOKwvh1NTgMw+8b8tExymqK6km/8SmAMtbzQn5+JlAfdVV?=
 =?us-ascii?Q?2qihfXtvj6RVlzJ0EfdyiBCxMsA6edBYgiIqGGJA2pnffFD3dg2G72EzRbS+?=
 =?us-ascii?Q?0V8Bw49XjOCPNQVNCDAGUUjIlwy+RQnkbpLQB19mpcOrbl9r7nhHjbYkQTIM?=
 =?us-ascii?Q?+Vo5LxyrHOnq0NjRlCBlOQ35JcYpOJdPVZhe3KALJoYdUBTdqnHqGMksRWnd?=
 =?us-ascii?Q?ySakoMoQulRgbWzt8xlftjm0hCTc6pP0zSXdu45DkDFU1choMO++EaE0TPa3?=
 =?us-ascii?Q?kQyieMeRxsQUlsp8mRgH9swGOzM8iGow1Mh43eOHwbrk7YI4j6Kn5ViS47Za?=
 =?us-ascii?Q?fvw3I0Wn0yxm48DD5akeXEwuxlo7zXB3+WudZ7DkwzUkgtYDY6Tq1TqkutRJ?=
 =?us-ascii?Q?/5KchCqf+rnj72cVn263zCwpYdYeOrcC0/Lyq1UnMd5Mw2HyvBvuBlCHw4CC?=
 =?us-ascii?Q?4osgibAd+trD5qzbD+CHDfDU62KBGNhfkr4jVhEKEhZ4N9549yn2whQYosyt?=
 =?us-ascii?Q?y5IeRnqbIFwjTds+yDw3jzmMtj1r4yPBJKjlSje/Bxjiks5F+XMlGbVXgQPe?=
 =?us-ascii?Q?vSou/Cc+0yzT4XbGnXAhMqMuqJnMBriUKoYpcu3ROnLdHDWDOYoDO0YDwwqI?=
 =?us-ascii?Q?oHdNGph0IyH4Dh8+nQ/1eds1/be/C7Nv1cKcfrhsOus8gVDgVPCLV0GgPm+N?=
 =?us-ascii?Q?GiHyLZwtD/qw6m0s2a9w3ZZBVgvJBuZs1ZXoGKGvio/DZWPelv44tu2e5g+n?=
 =?us-ascii?Q?11mJhaK620fO+Zt0I3jyli3PiSNP00vM/RaGhoMDXKYB0+cQrWdoJcm4tnzr?=
 =?us-ascii?Q?jsF05BUqH7pHrmkbQbSbBxf6t2q/NCpsbnCBQCqccejQ28rQfNpDWxXV/HDJ?=
 =?us-ascii?Q?DLD9AAPeSff1cnhJvyUR0IO8TAfJpDJQtCSw2HyBj6zT1wW350LOvRdy+xmr?=
 =?us-ascii?Q?+u9nnPUblw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4bd26d-805d-4419-6f22-08da3fd20708
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 11:14:11.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N5oWxMiiImHIlo1KUs7NgNmtbb29umyKbD31+g5w3IN3I7UeFcScyf034xIA8+gKgSiGrIjmDxZ3j19sKp5Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3590
X-Proofpoint-ORIG-GUID: wDFAfFm8udU1vEL4_zhbAtfk7jHwux-H
X-Proofpoint-GUID: RtNPpPCeoSIdk9zEVSiVriuT1ak9DDxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> @@ -731,7 +732,13 @@ static int otx2_cptpf_probe(struct pci_dev *pdev=
,
>> >>  	pci_set_drvdata(pdev, cptpf);
>> >>  	cptpf->pdev =3D pdev;
>> >>
>> >> -	cptpf->reg_base =3D pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
>> >> +	iomap =3D pcim_iomap_table(pdev);
>> >
>> >I don't know if a check is required here or not...  The comments to
>> >pcim_iomap_table() say it is, "guaranteed to succeed once  allocated."
>> >
>>
>> Will keep the check just to be safe, as allocation/kmalloc could fail.
>
>No, it cannot fail.
>
>I don't care if you add pointless NULL checks to make the static checker
>happy, but it's important to understand what the code is doing.
>
>drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
>   701  static int otx2_cptpf_probe(struct pci_dev *pdev,
>   702                              const struct pci_device_id *ent)
>   703  {
>   704          struct device *dev =3D &pdev->dev;
>   705          struct otx2_cptpf_dev *cptpf;
>   706          int err;
>   707
>   708          cptpf =3D devm_kzalloc(dev, sizeof(*cptpf), GFP_KERNEL);
>   709          if (!cptpf)
>   710                  return -ENOMEM;
>   711
>   712          err =3D pcim_enable_device(pdev);
>   713          if (err) {
>   714                  dev_err(dev, "Failed to enable PCI device\n");
>   715                  goto clear_drvdata;
>   716          }
>   717
>   718          err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
>   719          if (err) {
>   720                  dev_err(dev, "Unable to get usable DMA configurati=
on\n");
>   721                  goto clear_drvdata;
>   722          }
>   723          /* Map PF's configuration registers */
>   724          err =3D pcim_iomap_regions_request_all(pdev, 1 <<
>PCI_PF_REG_BAR_NUM,
>   725                                               OTX2_CPT_DRV_NAME);
>
>The pcim_iomap_table() is allocated here inside the pcim_iomap_regions()
>function.
>
>   726          if (err) {
>   727                  dev_err(dev, "Couldn't get PCI resources 0x%x\n", =
err);
>   728                  goto clear_drvdata;
>   729          }
>   730          pci_set_master(pdev);
>   731          pci_set_drvdata(pdev, cptpf);
>   732          cptpf->pdev =3D pdev;
>   733
>   734          cptpf->reg_base =3D pcim_iomap_table(pdev)[PCI_PF_REG_BAR_=
NUM];
>
>It cannot fail here.  It is not allocated here.  We just look it up and
>use it.
>
>   735
>   736          /* Check if AF driver is up, otherwise defer probe */
>   737          err =3D cpt_is_pf_usable(cptpf);
>   738          if (err)
>   739                  goto clear_drvdata;
>

Thanks Dan, I got it now. I will remove the check from v2.
