Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91C5086FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378098AbiDTLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiDTLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:31:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3741628
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:29:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KAuW50013493;
        Wed, 20 Apr 2022 11:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hyDF3FezsQtLJbx9kQw+2jbfj4c1IgBYwMYSwEv/Ns0=;
 b=xm5MHufpH9uS/2l9wAUtUDdICz8qZo2LtlD8lwbIJzr9d10g9H99PCZEEI5neOSGpVP8
 b+n0h5jUOzBM9OfXQXlUXnW0yZqrAUX9iaShNoMwlhylFRmmgztkSAwAJpM9vsAaJcBs
 4WNLeW0Xkz1Wu4F8dvS2ZMD7q2/lEZAbKnH9gWvOp+z9d8ZfBTWtMoQXtdKxZ7e7Pfsc
 yMHqm10lcQDL46D7I8F22t7PzJqSlh4/8fGMusCXMZBNcvt4+I2aRGZNEkXZHGNSY9ks
 Gmn9g1Lwtw0DE7LviqgjhA9RqzIaqGzgtJWV++ocEmrlC7k9OCax18L5vIUvl3HF/Ppu 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtgssn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 11:28:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KB5orO016074;
        Wed, 20 Apr 2022 11:28:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm85nq53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 11:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNu4OHk8xnerDeVxCEFcAlesTMV32Xyfnxe4QKvrglMxBiL/IjnINdtGfmZbQsxH6DuxqcVE0DQ30zuta1lUUmVzUfZGIaYn24qn6/K41m+wN71mdtjYVWqvfkeBX5nBZPYwslsqdHvPSngGHKpFwaNLK0oKc7ZkabmWV2iznhM+8YGMwEGtEPl/o8bgvQ12VG/ZxCidPXP5pTWgjf+RcKjZ2+faoYs0BTr5e77KTs6TMO+ZMtZFwWj80Mj+FIc1ml+6Aw163ZNliWGbQgN/p0vC7jiTmFJ/4Hc8a6ps7IXDGHnPcD5wSSYuar1bqeaRG5Q+z9+HW9LF3VjNF6zUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyDF3FezsQtLJbx9kQw+2jbfj4c1IgBYwMYSwEv/Ns0=;
 b=PcnLZQHkn2Gyeydk1/0dT0muo/uWa0Y8SFwRMH7kA+kNaysw9XdOwgsOlp8EvBOKDyFFQXFwdDrdWOMdbdi362mr/5GZWvE0SRryXZWU1euInlugG8vJSEX2QeMyxzvZwkkqrBKELQHX27djiCeoqfwLA+G2ssX0mB9uV1NLZ1M7CcZm9VDyipt1qaSzBoiUO+wK3pOhvd8I/U5CZAL7k4GJQgoE61bZMz1TdyxUrOMW549iUg7KK3WegBXnJT1dIQH/BGwnq011VbikeMX4Swk/0Vcp60Ui5YuigYeEQYmrBpJ/hl5dxcdVTRF5w4F/n6W4zxgdE04VVqm8Lo+3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyDF3FezsQtLJbx9kQw+2jbfj4c1IgBYwMYSwEv/Ns0=;
 b=djvwk3E66HibQ6Roi65V74n9AVbgTd3DKHzxonMCslLBSccciH0wfS+IGl29geHUpz5ajeO4C6Jl1ic3ZoYVS/2E0K5y0JxLtxklK9z4vf0gEb4sTd/4g7UQVCpFgYOCBW9r67zWxXncV5UpPHcKP+/8CL3vce35B9W/qd/I27U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5659.namprd10.prod.outlook.com
 (2603:10b6:510:fe::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 11:28:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 11:28:54 +0000
Date:   Wed, 20 Apr 2022 14:28:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/sh/rcar/ssiu.c:112 rsnd_ssiu_busif_err_status_clear()
 error: uninitialized symbol 'offset'.
Message-ID: <202204200039.noPcQg3a-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0101.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 466bfb96-04b1-4b2e-8ca7-08da22c0f3d0
X-MS-TrafficTypeDiagnostic: PH0PR10MB5659:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB56592BF5FD04AA16145BAAFE8EF59@PH0PR10MB5659.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPEr9qwVCP8oBHov7V6kZpZzkfaBovbttOQfjQipRNkbY1NK5E+msakotJ6GRx5hK+Lt4HCeBK9rUUx7p2RWYxnh0zo2lTvsOOaH4487LviouvT0GvnhApuE++4g+mGOuxpplsv4juzprwqqLytRcvxKPa4MX7gWrBeknYR7+auETzTLUAqemvrhI8J97kAUJp8r/aEZdsGE+PWs3mRFByYzKH8AVm7jTckazYzkcBdSwd6/UgVNqghpErmtnSCLlO69y0ss2cDuzHx2WFRxawpttOKjIpBpl94GbAzbbi2GIyigodjfQtMbfMXVWnXmMTDXBnDZuqoGmCwxASBoVY9QjKq+p5ykxOzHC9JH0X0OpxqQCIP4UFQL3oo7JmpIaZMHEoIulL4qY4Sqd7L+ubEYTbVTP4Uql4pbL1WpjZmGFGML27cxckRVNW+RpfFk+ZR4bnOalaIqW/qLhjsB5YPQ+vGeise5O1c+xQyLea3ihRFoXnLRU8D9ig+9mvOm9Mf2hg6Znw5AltHMm55LWMfd++l0hJtiGU6sUzrSvmXyBGKWfDyH4oGpOd0y8Q42SmR8GcM+RMEdd2qpK60ttlKNbonJtZIwmvePWNDhh02bTVQpFuC//tpsDkWHSDar8VNmICAan33QIvzDfNouR8L/Z9ZiqGHPDuGCzbQ2TC3RE7S4LhKC8Hq7z59Z2Ra+AgJ9BVA4gz4CV1xrX4sNQLdhJ54FADNGZetKw2kl54QTFsXWUl1hjMRJHEpADkSecawDcHLkQscAFUSlaBLTDmqdQYshO7UeXEc7pAkiez8FSUe9TtebKFUI50ZTCeT3YVIgDX7WfKdE4htcJwzLNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(4326008)(8676002)(86362001)(66556008)(66946007)(9686003)(6506007)(6512007)(6666004)(38100700002)(38350700002)(26005)(66476007)(44832011)(8936002)(5660300002)(6486002)(966005)(2906002)(508600001)(6916009)(316002)(1076003)(186003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cr+hyVETfZZV/8ga3BC2VYf0jCcOlRnSAYHNSuZAP85kWX6cH79hcqVHj+c0?=
 =?us-ascii?Q?FVeHgx9bY9S0HTxfW/WPqRPMBTRiQZ83lst/0Mt6UZ8IIAcPMQVjD4WZ3swg?=
 =?us-ascii?Q?qnDnoZhUYdnEc2AIV8Iv3bLhWrYixCCJvoHcYR4q04AvDmnkIsl4jK1saK6R?=
 =?us-ascii?Q?BHY5rX3TLfywb3JfAwxnEs6WaFdo1SCnSEokjPGYc8R79rpa5IPTYTGRG6ik?=
 =?us-ascii?Q?PggEQRDkgGj18P4U4NzDoDiJsW0UhCRJqc4TKj+GX42tW4lGxlCEfHPMGKjN?=
 =?us-ascii?Q?6D3uOgHKoTt9oGPrMEs2EXfig0IZVdv4gf2CXc8NhJavElyUmNnqH57RoepV?=
 =?us-ascii?Q?hikdjR1fCu/EjqaUGjPPt21IEOoohLiC+RdrxsupjqaFLQtl2IiyHf//+qbC?=
 =?us-ascii?Q?lXOgHJtokQzJF4bpLRdwMFtS16+HOdN7RIU3pvbhFfoV61PN6gqAyheI+sfc?=
 =?us-ascii?Q?hPlFnh5eqpM6mmjv53TnIcT9wV3gE9WkDoEjIv4tTcFoGDg4cfOAm+kn1brd?=
 =?us-ascii?Q?fMZUC1Xf5pJ7w1wonjnC0sWFaWfnJcRghjD9cSt8ByR5yLzEBeSZUYxg5PrV?=
 =?us-ascii?Q?TXZyZe3NAH0CHNKIm3rBamclYIaM6tQryDdubc1fr2+Qd9tp77cdPDSGUkG0?=
 =?us-ascii?Q?JL+Q0j7UCH1iKbZvnRi92vWXTAXHJn3dIQ6dhr0+18RB8ixpm1V/WO49ygx7?=
 =?us-ascii?Q?AkK1JVvNTF7hhSes3sfmJnbZbMmAi7ebSI2gmLKXbRrTCi9qwHqu6B56np0y?=
 =?us-ascii?Q?2jlG9J0NUpyVYzBq1qM8acC0sBCzs0ZW8jZ6GiEta/Z3B74w/txDurQBDA14?=
 =?us-ascii?Q?lH6Bue8z/W3DpMBU/uYzZdtRVu4VJK+L3NdQnBAhhp60/FHBQ3aowzJhXZ2k?=
 =?us-ascii?Q?ua6FALg1GXm47L5rJA+UPPwP6OWAZuD69Y7Vb10GsewzVbaPSQGqW3qlsqDh?=
 =?us-ascii?Q?beuPEgxuJDvVh2+wDIzyddUiWZKvhZ4IruTWk/JKq4KZar07Td8gQ2eGy2lN?=
 =?us-ascii?Q?S2SJBjVs7+TO2bLXiyr6hdLsPK0ExmUwwnVi/x/cjruYA7LDOmboWjhhLRNy?=
 =?us-ascii?Q?fcj5HTyV6BowTs3NF3AS3Ucx9g8xoBK1NVDqk6kJ9pPB+OnmZcm9fIde8G66?=
 =?us-ascii?Q?mFK6DLHBM3F/w0H65Af/U1A49fu+8ORw4bOnAxSKUmjiXZ6EwVfRDBiNCGVs?=
 =?us-ascii?Q?sOZjF1PD2Ar9gprlLegeVTV+dpivPZaYnMBA2C/8edAmvYGy8t+w9nkFf0Ey?=
 =?us-ascii?Q?kMaEzbzpJ8ZykdE6Sv4A96PMpffy5tNOgo/aGHdCdGQS8PtpN/ckYYrZ/mmR?=
 =?us-ascii?Q?WDAOPu3STgFcjUGNW+g1WfEhYjE1Ffh9Ew3DMyhY++XJg7YV5KY2dRAFW+yY?=
 =?us-ascii?Q?FOJR0Zkad8hwtPZVF12Eayvk1l+LD3+UmyexiPbh13yn9WKxrJgZtQdnRXVU?=
 =?us-ascii?Q?kRfciAVM7EXubs22b+otT9zX/hY8i9a9Ip5wKZpa8VQjyRWc/pmgc3NbjL3F?=
 =?us-ascii?Q?vdKjYV6b8fYzXWYlumObzeILQbOicMcldCZATnnQmDkegE1+9gmBz2XZjSU3?=
 =?us-ascii?Q?+xIu5xEpkDLtm5LLNfvMIACFpoWv0NyoP+z8DhWEVYq/y4Bb5lbzMN+m7HXr?=
 =?us-ascii?Q?OZEoaiMcgcRZygZo2E9NwlQOcgL0dfJnAiZdO29p+FBbGWPmFUYdffSUSo91?=
 =?us-ascii?Q?yYxczNq4hC0a0xgY6uq74++B/m5eXE3akADp75CWoIv/ubKCp3ERKhntcit2?=
 =?us-ascii?Q?2RTxitPlhvartyxmU2b84RY6dHeS89I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466bfb96-04b1-4b2e-8ca7-08da22c0f3d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:28:54.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdWPzuhl8mzseFxB2mYCEp+JpJTU8hhBA4Ojlk7pc/ynRm+fZS2gx50i245tIr/pEHNw82WjNQcAxaOrM6nxI7k7lJGdEqXqSQ/cZNXfNkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_02:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200070
X-Proofpoint-ORIG-GUID: LVWdbQG8qhAH3aqadzJDf_VqFNrsPrL3
X-Proofpoint-GUID: LVWdbQG8qhAH3aqadzJDf_VqFNrsPrL3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: cfb7b8bf1e2d660583dd91d870cec2f6728cbdbc ASoC: rsnd: tidyup rsnd_ssiu_busif_err_status_clear()
config: h8300-randconfig-m031-20220418 (https://download.01.org/0day-ci/archive/20220420/202204200039.noPcQg3a-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/sh/rcar/ssiu.c:112 rsnd_ssiu_busif_err_status_clear() error: uninitialized symbol 'offset'.
sound/soc/sh/rcar/ssiu.c:114 rsnd_ssiu_busif_err_status_clear() error: uninitialized symbol 'shift'.

vim +/offset +112 sound/soc/sh/rcar/ssiu.c

83b220cf8eb2aa Kuninori Morimoto 2021-05-27   89  bool rsnd_ssiu_busif_err_status_clear(struct rsnd_mod *mod)
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   90  {
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   91  	bool error = false;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   92  	int id = rsnd_mod_id(mod);
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27   93  	int shift, offset;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   94  	int i;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   95  
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   96  	switch (id) {
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   97  	case 0:
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   98  	case 1:
83b220cf8eb2aa Kuninori Morimoto 2021-05-27   99  	case 2:
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  100  	case 3:
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  101  	case 4:
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  102  		shift  = id;
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  103  		offset = 0;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  104  		break;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  105  	case 9:
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  106  		shift  = 1;
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  107  		offset = 1;
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  108  		break;

No default case.  The kbuild bot does not build with the cross function
DB, but even if it did, this code is too complicated.  For example,
the rsnd_ssi_probe() function calls rsnd_node_fixed_index() but does not
check for errors so Smatch thinks "id" can be equal to -EINVAL.

cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  109  	}
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  110  
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  111  	for (i = 0; i < 4; i++) {
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27 @112  		u32 reg = SSI_SYS_STATUS(i * 2) + offset;
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  113  		u32 status = rsnd_mod_read(mod, reg);
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27 @114  		u32 val = 0xf << (shift * 4);
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  115  
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  116  		status &= val;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  117  		if (status) {
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  118  			struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  119  			struct device *dev = rsnd_priv_to_dev(priv);
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  120  
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  121  			rsnd_print_irq_status(dev, "%s err status : 0x%08x\n",
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  122  					      rsnd_mod_name(mod), status);
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  123  			error = true;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  124  		}
cfb7b8bf1e2d66 Kuninori Morimoto 2021-05-27  125  		rsnd_mod_write(mod, reg, val);
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  126  	}
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  127  
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  128  	return error;
83b220cf8eb2aa Kuninori Morimoto 2021-05-27  129  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

