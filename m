Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C94C4844
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiBYPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiBYPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:04:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A117B8B3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:03:40 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PEkWPx013339;
        Fri, 25 Feb 2022 15:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JNEZW9ETLf+oA2rLUFNtbLEkDIfmeIVo0sxY14r8mzg=;
 b=jCVoaqKDXe+kuFXVuwpnErxy2L37LQ5c6fYN3poLgSYzRFIoAmXD31BUtrdTYRsYLXCl
 kIwQf1qQ0RpMSbgTwRx8CPX5mTYSjpq1dCa4fXGEZCu6qBwNxF1pN2DdDCs5dEJpZBMo
 PYNsSySDwR+/roLaxNku4NgOmoH1z4TniVwm8U+vVintgDwS6sMNeU1MMNJPkQUJjGmP
 cfqgFnYKSCiKFXvkQQraOCQjpOAO2UowMv9c0QxS1FYxKFp2xaU9JMqtBYT2uD1l/N5D
 gVEQFTlfFfYgS+RiJKwmBHi38IvQRCQK6/YhrJtqE/FhtJuA/KTEuoUQ7+Hb+qerL/TZ 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexj89649-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:03:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PF14vO148325;
        Fri, 25 Feb 2022 15:03:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by userp3020.oracle.com with ESMTP id 3eat0s6tmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:03:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baJSodv3ukpBfMhwm2FeLfLnELzDL4U5EvhaxoUUKPrOGPGoWQdFTrMR5Y5vFhNwrOCV+BZfejmLnrOuT/mEW7VhgNBe26ft12S9797DqmXIf6J/lvqvrIpBEHaB22dsyRvsEMa3B06gUN/r+lU1fBcyFKsSSKokrKZtso4jkY4VIyUpFR8dJ0PsRiFVXYIufzUi3WH9gi2FBrtfgw0ZESmQYu/31w7GpLFLB3zyrGAjYOhp8qm03iUVnFx0WcDWZr5OLjB9Hjbr02vcvTmlD0TG7x6aanCUJWgY6a6C5WYAGIkCgX1aALXrnN14Ba3xn5R+k/uwvd2oyk82Gt5KFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNEZW9ETLf+oA2rLUFNtbLEkDIfmeIVo0sxY14r8mzg=;
 b=WjZd+bCZkyVFW2OrouJKCotz1cRPY4UKKyLSloN+DpDJiAK7K2hYvTt3rX1zQSMk7OvI7uf9dj/e+h8BQKq/171WeaV/KjaKCmrSstTGZYK6C4QL+t7rvNBH7wB1WocTuNAeXEdE5L/y/mFiPcCeEhjMoompoOCvguJKP9v1RBoeRrx7iiTouD9KzqoEx3I4B0i5/5NolWZwCI3do/DDJaS5wPTL9abCnHpVK/L6gldfvpe0Y1P6/hCwOSXvOa9oqMCYTfwWd6/3i1wdW0V6G9rlpfzIPfsFTsUpBQW4Mhwem4cJ5alYVXixYLN5TnDxSytZkYeyiMsMdhAzVKPb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNEZW9ETLf+oA2rLUFNtbLEkDIfmeIVo0sxY14r8mzg=;
 b=LoTodtQsPY/OFoJlYxDUV7y5jlUawwczU02S4nHgZxazxr9JbtaDYYr3g0cghmI0vInZTtWB+lJAwBmUDlXQ4k0KaUD4GNIxkrBlpJCRvtmjmXG8q1Xq+UHVdK8etYD1W8WkIONbQ1J1+UBGP4zKraz1x9o92eKge2zkrOoEG3g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2746.namprd10.prod.outlook.com
 (2603:10b6:5:b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 15:03:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 15:03:26 +0000
Date:   Fri, 25 Feb 2022 18:03:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: correct error handling code in
 wfx_init_common()
Message-ID: <20220225150315.GO3965@kadam>
References: <20220225133409.28109-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225133409.28109-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eff1f90-3a2b-4d87-cfcd-08d9f86ff9a8
X-MS-TrafficTypeDiagnostic: DM6PR10MB2746:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB27467CCC7250DA1DD758053A8E3E9@DM6PR10MB2746.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwiio27D+yQyvpWZnb63d9jyzfIRtQrfgXW+jydD41S2usbaDcIDrKHgUzU2GpyrIFpiBSbxWms51J36Y1g98lzeMSMeDZ1kvdGLIirCipoZej/urfBuQrGICE4lLpKuQxBEMNhoPnVfKO2XZhnqJzcURcpn1xpvU7h1GVWAv6qH0WZMiFATCZxWmHiNiHB+4Q3jcAdi9+OeVSY3wRx1iSymveruhVY2vclAGmu0inoNsEe+ktEckrqsZrQBRLXV5TB0mGmkOPW+a+OqM9Gn2WSMcZPL4G165AFeitv4RClqCNmsXC7W5XvfQpVg1GRTgS2m2KBf/HuPsskYAOmRHzjD8WC8rMwsZUe6fY2Pv3cUf+O5gS3iVcqT6kkwKTXo18+NV7Wd4Z1nIibFLX1FYEIf0elyJYOGfhyOivYIc54HGEzfCs+R9TULb7HdgmhbdlNKr8VhFx27Rw0Ij/fk2ticDXOv9nUnuw97xd/KD8aRoTCuKzDTU3rIUp7iL9vcVncJgNneOXq2Itv6VaVwruIEM7F4r8WRllnkD17Skm+eWG8hvXCeewD2bc6/Uwxm71PFOyGNsIbIEhftAONuxe3BWgJreJO1JkrHVKcngfHGM8yiBV7MsNPx26yxgxUr+sn7em6BTkiLPRhMbJJoNpF3QMIjPma0WUQ44TPkSfIEsDzuVbYAYdoVvlCRdetP9qaNxZa8hSPF7CrHPANPPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(4744005)(26005)(186003)(52116002)(8936002)(1076003)(86362001)(5660300002)(6512007)(9686003)(6506007)(508600001)(6666004)(33716001)(8676002)(6486002)(66556008)(66476007)(2906002)(33656002)(6916009)(316002)(44832011)(38350700002)(38100700002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qx2m4IUXbWpPx0La8TNEr+IhRkg4kIcth3VTBrYyilTK38vI5CvlhplHx175?=
 =?us-ascii?Q?x++ZO5FXyX9cfZnrXmXhx2kwBNKiCvyFxtLap2n3XWPzGWgqKrjFkHXtZxwO?=
 =?us-ascii?Q?AsYuXnjSftt5tjx0+Wq6EtwKYPgu1jgPcAEwv5WVYiFE/5n2iGefTGGMyX2e?=
 =?us-ascii?Q?MikhGgkraNcQ2EFxU0pfwO4POYEuavpMBfsRXODVVWxNwjPg5P6IJAHj/aia?=
 =?us-ascii?Q?60L1Ev6dwCmUx+awROnfJG39VwMFV6UeJDTIedo8BmoPpbeKrDjegh2u1mXW?=
 =?us-ascii?Q?+OG8dpJW1clj837Lu05bySCunwb+8tKnOFi/kf+p8ULOOB3PyNGqe3bYZE11?=
 =?us-ascii?Q?Wl16eE6e2RBg16lXVKonK/5bCKJIwYu305bGfupscF+NNkdHLfvGFBPoua4v?=
 =?us-ascii?Q?CJHc/5uG5gGY1MbAQZbC4lZYoCE7ezFJndGTtsgus4RzefgsBTKdPxt5ThKs?=
 =?us-ascii?Q?z/+0dOKq6vvvDGwm1K6eg33Pu2zso1ggbGihlmmK4y0noIIY3zzXG7ui3b0s?=
 =?us-ascii?Q?RsiJzi9q8KQuaSbo60wQkezHwFwBtC5x+/BhELE1Xl+QRgOCxittqY9hDym8?=
 =?us-ascii?Q?AKA8g3xBD+WpJN6JieeCUsoGjYbcV1zFmd3mY/mvVSWSwrE2QgrwdV1IKqcg?=
 =?us-ascii?Q?oR8lOilXWTpoit+g+jzTHYVH3yqVBQ8JA9ko98Ogrvqi5u6U1tjQrTSlQJ+e?=
 =?us-ascii?Q?WU2/MJkAFolmTva6TI6gK5i5NVNNfAFXEWJWnVD5FEcfuy0ZKMQbSjJJ2wgR?=
 =?us-ascii?Q?OBBr2rUnYN235z4J5x4rFc+xc7Qd5XHW1938NtFsdsFe1SUKUmqKv9oq+zzd?=
 =?us-ascii?Q?dsWWLoxFoX7Lot4WwywBcUuxduV/JSaHy7bLh4vF0ArP4QfzFIoKNzEh8U6Y?=
 =?us-ascii?Q?ETRIaC7MsnSp0WJAjwWL1c+bMZyowxss77h/XvjLFfXtC72Mtne+PrQVv3QV?=
 =?us-ascii?Q?DhuTR713eCzG7yAlI7SbRBkcmeSf4ftGJOFzQ5qXfswq2t5q+dqg6Cvoxure?=
 =?us-ascii?Q?WvTsPj2kA5wlATjGrxtAoHur41odYZk90Z2y4S/FNurXZMDdsE/oI8bJVy3z?=
 =?us-ascii?Q?wcHRz/2I8rHuomoXrloVAu2DjpfQe5d/qIYe59d5+isM1irB+jUV0eQfd3GX?=
 =?us-ascii?Q?Dsh7LAO1wZ/G7sgjhtvwgsyQeZiZuDCdmPm5C51+LN2R/oebhCHO7okSBRb/?=
 =?us-ascii?Q?i1RuaAw2gwH96iZbv4kwV2oE+18ViTuB+rvVa3iTEnKnV4x/pY9ppm24IrNm?=
 =?us-ascii?Q?+qi5OCUJIFbnucjejlWRkd3WbBnG5CdvjR0a6ejSOKO1gehTHm0bN3sZYtY/?=
 =?us-ascii?Q?UCA8/rERW/ecU7TvV8u2RS7mzBE7WKO9IULoqEM85b3EJdwgHzQUbgavk+iW?=
 =?us-ascii?Q?Vqa/oLItIGHXClQXB417jHV05pND9nWyDFMThV5SdeIQJKKipvHBygo3W31R?=
 =?us-ascii?Q?Xn2mEwry0iALrSxhe/ROWvu775q4v0gc3Z1FwE5nRW6n1oRIxggmdjRcMWSR?=
 =?us-ascii?Q?6Lyr5hehB5jIPrZt3PF9TWBxfjNDarAqTxJYrW9F0pWZdFnplMA0hi2u6AXl?=
 =?us-ascii?Q?faO3L9+4XrfO3fHCENFgyiHTNv0WB9VsQdq8zb/viJBvJGcnih5ujS4V6F5V?=
 =?us-ascii?Q?eYfqYrXMAI9Wq6nd5IWXTcvsfrT7deF+W7FGHbJ6jDaxCUGo3yNo+BOvhEZN?=
 =?us-ascii?Q?PdIPKw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eff1f90-3a2b-4d87-cfcd-08d9f86ff9a8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 15:03:26.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfAjTFqbRY4NElu7l87pRyyxRXuuTtJrPeErftSjWFXnSrojDHw+7AJFLiK7O2CWIR3hFrBt3jqCtFrCcdBI5dHDxBmkrxDHK+hBtYOmP7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2746
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250088
X-Proofpoint-GUID: XG6wdpNMceiq0vhH-E28XCwAsjdOryHF
X-Proofpoint-ORIG-GUID: XG6wdpNMceiq0vhH-E28XCwAsjdOryHF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but someone already fixed part of this in linux-next and I think
they sent the patch for the rest, but it just hasn't been applied yet.

> @@ -337,8 +343,10 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>  	wfx_init_hif_cmd(&wdev->hif_cmd);
>  	wdev->force_ps_timeout = -1;
>  
> -	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
> +	if (devm_add_action_or_reset(dev, wfx_free_common, wdev)) {
> +		ieee80211_free_hw(hw);

This introduces a double free.  The devm_add_action_or_reset() will call
wfx_free_common() on failure.

>  		return NULL;
> +	}
>  
>  	return wdev;

regards,
dan carpenter
