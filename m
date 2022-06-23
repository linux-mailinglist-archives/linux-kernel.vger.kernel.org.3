Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86BB557762
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiFWKGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiFWKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:06:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2044.outbound.protection.outlook.com [40.92.89.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898202AC4E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of9ykHy6tpH7te/SiI9U1VAN/1wHfVuQObJfT/yS2c/Y69N7chbQjvh5HxniSzSyHtXE8gqxhhv0XtdTkPlNqMYB834RywMYSahJKMKCdsEh6SDuhT6qq9YYjGkelxBozEDN3tqf7X7hcU/uBskIGZxxME1QUOMDdZ/lIJLROC0vONUVn0WFDSZtEtD/50C0Mgd2zXkSUILA9ZXemmfq+ENJ3k9E2u3TQyJ7plO5a10mq8Rq9xJN3MxXFom7561sPLNhmMi8BNLXdNZsRKzVs70clCLDChlAK2FmJ8ga5ca9UOL7ONq/pfsLL1mb5t9VKFYG2od3MbpbPa7/ULe07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o/KgIZoDKx/ZyWpvbfvfejhTGSAkTpF3jUZIjPwQyM=;
 b=HfsNULsWgFFeCjpezKGDMXuoeLDOH8cJr+rdHmZNU3cyZnY5j6Yx4Ym0XgjD2gZV1nApsJd+FR3LeOhFVMupk2IJkHGNMxiJGzbsELcls30gS6S7JeZzCzbriuHbA1EzkOk3KgRVNs5dvaLZG8N2IdGxNRm7rQPXmOJ+LYFC9bwggiwOoShTv8MwcuoczxKltZ6uvehS+nz2mFYWR8Oov4RGsHWqPQTeIwf9mjRVAzlBTMtj4xet870uQ32sTaEQ8CKXtxLEvtkQT1Pf5np9kgAkNcUxeBD42XbTZl5g1mLo6G72gR/ZmPzKPrSaUtF9i1wMfKVUlopfS4ZPD3C+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o/KgIZoDKx/ZyWpvbfvfejhTGSAkTpF3jUZIjPwQyM=;
 b=SNDuiO7m2ZG+HNCFl6r5vJl1VXDZhzJnQIG92RInQuQ9eejTWhgetP2Di3Jrumu8kOwoB/mQUZlKynyu4rb+f+XKWPql7oQIa/VZli9u3O3iJhQre3CksOq40D/KDNMuD9VAvo7niugJJGPS/zhpISOzDnWS1YTt8ELvGGnvHIMV4T4+d6UD2Z012uf2o2D3gBrPiy+iWQSyINxkkrFe7U4vG8fsWjievrpb40Z6mbbtPGq3n56/aT8HtL42iMFPiTfVd9lFV8GPwTl0y68/x7k3Xw6/5nIXC2nMjtvEkUyJ2aaoCQl6oVaxNa6gyBVs6sM5Mgnb8Jup6SNN8WucRA==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by VE1P190MB0879.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Thu, 23 Jun
 2022 10:06:04 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:06:04 +0000
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v4 0/3] Staging: rtl8192e: Safer allocation and cleaner error handling
Date:   Thu, 23 Jun 2022 12:05:54 +0200
Message-ID: <AM9P190MB1299A41E3A9B2F9C0916A260A5B59@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [jtOex5pSsFCK8iiVtaswH9nadQF2+qJ9]
X-ClientProxiedBy: AM5PR0602CA0018.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::28) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <cover.1655975970.git.f3sch.git@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62fe2575-0f7a-4fc7-458e-08da54fffbbf
X-MS-Exchange-SLBlob-MailProps: EpEO96k6WokJw9qhnqKg7+E0MqObEIk6+wB7mBLHFAHalE8WR7uL1a/22zddvKi3ErKXnmNo1tEd2k4Cwnm6PuIeasC16zhQbXi/r34u7j/kGZTEAKkVV1fAPKYXMYUPj5/wbGfVPtR1SmT3PVojVe36VHIcjGTdjZ2lgdIrOs8bYOUvtdtRjGFHx7mVYq6Npht1ggOPr67GcQziKT5g5osmf1mVF1VbbUN+aaZIFNtLPgyMxBsRBQ/uEA2pe6hKe3U5KYCpHy5oVRAnpNj3UXLHIogJOgN/3hCXa0MZaHzwg/d0B2HRwKOk2WsYrHAJZspE+aNUEzN9xudlvmoggvADOuGx/Sq5Vl/bdbXoxqNTFd6md45lG30s9aatKd5dk7c72L3oiTZ/38Dn6U7rG6IVtD/3lSo0Q2fSI5wdnBD6FFzerkkz6LefxryNOWculBTa1zCTZ1CXZPFSo2TaDH9LRN4bBSSQ6TVi2WanxrzpYlId+k3cDu9SIWjjQb+orkY0CrDwigYANLxI8NV38PuzhYpX+U+vWlaOCAPm3THOU8e/hHQw8zluiqHT7ULnd8aGDLC+xMOKbPPNtXyeZFBqC1VkA6FYYPn4P8FjPl948UjZWUSLPJEYUljMCP6SGw8jY3nYGssdD16tWcNPHRHwM49q4RWwp+TtkFaAW4NoNskl1zfp8kwThDRBlW6+p/oYzqd9TXLGLdgOFrYf/pDe2Cs+PvkxDwOrhASHvg/qDI3/JD3oR9BKsRBWVNE9jk5GG4H8Krc=
X-MS-TrafficTypeDiagnostic: VE1P190MB0879:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdShZXVWEBHEvflUHyhJ+sGOH28V1ob7NPgedgQKijMVh3NnVcJDkoXRrdfZogr2rMaVrvaeTe9p9AgiVwq7l+LdFAu3mC2rpYqLT5mqTkU2WPhPmSUgoZswN2cLbYG2p9isY4yE1JCePvGCZOWURWA7vXhyQ2BlkAOM6xtmvIen8RFO0qSwMUakG5nrq+o7/jeT+fJf7WcR1iIqE17hAWS6rjb1fBx38wW3UbzeZZw3USqjCDKBX5U+gqcJBws9TtWEfXb4S/qhVXcQ7hJ1aawh2SNhzz6AxZLGY43c+2taOpuG0pMpZXjH3wy4G4Raf46MB08IouhCnQ6JiZdNQTUBlx6myw5sU9wtwgV+xV/M/ZxWHNOI6av1p4HFcBEiXKfOiDnQcFhNztrMZBFzyIzK5n6L0zLfU5zv8fboo5ZRbbGxMxv5jYZT402sxPQW4bZNn5/WYMr9z1WrpR4+I7IgtfNQEw6yDMYdysNTiKgzQfA3ImXVe4uXaB1YcqThi3/e7sK4Flt8dQwBOujHDo4ITrrIxaio6vhVsTb4OnCVH0bZuNUIg5/j3MLdLY/YZcPhopLz10romtNwcMnMlDEKxM7FMg1KOR2fLaiPTZGhKdoA4B55uAa22WNWYLW8ERz6v4FzqPfdzOfFSKog9g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ga1jWCUo50mUveyXQ/qSbjTB/sKnEF5qSWpGhEvHRRCcaKOR1drPKd8cFPsg?=
 =?us-ascii?Q?3OMr4HX7F4o18dq+moOx/76byLDxcS9lUnnX82l9Les327UngEISdFplUQcv?=
 =?us-ascii?Q?oHns9oYW2jt1pXY+yXxFvnddUO3EM3oapd+YD8b6YM0nDr0yGFmFfvLxiUhK?=
 =?us-ascii?Q?GGReqeceoG09BcyClB0xy+yvNBa6O0m2B2jabpArZ7oBbLfvt7auR+CySNj+?=
 =?us-ascii?Q?jSuqT0XAzcvZ2Ax/5QCiHv39YCLYPHNjmQ5rhgxrzZUYSsc4bBfhl+SiPGRt?=
 =?us-ascii?Q?ggUwfYn81insFr3SxFSf226rRRbFJIpwGFt4q9r51jcIqtpYsxsJvUisvydg?=
 =?us-ascii?Q?QhyyrJFbpG9KdaSP/3oytjO1QO2l0XV8rowJp6j8qtEXeRr+Dp5hEpGSFxDI?=
 =?us-ascii?Q?8CdjRIryBR7FpDno1zWrn/YtFi7hl/fNAALPDwk9aT6LB79bO2KgyFBH0dmY?=
 =?us-ascii?Q?vB/BBS8vq5hOhW2J9gWac6d8MtHOhZhtubasoZ1azMatySwHhhffLea/0fvS?=
 =?us-ascii?Q?Pze8TDPLKeV+MyGLyo0QkFisLcVLGx+1UDzEVAdL0HRNYlQwVPa7xTHRdOEH?=
 =?us-ascii?Q?5KkriY/dcd9dBd0Pqy6JexF+xSuqnZHZykdzZgnilCHc3JnnXIOrCQYjorpo?=
 =?us-ascii?Q?0QFdrZ18tslU1qGRHERfwTCUKaZKJnKwSaAaV9VJMV+C2ZYcorp35NqeTWm/?=
 =?us-ascii?Q?1QD8hyX8SV7ALhcJn0/iMwCMxa9fKQB4XsuunZvMAi4hkf4HKXwo09X8I0wu?=
 =?us-ascii?Q?g0Bdv2YjndKgUpM8yh/kPuuxU+85E9Z89fqoueR7cJYWolS68aM/LcV9LSdW?=
 =?us-ascii?Q?1NIRxuNYipRtnml9QHHLf/V0Vx45woFlnFfMGxX04pb6V0+goGTuT9JEVaNt?=
 =?us-ascii?Q?wr37o9wnoV2XpN4F6utuOUc/C9cp4kohECwEiAAOq9Li/59QPFom4aydbEnP?=
 =?us-ascii?Q?qC9v9n2G0dGUsBi4U0SNhLHIIyWhU5Dz5zXLpl5st0sBGaN8deeDzC4HV24L?=
 =?us-ascii?Q?+kXS8UEBe8I0LjyAUkb27PEfMSbpp9wYxpSM65meGaTkg/3dlbArjlhxo3VT?=
 =?us-ascii?Q?6/nY8wgJZar32xpFC/eFXSqOPjGcIIo9XuNKyAAV3+ffdZ+ogPrvFMVtzN/i?=
 =?us-ascii?Q?Cwpm9KFjpOiQhGvEM1IUrxitToNTxnRIgjcJbNeIec56Czq9INH+4YEJ5Si4?=
 =?us-ascii?Q?qn5oxHOk5hbdlHshmoRcDubw3Gt1fgQGJp6slCCcxFrBTPwtueAhMXeox11B?=
 =?us-ascii?Q?eUBuqoN1waxcMWKNo6jsg8+NIVW3gRnHN1v/rTUvgw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fe2575-0f7a-4fc7-458e-08da54fffbbf
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:06:04.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v2:
  - replaced kmalloc with kzalloc against memory initialization defects,
    thus also removing a memset
  - made error handling more consistent

v3:
  - Split into smaller commits so that it's easier to review

v4:
  - clearer commit messages
  - added missing kfree

Felix Schlepper (3):
  Staging: rtl8192e: Use struct_size
  Staging: rtl8192e: Using kzalloc and delete memset
  Staging: rtl8192e: Cleaning up error handling

 drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--
2.36.1
