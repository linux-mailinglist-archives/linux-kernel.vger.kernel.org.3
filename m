Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C849498D88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiAXTdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:33:01 -0500
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:5518
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345831AbiAXTWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbiZIjnPyQY5k1di6eSH9rDamVWCPSSxyZFy5ypaDhHgOL7soYabU2c4hIyYxSxfnn996YiLtJrTsYKNB35CU63ETjPMzi+KMlfKELu9J4ynSXBKpOgEkxRyvfuLWXXNaaeqsD1DMs+h12FKe498Qt7aHWZ+QndQ1HFJsj52eqru8kV1S3RxTQlc/TijrNuiinFQLrCGCOsmxo7wLUpC0+ZpppYckPZCY7hMuzbqLHwFPYahTDPJI+uocvpyyltP2gcMCezZyOnwfFb89QHPNrP2d5u9i687s3uvrWQoT/R4bI3N1zZjSb6U8Vfw3kGNjP0vOiWDTnP/Dtoeyu4g7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkBdIYWb1dfm3TnHC2o+Je60klQiIeRIg88oogMBJ+4=;
 b=i/QXWVCUBaxq61YiUMIbmofyal9NFDpqHAGzI/Doz1HOw7KWjHYydp+7VWiUr/Jx6Ecz0+ulBzkmmdJSa5z/4T7uBwfktspEU0falmDbA1qah5xwx0fV3q/XeN8lDLGZRJI2tdeY4dtbMuJhPECvyza/+cg4QzJBg8PnPG1jYwYQBKsfqP0wOHUFuSvkHX+smpzRBVvyHMFyah32VGsd+eCnXIdJhjrrTsSZB7LGthsOty8qOkA4Lxj78LhqtSy5mrx+sZ9unE8J/miqhihdcIgqjkFDu9mlzzCP7FCdSLDH88tqGquCqrTPu5JzyiJpIcjcgRlDgeF87RZ0VFtQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkBdIYWb1dfm3TnHC2o+Je60klQiIeRIg88oogMBJ+4=;
 b=Pr/B5Vb+2n380Y4KuqoatJAWoyib9qySGuRIZ/njCaOLueLzKg9rHuD75uIEbGNmmCHw/f9urNnvnnPDUS+r3OprIkvwFk77mbjSJVKt8rnXuaO0ftIUnx/b1wjXyRa4XPEbhWAoOJXP+prBZqsCs5SD1FNwl5QG809BG13ymQqaFP4joPNnNSvIowmU//uFH+72yCXipzY72nCdoJpX34OPH7RDuhL68rKJ4B7RAeEZImvc+Nvkm3bIa7hawu5e60G7r5TNGGbFVBVk127uoTGvCg6FAjKq8RJIoGGfrkdfXhlsoz8Bh7FeGjQCaTGGJ9hJ8I/EaYtBOvpPwJsX+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 19:22:36 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a9db:9c46:183e:c213%3]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 19:22:35 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Rientjes <rientjes@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
Date:   Mon, 24 Jan 2022 14:22:33 -0500
X-Mailer: MailMate (1.14r5861)
Message-ID: <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
In-Reply-To: <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com>
 <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_66E87597-6A15-453E-97BD-4AB79E478476_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a91f154-3735-44d1-14f2-08d9df6ee083
X-MS-TrafficTypeDiagnostic: MN2PR12MB4045:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40450821BDDFF8BA19C1C78AC25E9@MN2PR12MB4045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHRcWH7N0mvckEQy+UFMyIroqKO308k55VVHNBFvGqoklU9mptT0aCRZ8AJMa7xoYLq2+ARRleD2KOVZ0KRX/p65JMQ0KDDkjUXW7Om/vlJztk+LZYfg4IhTSSeGeqMXIoH8zJo3p9bonmKGY53k8FRy28ucBDTe6P7QfAuUw8sPGgB1AjNPZF3Z9CaNPoKp/Kzy/435/uFpQWO8Z6gpINVtGt41/ooeKjp1n0W5Q+/i93PhnNuvzjnG+O3x2CgxyKVdP4v8CJ5hArDdcLR7ryeGzsnonkhS7DjPWtnJ5QBF3D05uQjT0T9knmaTZwXK15SqGGka86TMTeCnuaElFjxUUc6BzxmejSNzN0IP59dqOc9329l+fZjyhyt2sO12xmMRQMwrRwELAWtOPZUvcwRdsn5ERy2JZE0sh/AQU0SjVprbfirR8KU7Ir0H18eJKfQVDFx4dS31F6E8b7xVjy/hBwMUXe/IwgiXKgwvJ9dSXSp3M5PvwMBp5rfz73Do4wIoIaOUmEIDBLAK7bdlLL6hFVa4zceIRTGDnjFnbpFg8mg7BycyohhFLemsiMcaqpHJnrNVKCahOB75kRJwDE1MBsGwXkw046jc3TqxJa5F4W7O4yZ7hkjYcDHFPzQPJQC1ApMsBSuXHqs2CQdk5+RoeXmETJ5OpGV1qJdzjVERTgliEkvA/5K0lb4OxfgANmIwICYVMwDMKbFgTTTlfYLeuOIjDsPz5rFNfZp29UpqLOB8xrhoDK2/Gy2ruyAlpCyEfb4qt2k6LWAC5RHmGbpZNyY/vVrUzFZUUf5ndMwLh1/RsFZuAdGqE/JAQm8G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(21480400003)(2906002)(6506007)(110136005)(38100700002)(4326008)(66946007)(6486002)(6512007)(8936002)(26005)(8676002)(2616005)(66476007)(966005)(36756003)(508600001)(186003)(5660300002)(33656002)(316002)(33964004)(66556008)(86362001)(53546011)(235185007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1l1TktNL3dNVGs3RG4vMFpRSWlCRFp6dVBWUFRWQkdndTV0ZDlVSUl4QkR0?=
 =?utf-8?B?Uk56cjBSSTRXb1lNQ3FtVWdBOTJiY24yYnNaM3hWemMzN05HSzZwanFEemN1?=
 =?utf-8?B?TFdGSzVtakpZTGdPZjhTSDBEclp6bkJQcGJCdDBrb3Y2SEQxQk4zWVNxaGxi?=
 =?utf-8?B?RjluajJSUjQvZFJlQTBkTjhqbmYzY2dLeDVIclUxdUhaaUdOTFlDNml5Ujgv?=
 =?utf-8?B?aUk2UEpncHZCQkhjblFsSWN0SStxUW9HZjJVbk9rako4bHd3Nmg0N1dYakxm?=
 =?utf-8?B?dldzYWc3bW5GdUNXelJaK1I4NW1sSmIvTWxXOERVQ1NQaVRUbWM3MTJsN2Rw?=
 =?utf-8?B?TTdIcVcrSFZBVFhsUU0vamhsV28ybVJUMWZqZXhZczdwVWdhb2VvSXFqVTU0?=
 =?utf-8?B?VGYwVXY1aE1weGFDR3BHcUtabDlRRjIzUHhIVng4NmRQendmRVc3MW9DYnVj?=
 =?utf-8?B?TUFoR1V0M1NkeHlkdmJKMk0rUkhPUmRVUllkRWw2RS9NM2Y3SlNjZ1hVWXVH?=
 =?utf-8?B?MUdyNnFFUVVqQnlWRzhSa0RUZXFhV0VSSklERWFhSDdZVk1qVzA0MEkxUmNG?=
 =?utf-8?B?QnRlOUJpMTJ0VUl6a0IyUUZqNDY1MElNZVh5Njg0WlNUTXoyWW53UGtEZWdJ?=
 =?utf-8?B?MjNuQ2MyRXlZN0J5em44ZkpmdEY1TFIxNnFVb24zTkdVMnhiRWtpcnUralJu?=
 =?utf-8?B?VG15c3hhRUtaMzFvaEpqb3lpRlY5ZFFRWnhZYmNuOXJYOTFMT1NKTTQ1NDBI?=
 =?utf-8?B?b1JybE1YRGdLWnpCa0UyWjhkQ29HdzFPeFhDMXlEdEdTTW1ncmpoMm5ZSW91?=
 =?utf-8?B?bEl2aWk5bktlazlzK1MyTVc1cm9uT3JJSm1DZ2NIdm5ESklreHJqTU5TMk5K?=
 =?utf-8?B?THFwczEvQTZDNTA4RG5CYU54MXA1Y1hDcU1QYklwRlN6eitoM1pTMDQvMHRo?=
 =?utf-8?B?USt5SVl0SFhtUmNpQWZjM0dHQmZKZGw0OE0xRWZKQ2tUdUlzYmEycC9rdXNI?=
 =?utf-8?B?ekk4cERTV3JhMkl6UE1IYzNMSjRoT0E2ZWpNKzlwVEtpa1VHdHR6RjVYNGMw?=
 =?utf-8?B?aWowMXRtY1ZBS2hMekFXd2M2aHdRUHFBWCtCRk9aOFJkT25rY0hLRDA5TkJO?=
 =?utf-8?B?MVM2TVVGbDZTT0pNU0xXay8xVHZ0cWVnTGRYY051OVVRTkx2VGhoQzR2Q2Jk?=
 =?utf-8?B?dldFbENlejk2d1I5bjhmc3JjTTNlTlRTNFhnQXJKWXducndvczRJUVdwWGRF?=
 =?utf-8?B?bE5OdklZM2Z6RnU0L1hLN0JZUXF6TVVRMGo4cWlMUVhGK0Y0TnpFNHp6ZHc1?=
 =?utf-8?B?c21jRGFMRjFmV0taL1BjSWRmbkN3cW54M0lyUEgxV3Fwek1rOENPMUpOeG9W?=
 =?utf-8?B?eERnL2NZRXkzMkUwRi9haEFmWFpzL01acW9pZ08wWCtQMGk5SDJqNllVODlt?=
 =?utf-8?B?UTFNN3NvaCtlRk5KclhscmdmZTRoM3g4YmMrYUhkS0RNOU12V1dtcWlMY2I4?=
 =?utf-8?B?QkM1WXgrYnlkbDZUYldUMHgxMThCVWxDUEtGRG9LQVNMUFNkTWxJeEtCeEtt?=
 =?utf-8?B?RVVsMENUTkpLZTMySGFaSFBGUXJ5Nms2RjRYUG4rbDFKOFZpcWZCcHBWT3Nr?=
 =?utf-8?B?VHdyc3dmanc1Y0p0VzhJN2ZNRjlpUE1ZcDFEU3VrcExFa2NpK3o0emFkSndl?=
 =?utf-8?B?U0dVUTBRVVpORzB5ZFJBdnlWT1JJZHpBTHVkcU1tQ3JlMmhYc3F2M1hMSkRj?=
 =?utf-8?B?ZlNVd3Vjalc0bjhoNnRCZTFnUjZObThtQlZNbldNS0RjRGQ0cUZ3dnpBM092?=
 =?utf-8?B?eTRZNXBRdmhHdTNpcWs4RGhpUzQyUTFUalpBc3IvUVhGZmRwZTlHdDY3OEN0?=
 =?utf-8?B?WVhXeXAxbFFZTGFIMXF2bGhDa1VhQ21vRGc1cGlUNnVkWTEwSCs2akRjd254?=
 =?utf-8?B?TzA5K2I4bzZUdkk1MkpsenBQN2ZsYU9DdHBsTDZwSEQ5NHFVYnEyNDl1Wmlp?=
 =?utf-8?B?dVFEVHNRbGZad0JaQm1DZ1gyYXg1MXdxaExsS3o3VzJTc2tqQ2lXKzY2REtp?=
 =?utf-8?B?K1U3aTJBRE14UDE0L2NFUG55UFVIclQ5MnVKU3krY2tUaWU4UUZVZUNzVnVX?=
 =?utf-8?Q?rU+w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a91f154-3735-44d1-14f2-08d9df6ee083
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 19:22:35.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVnt4gXhDBHzt0okrIP2L4O6UOGS1gMo5qyA0no7o3ZyxjY65YdgKzuiLY1YJZo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_66E87597-6A15-453E-97BD-4AB79E478476_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24 Jan 2022, at 13:11, David Rientjes wrote:

> On Mon, 24 Jan 2022, Muchun Song wrote:
>
>> The D-cache maintenance inside move_to_new_page() only consider one pa=
ge,
>> there is still D-cache maintenance issue for tail pages of THP. Fix th=
is
>> by not using flush_dcache_folio() since it is not backportable.
>>
>
> The mention of being backportable suggests that we should backport this=
,
> likely to 4.14+.  So should it be marked as stable?

Hmm, after more digging, I am not sure if the bug exists. For THP migrati=
on,
flush_cache_range() is used in remove_migration_pmd(). The flush_dcache_p=
age()
was added by Lars Persson (cc=E2=80=99d) to solve the data corruption on =
MIPS[1],
but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.

To make code more consistent, I guess flush_cache_range() in remove_migra=
tion_pmd()
can be removed, since it is superseded by the flush_dcache_page() below.

The Fixes can be dropped. Let me know if I miss anything.

>
> That aside, should there be a follow-up patch that converts to using
> flush_dcache_folio()?

Are you suggesting to convert just this code or the entire move_to_new_pa=
ge()
to use folio? The latter might be more desirable, since the code will be
more consistent.


[1] https://lore.kernel.org/all/20190315083502.11849-1-larper@axis.com/T/=
#u

>
>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> Changes in v2:
>>  - Using a for loop instead of the folio variant for backportable.
>>
>>  mm/migrate.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index c9296d63878d..c418e8d92b9c 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage,=
 struct page *page,
>>  		if (!PageMappingFlags(page))
>>  			page->mapping =3D NULL;
>>
>> -		if (likely(!is_zone_device_page(newpage)))
>> -			flush_dcache_page(newpage);
>> +		if (likely(!is_zone_device_page(newpage))) {
>> +			int i, nr =3D compound_nr(newpage);
>>
>> +			for (i =3D 0; i < nr; i++)
>> +				flush_dcache_page(newpage + i);
>> +		}
>>  	}
>>  out:
>>  	return rc;
>> -- =

>> 2.11.0
>>
>>
>>

--
Best Regards,
Yan, Zi


--=_MailMate_66E87597-6A15-453E-97BD-4AB79E478476_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmHu/HkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKX3wP/2U0E8oTmNPe6nFtlMTzKDK1Lr/4Vi/uh39a
e97o78hnPqD2PiAPxenBMq3pDxZN+qcJMWeXSATr+UJWiY6Nh4q6Bfeghv2rbtO7
xIMP1AlH6jcpi+xVBRqwp1hdgUE41V2vhhMhhLdhA751smyxn7icqo/LpkOaiRKZ
DZ4pj4oLE7g1atFTeQz0hwySUwf296p7hXareJxb7GRf58sVdkNMY/IZzqdrmR+S
joofnio1Hda8kVNCxEDsoFYfdnSHUD9UQL607Rq+3TFJiDA81ZMdW83/cRjhx2Qv
zM9AiMH3g4yTHFTSH+yRCrdsgmQtEThttRlI97fU9p6C2yDKJpCV3+uTnCcUCxIg
5clauciRzgvUjqs9AYqwaQtjypD4ISYjwbt2YMTbPfkG1ucSO5vAA3hFJepTvd/D
zFCE52P3iq2Qogw+lquj3FenHizbbySeyiDW0qCWTzJLASFyp75rpGVOgXzglQgr
bmpRc29yI+MpysLHJh/XH8jjArvkYz7s5X8uqUB9c28ltEf1zuOJGUpj4b5gG/2c
SQZzGqPSDa2J9R/jaZZopX7aBe9fJvF2h2UrDB5cffR9fxsy8GixcgtAJv0aMs2h
HoQS7tzFdXddP6msAvuSv9kMzcBqornJiyS6KaLnzHu3j46o5EQLY1Z8hfe+1AVB
qvKYHjEf
=NQ+Z
-----END PGP SIGNATURE-----

--=_MailMate_66E87597-6A15-453E-97BD-4AB79E478476_=--
