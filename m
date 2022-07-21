Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B22457D038
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiGUPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiGUPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:48:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4509D7664
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkdptinD/pAEZFuAzbTitDLx/PejFiorw4l5lp+7K2igXRaawPRmBH9dtviWopBxnEYMKhYF8FdUFQzGGgzs3naIygOG7JY061gVrd5zVo11fdpURuUWVIuFFlrOYpazg0d3qRt5NhhUPLeLOTHfydGssmkvnTA5ulytlqXAl1ac6jBRC+a2ZSHZZ9u3UTZG2UPqrc+Xwfybs5rVNQD4r0iMxu+djM16NyQjBKKfpTRXt//Xe9DkBalSNYBVVXD4BpioW2m6y60FqiQ22Tq8lnNoQatLOU2dkiMp6iagfkn8Cx6XEX8wW/yAS2nMq3YyeiuHKHXtsO98u63I9JGcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hkr9Yqfh0NfJMc6vETptt7qbCNRYkJAUyTApJvpI2w=;
 b=HDg2n8nXylMfWGKNZeJRMl0bAMIFj/PCQl14cb7PEKyTYNu9JLaT0ncsMUJ94uevOb3feP5Qf9DebAVyDLfnD3K098VBR3BhY/2RFDMPvwAIKrARUaKN6uBfYtLj4Vi9lGX5aU5M3SwrHAOKc4cfEB8Y4jQvFskWhQoLssoLxc14fPMliZBAz7SjpSzAzIjNqDrGuFHMotM8TZ1Ytn9VlVBYmFvd5G+AKz8MF7JAeZJ3pmD7Lhor/ZTUtMWBRIL0dkIenRjENeJaYBpdaXwbph7cCt5IKFwNQSqKA9cFjHJcz7DFp+0WG7no9RpzbSI+MVTSsEOMyv7gj9KuEY3wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hkr9Yqfh0NfJMc6vETptt7qbCNRYkJAUyTApJvpI2w=;
 b=iHleN1T8JejKkYn0navaKyfunMptnSmjCI+vQp8sur0Akrmmtdneomug+37ASwzTqF6Zd50q2LiK44t7fuZklIt6vLOw9b5Vfo/FIRj+zJHbdQKillPGn1gCPLmkD2NmMPjIlxqXsQtVNMA55jzLWOngTA4dNBvO/b6y3RdOPYKk2RptI2qJh4d6z3lCPUQA+V/Sfp2fw4IYsgnKtZcWUavs5k331LBOZK0YYf+9X5REUL23itzmbGojg0I6txw/3hL7cN+A1yNsnK42GxdvAaiwWKQZ3muGm4Zq6QtOInXoQBWyHkuRMqWKRNKYgUgIhwmWcmE5/gYwAziUzr2XEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Thu, 21 Jul 2022 15:48:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::5044:4e6f:f7d8:b509]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::5044:4e6f:f7d8:b509%7]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 15:48:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: Do not retry 10 times for the subpages of
 fail-to-migrate THP
Date:   Thu, 21 Jul 2022 11:48:09 -0400
X-Mailer: MailMate (1.14r5902)
Message-ID: <EC02F1E6-E201-4A8D-84B4-47758EA3F20A@nvidia.com>
In-Reply-To: <1658405108-100658-1-git-send-email-baolin.wang@linux.alibaba.com>
References: <1658405108-100658-1-git-send-email-baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E6833651-E51F-4CAB-951F-76BB2E931EF5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 656ada58-2598-4656-0d93-08da6b306aa1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2654:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qa69lRbtsBN/mZU3Q9IVkPvQ2T+Nw1NhdvFEBcH+OgYU7rygh+IlS6Dw+eve?=
 =?us-ascii?Q?gHnwbO8PGQlbGjX9klRiQGYITcoieGUngBqPIYWlA5wKglT7CdBTDR5/OIk0?=
 =?us-ascii?Q?r61vk4gANCmPAEs3NSvn36evw4lowTuk3NXohxdVi1tJHRc+HyLqETM/5q5r?=
 =?us-ascii?Q?O3yf3+q4WX9N5/XQZJ8wOvK4soBMjsGRsE2I6om5v/kjhn/cd8zUlg/4bbe+?=
 =?us-ascii?Q?emEkwZ9eS6+Q8yN4hftLKHq7bpGJhj73Yo4Cl8SMG3q0LCnp7Ojmxpea9ZoH?=
 =?us-ascii?Q?FRhIwMFjAvRP/mh7R2PGlR5YEiK2MD6ejnAJ5qU8uXaRU3rdylB/GA2mSgNd?=
 =?us-ascii?Q?r+4BvhYSGMZXcOO6+ov+pS75+PRpZ25C8JmIxUJYORN9PbJ6DqI9WlwhreER?=
 =?us-ascii?Q?YyXp10g8kJ8ppyKuiiaURMcGPQIea6zjgvEKK5ZVg0ksNGRJ8pptTt80bHFH?=
 =?us-ascii?Q?+T+M/O0XrvI4vhMu+Q7PhSRRamwQBOyh/PZBsyopm4H7v1ToFsqqthThkauu?=
 =?us-ascii?Q?f4vZuqtoATtgXqpmm7Z2uX+ZvtMfhYDwyG/Km5cGfDW0heMRTyGsgFDRIQv6?=
 =?us-ascii?Q?qo4m9UPRk5k/q1/yjxkrkOvp5/ghG8J2gX174oYh3qQ17QDGIP0bWvavgqGX?=
 =?us-ascii?Q?SehRKjsNdyyEF80h8TJYuol61ya5/tKwThDOdUg6g43ZEulBWxlbhjGJLKIa?=
 =?us-ascii?Q?d367X7tIsxfX3o5YNmPprmsptY3GOktKmo93UrROHwU+2+BtgC1LgD8T1Qr8?=
 =?us-ascii?Q?uGuJa3dtZxcZHnf+8DIx57B2Ip8JJJHiJtJdyujxuKHmpG7CO9RQbiQux6Rp?=
 =?us-ascii?Q?2HD3Yu2KUZmgCn1FBw60W8t7Qlu0cvC9fUcDMz7S9fDmKFeBDaPjJU6W26Bp?=
 =?us-ascii?Q?WwTGjHTtMT1bO7Bdp0tqnveefCftbhHkMwqcF4AW70QWU4eH7+BA2yGTM025?=
 =?us-ascii?Q?3Bg1tV0zerzaHftGXMDndA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(6506007)(38100700002)(53546011)(235185007)(6666004)(41300700001)(2616005)(8936002)(966005)(5660300002)(478600001)(36756003)(316002)(83380400001)(6486002)(6916009)(8676002)(66946007)(26005)(66556008)(6512007)(186003)(33656002)(66476007)(2906002)(4326008)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJl86mAElX/0g+hyoRSNQYv4H3A08iwtQeZ+YqOS3ibFTUEjbDNIZztYlXCe?=
 =?us-ascii?Q?3iKkTkDH3+zpw22UaCiArZ8V4p6M7ZYppsrvkgya7gaJ/obcSTSSWRe68s+0?=
 =?us-ascii?Q?aJE43o09SOSB2g5UdCHCN4/pmOmftJBV7X3ojwNVlwJegw0iQ54PhpgX9hvL?=
 =?us-ascii?Q?Vfm4iUMZMWAnLlaLb42piuEa66S8InYqajEpNvWhWduau8mIa6UeZOCUmRVV?=
 =?us-ascii?Q?c/Kds+dWlFXXCLw8Cxcigxn7nRb5doZ0e+SPQ+IaEkPsnLRzZgZgYOxvfKBz?=
 =?us-ascii?Q?P1rAPK/GrfeuIlhllzYlnPYEQzMRRu1eKAV3Eh9AU/Tgq5qVCoAIbpZSfVwN?=
 =?us-ascii?Q?5CTVrqAvsUFQs/Uksv8siIR87aUxtFcmoLpzs4booXiSO/4RirpZSjVdo/YI?=
 =?us-ascii?Q?jbhrOPXrieBMTl81DBWpNP1NcGNaRiqTRsDCvkv1JgQW5LWnIPtsx5cWlFxy?=
 =?us-ascii?Q?en/tpGsTDiX3c6xiUGvynFImWfXGb2LdrjzD39FWwJh6s9c8XIM38WMbnZKg?=
 =?us-ascii?Q?N4jSGEXqcAxBhsoN++Rw4jrvgM/WPJUcl4smbTKkJzrVTs8o6pd928hPUf4q?=
 =?us-ascii?Q?umjDuWZYiCYCh7AUc6K6CtTZ84S4epVFM15/oS0enNX1bGWEn18u1biIUolE?=
 =?us-ascii?Q?hwaTQlrNUW8mHDEzHTXBb74wN6jLzF0AjKZlQ06uJvqh0OJqB9mMpT4SgCpE?=
 =?us-ascii?Q?4nMPrmQbBSCU8RitkYiTvkQqs7HoJZQNUAWC25m/PIlzfh1/Go+/VB22mylh?=
 =?us-ascii?Q?QURs06vgAND5v+MwAuTWVZLcko6/SVYC9OjA6gEHYA4n4J3FO8nkKFrhgC9L?=
 =?us-ascii?Q?vFQa4zgjSAYpWog3ZVncf70V64DUTFLsYYU2oRopv896TiqgzhyWIek93uwn?=
 =?us-ascii?Q?jra/W6wqmBqaNL3LgfKHzesai7BD1Z1wvk/unyy8h7qmIIcj22qDBGrWTlgF?=
 =?us-ascii?Q?GuDXC0lQ9aZ5gxutDzMZ2cOZRTskd8NbN/6hLYbKyrDISJgezcwLa7MNg0iR?=
 =?us-ascii?Q?dpQDBFHxDEDwDsG3LwK29KGc17TJwN6I0jhM1R6g7K9MfOf+3oVqwRjKloaL?=
 =?us-ascii?Q?Uu8ryxq/9ZOJ0kdXwRtlJO9iWpImafArBQUOZra+zziLG5ftnsgHU/AThUR+?=
 =?us-ascii?Q?CciPDt4GBNDe4UgwKyaNESUtmeMYMxz+VLcgr0H1GTnPKUHNOb/Db77wcsGX?=
 =?us-ascii?Q?HGSt+z7aLQIebbwvp4VbhZlzHriEr8JJ42VBj+wqN3eyTx/bYmyLbuQTHJXP?=
 =?us-ascii?Q?jRw3kULtKQO4byQJyyuFMPvz06l25/L0RubmEFdFHgrO9CsREsBhqGQVhQoC?=
 =?us-ascii?Q?lhx+kWkPfPUURvv+xKVKdVvQMCKNGxHIZ6KmajeifvmgjgFE/AWEIjbVCzLd?=
 =?us-ascii?Q?4mbb1uRbShTzSNZaHg9xlRhiDi18vwHqXCN3C3nneSuiFCAVB45XdKltqO4g?=
 =?us-ascii?Q?WUkeVSRIJENCzB/QwKdFutoteABndVJ2v+v35gn0mVqerNKg/F2dJRnuvtg+?=
 =?us-ascii?Q?aXuVCWcG66/KAM3KxfjNG7WWpp9KGUtPkPD+oisyioT8UHlmqzZ0UPI0e0sn?=
 =?us-ascii?Q?yaaZM0oWHql5kMnofK8axFhL9smcx+Sk0dyNPJ9H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656ada58-2598-4656-0d93-08da6b306aa1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 15:48:12.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFY0IXktU3owMuMCmDHF1+g/W87MEYUM2R+nqk+VFPL/aW0QL9uqaGcajaD/WEbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2654
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E6833651-E51F-4CAB-951F-76BB2E931EF5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Jul 2022, at 8:05, Baolin Wang wrote:

> If THP is failed to migrate due to -ENOSYS or -ENOMEM case, the THP wil=
l
> be split, and the subpages of fail-to-migrate THP will be tried to migr=
ate
> again, so we should not account the retry counter in the second loop, s=
ince
> we already accounted 'nr_thp_failed' in the first loop.
>
> Moreover we also do not need retry 10 times for -EAGAIN case for the su=
bpages
> of fail-to-migrate THP in the second loop, since we already regarded th=
e
> THP as migration failure, and save some migration time (for the worst c=
ase,
> will try 512 * 10 times) according to previous discussion [1].
>
> [1] https://lore.kernel.org/linux-mm/87r13a7n04.fsf@yhuang6-desk2.ccr.c=
orp.intel.com/
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Note, this patch is based on the patch set [1] from Huang Ying.
> [1] https://lore.kernel.org/linux-mm/20220711084948.274787-1-ying.huang=
@intel.com/
> ---
>  mm/migrate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8429206..e36a084 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1507,7 +1507,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  			case -EAGAIN:
>  				if (is_thp)
>  					thp_retry++;
> -				else
> +				else if (!no_subpage_counting)
>  					retry++;
>  				nr_retry_pages +=3D nr_subpages;
>  				break;
> @@ -1533,8 +1533,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  			}
>  		}
>  	}
> -	if (!no_subpage_counting)
> -		nr_failed +=3D retry;
> +	nr_failed +=3D retry;
>  	nr_thp_failed +=3D thp_retry;
>  	nr_failed_pages +=3D nr_retry_pages;
>  	/*
> -- =

> 1.8.3.1

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_E6833651-E51F-4CAB-951F-76BB2E931EF5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmLZdTkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU1SkP/1VGvUeZfp3iFmS1/HdD3bCqbgik8u8uOYcG
RU2IlCXShFOtLX3DtPVxTBItrNCTINzRHtkGCUm3o+NFevc6DKdCynZxfsJe5c8r
iaMb7PuYK7+1GaqXcpRqsuo7fEgYnLu/jyQP96ur2RxqI9jVvuIMvvz6pt6tAasi
LO/jsQVaFhfQeDCr+LOTYe0Y37gpyKp2ZqB2PowI89RQax2o6OLfQXuOTYqRBAgG
mLk5RCnW3PR21x3rhP7JaQ6aIGWCEEmif5JPjocRYjjdDJEzC8iCISfSyIQwqvam
SLLbIR89SXcISRlXClMosm3BTc4RULtYK722oYw/791oLG/DwMdrgw9NrGKHX38n
5z1ybtUmeqoBCUz1EJ8cPgzPJ31XfU/8E1z1O/eF7T8r5cLWEuRbSRQTQhzMI1vG
fH1tVRUke3wAgU310gpoCWnMDpVbMUZG1xk7sIePrmqRqIw5racHq4nvq1JiI8H5
oUdpbGhB1Rm/zQp6iw4DSB7G9XvB1HHmmLhtWDINh59aJKU920CuQ5uDpT1HYNvx
JqhnWQ9V64lviaWtCA9xrOCpbH6JTNTzUn1XrHBElENRybVZHrymInc7BaeiC+nC
EzvFsAHiCkgbBS6+kHvfne4iO4V4XnZZGjzBdYf37xKLNMogYHpHxjZP17kn0rvF
MehT1xc5
=E+0g
-----END PGP SIGNATURE-----

--=_MailMate_E6833651-E51F-4CAB-951F-76BB2E931EF5_=--
