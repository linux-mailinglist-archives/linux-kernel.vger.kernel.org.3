Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8E5119D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiD0N20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiD0N2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:28:17 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F538BF6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:25:05 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RCPLrX017559;
        Wed, 27 Apr 2022 13:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=0lzRG+EqONpMi5RXnqZXZ4G9naGVOpSCFzOw5Z4gBPg=;
 b=O9qHjgEH/OPfJsvrKa8mG8s7AYC7D61OK89oPcrCaAK5+UaRl6F9FuA5IwfrTmgXv0Xg
 ydOBrDn+TW6Q6p48Cii1DED3oh9XgaaHJGAkN6e1Zwt931E2r9lXUh6q5O/7SAq89Awl
 1jLWV5KBuxcsIRnl6SYHRktP5Ft9JGvUcmrNtaeaqws5nG6TO6Je0iFvbNnsyCmc0YGO
 oAR1TIJmETcEEGYX2aDPQGXAbzBA2e22mI/PDHrQsdMw6ZFlnLiT/jvVorjRcANs47sf
 1+lTSoLLscSsWoWd+F7ZqVsbhwU1u1ZqIrz5mKGG3L779Ap0vrfVYcNRrgqGE93Il8f6 xQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fprtcrgym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 13:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSTnFD+U/IcHWMa7peCpDUwSZzmheG4ns6qLAOHHqjxZ6rLWZdAfRglPB+hG/B/J/uPPbjfeSQD8iKCHrmnlaulkVmBUbNxEeC1B0MQM2f2DhKiUHsICmCodTEcbJLRkmbBBOMGmo/MNsZFylceEpfdcUHg1wJMTpFB7UdJiNE5BYAlvdqR2kY/eYW/2qRdu3aIEZfnijKrTU+ZFvVTebwkG7KNtmuByTFF/WsazhCoWzhhdmjspgnfx4euz1z4VJpmjikQ97BYJHUrVAUUD9EZ6AhZZejsEGssTrEyTVTSHIjnKFzBWyia1UVIu1ofomRFruPtGhpIoFLZvLqr1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lzRG+EqONpMi5RXnqZXZ4G9naGVOpSCFzOw5Z4gBPg=;
 b=K5pyDWfyPtoubUcLsZz0MrAHUHV5nHdTwSL+dt2VmO+R49Z0ate6edcMQ5k9MFUNeZllvWcTVs90P239cV5UcYCohYJMdhleXSDilhhovA5L6+2GvyJ1JHfZD2c/uG2OIQmGhfLx9Na686tPEdRr9pRAsOe7jWaFBPZKDfX5M6YXpdpN78tMYYSoApv+IUgGYInBTRrlo0G3kZ8MposctQT+cVh0IAKayRj0eV8GUAWSL4LYZnhBGArkwgAfNMY/ka3LxKZrObwl01oL3p3KikvPv9viyku5RrLIlfkm0Wfu8fBqqi6j5cKkb2d7JcjmbyDX/GmprAmaF8z7eTySDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 13:24:56 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:24:56 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: [PATCH 0/3] remove remaining IDE driver fragments
Date:   Wed, 27 Apr 2022 09:24:32 -0400
Message-Id: <20220427132436.12795-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f802e1c8-ef75-4753-5606-08da28515263
X-MS-TrafficTypeDiagnostic: BN8PR11MB3650:EE_
X-Microsoft-Antispam-PRVS: <BN8PR11MB36509FD1DD76527F5E25DF0183FA9@BN8PR11MB3650.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtXToKxQDsNnCoF5F4a6CM4Nx9EaILaBAd+Qv4oYhqQ1OhgI837Jfc6TfGjAcp8zF/EIqYOldqRv7IVIEwh7K9912HM3pMUvgoEEUSp6TgXWG+/SZ+aQt6QD2JpWA78dFvDUByXcuRYoGTiS073vfrfJrYdmdMFKDaN+IAYhDbt9wnLzHosCQbQM/DuOz4YUhimb55fNORteAvkEVsgbSbM0ImoP9eBULvtL6q1q3R6ZcucZ3VpmeTLwbhwhumz6DAnZA4xGP5d0ypnObsXWkTXvSSxdVkE9Yg6ynnAnXyZyxtaKHlo/hsG00wWCNkI4Nz92Q1t6HFIZyznU6DxXx92Xk7epsWMyhibqis8/+RQA1MMx2ysVEPgaD1GYscZQLreYigjBT24LldlZQv71BUsR7SeJy0xuYt0nyE7BCqf4gaOLdo/5XiKzcub2ww//bTo5Gn3XOmr6/TS3TDdPvFPtZd/A75kS0MVAcaf8C8Be21Wx0i+AqY70RXjOZ0yIasN/8o5TJl9c1zFoJgxZoAYF6K91nPifb73w/fYXc39qMPPeoZAlSdL5R7rtqNY9rBviniPrggNvC9/IDZ5jNFFezcSFUv7B6A8lmyFZzBWvEWjoIl2VyIUJfxMap3nqQ6qa0MMPG8BJ/i5ovCWzjX8V8FObvifRpxBPM/4tnhsE7dUK2OMIth1bF8LhNycI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(1076003)(186003)(83380400001)(5660300002)(8936002)(4326008)(8676002)(36756003)(44832011)(2906002)(54906003)(6512007)(6486002)(52116002)(6666004)(6506007)(66476007)(66946007)(26005)(2616005)(66556008)(19627235002)(508600001)(6916009)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFILQlRvQ/ELgjnYKG3n8Gz4cMB6hh8GMZnV/XJUwBU5mPNEDjqmyvFL554r?=
 =?us-ascii?Q?Xns22lv/n56stXAVSpbrejX1jcEdfpcrij/EfnjVvOpN6ZGfFlOeMfSOI5WL?=
 =?us-ascii?Q?377froZ333OW+hIYN/9PD7HXeGhvGTVfCgvFZ7FVkojzO12rfF4ZTJlzKR8M?=
 =?us-ascii?Q?kO/RapXtOihYZn+jd8YAsE7zt8QAOU4JCZt9ShzrV/0OMBdepbX9hqNdXqxW?=
 =?us-ascii?Q?Hp0pTM9R5yYNVFffcRmqO6fmQ1jsYT2Oj7mnl5LoAzsdJtoT3AuCJFMT64gS?=
 =?us-ascii?Q?OYdj3fDou4OfUnByw1U2Bg9j9xzsz6LYUnIfDnWuYwXrftMaQbMGT17YzwIo?=
 =?us-ascii?Q?/6Lj8qLA48kEyaYCRwlGWS4P0kcsmnpl5uy47pIRtkmdDLIpDz0auyhIbwcB?=
 =?us-ascii?Q?ATLYSmhelMMn1kIru+2UhKdgIlnyabbxlT4BNN+0wyYCkagbnBFu9P/8J/6p?=
 =?us-ascii?Q?QO8raX2VSTFEKWnW6wZv2pxQBaieUJbB/AHQgKXtKCKNHvwKxUg26GrQHxOm?=
 =?us-ascii?Q?hcMKmRSY2YPvspBU+VSh8hmbd38WwSGyB7DlzvUGnfhUpMCeO7DxtmWNZI20?=
 =?us-ascii?Q?uWfSv/1PybDWfZ+IOhQJaiMXYCKbn1QjAvZ62HGkwyhxA/2Mthmg1y0zGVL/?=
 =?us-ascii?Q?C21z4Az6VHv4GAXd7q8l9tEiJt5cs+8Fo3R2FL+a+r9KlgguTlFst8xWoPke?=
 =?us-ascii?Q?c/GS4TkCpzSCetXaHt6052AGdQ6QVNqXb/785Ys3ZPNlSxY+zK+po9UWR4XV?=
 =?us-ascii?Q?/tj6FOeJWtMFywzO04SxTNLMCuKXQi3NnnaU0CJo5IIj23+89KIzYhDOeZFb?=
 =?us-ascii?Q?6j8eO2JKlIkQv1z68nPBUR5cPqPjiQfH9CrzRZd7UD0pfFFJnfOIl9BSbSeJ?=
 =?us-ascii?Q?tInAbxV0DOP1zIYXI2kiHzenwEFfjIANXiAh31fuk7UCwlMtoivn1ZV/QD0M?=
 =?us-ascii?Q?h69a+lSrcuWZ4FlhXT4mOiM4c23g0GB174qUBaBVcdz+tX243KFcDAyq1Wxm?=
 =?us-ascii?Q?0UDyGewctw2u3+g1ctlEHvA5nYxlD4B/B4hfJ0yauZZMKbbj4J2fKfQy+xua?=
 =?us-ascii?Q?kaM+dSvq0Yk1PEMydAR8icqC49yDXXLwbx/8b46Me7MChe7/BFQvDZPnVI2H?=
 =?us-ascii?Q?l8+jtaqGebZFlw8OYKpK94NKBGzdbAc6s62rPAuji2/8tbyfsom1WF7TzoPG?=
 =?us-ascii?Q?IIsz1hx29Wtt2hja/yjTRV/Sh1oo5HJ7LZQ8nHl9l/Y/bJuzUIWz96I5dcZo?=
 =?us-ascii?Q?4VWzj8iTOyTs484eYtT4pwx962lEh9IFmGl2U42NvIGEko4DEhXEuANpK2vc?=
 =?us-ascii?Q?wvXSlWM4buu/Tr78rw/YB1hoaEO0Y/nchsHUHQ88hKRIf8rHFJsuaqJN3cqa?=
 =?us-ascii?Q?QsFntL3/O2xXW8KUBIs3089X8sdPIT+yiyuA8BgO+ljBt1ihKIXmOekeNRyN?=
 =?us-ascii?Q?MpdehkcQOw7q2cHI6VIVzgIPjt2L8CTuy5GX38iJgjHAzPjs76HzAi2ocoDZ?=
 =?us-ascii?Q?CWLlSazYzmo1SYqvunTcEGCOC22BNAWwliK4TyfA4UtjB5Zapg4LuEASkJHt?=
 =?us-ascii?Q?RqLhh5eb0l+qlL3XATJgrulggFa3GtLl6norc3SIHJKL6oQZQDz0J6ymsFsV?=
 =?us-ascii?Q?mIhVXVHZFXXMKp+c0RejEnHX6sLnp5llL5Kbfd0Fu/BYQ5CKuXUF6ZRiEwc4?=
 =?us-ascii?Q?Y5zwl/3vMlJlQ5kdguj/Um8fu1Nf8BulKWj2SoCrZtgwQnbvwJz6w0fHfuXT?=
 =?us-ascii?Q?qQosfH/KRYgnNqnuSR5dNmp2SNFm5o4=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f802e1c8-ef75-4753-5606-08da28515263
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:24:56.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr/xSCrbCZiTdwZ+8YSoUhe2oyUiNL/XRmUq7ChaibnJ/bSQ3csyzCd0pWd2s01MFm0ynDDBQ4wvHJLu5CTZT3nJmhp6kZ+vOZH1SmW2wCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3650
X-Proofpoint-GUID: -NLs9_9xQ_zQbV_fMfsH1Lz2BtdjRTgK
X-Proofpoint-ORIG-GUID: -NLs9_9xQ_zQbV_fMfsH1Lz2BtdjRTgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=541 mlxscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple months back a grep had me find some IDE related bits by
accident - which got orphaned by our removal of the old IDE in
commit b7fb14d3ac63 ("ide: remove the legacy ide driver")
in the v5.13 release.

So we might as well get rid of these bits as well.  In untangling the
connection to docs, I noticed that the driver removal orphaned some
cdrom stuff that was only used by ide-cd so that is cleaned up too.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Phillip Potter <phil@philpotter.co.uk>

---

Paul Gortmaker (3):
  cdrom: remove the unused driver specific disc change ioctl
  cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN obsolete
  block: remove last remaining traces of IDE documentation

 .../admin-guide/kernel-parameters.txt         |  21 -
 Documentation/cdrom/cdrom-standard.rst        |  10 -
 Documentation/cdrom/ide-cd.rst                | 538 ------------------
 Documentation/cdrom/index.rst                 |   1 -
 Documentation/filesystems/proc.rst            |  92 +--
 Documentation/ide/ChangeLog.ide-cd.1994-2004  | 268 ---------
 .../ide/ChangeLog.ide-floppy.1996-2002        |  63 --
 .../ide/ChangeLog.ide-tape.1995-2002          | 257 ---------
 Documentation/ide/changelogs.rst              |  17 -
 Documentation/ide/ide-tape.rst                |  68 ---
 Documentation/ide/ide.rst                     | 265 ---------
 Documentation/ide/index.rst                   |  21 -
 Documentation/ide/warm-plug-howto.rst         |  18 -
 Documentation/userspace-api/ioctl/cdrom.rst   |   6 +
 drivers/block/pktcdvd.c                       |   2 +-
 drivers/cdrom/cdrom.c                         |   8 -
 include/linux/cdrom.h                         |   1 -
 include/uapi/linux/cdrom.h                    |   2 +-
 18 files changed, 15 insertions(+), 1643 deletions(-)
 delete mode 100644 Documentation/cdrom/ide-cd.rst
 delete mode 100644 Documentation/ide/ChangeLog.ide-cd.1994-2004
 delete mode 100644 Documentation/ide/ChangeLog.ide-floppy.1996-2002
 delete mode 100644 Documentation/ide/ChangeLog.ide-tape.1995-2002
 delete mode 100644 Documentation/ide/changelogs.rst
 delete mode 100644 Documentation/ide/ide-tape.rst
 delete mode 100644 Documentation/ide/ide.rst
 delete mode 100644 Documentation/ide/index.rst
 delete mode 100644 Documentation/ide/warm-plug-howto.rst

-- 
2.33.0

