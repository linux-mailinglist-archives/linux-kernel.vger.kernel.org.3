Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14E4E42F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiCVP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiCVP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:27:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044797665E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:26:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MEd6oO010783;
        Tue, 22 Mar 2022 15:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wsLg1p4Y58zcqPI30a7pIFOxCC5dT0jsfVn0yI2sFqw=;
 b=VmwvwKBGSuHJkgN+i3r+s9WRWAHHTVfPfTxHmEbFjSrteQW0nMJpIHIZp4PL1ss6p1Ff
 2y1NmWSx5PLaw7lNHMtQW2zYqPEO6GX2lUcURHzBID13Yk5Gf1zIo8uTk2jB/qDTa/hI
 NSvA646nztJLeNSnyOXtgdsQ3z6lFYstavBQyqqjTY22TEsi/VhaYAl+jH+zuksfJ4yW
 zAvC+4WgDCMnCSZuXS2g+OIFKDulM8oK8gv9dNKLgmsNc8rRXA7PwcmykGojxmUsI1ox
 g2+Sygjb6nC0tfkaNKN8R7JbpcMUo5blGpFx0ANfZc4v0/tJrjZeJDdFYyo/bpcPh9Fb lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72aem8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 15:25:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MFCUw3128475;
        Tue, 22 Mar 2022 15:25:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3020.oracle.com with ESMTP id 3ew70167gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 15:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCqr33bXjb57ilEyxl0pd33Zuu7pPh+vRLOWA69+YdqzQ6kzYLUL00JVZf23NermyWJCkt3XVgFjH8XeGzlg88AEWsKagrTWI9SHGvZWHbL4dKVGwxdCOvzLFjyPSFQ923wtmvDFbkmAyURgdhi5zWLkSw1GCfjxEpbEL0GnTqWms8q9wB3VmQMdCJkhXnarIjXw7be/5M7clWXg19NUW1D6u+kV5yZvIm3NYQ97NIMm2rs94ceNU1oE/7kgXgyT2c6que3J1Cs52sGetobHPDZrE7jFntICS2wRTexQ/OhhLpgC+ESzxuV6VsmWqJ7dUaVHvv1Q2Uwl2GObkHjVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsLg1p4Y58zcqPI30a7pIFOxCC5dT0jsfVn0yI2sFqw=;
 b=Gg5A/KfLOo5BFZWaxvC01JOlaoPfX9tCnOp26fvoe1SRN/ECGbug/EbOAja+YuCi3p6U/X896fLpA8+uKbaZAMcJtZD6ULFnnaaP2aDWuO7jvi/gOElox2NeEGySsBcEeb+/DkkuFUuW23sg2octBK9amLeaL7FbSN2JM6X2bk3nF+nFEQtpz/oJmvs5xjfefi+fCWhCSdq3lhADu/v26k332kc+j8j0OhRroopby5jLvl1ehBTnXqCXtoX/6NIwYz8619jQTKDT4X87HfeRV/K+CjLhhbmd2F2dWTuznQ/CtoUtrV5YFjURiL02FO/1F6FemNEc9GtPCehNELRtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsLg1p4Y58zcqPI30a7pIFOxCC5dT0jsfVn0yI2sFqw=;
 b=XVcYuCScwD5x20i48cbH2h2s1FdQmX1qU8qEN2bZ3z6q94aWPB8MWkbMqA7vz/Q5gZqO7RyJGp4EEWOaTE9UcAHas58sg5Xp99uP44eLEgNfme/mB24iy6NS72YzSLuYEgn/rbBwTJh0oHW3ig8U5qTWuWMH2LWeYEqHwjMwYAU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM6PR10MB4076.namprd10.prod.outlook.com (2603:10b6:5:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 15:25:55 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::7dcf:728e:946b:aea]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::7dcf:728e:946b:aea%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 15:25:54 +0000
Message-ID: <11ce83d5-6080-5474-02de-677a4116405d@oracle.com>
Date:   Tue, 22 Mar 2022 10:25:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] jfs: fix divide error in dbNextAG
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com
References: <20220319191620.32372-1-paskripkin@gmail.com>
 <20220319193000.6449-1-paskripkin@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20220319193000.6449-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0063.namprd05.prod.outlook.com
 (2603:10b6:803:41::40) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52d15071-accc-403e-1949-08da0c184199
X-MS-TrafficTypeDiagnostic: DM6PR10MB4076:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB40763515C47CC390F7598A1F87179@DM6PR10MB4076.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOo1PfOlWVokwVW7yOPm1vmCaXiuY6uaH0lRErjZlEIwAbJ89Pj0DEN7hyTxA5K+HxtQnMdg9S5Fam1ZVn1yK7uJ/9YsdhgcbcIUAGmkDQ3suf/40LJ+Orwjg4pcJ5DVC9OUVSF9F7idTSI3DX91UOLCVBKmx44vzWO/mmOOxuYpzwysnvwHOLkvRgm4/BJFlVIyOGrPrnzdwZnNqT1zq8U6Opxq+h5i0PfzqZtGXCfqIVIhpsQy9keZlC1L1rnpM2VwFPunHQ1nurMZzd9njI3HfxEZfHV4fNPDkgq2bUB0k1L/38Qc7HQEgEXF6MLfIz0d4qTIHwltkjBSj66kRiKWEbm0byUL7QdqZKsh8I+imr2MUNr6vZ/JXVxN985mLSvMul9VN8719Sy0fo68oY3z4IJETSEhKgNkRZ7NxKz8+fue1OhUhH6RUqe6jBSg0uKXOgRCUGtWgw/sixSMg9ETqn6bGPxpv/EnL3/YUX2Zkn2bnVcFMnMn7jwQXfuzuB+01ekC1mCn+1xiLqn6HDGfphhcZSTbS2rBpoB35646X2qHXFYbZThUgb6HocjQHhQVN0hZiyzQZ3NtgmTiYu3duHDiwM2PQofToL4a2b2clHNiWTdoS8aF6vjp9e3I1VsKZjP4skMnKRaIzGcBfKmrK263UJ4TbETTnRYtj9Gfu728pd6uYoSpP3uQIQ6icJelVOKXZFl2ZD/iXCioqqb+GnfNjHL+5Qf3IPJGRLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66556008)(66476007)(86362001)(38100700002)(66946007)(508600001)(36756003)(6486002)(26005)(186003)(31696002)(316002)(6506007)(6512007)(2906002)(44832011)(31686004)(8936002)(5660300002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpiUzJ6MytWbFVuT1ZoTDIvb1hLS0pUOUhCdHhGQXVJYWJYYVVpVlZlNjNE?=
 =?utf-8?B?RWdCNzFhcmdnWUdrMFFrRDR1WFRVaXJQdk10SDhUY0xDQzQ3VEJhYVVNVEdY?=
 =?utf-8?B?azhKU2E0eFhybW1DT253NnFudmloUEd2Zmk3Z3VDK3JhTUtsMjdYeTUwTG0y?=
 =?utf-8?B?SGNaUDllMU5zYUR3MU5oNUQvR1BIY0kwNlU0VTRmQjFtUzVnNmJhbmVUd1Qz?=
 =?utf-8?B?bjI1UlhGUlpYVTdWc3BDNXZiYUplbkhZTWpWYTJ4dmhDQ1h2VkdERENlRmMy?=
 =?utf-8?B?d2UyWXd0OU1iR1BsdjBYbVRmWTZsd1FOcEhKSUpYVmIyd2xhaGpPcVlLUENO?=
 =?utf-8?B?eGk1Z2c4SFhTWG14NGNzNkROOERUTjh2eG1WL0FDV1JidnE0OUVJRFJRU2dQ?=
 =?utf-8?B?SzUzbzQwZklDRmxLRStTOEtWNWc4OUVhenR4Y0t6dlYzUEpzcWlvK0tnUjYx?=
 =?utf-8?B?UW5CK0RpOVN6ampSVGtlNUR2ZWFEcTZoSTBQNE1NWGRYSUlnQU1IaWZsSDc5?=
 =?utf-8?B?anpVdjd3ajlCVkN5RmI1bWpBbmh3N0NrdTM2bFY5RjZtSU1OTEFVdllGWFk5?=
 =?utf-8?B?eDkyTUtpT0VVZzNhdnYrVFp6V0tDaU9obnBHbGVUWVRUWDlCbWJWYURVRjNO?=
 =?utf-8?B?WmtEeG16L1J0Wjc1dE1keWJxdHdDUmxwcWhFdXVtb0hyNTdaeENZSGwwazJo?=
 =?utf-8?B?Z2dKYituSG9DUkZBZ2dXU0t4UXVrNEFaYnpKVXRJZnBnWElORjZERE1nUGdz?=
 =?utf-8?B?M3R2S2hEakNKOC9ZQmMwcldhQndvdzN3YjBTdGRtVCtUOHJVNEFMZG03WGpW?=
 =?utf-8?B?SUlia0NLazVreDM4OHpUdUNhV1ZBOE9LNnRZczJGeVZnYVQzZ0NIR2FwVXpU?=
 =?utf-8?B?NXNUUU5UTW9iVFVpL2UyQm1hRzZSOW5xU056dmhBaXlnSkR2ZWxIV3llb1RN?=
 =?utf-8?B?dnRodjJQcTJFa204bk4xUnBRQW9sVmhvd2t5aGo3M0NhMmpMOE1FdDQ2SHhp?=
 =?utf-8?B?NzJZUEdlSEVpVXFSVmxPbHhhK1dKNXhDRjJjM1FudVpJeGZKTENVK3M2cXVT?=
 =?utf-8?B?Rlc1UGNUanFKc05IRElVUCtzZE9wd3pTZ0VYUlQzdEg2SHdvVWlEYTE3d0pB?=
 =?utf-8?B?Ykd2djNQdkxTaVgwQjNmUlBJMktYNTFnOWJHTGUwd1ljaGFwY1d0RHV3N3ZC?=
 =?utf-8?B?MkdnTmdBNTgwa1ZabC9qQ0kySUdmYm9UK1lVVG1nSDRYdVFuRHpSalJ5NjV3?=
 =?utf-8?B?VFhYNUVDRXp5cW1aenJKK2ZwVGx5NWVwVHp5RnM3cld0Z0ZTUm8yM3cvcVVi?=
 =?utf-8?B?a0JQeGNIM21nckUyT3F0YVg4UGt4dXU1MmxERk1CUXlDV1ZCeXpZekRmMWxm?=
 =?utf-8?B?U3lCZjZzSkZpVGRsUkdpK0tLaDFSK3pmYUt5L1hMekdDcGRLY0NGYnc5WkpH?=
 =?utf-8?B?ZFdmTnVzL1JUNkdqSlllQ21Lb2hJaHJISVdYenp0VWs5ZVh2Zi96OTN2ZTBG?=
 =?utf-8?B?TGF2UmdFLzBadHN4RDZRNkg5ajJRSFk0RjA0dHJoTDZJcUFXdHkvbmpRVE5R?=
 =?utf-8?B?d1dUUitBb3pnbUFkc0FqdzZQWUhEWmlFU0dUMThUSmZXV2hXcWk5UHZzUVdm?=
 =?utf-8?B?a3VRdmcyc1RqNmFKT1J1WFBWRGkvT1hqV2s1OS9EUVVSOG9kaHlvcDhNRnJv?=
 =?utf-8?B?U01ONzNzRzRBRjNGZnNZL25QWHdvSmRKWEdaS21lWWtyd0VMSXo4MFVwaUsr?=
 =?utf-8?B?VEtuM3BDNERjaWNwaUYrbWN4SHIzTHFZNUNiM0N4K2VRMGtUeDlRQXYzSUx1?=
 =?utf-8?B?SVZlNUhYblZ5bDR3QVBsdmlYTnUrUVkxTms1ai9DQ2NsbHhTY2luTzIvU2Jq?=
 =?utf-8?B?Nlp1ZUZWMStqdnk0cUliM1BoOVBzUTAxWVhBRW9GSnJZYkxraFZZTXJaVW9o?=
 =?utf-8?B?WklwSkVTSE9EMXFJS1dXZysyZTFVTTdrUDM3bGZTMDRocmhoWXZUNzlUZndH?=
 =?utf-8?B?aUw3OVVPc2NRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d15071-accc-403e-1949-08da0c184199
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 15:25:54.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GXy98kVaED8JTRx9r0xRe2eA6oVRyfqPD7FtgJ4jEqqfeQFtHnPN2JmzXFkohkUd0Ml6XzHG47kmmEN5Vy8sKSbGs3GC9Ya4dx9vU2a3fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4076
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220088
X-Proofpoint-GUID: VZr7vX5VASd_yR5_myoM1eY3yZVbjA64
X-Proofpoint-ORIG-GUID: VZr7vX5VASd_yR5_myoM1eY3yZVbjA64
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I'll push this for 5.18.

Shaggy

On 3/19/22 2:30PM, Pavel Skripkin wrote:
> Syzbot reported divide error in dbNextAG(). The problem was in missing
> validation check for malicious image.
> 
> Syzbot crafted an image with bmp->db_numag equal to 0. There wasn't any
> validation checks, but dbNextAG() blindly use bmp->db_numag in divide
> expression
> 
> Fix it by validating bmp->db_numag in dbMount() and return an error if
> image is malicious
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 
> Changes since v1:
> 	- Add missing clean up in case of error
> 
> ---
>   fs/jfs/jfs_dmap.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 91f4ec93dab1..d8502f4989d9 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -148,6 +148,7 @@ static const s8 budtab[256] = {
>    *	0	- success
>    *	-ENOMEM	- insufficient memory
>    *	-EIO	- i/o error
> + *	-EINVAL - wrong bmap data
>    */
>   int dbMount(struct inode *ipbmap)
>   {
> @@ -179,6 +180,12 @@ int dbMount(struct inode *ipbmap)
>   	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
>   	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
>   	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
> +	if (!bmp->db_numag) {
> +		release_metapage(mp);
> +		kfree(bmp);
> +		return -EINVAL;
> +	}
> +
>   	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
>   	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
>   	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
