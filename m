Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8F4AF8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiBIR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiBIR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:59:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0570C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:59:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HAbYZ027666;
        Wed, 9 Feb 2022 17:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=2xrlzxLw2b/5ZfoWy6qky0IW04k74UAyHezpoLZhO0s=;
 b=iS+uUO5/LVmCCPKMto4xFDpD+E7amNE5P2RUUxIoMeXkKOJjUR82HXPVWDiw1TtY1S2u
 UF6NsuPZMKpctCHbYRDiq6uOilCnhVtk75nRJPorlYXgZs//hvJbpyF+pVf+HMNxyxln
 5wQLUqsXopCAWUMnjsCQ5OZJGF2fh/eo7ctobFoc068x2pBxqwDAzJd0Ub9LxrFHXigJ
 pG3OhX2jfZz02jLGQAInIxjovmBIQJag6qTqYFgyVILdX4gkCgJiixM2JkuEb9+qJeTk
 EtDUSUMLqeQpzpS5cgzNBlT26mdeExZzar4352zvuuplhSmD5yfCsnT9mPjriJxW5LqK 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdswb9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 17:59:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219Ha12I010870;
        Wed, 9 Feb 2022 17:59:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3e1h28pt03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 17:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFRhL7p1Wix5UEjLS6gfKzzRo6eOxCuLKZfM3KAqO53dNcZpMoqVFcl2092HIE33VblpPXFZuUlhFq+H0jVdADOtu8Y+LFi7EvP46QRdQKE659KD5cDuDM3VRLU5ainVXqy5cKr2asvPz8e2ey05Gu/wycnQLtrUEO9iVNMBDkPNawImMvck8joWfIU8SpmWoRQ2sp8MwE3xTg568jDB6EWQ2y+o9dgiwPNmC3SKRyX99KBwGNWPRKBarjelKBeO2yqN5QUNYEXSQOTDQJHRvGsbButq1nPMSu2YtoIZxJiM2oHqA8XkiX1HB4H+eaPoTi3LZGpOfii3n9TAQXt3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xrlzxLw2b/5ZfoWy6qky0IW04k74UAyHezpoLZhO0s=;
 b=knCItFyaMxdMLh41ahStWNp4SpkqPBaL5aJ7HVHH2Tc72gvc8QvfXV2n+d5ecLfYsj+Whe43vj1Ao7qr3YtqGrGV6QSxV2ypZXPwc55yy5zsI1VS1xxL5kNjKC0kauFCKOTetfU2/fol6PNb/nUBxsLdXdWxy2SAmcENNKIZ5lB5jVF7LtKGMkkODDxs/wcnzMHJ8gKw/4QvvliuFPA9kLQY2gLlueOzotJbu3kXavCxgedmuMwEfZHQLhm5Jufv+Il+rJadi8T9TxFaZiU71edtHPJksYSm98/Twms9f1Sf+PmgiYnw+874ta5KxESWAj8KNvKo53wc9SLy5dH/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xrlzxLw2b/5ZfoWy6qky0IW04k74UAyHezpoLZhO0s=;
 b=iWiSIRNtg+sWG7metagQEq8aZViLKpQv5ikRJrM+facBZluhT4gNsByNGlaQU97Yk3k4Srf7YB8nHvOXM3Cg5LbF9NU9zAxbrSwHs8lOQGRsBUR3T31nZ6641QIs7ZpS2ZjDag7XFo4/U4N7IHFPnh+UhJ9npHIbozJfn5CQw/Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4833.namprd10.prod.outlook.com
 (2603:10b6:208:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 17:59:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 17:59:14 +0000
Date:   Wed, 9 Feb 2022 20:58:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mtd:spi-mem-ecc 16/29] drivers/mtd/nand/ecc-mxic.c:652
 mxic_ecc_finish_io_req_external() error: uninitialized symbol 'ret'.
Message-ID: <202202100023.AD5wMMvp-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83f1c0cd-9b91-4c6b-1c47-08d9ebf5e216
X-MS-TrafficTypeDiagnostic: BLAPR10MB4833:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4833E31615D1BC8F9545206D8E2E9@BLAPR10MB4833.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7yOLGznm5nM8hlB2L8ICCp8iyUqRdyrWaxFrAE/cdJAlWjxs2CdAle/LsqIWyYJTMlhMR9c7grbrEA+WPQDJqGHw1AUCUtmuhWmoYlkr3fP8a2Yj1ZtK+0JAGS1DDKBpDTpTjBNaiHGUk9ABbZElSnqwe5o2OM+Qo26Xdg1HTK8QbaxPX6EXyn71DdbUpVE7er0xNBQQimbDYmsqmTSCYY71YCCULCXEUC+tyCaxhIZ9eEqabtZuqS0xFKzDQJTEf9gQEmRzy5ATXUeKTkKqzGB0ZfrZk28tXHUZ5aGLJSWaNIndTS8+61lKIocVYR277883ZNBnud/b7xNH8Bkk07PJ0MelweQMvjtMjUBv2Vocy9wHxvFNfEj5NLidcEEp0FOkJ4X8Lhq6v/b9mXfcSDspD9I4XEMDzyKqsNXRZHiHVtK4fMGWZZqonr496lotf0MooWxbnjDo0BJt+V5onzvE3TlhytPEkGL0eugR8//kz63jiR8TLQqt4U5MpraFNqXYjYw2mqbeX+n/e/avTD+GuscSrwb32Q2owgeOGV8omS5lR++onXAqDcUw6ssA7dPzyEOJaMzAIT9hl2EZ2D4vaUwVMbisG2QC5iINJjTgr1E5NHARHYA8J1UX010wi/VwRn4zB38xppzDfcGLZom0tZL06Kms8Hi26l4pI5Yt4pX5E6X+6BkUS1l3sThaccz1jf68uWZjt8FD/ZIsgKZikMpLrq0Yp4+h9ugHe6M59/LBv//wsaHNZ89/kouQf3jIbqzvy4wD8EyjrODKKK8n1yPd0S3s36S2U3wHjZdX1aNDwutkU9AzaeYZLmSlqrdSToLsCzbNUCw/XdPWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(66946007)(83380400001)(316002)(66556008)(508600001)(6486002)(966005)(6512007)(8676002)(9686003)(86362001)(6666004)(4326008)(6506007)(26005)(186003)(8936002)(1076003)(6916009)(66476007)(4001150100001)(2906002)(44832011)(5660300002)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzwcmY8d3/IaTOrZDLSn09mMnmUVTjkvz+ekD0AGgmebON4hkeK8qD1WWHcy?=
 =?us-ascii?Q?HTP4Cx7nPYdGVRBpSLSXkZcFmtTiVWVocJ3a2hIVsYsml9TdhMhkrmzZRyax?=
 =?us-ascii?Q?0nozy5Bo/pdJQFqLESdAsj1aA1/cqQK0Bk+nupGEyiw/17hkSdRRZd0HjbAt?=
 =?us-ascii?Q?6aEel6s6bZjUM0OGFW3yDwxZh2KL+Sm4i2CFDLvXsnycYtpSZz/BIwttBNjv?=
 =?us-ascii?Q?mJDX89v2GTBgD5lH/4BumcgrxW4haiBdxhlf7WS2sEsoA2/58QribMCO8K4W?=
 =?us-ascii?Q?32Bck9QhalutjqKe70/elp/qPPyH80zKfFsmRvEMNDajeWs1lkd847rRCrd7?=
 =?us-ascii?Q?4q0oVpnsyLk1L/k4KNrxGsfhKuhfakwwVJtKEK4EYQMt4oLT5nD5X09EE90v?=
 =?us-ascii?Q?yuJaqQR5ilTo9Rw71l1rcHyUEsNdZPfvyoC+uKRXExaCbyjKukFICKzh+HRh?=
 =?us-ascii?Q?qqZwpHY85txN8BVm/kw57Bbq5TYFsYFpAIfzdvkNZFztI5cR3JrtLw5DKVUe?=
 =?us-ascii?Q?w7eEhs1ixjTe8HIscVeYODktS9s5ZQmWYyBuYBUa1aFlZVN4as5VXcv6GDKa?=
 =?us-ascii?Q?U5VSJfmQtOJ6x4snIGFIJnNP/emKjPLtiPIzga4oelMz3uC4fmZaQZWBQ2SD?=
 =?us-ascii?Q?Kz+LkzVqKKEyVD6NS7j6p+Jy+IKQmDL0dOnuxyTyRpKOWGRALNZsRsa9LmTr?=
 =?us-ascii?Q?iq8gTHPvRFBMFoX/wO/0gfIRH8ydN2lbrjbt6LBqAIh7jbHXV6snlkOUA2LC?=
 =?us-ascii?Q?eoVrhkPdb+NtFc7NcP6/oCykeZa8RdOr0wBGPkktFhO1V22vJW005Ng9hWfq?=
 =?us-ascii?Q?CWCtFj1hCySwM8vSodudJGNunRuHt2p5IAozDQikVK5WR4RC81xiZ4nW7m4j?=
 =?us-ascii?Q?wcwx0MmIW9RGsoWZs8Y1BEicO8G+qNokfbDVo+Uj18c8lMAT2wL1BcVxgksX?=
 =?us-ascii?Q?ZP6nPC2vwrAJV6OwCcSOt6vWy+9yoeLDyN2xOf2TFTEVeMS/FKuszSdPyBLj?=
 =?us-ascii?Q?4YF+Ji9zGHleSU6bQhkejQ4q0GDqtBpinzJ4Um/Crb9R3pxrO2OZt5xg651p?=
 =?us-ascii?Q?2xM5D21L6lsrcHC58f6xgOGoD4XkpMBawwID3TwdcHlmhl+QlUUL4uFYDCFQ?=
 =?us-ascii?Q?hXMbMfQIWW2s9XqnThpKitxske0BRFCHmKr8aoYzrf9N5FqZ2EqU1khVWAts?=
 =?us-ascii?Q?BskiXlSzFJ4vNwvJ2uhRAwfTczty4CiRklFFdg7Q6z/FchYNxCKc/FYc0OK1?=
 =?us-ascii?Q?sBk/xMFZa829Dzr3we6MNqLKgzW+A+i20HvUtamzB8KiS66ZCKEYuAXwhtnB?=
 =?us-ascii?Q?BKNLizpRl5U3Cjuxp04r/i5Hst6pF6aGj3gxZlHmkoFHrGfMWGcLcZTz6X8C?=
 =?us-ascii?Q?j2l50gvhrttVt1uA4wOk7dq6CX6y1e/9CE+7SlLJCt3+hfb7jfTCZLiwId9O?=
 =?us-ascii?Q?AX4+3O/h+oxGopZc/f/D/laqQvYxg4SVSFbnLYhcVgh+jVJ/AJunXtLlI1qi?=
 =?us-ascii?Q?91X1hLDEd7ucDYpHt+q+OGsS/sCKjNWqvd3twaWcbrogaqPp8w0IzsqzFiJP?=
 =?us-ascii?Q?PX+Pu0dw4vjAEtz0Y7Tox8VnOEF1K2a+aCWb2rip2E6K4Kgc+Vc0GLyO1AR9?=
 =?us-ascii?Q?dprqYdWqlNIx5wL+poW8sj1mAkwgOztn8dMwfLteUlK6GMOUKbJzbownzPta?=
 =?us-ascii?Q?mNUw4A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f1c0cd-9b91-4c6b-1c47-08d9ebf5e216
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 17:59:14.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMgcHaXQLGgirvR52W+JTAIZK5bfBvetiiAw3tB7h8FUhiIQ2g8T4snrqEjPQV7VyIGLFjeZKyZpg6BK7DXM9raufsAZzNFDeCgiHVw3um8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090096
X-Proofpoint-GUID: giHP_wxEzmM9N93XnlXraYWKk9dJVwjN
X-Proofpoint-ORIG-GUID: giHP_wxEzmM9N93XnlXraYWKk9dJVwjN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc
head:   b556a86810e25b9d5a56da553bc65e5f4dcbedb6
commit: f46b431b115d2ead7ccf71da53a5d1993f0acfcd [16/29] mtd: nand: mxic-ecc: Support SPI pipelined mode
config: arm64-randconfig-m031-20220209 (https://download.01.org/0day-ci/archive/20220210/202202100023.AD5wMMvp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

vim +/ret +652 drivers/mtd/nand/ecc-mxic.c

48e6633a9fa2400 Miquel Raynal 2021-12-16  611  static int mxic_ecc_finish_io_req_external(struct nand_device *nand,
48e6633a9fa2400 Miquel Raynal 2021-12-16  612  					   struct nand_page_io_req *req)
48e6633a9fa2400 Miquel Raynal 2021-12-16  613  {
48e6633a9fa2400 Miquel Raynal 2021-12-16  614  	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
48e6633a9fa2400 Miquel Raynal 2021-12-16  615  	struct mxic_ecc_ctx *ctx = nand_to_ecc_ctx(nand);
48e6633a9fa2400 Miquel Raynal 2021-12-16  616  	int nents, step, ret;
48e6633a9fa2400 Miquel Raynal 2021-12-16  617  
48e6633a9fa2400 Miquel Raynal 2021-12-16  618  	if (req->mode == MTD_OPS_RAW)
48e6633a9fa2400 Miquel Raynal 2021-12-16  619  		return 0;
48e6633a9fa2400 Miquel Raynal 2021-12-16  620  
48e6633a9fa2400 Miquel Raynal 2021-12-16  621  	if (req->type == NAND_PAGE_WRITE) {
48e6633a9fa2400 Miquel Raynal 2021-12-16  622  		nand_ecc_restore_req(&ctx->req_ctx, req);
48e6633a9fa2400 Miquel Raynal 2021-12-16  623  		return 0;
48e6633a9fa2400 Miquel Raynal 2021-12-16  624  	}
48e6633a9fa2400 Miquel Raynal 2021-12-16  625  
48e6633a9fa2400 Miquel Raynal 2021-12-16  626  	/* Copy the OOB buffer and add room for the ECC engine status bytes */
48e6633a9fa2400 Miquel Raynal 2021-12-16  627  	mxic_ecc_add_room_in_oobbuf(ctx, ctx->oobwithstat, ctx->req->oobbuf.in);
48e6633a9fa2400 Miquel Raynal 2021-12-16  628  
48e6633a9fa2400 Miquel Raynal 2021-12-16  629  	sg_set_buf(&ctx->sg[0], req->databuf.in, req->datalen);
48e6633a9fa2400 Miquel Raynal 2021-12-16  630  	sg_set_buf(&ctx->sg[1], ctx->oobwithstat,
48e6633a9fa2400 Miquel Raynal 2021-12-16  631  		   req->ooblen + (ctx->steps * STAT_BYTES));
48e6633a9fa2400 Miquel Raynal 2021-12-16  632  	nents = dma_map_sg(mxic->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
48e6633a9fa2400 Miquel Raynal 2021-12-16  633  	if (!nents)
48e6633a9fa2400 Miquel Raynal 2021-12-16  634  		return -EINVAL;
48e6633a9fa2400 Miquel Raynal 2021-12-16  635  
48e6633a9fa2400 Miquel Raynal 2021-12-16  636  	mutex_lock(&mxic->lock);
48e6633a9fa2400 Miquel Raynal 2021-12-16  637  
48e6633a9fa2400 Miquel Raynal 2021-12-16  638  	for (step = 0; step < ctx->steps; step++) {
48e6633a9fa2400 Miquel Raynal 2021-12-16  639  		writel(sg_dma_address(&ctx->sg[0]) + (step * ctx->data_step_sz),
48e6633a9fa2400 Miquel Raynal 2021-12-16  640  		       mxic->regs + SDMA_MAIN_ADDR);
48e6633a9fa2400 Miquel Raynal 2021-12-16  641  		writel(sg_dma_address(&ctx->sg[1]) + (step * (ctx->oob_step_sz + STAT_BYTES)),
48e6633a9fa2400 Miquel Raynal 2021-12-16  642  		       mxic->regs + SDMA_SPARE_ADDR);
48e6633a9fa2400 Miquel Raynal 2021-12-16  643  		ret = mxic_ecc_process_data(mxic, ctx->req->type);
48e6633a9fa2400 Miquel Raynal 2021-12-16  644  		if (ret)
48e6633a9fa2400 Miquel Raynal 2021-12-16  645  			break;
48e6633a9fa2400 Miquel Raynal 2021-12-16  646  	}
48e6633a9fa2400 Miquel Raynal 2021-12-16  647  
48e6633a9fa2400 Miquel Raynal 2021-12-16  648  	mutex_unlock(&mxic->lock);
48e6633a9fa2400 Miquel Raynal 2021-12-16  649  
48e6633a9fa2400 Miquel Raynal 2021-12-16  650  	dma_unmap_sg(mxic->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
48e6633a9fa2400 Miquel Raynal 2021-12-16  651  
f46b431b115d2ea Miquel Raynal 2021-12-16 @652  	if (!ret) {

Hi Miquel,

This if statement is reversed.  No !

f46b431b115d2ea Miquel Raynal 2021-12-16  653  		nand_ecc_restore_req(&ctx->req_ctx, req);
f46b431b115d2ea Miquel Raynal 2021-12-16  654  		return ret;
f46b431b115d2ea Miquel Raynal 2021-12-16  655  	}
f46b431b115d2ea Miquel Raynal 2021-12-16  656  
48e6633a9fa2400 Miquel Raynal 2021-12-16  657  	/* Extract the status bytes and reconstruct the buffer */
48e6633a9fa2400 Miquel Raynal 2021-12-16  658  	mxic_ecc_extract_status_bytes(ctx);
48e6633a9fa2400 Miquel Raynal 2021-12-16  659  	mxic_ecc_reconstruct_oobbuf(ctx, ctx->req->oobbuf.in, ctx->oobwithstat);
48e6633a9fa2400 Miquel Raynal 2021-12-16  660  
48e6633a9fa2400 Miquel Raynal 2021-12-16  661  	nand_ecc_restore_req(&ctx->req_ctx, req);
48e6633a9fa2400 Miquel Raynal 2021-12-16  662  
48e6633a9fa2400 Miquel Raynal 2021-12-16  663  	return mxic_ecc_count_biterrs(mxic, nand);
48e6633a9fa2400 Miquel Raynal 2021-12-16  664  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

