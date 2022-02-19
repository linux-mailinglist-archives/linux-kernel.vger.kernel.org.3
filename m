Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF254BCAED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiBSV50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:57:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242433AbiBSV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3A54BE6;
        Sat, 19 Feb 2022 13:56:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21JJlxLx016401;
        Sat, 19 Feb 2022 21:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LoiQtYlSUwmb047Has4DyOs1qTL6kEvYoeZRlB61x+4=;
 b=TaETkdUjimulAQ7WXjIt4pjHXafQplg4LAJpDOzZoMCKfyE93fWqDyKSPFq9ltbL5Yb1
 ovAvu+3d0i/9R88ZIuUqpEiERsbQa6KO1WBD1HmqZGv9cXRknKSYKQZowcIZ/f6M908f
 2v7V3tmGO6bgRnyl1nR3tM9AS5lQZ2NTAOMpjfT9NqsADsGxCr8EPxa9a/Gf9THhoV+m
 o/QA30KMwNErXBWHtV2amy15eMEp41adFMI/m/X4j+zwUb/+drKA51P9Z4CuFrMrhXVw
 unIP2+67n4U1AxrxadPCjohdk6jlS5r6y3VgDkFhQ9uvlU5JXKE6J8AGoZdjliKX082R Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eapye13b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 21:55:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21JLtVed050538;
        Sat, 19 Feb 2022 21:55:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 3eat0hstf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 21:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz+0Er0xx27oSG8lTqnc0/UibmhHhjGVQRBPWem30tFOc5pvQehklgQ0HYggtMo0d7RUNXKPMYcxYc09ZD6oYwH+UiKi2wTfPDvPVJMVbq6bpOkYS8cHLwU/w/PEh3eEtvR2XP46jiqf1ZW1dHc+10ydVv2LvyI72a8A3CqSePDfx219p/QmPXKo4y0SNaMbtjTaHM2ilvtRKbphhZ9rkjkl2+nMcwF84BcUxLuz5BxjpeWkoeTUk6kqXg68kSDz19v2wfVjt7QkBbpG8qzioiSsom2dgcYIhozDJcFAMQmX4eGjXFPuRtOoFrd+SeurY0jTT1mCSDJyTXeFCXhaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoiQtYlSUwmb047Has4DyOs1qTL6kEvYoeZRlB61x+4=;
 b=YElnP1Xdt7vGjghXn6RF7Cb7wPvOrEZ1EhWYqNxj/gvGs7bEfmebQfjEt74aZYret/hpAXAwpru3inSw7OZGR04FO4RFDiE6B1PqxEO4IzkZErxpU4B/niFdrkJ4r9ezxLlws0a0mTNtPxkaQpRe8advzWG9VpzkoqHlOrfThGxwGdlAWcO+cMvPAMmgaFNsR+guw9cBlQlebSzOV1nfqJj2aUZA9/MBvu+K3S1VbdTowbREDJ6b6D7ER/M8dO6Y+ux3NWQ1ELedOo4b4vGteZjFbbdGxRk1V55hTwVBJsXqS/ryLfZI94CxAg1RoW5U6J5Szek5FDo8dpO+OlF0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoiQtYlSUwmb047Has4DyOs1qTL6kEvYoeZRlB61x+4=;
 b=sDoi6fwhE25zcFB49+4XA3C3GgeViFggP99iwZUZYBSZOx3/QEoRLkoyk9mSEBvrW7cYOQqc0uxUHT8bV8j1a5W1SsaxduMLNB9mdSChpQwmfEVIEYQ1XxylgC1fhw4ezpnyzQINkRvDTwFZcISOZwxQ+jvcsSd6pgQc3sWhA3s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR1001MB2294.namprd10.prod.outlook.com (2603:10b6:910:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Sat, 19 Feb
 2022 21:55:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.026; Sat, 19 Feb 2022
 21:55:56 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>, <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgmmh675.fsf@ca-mkp.ca.oracle.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
Date:   Sat, 19 Feb 2022 16:55:54 -0500
In-Reply-To: <1645112566-115804-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 17 Feb 2022 23:42:28 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f484dba-b191-46ec-9fb6-08d9f3f29b7f
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2294:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22940AB7E60B36983968FCED8E389@CY4PR1001MB2294.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYTKl5p97TQupji/BhPC4IbiX7bN/gSrorarLryr7o1kxOXslKRCWdMhQPAgb8nOxI1/d+m6A1nju20QPw5AKg6ZFBqT5JLaaH0SfM4h1mrsYdOICx9sKUW3zaHoh1yBg53rCnO9cyNTzJS/CIX3xjgLXjicVQVaS+JBJ8lv8ZcSGmzzXg05Ic9oNUvx349MjN8WGR+FoCHnZXho7xvn7N+FRrNvPHoLg1lA1wxogpAKEV2sXcVyo5rtn0Bg6MJOHPzXCkgUicQ+5rOjcACl10yewkuwlrjc2KBqxSyn5Tjaz7kXVfcNPUprelMbx45zlRRdcflUgiy16/RkJYEEB38TEIKPkAD9D5BuWI7J2Cduy7LERF+fgT14Vawjt8sYTxopNUUi7oixs4TxYstU9qeUXFBk4bUsZ437NXL7WfmUJYXAQLBWiek3BGdbdMiC+fdgBZWSKTlR2c6/ohmt83WvI97yf8sOwnioXb+OMKacPJ1hngFUgtLSgPTAbNUGT/y+DMU/OZuAaT6wOUfrw330DBo+cMjcVNBErL/ZyRnAu0Bdvdf2O/ml6nZrAPPysZmhzRgcJTSqyt/Hu8YTqhuar9gekS8BY0SAhSN86jvw61g5QgRWcV+kiNKyslFzRvrUjuJP7i5O5pj8T69XdtmyYHsOD0a+0iwZYvj+VAlIxXO1LtxUr7YG8grEtqOwpyzIVZ06yZ/mGRwBBE9bXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(26005)(186003)(558084003)(5660300002)(7416002)(52116002)(6506007)(38100700002)(38350700002)(54906003)(6916009)(316002)(8936002)(86362001)(6512007)(36916002)(6486002)(8676002)(4326008)(2906002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zgqrPupcFyPOsxPgirnf4OWWpvycbT8Ir8SApC+fCbSlY3zmRfhXO3CUwzO?=
 =?us-ascii?Q?4bKNWK+VECdHKLRLX/yGQOZu8eIsK8hCY/q/aUc9QPsolepTjOGKpjiVntOF?=
 =?us-ascii?Q?PXjmMdHmFnYQMWyauaOUxd+VuX2jYxdzZaANzUtjQ+27NU9/uD+7iKVj1KA4?=
 =?us-ascii?Q?Q+Zt3jeTrfPFzt4wELXxLicINIXtcJS6wcxasHgXyW/c7ASKXa5/IhG4O+Sn?=
 =?us-ascii?Q?925Yn0EvSAvZbxYnw45e6MfRPKRLa4cwN/dXuq1lHEyV0ME9FR7WY235cR3e?=
 =?us-ascii?Q?AgXcihF8nOwBThfyo8dwEZZV5+SH7dg+mKQi5SKJC4OVOithv23qNZH47q7T?=
 =?us-ascii?Q?WuSBn1WIDE0RJPRtLTU7cOV/80/U8L5ysM0hs21fsiJsduIDeQPFJDpsDKCA?=
 =?us-ascii?Q?kubgOSlhDb1F3bJHDNDU/16faP1oxrdszL9kJ8KXPffomrng6Ec/7lNxCXUW?=
 =?us-ascii?Q?K/SgzCy38+k/0kkiLenz1OqqhMFhlJmppCOupFKLR+7YX3ZsCtVIKyd9fZLF?=
 =?us-ascii?Q?+4rA6+7YXCLCpBp6x9yIrR2VvXCn0KMSxZVb6ctg6XxNGqjJjLzyCpnuXY6j?=
 =?us-ascii?Q?PQyD7zDTn5/9A/toMwY04l+LYs9xqfYF+p4MQSSkNPDdMIMJihTYCgbJDTIB?=
 =?us-ascii?Q?v4kNKM1NWCQbiUEbUiU4DEBk+4VHpggQCSuCrkU78filWccyn4iT/GgSOwct?=
 =?us-ascii?Q?2/Us0ixiIIkWmO6cPb1S4l0x5NPpVmlKsJftkulU8+SrEc+NM8HfTa77PkSe?=
 =?us-ascii?Q?3j4/7hxiuL2UQU69BbXEnzkhpOHI24knapU/fqWm+mjiyRqlB3s8ut8syYqa?=
 =?us-ascii?Q?Zz/VDGoswaPyfg/Dk9vebRRBaGTuVTaoauylWbXEXJ4xagAwKLYWPXCo1Lnz?=
 =?us-ascii?Q?hLtNUFZ0CPS0duCtoRfHATmUVqCfnldVMcjNYq7xJgez/0l/6B762Ao6hSRr?=
 =?us-ascii?Q?aItSHeiyBJF3d8YU/D/OoHvOAKIskmOkQPhSviRp6Lf90rjRVGognQm9dWkq?=
 =?us-ascii?Q?OLCYSfa/vfSw6y+T6h0dALrXl3mrYtMuxScFaHSiISdC0bZMetbIHpil/wfu?=
 =?us-ascii?Q?wfJPbAYndqoU5uNScRA4x3MLCVXkjU3QHkRuLI4CMz9xyPg2C/9vId6kk1X1?=
 =?us-ascii?Q?W/XeNpVSRrbNVa5xH4aAPQu0FPvyCa3K7Ia0V3hhuSvky4a28XhWg9k1zgKw?=
 =?us-ascii?Q?G68GqH09hXJJnHevTYMlmkznudBKMKP7S2I4Yx9doGqzQQpqnRy01Rw9je6E?=
 =?us-ascii?Q?2/yKBE9A9GungLlA/Ii00BKhX3gpf1TxR/6JBG8rymMsyp451iujeDIP3l4A?=
 =?us-ascii?Q?ThAIXd6TFN6wTC03QtQokHNdNj/JQ7a3JciUfQqZnEmGRx2CTrwi+YeodPvo?=
 =?us-ascii?Q?pVukb86QrFUPEgHf81sF65D4YeLcN36cN+lQCW/PRvcFMghBW86fe7ncoGRJ?=
 =?us-ascii?Q?pLm+3PVVtNFcqT4HTVn5rmptOPLyTA1nxQ+i0XA7osPzxZi6B5KK73vE3YLe?=
 =?us-ascii?Q?NldmFYrrD/BoCMf00w0S4yC5Y6ceUk/TvELxUVfSpJWxDBCLg6Gsqhsq27Ca?=
 =?us-ascii?Q?h0EWxV8T5G4LUsfDckZRiz3L28E5MachgBjb+97jbmws4HjZo8SP9GVwKKAz?=
 =?us-ascii?Q?8bZdpokk2hqyjmaT9UlO8BmIYZxglJmAuEP/IYGO2QJOXtEOUmfsw2ZwuSya?=
 =?us-ascii?Q?xI8ATg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f484dba-b191-46ec-9fb6-08d9f3f29b7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 21:55:56.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puvEsu0gAQWpiVLGJMkqSX0WT/9zjxJUL4KK56xM6fJp8u3+UzJO7a3Va8FAgWemq3N+HTJzJh3gHnJNM+Dy1oJD9Zi1ammh90JWNwa/rrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2294
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10263 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=782 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202190141
X-Proofpoint-ORIG-GUID: PttMmTJnayX01XjwoUd8i2v7_jQL-OS7
X-Proofpoint-GUID: PttMmTJnayX01XjwoUd8i2v7_jQL-OS7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The LLDD TMF code is almost identical between hisi_sas, pm8001, and
> mvsas drivers.
>
> This series factors out that code into libsas, thus reducing much
> duplication and giving a net reduction of ~350 LoC.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
