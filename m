Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB44AEAE2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiBIHQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbiBIHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:15:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9039C05CB80
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:15:54 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2196ZEqp011044;
        Wed, 9 Feb 2022 07:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=UdBq2s6qMDcvXEKVleD1sbDcH7B4+gB4oq3v6N+ryTs=;
 b=Ynaqt+wB48vCKd9t9YzT88Z9YcDinTzaPUaX7QZOdv1nLIQ1a0Wqc4F7DFAXzsHjHPv4
 GvvgWaXcLxmX5GA/+lchxcOUvMJsb5jfspDA8RoHyHcbNNaNkXkBT8kYHIdBlGQAc6pv
 U2Wl3pq/mJq4hc8v6VBgZ/nyOfsaSCuscP4bD6dLL9ek7BG57V+8jnMr3V0G84kuXgx2
 V6z8aQBAnd3KFqb4kjbOoMLLrZdNyRhGKEk9bYejRO48aPnaaZlDbNw0iCMlYC6LcB4Q
 IqjXxISL6wtAXBdIDpw5Am0LVfYPc+LQcDhh+VFd2IYd5x5rYeUuUpFonBSRSNlIE8n/ tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsus5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 07:15:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21976hQK177730;
        Wed, 9 Feb 2022 07:15:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3020.oracle.com with ESMTP id 3e1jps9du0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 07:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWSlpkOSGCysw0YmSrcG6m1AAISTW/+wXxeES5V+my1h3ea0if08o2lR+UsHR82GuC13DlU2C/RkS8b9L+OZDoJt4Ttx+dZLe47fbGaQeHqSj3Fd23Q90d2QPzPu6iFrclMP2wm5L9y8Vp2TbSlIiileGeDh7zVN8F6kZcCf1IV8GaMGcllpzBlrbggqazjcQK9GWcmQpuWt0WYBhxoOJlxQapRVoo7gzNFTvfedzTMbMsao+SluNsuEgxi0Sa5h7QHiBcGORecdOQkP1ikPe5dYxBK8xTrD9i3QXrlRRmrx4HSgabKEOkCpiccvn6vyUhgOVMHnRqPVPSIs82N0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdBq2s6qMDcvXEKVleD1sbDcH7B4+gB4oq3v6N+ryTs=;
 b=nM6bGNeDw1MPv2475nbNfRlF9f0KhxQjXaWzNhw3MFtTcQEojFk0ri0As8A98j4pMrskWUtPnGUurOsjJo9R+vda3R6KLoYpkeU/vJXvHN1nthVYoSRbpLcxjzGsXVARfiw2IizZcrLlpLa4WWunwlwt8+rEz1TYYTV2pQ66XESkwCf4Qxkf2LOWQi8EabCmipDjUyeZXL/Vp0faF1my+HbjoKM/xlQZmqI7aKenlNW8Hg1DWIdgIreN2eyfFfaIXWvqu2ok+7QjI2gZ2dxs5iWu4s3jtdw7t6jqUW6y+sn+FuLrKIiL04elVaVwhGbQYsIOeGtWjipYfexB34amMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdBq2s6qMDcvXEKVleD1sbDcH7B4+gB4oq3v6N+ryTs=;
 b=ncu4Dvfi/18tHH6vhqyTlgY2ZbkspenXbTmPYmcRl4RQdH/oS54g7W9KuF4XIQ0rGkHa1iqrzcie+ufTumaBNU/hCIDq9e9bb21hf/Dff2wA4nu8YaxXCwlrHXhWHvkZyqgWjkdgNo658nK0BN8fbK5QalJdj3hGfn0IA2v9dw8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1920.namprd10.prod.outlook.com
 (2603:10b6:300:10d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 07:15:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 07:15:43 +0000
Date:   Wed, 9 Feb 2022 10:15:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thierry Reding <treding@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/tegra/gem.c:153 tegra_bo_pin() error: 'map->sgt'
 dereferencing possible ERR_PTR()
Message-ID: <202202090230.00iA3ozE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f6c88f-43b2-4ddf-68c3-08d9eb9bfbd6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1920:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1920B002B0262C55057239C98E2E9@MWHPR10MB1920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yptE4Qeuf0772KV6ezfDz6bC6GH/8b5hdpJGefopDlXDeqMvN4/tadcwK8sNZRBXby+umR5OlfneON09AglvjWjPxaLeVb2ZZkH7kGl9/wn0qAUAeTL6vDHuvIQbfQsB0v9uInicNZDbSCvgBbwbsGkG0g1ZYoD5pNervnpVSmbTm7g3cREun3UBC4q0QDL0N/YpAudth7smmxMOD8ylaEZ1lSiDEsMGJ8PesEZj08o/jOvMJjRE/aSHlxZRNaIyPg5FEipehQyBFBVlenSY1RruV05ZvUIoStivFweNjdXZI4xNE6gCtBOwVZ9ONjZGanuOWAMYnBP7sVLzouiaqM/IPEj4GP52UZ8FZHCMgONzGsYXTpI7BSWDoYmGsR30uTi2Sd374EEam2fctW3UZRxgPOL5xKg8epBTt8fzxMpjp5c01YSTYGpZwIC5VhzNkGR8uGDT1LJxUBWGuyfVtf8YzkXsxR7+QZKlwAdr1AvOt+lSf/6CkB3eIR6+FAe8TkD5PF2Kp7+/eAGU6SorF0WpQZR9BXA/sYmqxKtArgBSvsEUp/pOFe2QTf1Zw0tj4+Ig0M8eT0W4MmWsvPXCrdpFMcP5GHQuzr+K2zOjiRxDsmkuvrEugoLALpw4toZn3CZNLyWcTi95Bxx+lxg7QxB+OwQJbmd8RmutKj3QrIq+EBgqZY+kh2iGx4IO4zVRAYVAi+y8s9A1jNE8KKYyD9LvXP7Qj45H1oIDdq+YB4ARMc2HPHK/w15SO2v+wfJrl3SObh3vSWrT1ilCqqmaS4Vu/FCNfH5X8ZKGzEwQe2L6RkMPvzMecsU/gvlgVJm8bzJJgfDXnTVIyGlDEkcwxbO/vCcetaTbzmwpkgr/g6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(5660300002)(26005)(30864003)(1076003)(4001150100001)(2906002)(6666004)(508600001)(36756003)(38350700002)(38100700002)(6486002)(4326008)(52116002)(44832011)(316002)(6512007)(66946007)(86362001)(9686003)(8676002)(966005)(8936002)(66476007)(66556008)(6916009)(6506007)(83380400001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84hk5gLZXLHzdaTFsWwrDmDQfCKKbR8kKQzN1ImI06tfYQHzpFLWzOQnWzmZ?=
 =?us-ascii?Q?VJT9TTrO79kjbzceBaAFbOsLe+8ijWCDCO4NOEfR8SJNZ/X29zzv+n4jdqgP?=
 =?us-ascii?Q?drw6yXFV4XSqgV/PJ5ZepSIlb4oRHUFkX7DWkob76MwCOEfww5OyjY7sal8G?=
 =?us-ascii?Q?YwBqA8BLMZ15NDiyRaSePm1Ltk8kk69DBU0+WLp9Eu3HjhqyJLs4tCH75t9G?=
 =?us-ascii?Q?YankxSrmlGLbnZpGY5oH6tXOMx3ZL4+2kJ6FlNQE+K70pSPElO4GOPnhY94K?=
 =?us-ascii?Q?NRzyhp+jeYerT39VJoaoj1EQ9s/ZjP8r5w8axk5X77r9vGE7Rg/TeklKNgDX?=
 =?us-ascii?Q?CPYfTLOzF3mJqCAJTtsUYJs9K3kOZwiQu6qEn7z8OWHoYv/FeudGBV053tMl?=
 =?us-ascii?Q?XBnvBNDrKu6T0FQ4Xs3gx+SrTVgrnaiUF9xHkfZgsCykQ8iDHTW5x677WwxA?=
 =?us-ascii?Q?G/UFgbIi/qRsM1P0gIO+XYgZN8k+p7j7EBKpjKTicTEWDTq3s90dkNzlzV1N?=
 =?us-ascii?Q?GQA0ao0QP8r3JbEuhG87xgGOC0t7oSjbQbD4rJP/Kk7c7U1tUMcJLYXeg9Te?=
 =?us-ascii?Q?lb3NY6Zx90LAFno/Vrg84G7/d30IwzanbvpUH6jAZ3KpfME3Uf5ze13WhKPu?=
 =?us-ascii?Q?JT31rRy/+m50rOeIwwpy/63uCr0f9kM1FDbIB8A8a0MZTE+nGjrp3BkMvLhv?=
 =?us-ascii?Q?gheDMY6FfTbwMfIDtGqnAdekMVr4RdZzCf7odZtDcvoi7LPpJsvwgG08ndpi?=
 =?us-ascii?Q?qrZqnTadc6p2RQlcMYjSAYErUYk6cGJKQjevmMNvW0PHHrkSdRcAwBHUjZC0?=
 =?us-ascii?Q?DLvCu0gKcj6UyHbDbXpynAI+ZPnJQvt0ZMAL+PSclign4TuEOKUkokQDGjh6?=
 =?us-ascii?Q?kUnG0CS67zzbE0On68Q9WsdeUyn3g/gx9vDmd7y/ndvEwlrJS3ERv7RAiAkK?=
 =?us-ascii?Q?/7xsWe7thedcvG/iO0bUN5RCF3cCgItyy8bUynh1q2JLiQlRJnWRIONsMqc8?=
 =?us-ascii?Q?LTkEfdQyt0aN3pFZ1635OMWhTKkqScvjAlg5aiQUu8K9OzWmotIAHnz5jHsH?=
 =?us-ascii?Q?11LfQ7Ym/DQn3+hv+3ojAawfde7TtAIU8BsUVQFruF5Bcu6zg3RDshJpefj9?=
 =?us-ascii?Q?BnjET8SEUVgU2i6gscnRKtOxKbsPkeNjXe9zgNwFA6DFCDrRE1uUWPHIYd/s?=
 =?us-ascii?Q?/5GAh1aHl+mN8VfUI9C85lPb++KwHzQgJwdzBqciCS/cv+VhMiGMh/UBHtZa?=
 =?us-ascii?Q?uSZyrBnE1/Jpt02uwCaDZ6BjUkrZIyoGJ+/UaX3IaKEzDIWUxWY+yPHSpi5p?=
 =?us-ascii?Q?L7cuRbQwv57NvFLB6VyZbXO3dg9xjcruXdRg8J9+Kqn8UkQH5qgNOn8c/128?=
 =?us-ascii?Q?8Dl/wM5hphxgAEAwsK9vBKdqd+Np1zkUFlVZ1044X0akNVnfSLe6Mh7TV9Jd?=
 =?us-ascii?Q?yaC5dLC8U5DMn8IW2vTQeDPu+hb/hF7+UIIg3NUS5k42L9GqWpOKascwvtJz?=
 =?us-ascii?Q?N7Mel9BMzXyg18l0mFaiGEVu9nHUhRtyKU1ok+LbQM2raX3zn3A1rV0787kT?=
 =?us-ascii?Q?Aq3II2mgC2GcpLVQ6dIK/o+21LHODLR51VoZ7ka3FqPiZCTE5xfSrizjwSFa?=
 =?us-ascii?Q?JTtp5lSLGQMALfWepf49JeYS78QwnWmUf7el8JQGmP/M5zVLiRanCJBlg/ux?=
 =?us-ascii?Q?eDDTRA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f6c88f-43b2-4ddf-68c3-08d9eb9bfbd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:15:43.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItN3k9ixS26MdCSfWfb+hPHC/WTtnPRgEBg+G3WhMJ0Chrgp7avo9/AAWHqU9jC4WAynnlyagF2G9GGvTV5Cn8zJTimXiU7EdWEm+AuHNuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090049
X-Proofpoint-GUID: QLcgTqJJwZsnACmiK-zy2wlD33xSE2F-
X-Proofpoint-ORIG-GUID: QLcgTqJJwZsnACmiK-zy2wlD33xSE2F-
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   555f3d7be91a873114c9656069f1a9fa476ec41a
commit: c6aeaf56f468a565f6d2f27325fc07d35cdcd3cb drm/tegra: Implement correct DMA-BUF semantics
config: arm-randconfig-m031-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090230.00iA3ozE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/tegra/gem.c:153 tegra_bo_pin() error: 'map->sgt' dereferencing possible ERR_PTR()

vim +153 drivers/gpu/drm/tegra/gem.c

c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   58  static struct host1x_bo_mapping *tegra_bo_pin(struct device *dev, struct host1x_bo *bo,
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   59  					      enum dma_data_direction direction)
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   60  {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   61  	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   62  	struct drm_gem_object *gem = &obj->gem;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   63  	struct host1x_bo_mapping *map;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   64  	int err;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   65  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   66  	map = kzalloc(sizeof(*map), GFP_KERNEL);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   67  	if (!map)
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   68  		return ERR_PTR(-ENOMEM);
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   69  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   70  	map->bo = host1x_bo_get(bo);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   71  	map->direction = direction;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   72  	map->dev = dev;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   73  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   74  	/*
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   75  	 * Imported buffers need special treatment to satisfy the semantics of DMA-BUF.
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   76  	 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   77  	if (gem->import_attach) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   78  		struct dma_buf *buf = gem->import_attach->dmabuf;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   79  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   80  		map->attach = dma_buf_attach(buf, dev);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   81  		if (IS_ERR(map->attach)) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   82  			err = PTR_ERR(map->attach);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   83  			goto free;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   84  		}
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   85  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   86  		map->sgt = dma_buf_map_attachment(map->attach, direction);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   87  		if (IS_ERR(map->sgt)) {
                                                                                                   ^^^^^^^^

c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   88  			dma_buf_detach(buf, map->attach);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   89  			err = PTR_ERR(map->sgt);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   90  			goto free;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   91  		}
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   92  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   93  		err = sgt_dma_count_chunks(map->sgt);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   94  		map->size = gem->size;
de2ba664c30fcdb drivers/gpu/host1x/drm/gem.c Arto Merilainen 2013-03-22   95  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   96  		goto out;
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28   97  	}
585ee0f27ef7b8d drivers/gpu/drm/tegra/gem.c  Mikko Perttunen 2016-11-08   98  
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28   99  	/*
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  100  	 * If we don't have a mapping for this buffer yet, return an SG table
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  101  	 * so that host1x can do the mapping for us via the DMA API.
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  102  	 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  103  	map->sgt = kzalloc(sizeof(*map->sgt), GFP_KERNEL);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  104  	if (!map->sgt) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  105  		err = -ENOMEM;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  106  		goto free;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  107  	}
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  108  
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  109  	if (obj->pages) {
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  110  		/*
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  111  		 * If the buffer object was allocated from the explicit IOMMU
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  112  		 * API code paths, construct an SG table from the pages.
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  113  		 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  114  		err = sg_alloc_table_from_pages(map->sgt, obj->pages, obj->num_pages, 0, gem->size,
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  115  						GFP_KERNEL);
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  116  		if (err < 0)
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  117  			goto free;
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  118  	} else {
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  119  		/*
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  120  		 * If the buffer object had no pages allocated and if it was
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  121  		 * not imported, it had to be allocated with the DMA API, so
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  122  		 * the DMA API helper can be used.
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  123  		 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  124  		err = dma_get_sgtable(dev, map->sgt, obj->vaddr, obj->iova, gem->size);
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  125  		if (err < 0)
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  126  			goto free;
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  127  	}
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  128  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  129  	err = dma_map_sgtable(dev, map->sgt, direction, 0);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  130  	if (err)
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  131  		goto free_sgt;
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  132  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  133  out:
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  134  	/*
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  135  	 * If we've manually mapped the buffer object through the IOMMU, make sure to return the
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  136  	 * existing IOVA address of our mapping.
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  137  	 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  138  	if (!obj->mm) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  139  		map->phys = sg_dma_address(map->sgt->sgl);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  140  		map->chunks = err;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  141  	} else {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  142  		map->phys = obj->iova;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  143  		map->chunks = 1;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  144  	}
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  145  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  146  	map->size = gem->size;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  147  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  148  	return map;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  149  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  150  free_sgt:
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  151  	sg_free_table(map->sgt);
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  152  free:
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09 @153  	kfree(map->sgt);

Error pointer dereference.

c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  154  	kfree(map);
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  155  	return ERR_PTR(err);
de2ba664c30fcdb drivers/gpu/host1x/drm/gem.c Arto Merilainen 2013-03-22  156  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

