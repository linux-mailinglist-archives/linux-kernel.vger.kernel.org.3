Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8844F1DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387308AbiDDVnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380011AbiDDSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:39:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA54431376
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjB3UB+m2kt/PVGzhEfdFIJ6mANEet7z3BBGTg+qyr9xuuqLU6Quunxx72iENGECzIGfbjkiWQaPJ3LX0oIpAXu4Ctz2bNuofR/0hrh6/1EQuM4LFi4w/f3NcfR1hICELSfz4n8AbnUaBRyjcsZoWpSkZVxzkbUSsB0xBl3KXUSJRg4im6N3G/EihFb33JZqACrcAjgKTwH9th9OOu8EfbSvokSf96lI+M65djKzIb7pZL+F3NAVVC9lpXwzOdDE4S0Idsez94zgNHAmGKsGLExxwdNhtvlnIBAIjKrUKmmpdDRTHn9kjy1B9qyy5JgeSt/TUX/+6jwjjQzgtAU8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8GOFUFTIpEbmD7cOs7WC5Cjt/6Shu37mhvpR48paAk=;
 b=elx1DILOFCn2gvVMteuuwaEbIvtZmskunBtiAhSMYkhEXvoUI19z4SPpL4Po68GN1pXmU0y2arzoGElrG/ciCr2eUpxmjUJ33YiEdX5prSO2wurcmy3T6aGURanwXyvz50s623kInvNEasaOdubG9sWpaRrGnL5d/WCgHfjIhL+zqRCn0h5tbOIbu3zMJnVMd3hHR1Mum9HLMK9klPpibQsEy9TfISbzbK4KF40XBBdNEMvAgokmWDLp6l4Cy0CV7f9i44C/KN2LdieCSdF5duTJi+HtkRNxfjLUh5UyNrwi/91q1p1XDyxt2RzOf+FN1UQrsTEea43W+FWx8+ZQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8GOFUFTIpEbmD7cOs7WC5Cjt/6Shu37mhvpR48paAk=;
 b=SEG+iMhn5H/FcIqGs5px64XJadwgGq38KiEUi6+RveoMs8Cvf2zEFZXAI5qTvocogPbeZBRJlJLm6qJrt6S/CaSqwWmjifaWPgjcpLcNzQuF76j4YQ0CmzUKCe3vLvchnPdyl3as33LwmEV/L1XaZ2bt1YsVgWC9AsSRG1aeUrCe1LZrcgYcUz7zv+UTs0cmIddt2EECBhIESo3J5Z7a+oUp+H952GLoq8PypKlY4GCSS6VlcchcS+ybtpZKokaaeAXxNBSPbsfpWOS8mm0MpEcfKke11ZxSqlU/7IvsTLI1Q0mSez35U2T5jTR5cfhg7GC5LaxAntt3JYnP42zfdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:37:43 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:37:43 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH] mm: migrate: use thp_order instead of HPAGE_PMD_ORDER for new page allocation.
Date:   Mon, 04 Apr 2022 14:37:41 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <7CA80FB2-9F72-486C-A5AD-D3E6D415EDAE@nvidia.com>
In-Reply-To: <20220404112802.4c07585b7b7e420342c9b0fb@linux-foundation.org>
References: <20220404165325.1883267-1-zi.yan@sent.com>
 <20220404112802.4c07585b7b7e420342c9b0fb@linux-foundation.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_E61DBF63-2065-466D-8506-83E7B34B6DB3_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:208:134::21) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59137e19-f18e-4d53-e0d4-08da166a34c4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB283016A9C88FB33AF72CE56CC2E59@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S53bUAxyl0+Bq363MoXEdxX+nPcVeLuOxtJmqw38B9eq7Xq0yDj/0JMxgcpW5tK0ATkbvPwyAw+vidpp6mqexjfHP+5xk4RC1VaJ3vDiEVoTizWO7HTP1jmePf6ZbasZY7mioK8+U3UQzYzni0HTzW3Gu5z9E1QKGZsyAXUR6mYT2w1i756W0b4zGr1r3OQR44hYzjpDReI/mocJE2xDaVHJzVCvnCz8qLodnUVleLWNgro3Q46OeBauaxDFRLhOCEpyrz38pw7LXkKVQEj6nh6kvWOM9VUVE28wZOk2B3NpnQbzz0NsFvmkwdIERM+s4tN5i2aNKL1wMSI/t3k5sK9RDYC5u2ko1JpzUu8Pe+I0BJE8t+9E/B9ptHaJAZl30PcDy1nMb0zZ4sG4BarlD+pbhNQX9NnwoYeFfwim3sjDfbQyd54N2dEaMTahIPw+ae1H4nYha6TVc9tC0usCmQYE9PNW9oywYu6jrVF9L/tXoo85ykaVgjVNlUiHQM+3gdhChrLsZuTef4v/Vq9n4PIMCX9WB0ZR9jZ+FWSb+fM8I0QEGqD/GKavsc15BSud3QM/4YxL7VRMLnl/jKLCPyIe+xepe6CNYS2SyRG0pOzXeXsvM/Ogfs+x8gaDZCHdUqY7dnfgrqlvZjTkuo30ZBGVWKfR1zDs98fcgwcsB9ydFmn6YhIZGzzNjAIsAJHxHS05epUKoq0sboVALQjXT0IFZAxUDPKzWg6mZV63LvLBFwd6QAbbuyDxdzcGmN+y0q6r7A0UYXPtrSwRYjQ/T95VHzi31c7j/DsNybUGs8wYqi0+W9MKJW6b1CEX4jLe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(83380400001)(6486002)(186003)(966005)(26005)(508600001)(5660300002)(45080400002)(2906002)(6512007)(66476007)(316002)(8676002)(8936002)(4326008)(66946007)(66556008)(33656002)(21480400003)(6506007)(6916009)(38100700002)(53546011)(54906003)(235185007)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AObAlW0j8a6GMuRRrfn0IlOeBBIa920FUHJXnq0YIZ8ltwRW15/AzLZhKaLm?=
 =?us-ascii?Q?ItOdeJzpPxluiXgjmdJnkuWfXyVtN0b3DcBpRDp4UXPYptYIlCJFOgaWJexS?=
 =?us-ascii?Q?XySvrT/cj2FvFeM+ASpGi6u+QM9C0W30GVZUlWzLdKWI6sgqftracKgBJgyz?=
 =?us-ascii?Q?PJS56CunRsprC7eEcyHcpgO1Ok00E5UeKIdu3tei21E/FPBxpi/KKbPxd76O?=
 =?us-ascii?Q?TpGjJLru+a51apQ9fTDodCEhqxN0fac106AEludezGt6Sd7lCJnAzwzbK/iL?=
 =?us-ascii?Q?YuBN2Q+I/DVSUVAWK6pWgkquU/aFEjT2jYBSFbrDUqdAvv6OZVbEdtSN8oVs?=
 =?us-ascii?Q?tPPTD8DM+l8/748z26iSJ3oka0QVmiTqdbZXgtwU6Q/eCjA7tsfA9XBNLncP?=
 =?us-ascii?Q?hc350tSHNEfyq8JeKGzpVCdnUv5l/5GInx0qL22Q4SlQ3K9OXnqn2Nyp0NO3?=
 =?us-ascii?Q?7LlqRRw8unmXnryrI2/UCXbWIi1fjhZt/M7htutXS22P4vSm/aXe1Npqlt8b?=
 =?us-ascii?Q?2TV+PTK5rhogQgvXwPlmC4Db3Oe+2vrwlru5ECGqZ/8gjGc/zI0KytU2EOJe?=
 =?us-ascii?Q?ujcl8LEmlf9/mfJ/OJwn+cBCbHqrFJqMDXvPQcViGZi+evkVjpLXzDhQKC42?=
 =?us-ascii?Q?5ljqT9+z4EkNcqVPHR6JJ2N/9ECltibki6LUaxvl1eHbVbIdiyDDmKtkJ+Fn?=
 =?us-ascii?Q?zmQ0QAbNH6HX+X3Z11+N3Z62+abEyLCl/jZavm7/HXIjCKXYS4wIGeD8ni7X?=
 =?us-ascii?Q?fPSV5VgFtyYhTCZ+KNpG6Q3SSuabd4CJvfUhwjRXsvdZCY1fn2y3RbDsac5I?=
 =?us-ascii?Q?b6XNfJZ+/ltPm2w36xkQ7MMWtgIXAH+fk1k8B8kIBKWaPxeuyAxP3vzt+OQQ?=
 =?us-ascii?Q?7CI5xGhgD7K4NcJ636Nyp3NfDipDu8wT6G04VNCxJiis4dzuxFG3kA2oKixd?=
 =?us-ascii?Q?BIOjP7hgmh8QxyPguKMX8sOVjugzbSMHbwxCtemSxi/8kzAdSoiIYKkLlniY?=
 =?us-ascii?Q?hyiLGzfMPyzmFEuxp8uvZ+XJXQDd7/7o8rJVK4vqpk701fdmeHUoD3vCozqi?=
 =?us-ascii?Q?qo3zDRL4dNIKsR2QWGGJC+qwrA7cAHuk5Fg/0sbcef5n4T4gZP+vn+oJ7gc6?=
 =?us-ascii?Q?c0W7J5GiwnWQO5i8LdkOVl86j0PttrIarbP1+n/GjntWukwqcNJ2dtFVDEeX?=
 =?us-ascii?Q?cYOv13oU1/0HDnjFpgByPF0mS/EVJvg2XDwBiJx/NnyPLYjkxaqDLKxCDiqA?=
 =?us-ascii?Q?IbjtE9LBp+rf6I2U7r98RCQHNWKk+lO244QkkRVaofu6OG3x3DUw1xmz0BWk?=
 =?us-ascii?Q?jJgRiQ93QBzb069LVnH/+RYtBmyZ5eO7ssWrxLxtRptBGqR2SFC6k0+f80VF?=
 =?us-ascii?Q?urTPEiy9I6B4w/VlAjmlZnHx9XeIVMPBHQeGG339a2zqdWycqlw+x3K3UpDN?=
 =?us-ascii?Q?mlWpHYS8LEzhmevBY0G88/drKpH1C2izREFD3rc7BnR6unNxqGevgxbe+u4x?=
 =?us-ascii?Q?oaMR3QcdfhXQZJUa0/4LLSdRFv3lqbCEsubMjj+YsgNURt+pToEveRfIHaHv?=
 =?us-ascii?Q?AzFKP4B4VeWFXJew4LwjkDCbYngROSt0Saz9Ht86SxQ9Gyrul3rCFAzNDhnC?=
 =?us-ascii?Q?Zt/dDPsqOJbiVPZsfAp4pwA5boxf49dbsA9eeFUvZGJhx6vJWefGXnvsElZk?=
 =?us-ascii?Q?CwCzCu87BuLrMcgNWZT4L+mUABw6u+kLCYaEQosYhqQpQCZQRYC1KMnxaw/U?=
 =?us-ascii?Q?GgBa/7nZCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59137e19-f18e-4d53-e0d4-08da166a34c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 18:37:43.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UVVayber4zHRLpfLoW3CagCpvT1NCuRq5Jnv+QK5dsTF5fi/GP8+lpZ7LMS8R7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E61DBF63-2065-466D-8506-83E7B34B6DB3_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Apr 2022, at 14:28, Andrew Morton wrote:

> On Mon,  4 Apr 2022 12:53:25 -0400 Zi Yan <zi.yan@sent.com> wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> With folios support, it is possible to have other than HPAGE_PMD_ORDER=

>> THPs, in the form of folios, in the system. Use thp_order() to correct=
ly
>> determine the source page order during migration.
>
> Changelog doesn't describe the end user visible effects of the bug.
> And it really should, because
>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flore.kernel.org%2Flinux-mm%2F20220404132908.GA785673%40u2004%2F&amp;d=
ata=3D04%7C01%7Cziy%40nvidia.com%7Cbf27ebf19d8a49a9b4b008da1668dc09%7C430=
83d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637846936880192108%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C3000&amp;sdata=3DpgvzV3wv6icqkMaWY2koB9X4VqlPMaSHeB8r7%2Fv1938%3D&a=
mp;reserved=3D0
>
> it fixes a kernel crash!

Thank you for adding the information.

--
Best Regards,
Yan, Zi

--=_MailMate_E61DBF63-2065-466D-8506-83E7B34B6DB3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJLOvUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUygP/0UqtOKJl9gXUK9/SOCG1W5IR+ihOIqS+Cpw
0wHflXeB43B6Ud3TIW6vCbRqGJawwxHPxcqw7uhBR1m0sueRfU7qqCROJpBV20qj
3krKTRxzJCvDpjxQKDLBr3C727e6kxbaVx+iYyRABkAdPONz1iKdpeUZCcfyhmbW
QkHqpNsPGZdaqSBvy2TAM9bgG+sy1BYSM0nDLzm9R5LONaI0IS7u1xrYnWjUpT9V
ibUe/KNHJwIDHvKWRSa4OKefU54rZn5Y1nGLsONQVAzNvjEnR/LLbPkSGpu/UMXr
+GGe7qTshKx6+TpVKsn+HSGH1Br+FVjME5Q3LtgJTGGwh08oxgrLry46ViOg092Z
8FKqDhIcGLUk2GQLXl+XDWnr/uNQaV6IfU+AW4iO9+QE1raMapTQrfRZ5jfdA9W/
YbCjvHVpmfevGpvK8ui+fnOw5Eyz+xL7Jyofq2JxrFP7qqeQG+hrgNYb9dJVl3rh
VNBU2t0BNKbT966FWBMjm8a9D2/zCVzA/lOtIqwT/wh+t3Fgh2fiBEs6RfrXoQxI
w+A+0NEMd11CuqdoyUdfPMsTmjcbsB8cVGNwSadJYH3IUNbbkXFqnV/D/suLI8EQ
AD/vfBNQpfiVNP8hiJCYVvLuHhfkO8zUEI7PsKb6quioRQWDa96UirfcU2+KRRq+
F2bO5LgA
=pv/s
-----END PGP SIGNATURE-----

--=_MailMate_E61DBF63-2065-466D-8506-83E7B34B6DB3_=--
