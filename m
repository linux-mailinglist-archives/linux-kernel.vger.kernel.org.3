Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AD529AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbiEQH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbiEQH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:27:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ABB47384
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKkuh2F1kcir7eEoQIMkZljJDwtPipMlsgpFQG1YuGDk1qoQ18yjge1j+TJOECGLlGI8PJAPvCvSIn9Qmr/o6RgXqmk0TQhnHjf1wQKOwBOcrpzaoSgmCnJVhRSDFaYpClS6J7ZDWm+T/CxE/Yt3zEAWCCTXeS12GPClLsWnrxjUVznEny8pV8KpqvzYkiCSJbH5BE2AxP9wMI6gQ61SUsEgmkrjLF+FOIc/TLCwhu31PpjAXbL+/MuJte1mi1z2ft641hjdvoJj44x1x8mhTmY4sruSpjN8a6xoguC7Q5WtU9WbsoTlB05I7uQjXCOczxeDevDYlcIRqMY1CqMrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2Vpj/bLyoWpp0sjo7dmOZqPyfdFx4SFakbJD7wBg5w=;
 b=RDPfSHbRThCTH7jGEQuVugBc2H5cLEinJs7zvVkYI/A8wLlYOlJA4JorXvawuSQ4G6TiGpygeF3o9uJUKQmpr4cRNRhzc1MZWSW79zCnwq+v8wOLPr6C2ISFYbho/cSGQ4+pqzSTLAFN7WF4xfgG9WJVAxNMEBaW0xD7+R8clfLdkqzQu0TZ7Hl8zXnjtYXfPSL0Tr9/FtPjCqoSaz2bsFctQomaNFvf5i+2iR0jewUpmBE5oUfRLsZD9o7+s1kour3xl2o3U2mwXrU6qcBKatALr3vKJAqGAhgrJTaDmGOvPQYLe9QTIkiqD217AlTsV6Y9+9k3j8UWNYEO63hs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2Vpj/bLyoWpp0sjo7dmOZqPyfdFx4SFakbJD7wBg5w=;
 b=bv3jU1cMpl7JHYrNPlxzgUdgIE2qBUP1Ng/8o9306xsnr2nSq/zi/wmqaNNJPUVqkNgnlnAG19xzYFv1cVpa0Zzrzc6zwSXFDk2eP6rEJ30N8yfKGcAVmkfPsuf9MFJCBYdKEOQurGZHCXBJu4WGFCoR/6uPCmec7aYUP2dZgHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 07:27:26 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::f8c2:3f6c:3211:7b29]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::f8c2:3f6c:3211:7b29%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:27:26 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH] dma-buf: fix use of DMA_BUF_SET_NAME_{A,B} in userspace
Date:   Tue, 17 May 2022 09:27:08 +0200
Message-Id: <20220517072708.245265-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: MR2P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::17) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ff1d11-f157-4afe-1c38-08da37d6b132
X-MS-TrafficTypeDiagnostic: MWHPR11MB2047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB20473ECDE87232974BA61FE293CE9@MWHPR11MB2047.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyi0WlZlTkP16B04lzOzhGe6StyyW1dHuD0NyFBX9f12DCknf6ZaT9qJaIxh7aEeghOKez0wABaMxLfKVSoq86VNQuOR/X4z6+VhfvE3/nCNmsD4oFK6e2/1YQL3u96uj4YdGtMpWWoqbawaDkdnfAf0bsa7s8IZkg56EnSp0dcy4O0ZzeKfBmz3MZwiCA7lH1Yj/SJJLFhqyCBbiTDNcerd/l/wRDMhfBUPIoXQldergnvnAR9p78v7fxQ8snGGfbHy42bqJfUNHdBXPqGJF6QRd8oPqG8jNwZ/5VhJjXYHmn/n8xCC7N2chKhdM6kLZZI+mXishEjXHt255iEZQzYfmkspJf7LAe7hMSTjqmiU8qGZLb2KGR1Dy3zEAafZPodlZdEnC65kFSJzwVYzvyNRvFxrwlrMyhG8ie6pVMW4zXdvhyci+4hqBUnJ3wIFa6nWywHXyy/YxBw2riOCCNhA/b+tCRvxApzNfmeC6oiTx/FxCRGwQpcMasWybntZNI9+Q147FLDpOq9m4RclzCPiWz8OWaVQpgUxiXPjRhe8W9c6yGd/WxH/qBHImxVqjRbGmqgffDZp64R/Dn1xEYfChmT7oMOxeFAj4cHjG4pN/lo3IH9HK+p4v51L8LKv5eDMkJEjqEV5CIYzyWrrCKvz4YgRdQ1mvk2asSwj3l68mT/n5TPj3wl77skRz8k+QAmqrna+pyunkobhktRwDGr37BEX4632RN+J0mdHPt8oaNbYqimZhxroI+iG4cTGiY5KFg7ZC2NgCN6HNeXi6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(966005)(6486002)(6512007)(6506007)(6666004)(52116002)(26005)(8936002)(316002)(86362001)(110136005)(83380400001)(36756003)(38100700002)(38350700002)(4326008)(107886003)(8676002)(2616005)(1076003)(66476007)(66946007)(66556008)(2906002)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU50V2ZPM29MSGlWT01WZzRsbUU0Ti9WYzArR2VxMFFWU3lLN0tBanFSQ1F3?=
 =?utf-8?B?dE1OVnR1N0krNXNMd0hrQVJjWTkzcjA2NVdhVDNXZklTTmJVWDdDcE94WDNX?=
 =?utf-8?B?ZGFzWlZON3JZZzhxeitTcWZsSUZyZXB5UFpYS1JKdFhWTU9TNCtjWlo5bkhU?=
 =?utf-8?B?YzVYN0xNa25uVkc2cUd5UG10eCsxVkttZ2RBditQajZGNExuZzE5M1EwcCs4?=
 =?utf-8?B?VGVQZ01xVEEzNjExWThRTjNsRDhjWmdKZG1ETnh1cFNGZFZCVTdTU0pUWmVt?=
 =?utf-8?B?TkU4T1VPZDRjZUU5V05FOE9BQityYXIrTENvZTYzdklMWjN5YUdwNTVCSENQ?=
 =?utf-8?B?cndBWHFHbGV2eExQUjVlMVZtbW5PRUVyZitvOGdwQW02UU41SDVZUE1OcmdG?=
 =?utf-8?B?WkhrTTE0SzhrMStMYWh0cWZwNzVEWDZuREgySDFKeEdsU2ZJSEdOMnMyOHpa?=
 =?utf-8?B?dnYwNzB4b0hpb1dFSXYzdGthN2hVSTBsV2ZkQ2ZnZGVVdGN0aWxQNk44YjBl?=
 =?utf-8?B?NUw3eFYxZ1lsZW9kTitTTVVJcG5CSGVjZkxwMkNwT0J6ZTZaVTBKWVlNSmZJ?=
 =?utf-8?B?alNCRzRBZGJoa3RRUXhSU2c5ZkREQXkxUzZJaG43STJmcVIyTnlSVUxxR0VQ?=
 =?utf-8?B?bDAwb3BBZFpRbGI3L3hyN1BGc1dlWGdWbWxNamE4T2hKdmZmcGJRSHR5Zy9G?=
 =?utf-8?B?MVhGSDg0bWtQR2t6UnRGNWMyR1VrYms5V2FrRkNvMnJkcnNsSVJ1RDVlMkdB?=
 =?utf-8?B?eU4zQ0tSdWZiSWRQN05ZUEtUVE1mbWpTaFRxdXpYZHR3eFU5TWtTbXVrOHc2?=
 =?utf-8?B?WEdqUjZIYW82UlFHaVhhYmoxcGJiaUxPaTk2SmQvemcwYjVRR0E3aFlMSTJ2?=
 =?utf-8?B?WFVwUjhadlpkMTRNblN1UWhWMklZckRYblNBTXFjV0RBdGxVSTU0ZmdsMDFn?=
 =?utf-8?B?YVZsb2hiMk1FRzFoSmd5TS84cyswNURTam1IZjF5bS96cklEbDkxb2duVHlK?=
 =?utf-8?B?eWVVUEF2WE9ITHNoSndENHFndWppdUhCcjE0T2ZLcThlQTFPa2JkNEh6Zkpw?=
 =?utf-8?B?VUU2bm91MjJobjV5czlWNi9OVldzNk1oTlpjWjJHN0tNLzN0eFN0SFBqbnB0?=
 =?utf-8?B?c0ErRUtrTWF6aGUxYkpPeWRLR0x3UUUxS0FpU294N1lUakpteG0vYXFCMGt4?=
 =?utf-8?B?YW1BTEk2VER5MjEyLytZWjYwNnBjOFFxWTdUN2JjcVNxV25VcFV0aDFhUks0?=
 =?utf-8?B?cmg2QWIwUXg3N1l1a1BQMDRSSExsVFJXOWR5ZVU0bVBKTTdiUHUxWWw2MWdn?=
 =?utf-8?B?WW1ROEkyMHp6Z2crVXVDaVRBZTNYZ0JQaVpZekJnODFMemNOeTZlcnE3SDUv?=
 =?utf-8?B?MGpQR0xRVmF3WUdCZlM0MUJNejdyMUhLMFBPZWUxYU80OGJFODV1eWtPem9N?=
 =?utf-8?B?SFV3UC9BYk9TRWpiVlY3MHlTUWpkcEw2U2lKSVIzV0M0T1FFVkEyOExvMFRU?=
 =?utf-8?B?NW9WWFlGbWovOFl6bW1TVG1PNVNYVS92MWZlUjExVHRsRUdkUGNXTGxrQm5i?=
 =?utf-8?B?NWp4ckRzc25BdjluTGhYc2hpVXBPcVhMOExBODl4T3c4c25CMWQ5ZUE0dGJw?=
 =?utf-8?B?T1I0dHBMYkd3ZjV6cG9hSEZqSUtUUWxHN1plaFBUWEVCUWMvajFUTG5pcHZ1?=
 =?utf-8?B?b0hOalZIdVd0UmlVNVlPQkkxSXNkZFJoYm1iVTEzT2V6R1dYTjdkQXF3UXNh?=
 =?utf-8?B?eGVDL2NxM2dNVmRnVmlQVTZHUGpLeXJVK1RZZHNpdWJEZ1lkbEw4NXFUT1lR?=
 =?utf-8?B?L0t6SW01aHdsMS84c1F3NHNrU0tPQlRJcW5MdDNGVldqZnpQQUs5aDVKSTVV?=
 =?utf-8?B?RG8vYU42dDgzUml2emF2czlBQU91YXprUjBWYVdoVFR3eHNweThnM1NFakIz?=
 =?utf-8?B?UnB1OXRSZ0dpRHJBQ2ovVnNzeTh5WWd4QzVTRkYzVWY4b1dBNU8rSk1CVEZ1?=
 =?utf-8?B?bmdvWVYxdEFoWUlpMW9ZRkR4UnJyRkROckJIWEczT3d6VlVraTlSRHBVcDRS?=
 =?utf-8?B?QW4rN1c1cVVGU1E4aXBTRUZ6NFZMZXg3TkxVdEVWTnVzck0vNmgyK21ERzd0?=
 =?utf-8?B?T1hpT0VUdHFScER5L0piRnNuQnlyNzVVK0JMRzNYdzVGdW55aFIxcXl6M2FR?=
 =?utf-8?B?WFIwVjl3S3hob1NZN1dOQWw5SFZLMTk2Y05YZXRiQmkzVXovcUoxMVZ5Y3FJ?=
 =?utf-8?B?OGRndWdUNmJ5M1E5SkdLWHpoQzVnVnFubmpoQUQ1R0tQM2hCY0xRajhjNGZx?=
 =?utf-8?B?d3FDN3BveXNCN1lPV1RiSkR1MFBWSTdHcHBNL3pVRkhkTkVCOVM0Zz09?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff1d11-f157-4afe-1c38-08da37d6b132
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:27:26.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+htM7EoKnOpWlr/TjYK+dfJjCStA84uweWyDCW7HDymiycAJ2NtfSQglrcjKxKFCZCU/WuWg/+0OCoDoJCb7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2047
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKVGhl
IHR5cGVkZWZzIHUzMiBhbmQgdTY0IGFyZSBub3QgYXZhaWxhYmxlIGluIHVzZXJzcGFjZS4gVGh1
cyB1c2VyIGdldAphbiBlcnJvciBoZSB0cnkgdG8gdXNlIERNQV9CVUZfU0VUX05BTUVfQSBvciBE
TUFfQlVGX1NFVF9OQU1FX0I6CgogICAgJCBnY2MgLVdhbGwgICAtYyAtTU1EIC1jIC1vIGlvY3Rs
c19saXN0Lm8gaW9jdGxzX2xpc3QuYwogICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5j
bHVkZS94ODZfNjQtbGludXgtZ251L2FzbS9pb2N0bC5oOjEsCiAgICAgICAgICAgICAgICAgICAg
IGZyb20gL3Vzci9pbmNsdWRlL2xpbnV4L2lvY3RsLmg6NSwKICAgICAgICAgICAgICAgICAgICAg
ZnJvbSAvdXNyL2luY2x1ZGUvYXNtLWdlbmVyaWMvaW9jdGxzLmg6NSwKICAgICAgICAgICAgICAg
ICAgICAgZnJvbSBpb2N0bHNfbGlzdC5jOjExOgogICAgaW9jdGxzX2xpc3QuYzo0NjM6Mjk6IGVy
cm9yOiDigJh1MzLigJkgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbikKICAgICAg
NDYzIHwgICAgIHsgIkRNQV9CVUZfU0VUX05BTUVfQSIsIERNQV9CVUZfU0VUX05BTUVfQSwgLTEs
IC0xIH0sIC8vIGxpbnV4L2RtYS1idWYuaAogICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+CiAgICBpb2N0bHNfbGlzdC5jOjQ2NDoyOTogZXJy
b3I6IOKAmHU2NOKAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKQogICAgICA0
NjQgfCAgICAgeyAiRE1BX0JVRl9TRVRfTkFNRV9CIiwgRE1BX0JVRl9TRVRfTkFNRV9CLCAtMSwg
LTEgfSwgLy8gbGludXgvZG1hLWJ1Zi5oCiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KClRoZSBpc3N1ZSB3YXMgaW5pdGlhbGx5IHJlcG9y
dGVkIGhlcmVbMV0uCgpbMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9qZXJvbWUtcG91aWxsZXIvaW9j
dGwvcHVsbC8xNAoKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3Vp
bGxlckBzaWxhYnMuY29tPgotLS0KIGluY2x1ZGUvdWFwaS9saW51eC9kbWEtYnVmLmggfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2RtYS1idWYuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC9kbWEtYnVmLmgKaW5kZXggOGU0YTJjYTBiY2JmLi5iMTUyM2NiOGFiMzAgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC9kbWEtYnVmLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Rt
YS1idWYuaApAQCAtOTIsNyArOTIsNyBAQCBzdHJ1Y3QgZG1hX2J1Zl9zeW5jIHsKICAqIGJldHdl
ZW4gdGhlbSBpbiBhY3R1YWwgdWFwaSwgdGhleSdyZSBqdXN0IGRpZmZlcmVudCBudW1iZXJzLgog
ICovCiAjZGVmaW5lIERNQV9CVUZfU0VUX05BTUUJX0lPVyhETUFfQlVGX0JBU0UsIDEsIGNvbnN0
IGNoYXIgKikKLSNkZWZpbmUgRE1BX0JVRl9TRVRfTkFNRV9BCV9JT1coRE1BX0JVRl9CQVNFLCAx
LCB1MzIpCi0jZGVmaW5lIERNQV9CVUZfU0VUX05BTUVfQglfSU9XKERNQV9CVUZfQkFTRSwgMSwg
dTY0KQorI2RlZmluZSBETUFfQlVGX1NFVF9OQU1FX0EJX0lPVyhETUFfQlVGX0JBU0UsIDEsIF9f
dTMyKQorI2RlZmluZSBETUFfQlVGX1NFVF9OQU1FX0IJX0lPVyhETUFfQlVGX0JBU0UsIDEsIF9f
dTY0KQogCiAjZW5kaWYKLS0gCjIuMzUuMQoK
