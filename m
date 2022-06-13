Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF45482C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiFMJDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiFMJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:03:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B620E0A0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:03:27 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25CNhuQ5020784
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:03:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=8PWUKd28P+6YPQiG+7eI0TZw2yba33YhTpdLQ5LRZPA=;
 b=Ejzt/H3yRoH3MkI5ww5cY/r76v0VESFiTAvdFDUd8b3W9c6Oc2/W+GT6WUkg8ySxZ+Io
 oHnmuuoe8B0k4ZFt7sfeSZCizpa00m3pMT/QNZuwPAaSREEX3izlpkCs2d2Yp2Vbj0jc
 OFbGSmupGj6zhbJ6WzIo1QnqYF0YWxCE4Zk= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmpcmffdb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIB1AhxJCVEpZlLr/nkm0LCDoo4lQxoMDZ7QcVvmPj0t6arOOprOsYR9U4WsdTqeCb/B+r/hUI2ld5mSrpELDGvTT5kgprHyWffHRs/hcmCVJYmGSGHnm5tYHD32RlHe0Mes8vwZvq094YchlTDRojgYBhiKbv6C+7agVUthmdfCEKYD4uwD+g+aKAg0NuAj3kZTTZqGjL14hUCnU5GG8qtTuCeij2gC6D3xAxC/gCNDsgvMJcrU+lqQZE1m0+VOXIWba0maECWbzOfPZHvTm1Boi4ytaFLKz5rsl64mRJZw1AlcuqTKCyLez/HzOVt6JcKUHV1AgowkpfCbmwOYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PWUKd28P+6YPQiG+7eI0TZw2yba33YhTpdLQ5LRZPA=;
 b=FAF0CpUoXFtMxU/g/DJ2+fYS6zmzLJqHtrp7MqooeJgvJp+7bXcADNdnRkJV4Cx5RCa0kT7GBPur+VIIUtklPzaJYTid3VmIHMu+9vM+S84scBA+cXZyhKNVAzq57MyHLk4LFBE1rBwrWnWH5Bq6lk38QeanPY34kDAJKgkedDV86aFQ2StPuwwRDLEjy4OlarAOvyogVHQvJRannfp+h8v+DZsXKAmrEYVdRDO6FoTOQPURXlUxOLaIpozQY1OZVN3Tv3lsVqhXotQvX1fFvuiwFXCrl06Un5c9BNjdgB6GqnYo2z5MCug+HsCo2V7zOTOW+7OFUYPzw8IJtVJ/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BLAPR15MB3841.namprd15.prod.outlook.com (2603:10b6:208:272::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 09:03:24 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 09:03:23 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     sunliming <sunliming@kylinos.cn>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kelulanainsley@gmail.com" <kelulanainsley@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RESEND] of: Add missing function declarations
Thread-Topic: [PATCH RESEND] of: Add missing function declarations
Thread-Index: AQHYfiw95YJNL9wORUehks5+IVdrAa1NDIAA
Date:   Mon, 13 Jun 2022 09:03:23 +0000
Message-ID: <Yqb9VoYe+D69KYTY@noodles-fedora.dhcp.thefacebook.com>
References: <20220612071535.1179039-1-sunliming@kylinos.cn>
In-Reply-To: <20220612071535.1179039-1-sunliming@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 422b1e07-6d2d-4b4f-f8a7-08da4d1b91f6
x-ms-traffictypediagnostic: BLAPR15MB3841:EE_
x-microsoft-antispam-prvs: <BLAPR15MB384156C812379FACC9BC53DCC1AB9@BLAPR15MB3841.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeRbsrzzib1xo6xneccKFYZDRzseBCiEgHcykbyY1KM/eXwLuNQdg6tJ7QmoKSWETxTpLVocwCrtGSEXyu3C2dU5eV5ltJVPopyRI9He/IIH0zTLs+6G8yUuFCa/aTDT9JRFxH3B3NXzEqM7nKMeSJGjF2HUTmd5guJ15TMSoToJms9c3DvNE4kJv+BZuzvB3agZ/OcCoTmLaTIVLFrJ4zxUcH3e76La30pRygnghtoVaVarTRqjqqyd6xt+K38du94Jv08a6kwyAx/9uCyEHJ1xThWcmTXxgn8IxLi22ARmmKkOBSNpATYMsj1AXiYIM4QTNrgbVcpnU/qaJ4nGW7SD1t67y94pHvCTxNVvcFOIXdsbtnW3zdz0666bq04ec0LcRAxHLpogTKOTsMptQFXrqlyZTOBZgl10XDzVbLyjPBaGfwzF39tGSvlY+BNmN4YrJ9urBImX1PEYAfdVPzxveubQXPa1SLuNhONUvTx2TO8fxaJq7p7ivxm6rylV26LnYlZp8YKUPJqYQ0PGJV2bm0SfRvclgj7LhJkldpoBC5KjtA/zjYk4S8yDl6T4eeiWQhnRk1WzPqAxbtZqJn23D3mJ/HdShW3tR6sXqkOFl32fq8s/N8lkANaEP4nyCT9y5n2SOhW2GRpXJASus5GV0sRlgHqpok9ufTSWs6ITHO/A8ju8OEyGxKbu1+hi9YKUWxrlkUobm1A6K6YqGduieslbLvZcDidtQFCLAtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(508600001)(66946007)(316002)(6486002)(6916009)(91956017)(9686003)(54906003)(71200400001)(6512007)(86362001)(66446008)(26005)(76116006)(5660300002)(66476007)(4326008)(64756008)(8676002)(66556008)(2906002)(8936002)(186003)(6506007)(38100700002)(122000001)(38070700005)(83380400001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D5PS99Ae7wwbd2Np4G4Xhk4Vc2g0qkajHCnj70KLVwxnmMImn9qFsUQrhuUP?=
 =?us-ascii?Q?yYnmPkKQSVT21syFIxTInO4VmTnX2/KGgHnYdlrA9AkrAG9j/lobsWcT+O5/?=
 =?us-ascii?Q?Qzybe/k7LQL+qTpOWjftOUYXixDY3TBOeQ6leYZRG9SO6J2GNhTu9tJGRGFj?=
 =?us-ascii?Q?vcs4g/tCuLN33LRF0Joh4nzuWJn44pla/qh2EuZXlVL/h1/nhBWCS4HZIxsK?=
 =?us-ascii?Q?xmp+ZysiZef08iKEy3C2mlDv5y+zZRu6MrcwT9xudulQdZyGa1JKlt5VNQBe?=
 =?us-ascii?Q?f9r3fLuxblRKExNa5ZEe+re3xMUd/cXFrzIAetvZ9bE9ui1AhBvGiSEWza2u?=
 =?us-ascii?Q?RlV9qMvC6Dey8eg66krit7SEMfAVjn9nF1+gZYIjMdke9scFmbpMGt0iAdtM?=
 =?us-ascii?Q?hLx7xfQ1x2fhAA8wtmhBt3cVKtswIDtQBUs+5TjwP3k6zTWSPVdFEoqzu4mS?=
 =?us-ascii?Q?4UNi0U8y8xpaNa16ci7dMzTSDejx4oWUn2IziCykT0hTUVDaFkx1GnIfhyT+?=
 =?us-ascii?Q?xZQpCDtHMsz2QSAiK7ausT/+UAiMK7cqQx4Fhjlrm3Qia4vIEN1Mwmbya7nl?=
 =?us-ascii?Q?4bZzKtPppJ4p/QpdbH7nH1r9i2qBvGHQNYu6+kozOsVfiYnqmRVyYrl1on/N?=
 =?us-ascii?Q?60WAIg0Cb0un6+NoEqBYddkUHGxWHdhD1/IaUaVjvJvdr3h7+tCiB3iaig7S?=
 =?us-ascii?Q?thjhgLxUauT52esR/nXnjdCnSUDu5zSyUYJhu8WTFG8xxF8svueVSwoIsYzz?=
 =?us-ascii?Q?d3fBaYxIloGYEUFrpn25JLh4vC5tDPlni0YG14npswz/vXEg+TFtbSey+bxH?=
 =?us-ascii?Q?tdbmKWaDelQ8T+o85/oTG5Zey6UgyfpXAMN5ZyF2PELaVaaaSUlXMiRU+gce?=
 =?us-ascii?Q?NkPFCMqTCWWCwVM7Vm9rwdr4QwUUnS8k31MtAYMs+RLHWP0AGsz5mTu1KghT?=
 =?us-ascii?Q?R6M5ywNtT3nLsOeUbWynPudeiUqZ7DFeMeKTj6Zx3ev4WqdSYfTQuf3qynPn?=
 =?us-ascii?Q?EVUbIUIE3hi6lAw2rXjap++X5ibXreyvXyLkEL8XuUSOJ/GCJUYbAsRTJRoq?=
 =?us-ascii?Q?U3SlVf1qMcie051WHYysDLpOJr/JB7L50tTSPksmXRgGUPy3DOJ/oRnYmPgF?=
 =?us-ascii?Q?PNeCAeA7VB1LwfKbHfyj1fRn9zcvGzWd20FXNGprtN756CcxsQNNNFfsrmet?=
 =?us-ascii?Q?SmpXjYusnKfdaLImlbbG2Jm7JIrcsVVKEAvTWCQWxMgzTlAJo//cXN0z/XIG?=
 =?us-ascii?Q?mdgMlPKWRwt2wAohRV7OJ7KeMksj1eAZAulpluxKZ5H91aohv62RlVgCkKQw?=
 =?us-ascii?Q?/gd82RhkG2PQ7BHD4cOs1NzgxBAOtak0We6+lAeOJgx6c+MMphWDlQE/PeV0?=
 =?us-ascii?Q?3gRR1lnjtUNlu6b5oku+P7Vdy9Fr15Pc2GZH8zttu+KacoDV945uuwENzd30?=
 =?us-ascii?Q?gzQOr3Ew+fHRyK3FQrXEQlhGpV3Bc2ic76OfVNf2rG8JTwTikxqKyC8fY8Tu?=
 =?us-ascii?Q?xjo1DeCyJa57wHchMn2y3BF0+h9PvQsszYenZ3tk7vS5frVTLAkQl6aAwMR/?=
 =?us-ascii?Q?t4gvtFx84iCM1Sor+TdN4q0zaThR5j/zL39obva9ob5xMi6kuq7mEYGhTof8?=
 =?us-ascii?Q?s4w9WZbIy9sbcMpA7XaUKB1MBKx2IrRLzfcqDsfNo90YIkVDC83QrRgKoj60?=
 =?us-ascii?Q?kWn2ZwzQorHUl7Bwb0ST1u9Wpg6Nz8FoeoSZgsuaReEtn6uCnZzJqYjMenMd?=
 =?us-ascii?Q?Aqiow0Qusg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D205169C2118E74D97D5C5A7D9990AD1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422b1e07-6d2d-4b4f-f8a7-08da4d1b91f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 09:03:23.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhutSHhy7oecXF47A8OFnm4xUBImwkakL+3TwrnBvEGYiMiyukrUD89Gw4WU7vov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3841
X-Proofpoint-ORIG-GUID: Q7ag7divlyoYuZlBjjGJ5Aea81WiSBLA
X-Proofpoint-GUID: Q7ag7divlyoYuZlBjjGJ5Aea81WiSBLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_03,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK. This is for a patch of mine that I don't believe has hit mainline
yet - I've only seen it in daveh's test tree. The prototypes for these
functions are now guarded by CONFIG_HAVE_IMA_KEXEC but all OF platforms
build them even when the platform doesn't actually support IMA over
kexec. I'll update my patch to avoid that.

On Sun, Jun 12, 2022 at 03:15:35PM +0800, sunliming wrote:
> Fixes the following w1 warning:
> 
> drivers/of/kexec.c:126:5: warning: no previous prototype for 'ima_get_kexec_buffer' [-Wmissing-prototypes]
> drivers/of/kexec.c:153:5: warning: no previous prototype for 'ima_free_kexec_buffer' [-Wmissing-prototypes
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  include/linux/of.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f0a5d6b10c5a..3a166a1c4ef6 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -844,6 +844,16 @@ static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
>  	return PHYS_ADDR_MAX;
>  }
>  
> +static inline int ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +        return -ENOSYS;
> +}
> +
> +static inline int ima_free_kexec_buffer(void **addr, size_t *size)
> +{
> +        return -ENOSYS;
> +}
> +
>  #define of_match_ptr(_ptr)	NULL
>  #define of_match_node(_matches, _node)	NULL
>  #endif /* CONFIG_OF */
> -- 
> 2.25.1
> 
