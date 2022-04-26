Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39A510192
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352663AbiDZPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351997AbiDZPKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B014AADA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT0ff015405;
        Tue, 26 Apr 2022 15:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=Aio6XnHrX7BgZez1LTpvKrmWlFIDi0vMRRgklF7ShAdzHEr3v/X4r+B0WCFaqJhU/obn
 IVDK08YK6UiGLbHB8nRni7iza605jsJCJNpTTB9AByY57or7UcUuS1fpL/XUACdcqEgy
 GZsl891PgpbWQSjDxiE5mEMctWIMUY+ZxpE/+YeT3qLRELZLF+Wn1jbS9SjcNbJRMkAl
 cUozIGIZr3bTk+B0xVjfEJh3ZlpdMCAuZTku8vbib6M0arMS02ufuMgqH5iqa4GUpQXy
 0PtVuoSk44Q06YokIzRVngsLUU8YcQT86FF7mLC53WBXpO8k6alWYx6uK348VfHar4IY qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Us0037859;
        Tue, 26 Apr 2022 15:06:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8/uICdo8ihmK+Qj1Edtua/gsG6zi8e9tfEqdR1YG6EYrKy0rcUn59PnVf8kUde3obm/Wk4Pm/IbPdLvGbRWkd+teb70D2POeiWGhlvAzhev7FFMMiSbvmlod2tWjdAEi+KxVQ/47uLQvpLDljcToVlpk9sR2J5HE2KS37ZzPxOoRgcubsCiINXCxTignTbKO2TX9S66WL5UNgHYmMIYUXcLG5NrusAgdHHnczclcVnhcHeqZcxMSUdAP8FGB7yNf0DOeuZSxRMOqC15c4xaR4spwnnf76VcDvrabmfK3plN+BJa70R3vPOTpThs/QMWpeUXB6RDQP4NucD/zXM/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=ATcWaI+DHwn9dM1sbZnOpragibR2KykmT4IZS1jLV4dEdPwlgQGF9R1Nue7BHSGmugID+he1asGfHAYMZbcKT4Xih/1EnOS/Dd1qJHfzTWT95F8dkFJ+aAyUB+M7MVgNsc1Ws1tasOpcrW9/jWkAt5iFRSQAxyIi8kQB6cb4XKXRl6vroD7bhyrSY9htXGq0PAHQKQBCXAP+QImn0F8GHg/zbEwnZQMehJvl/I62axCpNcMH7WO8crOg7v1bDtPwoQWRidOnDOXl9E6D5GDCCw9BOOy8G2w2DlpnIeOj3VqUTRY+4kntSckSDkqjGSmLoWr8dAe8pRo3aTiblbmYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=Xw0ogf0G8ghHMFpShPTvkIktobqRgmctQ5yx4pB+2I2v/z6F0QmxTerxO3kLcBUP2Kajbg/7uyeNKdQriqKgIwwla7A1Ju5qknIrmZ28k/RlFUE0lnFAn58fb0ILv8oL75wO7vrcuPn9iISGq2lrrVwQoYUk2doeHltku1+SGZs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 20/70] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v8 20/70] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYWX845415ne0PNEm0ikSmcvkOyQ==
Date:   Tue, 26 Apr 2022 15:06:34 +0000
Message-ID: <20220426150616.3937571-21-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1140a1df-5185-4e53-6258-08da27965af8
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679ABD330675D2B411202D9FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dW4W5wHN9iEuY6sKbCOy5kQFaokPkm4Ghg4011vPn03YYhtP5yLyxmt1osZzSQ9FDsQPVgLbkkz23b477fq0dO4T/PtZtYusJBZi7LHSdrlLRGLSqDgn9VpgDZO5jYRXXbFoeR0hfNd8UoeG7aU7+0/E9SdiB2T4m3seLfU3nzA2ES63t2mQz7Dp+7zVbqmGPhVBt//Ne2nJeOXUAQWjxrP+7eiUBBoOvXOn19b3gAgvI3ycg1kllD9rK47jrnLUt8T52/N/T8Yyo0TQgiJBT3eiuVdlc25N5qNgh3nNrRm0/kaC8B1d6OqInJM4lRbwI7J/L52TLXr2vfKZnwzDWyTaJqdGAAZiyVtPbwnTErDotCL82sRlZ3wV+uHSJxWWpKnTvq++F2aJKXdKCoIiZHB9+NGL6J971hbfVoTcIOA5W8+OMpeIOgh7W3Vhpimp6cC/+KVaEcbYBGUewha/DPf3YpBY6LZv/RM+SIpcl4QU0fALl4JSsmnIys9jlZh5MIVoH4RJjU0AdHE0LXVC9AHz95LnLA0ryiwRIUyDMisYeqf9ni6icePYt6Ky1BkOmVRvLlAj4wdoOe8P8CoxemH83miBT+4vobSKVR35sdJDSGwCWbSXqt9foSrdYf3JUWMaktfW8VMFJ9PQMdvlXo/WvOU0dBXmGp85555+Oz+fwjfNXLHSO+1+UK2YDV0xYAJmj+hRdRqEqKuEhXUlEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(4744005)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DMwihAIj3Xs9pJbLvDwBuGDcd4aaYMyHb1swfoxiEdAICfldp5JFXLYyQw?=
 =?iso-8859-1?Q?2pxjuw5tt2ZWH7B/WeE2VcpQ40TZrfx6Ek9a8J8Quf1JRSRlf9PYzefizg?=
 =?iso-8859-1?Q?HGUQFehci5JSczMahQUDPCkxtllk7+W7sR6W/SFm/w9kN0dP52PB5rZITi?=
 =?iso-8859-1?Q?9qfU0nP57X0BXEQGZDWYQQushF5lIcCQ97ISD3t8qXRBBEMYl23ObU98mV?=
 =?iso-8859-1?Q?DdFLi4DFNW0KmctXcVS4YokE2AnZQu0Mjv9Y9amK/nkmOxwYQq5z6+KFJ1?=
 =?iso-8859-1?Q?18cElHN0SM2TNXOLw22rsegZu+7pULmhHxPSwV8Yg+6QPpc9504xB8q4zO?=
 =?iso-8859-1?Q?WQh7SpAM5lUt0JzYQVHHh/UUaeqC18hmm00WWDudQEP2XzlR4J53DTjHWa?=
 =?iso-8859-1?Q?eGOQljggXeGIH9Sf4EfLL7zlNrsIgRGT1VkZ2G7ieaOhMEcMzu+ADO6Z72?=
 =?iso-8859-1?Q?6ZloFw3dEKpAFaa2SMFjwZzwuMOsMbXCf4/VytlY/+0ZHqg1/aQwoG6MSC?=
 =?iso-8859-1?Q?0497G814Q3mSCZHUTt/YNIXoNH7V8WCAbXoSlVusOKG14Yd5+QmO3CChXp?=
 =?iso-8859-1?Q?1GNvwUdVlvHMwtHeC21TtUGXWz64fJOc+wgUTo/T9Dn192109Iz43DCzbd?=
 =?iso-8859-1?Q?6+MUrUsx9JKk/hGrPmjDkL3+MGArI1Z7MYjjkeuPwZs0HXrW2R1LHazWFE?=
 =?iso-8859-1?Q?zrtqIYDJHHDOPePk/opac9lnRfhm9YbhQWnukgLIpsqsGzgdVzSpW2h9My?=
 =?iso-8859-1?Q?I8Nn6PAO5Ui8XpoSNnn9m2axAdT7zhmg5L9/MiWUpOgSdIPw41JQS9jOrg?=
 =?iso-8859-1?Q?R5YKNZsmB9XGN61ZxQ8qOFXP7Z7E+KYvw7wE4Mt9nr7YqYC2DDPCt7JDEf?=
 =?iso-8859-1?Q?zgArmr7tKQm5B0xAFjfBqmpVa+CDE26bSpxG9SACAHDqrzKM29sFcdrVRJ?=
 =?iso-8859-1?Q?IMI83JvkB7uWvzES4uS8OES5r9ALIG7mvTi0qc1F2sQv06VbvFqK9KnRgj?=
 =?iso-8859-1?Q?mghcA9cGW4uhkSMsdFWoe7+sNzo69lMETEzHmzfiRGoWF847rM+8Nc4OwN?=
 =?iso-8859-1?Q?7GTJ9mo4NYQz9xleaa0AZ8mDXy+1B2LHhwPK0Jg91bJHSd1+bmfb6665A1?=
 =?iso-8859-1?Q?e9vB3/4wp/E+Az6FTU6tqjyBox+CmqM6fbFN9jtxPyLxZvhA6vtJf1ebDU?=
 =?iso-8859-1?Q?d053R5t6GadEUxAnq5aXbAny0bdmSEGozTQDc5AbEolLdQo+S4em8oLtRR?=
 =?iso-8859-1?Q?jpp3XDqVD7/TVzm4pvK2mhmgD53/QXfKsfY+xj54HE+8rrP6TNXr6IPXd1?=
 =?iso-8859-1?Q?dExTJhQLwEZwQa92rAu2dhlU2x6t9Tx4uvJHK8k0+PNg8SM/R8/2x5BHYJ?=
 =?iso-8859-1?Q?mZSKJHhMchuJNSmeK8ANgmVLmvK2F0rE8xMqft7hezc49w4x7znCoItLlr?=
 =?iso-8859-1?Q?NXOfp9zL1zFFqq54Tvwej8sqzlqyoBa81ke983AT1oNcwdLzxIPf92Cy68?=
 =?iso-8859-1?Q?Iazz2DrdCHr3u4YIQvujRdd+YYQ5p3LQNfGdz2zx6m/ieA63TAFqh2eIW2?=
 =?iso-8859-1?Q?rtX1Aw3fzosqbxE3AGiGragwa4O4zkEJ03GFTaBBWcsuL5IoflafQbu27Z?=
 =?iso-8859-1?Q?rDuQTM6tuUbPtq1Q4Y7v8pIJKvq3qbIKi0oG6At1GLeDTEI45xyZNBcnyc?=
 =?iso-8859-1?Q?TjHjiS3c97Ek8192ezqT2V4YQGCaK0hETyT6pviErOYTDgyiZMatjOeG8p?=
 =?iso-8859-1?Q?ARlNOag0bsmb3iJ4kXH8IVx6NcpvnGJLyXWGZcY9RgdnpmD93o4/JQhK9d?=
 =?iso-8859-1?Q?FcHhLSeRrTMrkogkTCvkpBdgd6RwoBs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1140a1df-5185-4e53-6258-08da27965af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:34.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoVUbjH6xfpfVGnamYb1URQR89UJIUp8kEFTOqxCfa/lHevkiunQ4sv35D3Ld+UqqsUyCG2I7na0Qx2hxLKePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: g7m9AMN-Dkabo4UvHtp14YtCkZcyTBbV
X-Proofpoint-GUID: g7m9AMN-Dkabo4UvHtp14YtCkZcyTBbV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.35.1
