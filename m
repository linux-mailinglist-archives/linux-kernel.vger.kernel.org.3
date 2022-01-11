Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94448AEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiAKN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:58:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47126 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230453AbiAKN6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:58:40 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BDDJpR018289;
        Tue, 11 Jan 2022 13:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=E4x3UB1wj5+6KidcArMyRWgq526xPSeAyyQZnDB4v+I=;
 b=YiOYuDfYvDdfjU9eTMnGDjhwS2zi8Hv9szyfy6aF/P4YCr1yGVzuDNINsHJrMr5L9lAt
 jWw4Cb4Q0CVDKRXf4ELagvXuhTwc9iADsm6wHP8F1rUzEjRSt8C+FQAVjf9ze0fJGsnp
 9v8fiHoS/3uohUFU+XtLARdiTRvk9Y3ZsMWeD89Pa7nnEyuLPQwhQR1toMuGE2JAVZU0
 zv9679VqH4i3UVoJ7F5r769uEomt9IVvZF8v2FoFjssk8xK+ceNF8ksZm989NVg7zeb2
 Sk5iQq+0ZkJL1lsLBWLAyR8GjFnUei/Xw/j+HE8XyGtgx4ne/6zKaWpH8EN4Cbgek9dr Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74b1p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 13:58:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BDu8EU028987;
        Tue, 11 Jan 2022 13:58:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3deyqx6d71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 13:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVv0zm6IKE24Qg6ekVqIHuYnnQJUFOu1avmyW8mmUCC6H9KxFGlyCq/xJH5mfmhEyIQhyCpLqEhqO26apUrMgkuHDT6gkyvmdfI7BTVU+qBd1MeHNqX3CSEqxq9S54IZhrX7dqVa8wGbktyhYull35zsie5COsd2hP8dtSQ0JrYmjaYIYVZJmhoueFO5MB8o2Bc71F2dqUXGaQdaMPsK3DaLWx9hnUgpuwM1WhweUkGIJgc4zRqBgmsMWw+d7k/NdZ/NOs9/Do0SYE41KLDLB1DozlbbIuK0eEGK3NZDrEkMRpooSh2BAQ1VDGdWIjkybcPNj7Dn9UVCvdYrNOYA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4x3UB1wj5+6KidcArMyRWgq526xPSeAyyQZnDB4v+I=;
 b=VATipZkyj9LSDh6HhuCJetmq0t0M3FeiUlQngyHiloNlNrJbp4xpsWlZhb/RmMneNdLFXlQ7yROw2SmVJA5yWGHJCbmY9QOywANx0qYEROMl3zcUE8PGX5GLqm9LRgKsI5YHbuYzsMmpaK6RwYxs4jN5yExMa6vWq8YZKhL7x1K2qZlGP2YRIZxBM6U5GeuGHAzv2YU4jGPpDVGs0V0jSsyLnt3E8HQlqKNkkfYIMGgJ0VQOFZRAAE23t6JgkOlB5SUJpauNUaw/D4ZrXzSKVwyv/T+DNSr2AaBD0Bjs9kI4kjmNmwAcrSs4RLiG4ax+A7XPQeHQMw2Gps9CaTJ6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4x3UB1wj5+6KidcArMyRWgq526xPSeAyyQZnDB4v+I=;
 b=VLHaEDtPjK+qDVoOgRlgSclXh1mGhyBiON9c3kxuaJ2R0Onxpq1uQzxo1Y3LAKMwk72cGVVK1Ge+uiCNssCS5VELahlEvSlK6um/J99EitthkPwr8HVrnXahQm+YPh4VB+zAo/qyi0nTDZmBZEaicpNLUShrWcycAonXXCJH7K4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 13:58:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 13:58:27 +0000
Date:   Tue, 11 Jan 2022 16:58:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     kbuild@lists.01.org, Wen Gong <quic_wgong@quicinc.com>,
        lkp@intel.com, kbuild-all@lists.01.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kvalo-ath:pending 52/56]
 drivers/net/wireless/ath/ath11k/wmi.c:5651
 ath11k_wmi_tlv_fw_stats_data_parse() error: uninitialized symbol 'len'.
Message-ID: <20220111135805.GL1978@kadam>
References: <202112110427.o6xDAKfE-lkp@intel.com>
 <87czkyv1i9.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czkyv1i9.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc9c08be-a17e-40b3-0b63-08d9d50a70bf
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46435AD68366B21F1555C35D8E519@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYOVFjUJYCDaQqAPgUreHGtA4Cu/pUO2Vy/pPaSX4WNmBG7JroeT97pxGLIIwH+NHIu4XSJfQFoGYiN5nJafhvXr268ZGOqU1jRKFIs96GZ2d7SgW6Me6Zv1o4ZDc6O5q83CTyxsiTrvLS9mFCBC8Na0nyIwtxxEfGvvJYKVWEfT71ybcAA4ElmrGYcR46xVd9uYWqYDP+AZWckOb/ILg+Nof9TOWwBANjyB6FEGa7A1vFbSqcee8C/s5UukpQRr/ztbvlGh69H0JdkC2jzNgtdukqkgYsQZNZX32OOODuVU/tC+qm5xzX6Yi6RVSUnTzv1A7hnUcjKxninuEnVI0dbfBTtkzbUh2h875eNFFZ/cEmi5fKKA9nbOKmU/bKiW5BA6qUcnMfBLnQybMeAo/Qj3yKd0rrzKDtIDuzAZ9qAdgxj1mAS/NDwgDgPNKpvKvOxqECYxgEjblNGvC+iOO1O13u3NY6DUO9ZdNlHdW1sESpubExHts9ZpvuGYOwiX5vXz4e5B1rt7p5ONOm39LJz1uoJpBa16HNBhYtkYb4/Y7f4TUoJT5hGFVUtzKNIxtsCEsaPoFCvPjbGra0xa9oSvynKedNXWkrVdAr89LPY40jUdjOzKyht/8q3r9KhbczN9dDXwnSQ0hbCaq8KtaoZ/dsFrsYPMWgBU1ScxG8WGMiugI/X5qAOCMknilGIBpyhzxi1TYkS8vG6U/N8g7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(83380400001)(6512007)(26005)(6486002)(508600001)(86362001)(4001150100001)(6506007)(316002)(186003)(66946007)(5660300002)(66476007)(66556008)(33656002)(6666004)(44832011)(6916009)(33716001)(38350700002)(2906002)(4326008)(8676002)(8936002)(52116002)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9chnrDVKJrRr1v03DsjZ9QGfHICZxVU/v0muwqYbm+HJ910ZZGAmuxM+V3Pd?=
 =?us-ascii?Q?OrDXK1hK1+S78OHxIwmlydx1WRlpNiWTo4qn2ArY3zRQaRWZ09anKR915wih?=
 =?us-ascii?Q?mT4SpsIvZiqJMwsbr2jeVtR43ciUFVoSmEgRBELord3/xurbNSp2BnxbuEEH?=
 =?us-ascii?Q?Pd7LxKjUWv+4aHh9Q+7mYVKDPFSt5jd7Ma6JXe6xxzyLTBrwYfV0mXf4gdwV?=
 =?us-ascii?Q?5o84qk+T7FmeAOSy3/067urpDwH3D1snG2SuYwIs2FPkjg+O1CYoiEVZwqT7?=
 =?us-ascii?Q?GJGdLCjDWv/tNv16HqcuLfoVF3qGskjN1EHGRSIVlhzTC/Ix/JV7TY3HgspU?=
 =?us-ascii?Q?rq3PN24oghJ12mpWqIt6sWmkifNCEx3a4EJkecDz6ksdAL7ujzcmmMqz8RVZ?=
 =?us-ascii?Q?6o1UhTAkjFb7CWZ4s6tW29uikREAXz2vtMsXYefRlc8u4I7u+JpALEDnHFiA?=
 =?us-ascii?Q?qLuYVeKmwZrci/Lnjn9dFVN9RVYhLlL7B5KQceIxnsj/IHSIvj2b+LAc3nOM?=
 =?us-ascii?Q?hxJ9CQDwOXJHekMqCiwOv7LNnNUGpGIpBieUcXvqBf3B0Sx22lM1nR5uFNla?=
 =?us-ascii?Q?JqWyC9i89aGg/c63pxNC6yRvBtiRmfZNBWL3D/BMmoiCqDmgjATnKxFtS0OJ?=
 =?us-ascii?Q?6vXyR5OpImlqZsjW49wEsevzdl0Q4GQIq9Yk1aTGsWUKBmuUdt+gyhqNMsYp?=
 =?us-ascii?Q?2mmn+ac2Rcpb4Lomlwu33D2qEmNctGS+lWMDD73npAuSUM/CLUBWBkGOQvwd?=
 =?us-ascii?Q?SRB9mh0jf8SNGo9Sa+ssZs96eKPxVLcnRMd+79rNLxssfvmIqcsdx7eKffWg?=
 =?us-ascii?Q?0nRWdZLQLjhAGoNdNVFQM0t+M4o0se1m5RFIgpoVNh9hjkV4e/oqF+KZtkg0?=
 =?us-ascii?Q?Nkfuy4Km+Z4HTtoo8ponyvFgifuhOITB5O8TfSdQ5Y/Yt0PvTNTX89OqLR8F?=
 =?us-ascii?Q?TP3eL09g+/zT+8Zy5jqzGvf7fsyevAb6RF90+YhnXyjQrcxcNliYsRNUhZNc?=
 =?us-ascii?Q?PCIP5OFxwf602x4dfq+HtNHVSDd2Z2VNZi7ZHm2dGJoVfDA/mWGOnhXYm3ZO?=
 =?us-ascii?Q?V1jCDEGxeC54R5LFg6a7Xvqn0I18iFrgNE8jIBkyt53WEPTzB1FJKZkHNVsB?=
 =?us-ascii?Q?Z7oqO2ypmaZP7s461PbYKKuc1Sas4wJsrrmdM/bXuF+jD6TAKqafBn5AL2aL?=
 =?us-ascii?Q?ntdBTiff2JorGs4IbQ4NXSFLd4vDkH3zrAF5nfh/SN+C/hneJXHEK0dJTv9B?=
 =?us-ascii?Q?HQLLUaFY9h6SYVqTVtX2NV8VqFwTYIzLWCXudg3JSB6YwFavBqrFyDuz23jQ?=
 =?us-ascii?Q?Zux4efurPB78gBioZfbl5a3oQ0uLdXSl4vLxtoeVvEkzZ9hs68jRS8zvcptt?=
 =?us-ascii?Q?tsC5OBnBccd+ZHy8R8I08dhwkuXfrcGzqQWIdWitaM47WeRi6YHmGy3+0bEb?=
 =?us-ascii?Q?QPP7O+t+1x/Hu+pjr/DuhThZtjIByrIjpfqQzXZPJ2oUiriDbSde2XORqiMo?=
 =?us-ascii?Q?O7NnvaB+WYPofaxdsYDmn2w6aopU6edyxLAT7ykFTF7KZ9B/dPoHNwXP+jvi?=
 =?us-ascii?Q?on+uoGN5hdB/X42RIuMzMGu2wt7Rk//5K+2m8RtqNh/nVuYZ9BWWOunZvIv9?=
 =?us-ascii?Q?4aELnhOb7wzqPwtaDAKU5pTgP7x0n+LMSHVDZ/kpOe7WWK+FvsjWv9cqoG69?=
 =?us-ascii?Q?6fF9Ud4I1CCX1WkOMXoux2lRK1k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9c08be-a17e-40b3-0b63-08d9d50a70bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 13:58:27.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvrwhFA0Tmo96XeToAVmZaOKnJ3tPYdSomOD4CxAWQWoxtHyVVs9bfguxkjNikDRvzs6e4wEUKxOoxdHxRM7alnxR8P6GEtHoHb1pNG9QXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110085
X-Proofpoint-ORIG-GUID: ECsZutGe3Yi9OoGTHNf_89FN2Te0HJ5h
X-Proofpoint-GUID: ECsZutGe3Yi9OoGTHNf_89FN2Te0HJ5h
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:35:26PM +0200, Kalle Valo wrote:
> > bc5c448b70ff14 Wen Gong 2021-12-08 5629 static int
> > ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
> > bc5c448b70ff14 Wen Gong 2021-12-08 5630 struct wmi_tlv_fw_stats_parse
> > *parse,
> > bc5c448b70ff14 Wen Gong 2021-12-08 5631 const void *ptr)
> > bc5c448b70ff14 Wen Gong   2021-12-08  5632  {
> > bc5c448b70ff14 Wen Gong 2021-12-08 5633 struct ath11k_fw_stats *stats
> > = parse->stats;
> > bc5c448b70ff14 Wen Gong 2021-12-08 5634 const struct wmi_stats_event
> > *ev = parse->ev;
> > bc5c448b70ff14 Wen Gong   2021-12-08  5635  	int i;
> > bc5c448b70ff14 Wen Gong   2021-12-08  5636  	const void *data = ptr;
> > bc5c448b70ff14 Wen Gong   2021-12-08  5637  	u32 len;
                                                        ^^^^^^^^
"len" is a local variable, not a parameter.

> > bc5c448b70ff14 Wen Gong   2021-12-08  5638  
> > bc5c448b70ff14 Wen Gong   2021-12-08  5639  	if (!ev) {
> > bc5c448b70ff14 Wen Gong 2021-12-08 5640 ath11k_warn(ab, "failed to
> > fetch update stats ev");
> > bc5c448b70ff14 Wen Gong   2021-12-08  5641  		return -EPROTO;
> > bc5c448b70ff14 Wen Gong   2021-12-08  5642  	}
> > d5c65159f28953 Kalle Valo 2019-11-23  5643  
> > d5c65159f28953 Kalle Valo 2019-11-23  5644  	stats->stats_id = 0;
> > d5c65159f28953 Kalle Valo 2019-11-23  5645  
> > d5c65159f28953 Kalle Valo 2019-11-23 5646 for (i = 0; i <
> > ev->num_pdev_stats; i++) {
> > d5c65159f28953 Kalle Valo 2019-11-23 5647 const struct wmi_pdev_stats
> > *src;
> > d5c65159f28953 Kalle Valo 2019-11-23 5648 struct ath11k_fw_stats_pdev
> > *dst;
> > d5c65159f28953 Kalle Valo 2019-11-23  5649  
> > d5c65159f28953 Kalle Valo 2019-11-23  5650  		src = data;
> > bc5c448b70ff14 Wen Gong   2021-12-08 @5651  		if (len < sizeof(*src))
> >
> > "len" is never initialized.
> 
> I only quickly looked at this, but AFAICS ath11k_wmi_tlv_iter() provides
> len to ath11k_wmi_tlv_fw_stats_parse() which again provides len to
> ath11k_wmi_tlv_fw_stats_data_parse(). I'm not seeing how this is
> uninitalised, did I miss something?

I think the bug was fixed and the tree was rebased?  I only look at the
email and hit forward and the code in the email was clearly buggy but
tree looks okay now as you say.

regards,
dan carpenter

