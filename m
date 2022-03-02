Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27AB4CAF99
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbiCBUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiCBUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:20:36 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6BAC7901;
        Wed,  2 Mar 2022 12:19:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXmEVEMwplQmqAK4xjXw512eWTw4Ol9Bfl7EIPHDFMiIWAAFUEeg38U0NU9REvv0zNPSOEshYwyKlpwphrBRHrUE/+jOH4p7E6NRQZkSc/cbIAL4LiQ05rJhVYQudSY/oU4/ZQIwduv0qUHi5mBs7Q+ZMGrItliebU/wm6fAmqoR0o4lnK2Ac6IsLI9pqkj2U9p00nqiq22IlTWi44V6DRZOqcNJ+nGQTnpm8oOoqIC1309EQqqlM1W3U/cOfqyNj6US8bk8g0vzjPs61OYty4xdtzb1GuxmpRllGWQs5MDohQVvrzigMS0eMWzyQM9LqAd+sS/lip+IOLHoKFOr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoO+JfBU1ExSnkPEoO6Vp0oMgTonpb1pjqsH/puwgYk=;
 b=aLqGgy+VqERXu9+kXCbhQRk+0A+MsZ5IvaZqmgj/CUVM3xWx+q8BeOTQ8Axy6KojQDt1o3D10WWmCvs82ybTzRc0M/nQcmFwyrmVKPCq4qJWdHpJkLDKVjcRocLtRm33j5ls8wET5sQYHLvwYF86i2MT2H+USTpgfo7nu2aILR7EQvCOzsKX7jeG/8Kd1eFNQwnoUguPgG6wA6edUGoemQ1eDgrx1o4Uwcl9NizrZDinYQPgrtXd5pxY3E10WOXi92LCJHBhwdotKNprDmb2C712SzGuTpzsd5MRYbU6klciuCVnFQTm0O4HhzEzqf7oW4sDs4saLKP4XDjiSgW+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoO+JfBU1ExSnkPEoO6Vp0oMgTonpb1pjqsH/puwgYk=;
 b=CBrxLu1eZjS42AwhEtew4uYtEkxIx/KZquQYRSi6jg4y7jxLZ/XEpkUgbbp8bYvVg/HVOSTjvhb4zOuOFhKyFjc+KO2/gbwC8r79Mn3FN/RCKpz+JxhXGa0BZScw9E5i7JZkQxbbtLbDbugjorf2n0j8LGlwc98x1oMF3H2LrKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by BY5PR19MB3285.namprd19.prod.outlook.com (2603:10b6:a03:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 20:19:49 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::ccb3:6c11:fec7:b28e]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::ccb3:6c11:fec7:b28e%4]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 20:19:49 +0000
Content-Type: multipart/mixed; boundary="------------QohldUDHUPfokZEdaiTh0zq5"
Message-ID: <e92ef2ea-bb1c-8a8d-2e25-c784a784b995@ddn.com>
Date:   Wed, 2 Mar 2022 21:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fix certs compilation / export is_key_on_revocation_list
Content-Language: fr
From:   Bernd Schubert <bschubert@ddn.com>
To:     David Howells <dhowells@redhat.com>,
        "\"David Woodhouse" <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <ce5bc8c0-2c6d-2a22-1ad3-357254686366@ddn.com>
In-Reply-To: <ce5bc8c0-2c6d-2a22-1ad3-357254686366@ddn.com>
X-ClientProxiedBy: PR3P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::12) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1961ba8c-1c1f-42fc-195d-08d9fc8a0030
X-MS-TrafficTypeDiagnostic: BY5PR19MB3285:EE_
X-Microsoft-Antispam-PRVS: <BY5PR19MB3285FFF6311AF1F3DDFF5A04B5039@BY5PR19MB3285.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHIa6MdciXzzL+MPnnwpZK5b8yHkUljuFswMDePY+rzhdqbhwtdzp6RQV2nHcuqpZTJBdfiS2x33UKeX33n58Bre0AvQjB74tAzg2KGg/lJjAGil/ZGGj1GerrXMNE4aSmbqoLSyDOhErO7NtmjP0HxQ06u1/8JmFBdhjjKwU8s9eWJMfTaTAq/wAj9Yd6aUC1YW1dKm+QCGLL4u3Ps3Wxifg6wyNmAWAKFgz6EGHmzdYVCkCU8rQEps1SHPDgBZxOR4SGlQxEkO6dmlk9o17a1dyBspLn0DodE7dQMVD4HmudOqE4qKC9dtiVrKEIDVA+WZU/OlDgFyNu+H/o/eItGhhY4TeXadH7RMnnuHCDeQhW/uqd+fuQLjAB/7iOvN1BBQK8GpY46aj/4gDosyNEeylxjuX63zGmXiVeN1ysVDiJs6VqOSsEq2xNGhrTcZ8+VRdDAz1bgun47K6tW5q+BlRfMMvhXO2LCnVfeP50Sow1fRJp3jhIq/5Sh1Uk9ExWwl7Rfw4b0bdfe/YfU5F75TqB1KO+HOViKbPsjS2+LGNuQAysslRLVMqLfzXjcg0UDA0PyX+l6J2rmTeBvi2WZrN024sskGDVbxd+bwTyyOf4bAW7xlu+WnJl1wrjsYKuFfFjt3uLYO/AadAxL97nSdO/Z38YZ15suRNyqg5zJn6QCrLQoOGfoE1smVUWjia/S4gac3PBMiIVSiKC6zTqk6gMr8UcF9+zNRXgZiHKppLR+upPqQStt2pfYclzUJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(38100700002)(508600001)(86362001)(6486002)(83380400001)(110136005)(31686004)(6512007)(8936002)(316002)(186003)(36756003)(2616005)(33964004)(66476007)(53546011)(8676002)(6506007)(66556008)(6666004)(2906002)(235185007)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVNzaGtlQkdEUlAycXdmWTF1cEpCQUZjV1huY2RFRGk1Ymh2K2NObFE3Z2Ix?=
 =?utf-8?B?NjdhbnFhcGt2MjNySHFhcFVXTXUzQnVBU1ZPekVYSzhkSW1DZENGZEdvUVF2?=
 =?utf-8?B?MmFtZWdnUGVGUGhIZkt2Z0VSU0l3V1pWdjdCdHBxUUxuVWxLSVZpaytTSDBk?=
 =?utf-8?B?QWlSQ2JCbmhxckg4NDVYeVpwTllOekhNOVRreEpUWGJuQXE2eHY0VCsvVlhT?=
 =?utf-8?B?b0d6c09VMHhoVmx3QlM2Q2U0Q2tISmFPZGFFQmZmaFczOTV4NHRLUUFINHFO?=
 =?utf-8?B?MHY1Y2R0elRXNnAxQnU5dURpQVNSeWU3RXdibW53cDg3RkpLdG1HdUNDOG5s?=
 =?utf-8?B?OWdNWWpDK2lSd3BheVlPZlNURG1ITmJqV00wREtlMUdsbGlpeWVYUko2Y05T?=
 =?utf-8?B?OUhaNElDRlZZMkk4QytGc2h0OEM3Zk1vODU0R2gwN2JzQlM5STZRenpRWTRH?=
 =?utf-8?B?MG1EcnNiRHNzL1UwQU9sbEthdW80eWxzNTQrLythdElaZVF4cE5BSGI4T1hX?=
 =?utf-8?B?WWt4VlBXakdKM3dndzhUZVJJaTJldmdlaTUwKzZhbFNYS3QxLzBhZmNDWnB4?=
 =?utf-8?B?UW1YYTBPa0tILzhpRGRkdmI4K2lwUG1TMG1NMDk3NjkzTUM3QTNZMjlzdm44?=
 =?utf-8?B?blVmcWJRekNPdTV6My9nb1ZUUXJXckdNMDNMeEtRbWtXNXNXZVRSRFJ0ZnR3?=
 =?utf-8?B?ZnNKcGowaU1jNkU4Vk9EWGQ2M1RVSVlkT05mSE9tNC9LaFF2bkczMTR5STl2?=
 =?utf-8?B?R1lQUk11TWhKNXpRcXZvaE5FUEdCdVJTb1lPM0xOWEJjanY4eWJqdjkyMjR4?=
 =?utf-8?B?d0RQSE5OQTNaNmhZOE1YRUhLVzVLRURMK095WHcxQ1h5VzVnRmd5QTBkc3JH?=
 =?utf-8?B?OHkydFpQMkl4KzVoNW5sNE5sWHhZaFVuWjBhN0xDQlgwQmZTOTQwN2RMMGxi?=
 =?utf-8?B?L3d4Y3VOSngzSVByZUlLQkJCSVR2WjlhWVpndExOUDhPRHgxb0Q2NkxiQWdG?=
 =?utf-8?B?QWFYblJFMmQ5aEoyUzRKTmFOMVlUYndrcXV4R09lZ21kR29WZkFxRUVURHFZ?=
 =?utf-8?B?aUtQVTNEKzZETzV5U3lOcWFmSk0rdG1vVUE3SlZmVk1RQm0wbzQ3dmdVUkxT?=
 =?utf-8?B?VTBiZEZSNkxFRmNReXo1a1JWZlE4NlhwTFc1VmRIUkdld2lUQWd5bGJrdGJU?=
 =?utf-8?B?SUMyU090N2pTZ0sxejNuM2ZRRnh3bDZ0MzE1Ymw4MUZuVDZyeUJxcFlNWmdR?=
 =?utf-8?B?R1luNkZGY1B5Y1lXS21nZ0piVk5ZeXQ2OWQ4d2FFRlNoUlZlQzdQRFNFN3ln?=
 =?utf-8?B?QzNDQk9uUXJZSGZlbkUrc2M2ZmNMTlpsWXVVSDJ3U2EvRUNMOGNhaGdHQWE3?=
 =?utf-8?B?eDdBMFBXU2o2QjB6ZDYxSk5idGhvcVZQbFRkWnJRVFF5ZzUvVEpMVUVrZkFr?=
 =?utf-8?B?VzRpRjNuSkJpUkZXYlUrZ3RzZE9DUmdVUnB5MEJrSFFTeG95aWFWWVlGaVRp?=
 =?utf-8?B?VmkvRmtLbW80SURBZHUyRnJBMWtmLzFINzFQa2dhNkZQYTE3VzMyTDdMdUxF?=
 =?utf-8?B?Qk0xV0lIT3hEMFNhWlgvTU9XMWtzK0h6V2ZIVGFNRDQyeWxEUVgrWmNvdGRS?=
 =?utf-8?B?TFFQd1RQWlZuY2NZWGs5YnRBL1ZkRzhXd2p4bS8yeFhhTGR4bjhmZGNGSy9T?=
 =?utf-8?B?OUQ3OU9HUVJaRXZOVTFMTFhRZjlXRVV0QUhMZWFjbW4rTVJzK0tTaS9oVDcw?=
 =?utf-8?B?RGVNZUNoS1duaENBTTR1eWtseEtROWZIM2tXZWFPL2MvUFpsVW9hTnhheFRs?=
 =?utf-8?B?aUorWks5YmRBYWZzZnlnVGFBVTk5K3BxVnBaVXRaSC9KQzN4bDgyVmllNUk0?=
 =?utf-8?B?K2JWc2kxRndDZVVIV2hMSUJweGt4MzRuRmZuaC94c2hMdjBzdUpoS2xEUFkx?=
 =?utf-8?B?QXV0eHI4a1h4MHVvd0luMWhNWE96Sjg5eTR2Z3pNU2lqQlNISHQ4Wno0RUhh?=
 =?utf-8?B?Uzg4TCtsUjV4U3ZheXRueVY1L3FOMmJzdVY2WkQxak4zRzZua04zU01vWFhu?=
 =?utf-8?B?TmVnNzFzZE83eSs1c2E2MmgvUW00OHZNRW1rTVEvUzZBTW1hUGpBWWtIS3d0?=
 =?utf-8?B?Sng5TGg1Y21HUEZ6U2x6SUsrSFVGdG5oSDE0TTIvSmN5c3hMV2NtN0M5a0cr?=
 =?utf-8?B?Y3N4enZvRllmVHowN1FEQ05UeTJiWHpnYlUxNG42TlRPbW45ODQwbXJlRkM5?=
 =?utf-8?Q?qW/iThQuUdiVi2k2upa+uAwrEDY7NgRks4j+pgvR+s=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1961ba8c-1c1f-42fc-195d-08d9fc8a0030
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 20:19:48.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV3u3XF168r+1Z5NYWkLqYs5xdp94iqVFrwXVgD3o+ZEpC5jAlTtcti3+lWQYZxINb7qZLG+N+Ibvhm1cyhsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------QohldUDHUPfokZEdaiTh0zq5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for the spam, besides that pasting the patch somehow did not work 
(I cannot apply it myself), I had also a typo in David W.'s mail. I hope 
that attaching the patch is fine.



On 3/2/22 21:06, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Compilation of 5.17-rc7-master was failing with my .config
> (actually taken from Ubuntus 5.17 package)
> 
> certs/system_keyring.o: In function `verify_pkcs7_message_sig':
> linux/certs/system_keyring.c:224:
>      undefined reference to `is_key_on_revocation_list'
> 
> 
> That got fixed by exporting the 'is_key_on_revocation_list' symbol.
> 
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>   certs/blacklist.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index c9a435b15af4..ad39780e5150 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -192,6 +192,7 @@ int is_key_on_revocation_list(struct pkcs7_message 
> *pkcs7)
> 
>       return -ENOKEY;
>   }
> +EXPORT_SYMBOL_GPL(is_key_on_revocation_list);
>   #endif
> 
>   /*
--------------QohldUDHUPfokZEdaiTh0zq5
Content-Type: text/x-patch; charset=UTF-8;
 name="export-is_key_on_revocation_list.patch"
Content-Disposition: attachment;
 filename="export-is_key_on_revocation_list.patch"
Content-Transfer-Encoding: base64

Zml4IGNlcnRzIGNvbXBpbGF0aW9uIC8gZXhwb3J0IGlzX2tleV9vbl9yZXZvY2F0aW9uX2xpc3QK
CkZyb206IEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4KCkNvbXBpbGF0aW9uIHdh
cyBmYWlsaW5nIHdpdGggbXkgLmNvbmZpZywgd2hpY2ggSSBoYWQgYWN0dWFsbHkgdGFrZW4KZnJv
bSBVYnVudHVzIDUuMTcgcGFja2FnZQoKY2VydHMvc3lzdGVtX2tleXJpbmcubzogSW4gZnVuY3Rp
b24gYHZlcmlmeV9wa2NzN19tZXNzYWdlX3NpZyc6CmxpbnV4L2NlcnRzL3N5c3RlbV9rZXlyaW5n
LmM6MjI0OgogICAgdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgaXNfa2V5X29uX3Jldm9jYXRpb25f
bGlzdCcKCgpUaGF0IGdvdCBmaXhlZCBieSBleHBvcnRpbmcgdGhlIGlzX2tleV9vbl9yZXZvY2F0
aW9uX2xpc3Qgc3ltYm9sLgoKClNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHViZXJ0IDxic2NodWJl
cnRAZGRuLmNvbT4KLS0tCiBjZXJ0cy9ibGFja2xpc3QuYyB8ICAgIDEgKwogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvY2VydHMvYmxhY2tsaXN0LmMgYi9jZXJ0
cy9ibGFja2xpc3QuYwppbmRleCBjOWE0MzViMTVhZjQuLmFkMzk3ODBlNTE1MCAxMDA2NDQKLS0t
IGEvY2VydHMvYmxhY2tsaXN0LmMKKysrIGIvY2VydHMvYmxhY2tsaXN0LmMKQEAgLTE5Miw2ICsx
OTIsNyBAQCBpbnQgaXNfa2V5X29uX3Jldm9jYXRpb25fbGlzdChzdHJ1Y3QgcGtjczdfbWVzc2Fn
ZSAqcGtjczcpCiAKIAlyZXR1cm4gLUVOT0tFWTsKIH0KK0VYUE9SVF9TWU1CT0xfR1BMKGlzX2tl
eV9vbl9yZXZvY2F0aW9uX2xpc3QpOwogI2VuZGlmCiAKIC8qCg==

--------------QohldUDHUPfokZEdaiTh0zq5--
