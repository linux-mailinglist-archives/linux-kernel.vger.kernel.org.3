Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43348C692
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354352AbiALOyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:54:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52590 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354380AbiALOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:54:37 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CDNNma017606;
        Wed, 12 Jan 2022 14:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b7DiseFBTyr0CEacb4qIwLv6YS8rDPI3DX3oOQezmcY=;
 b=R7nGO3zzV8eoDfcgLBHpeMPse8daDlwj7AK7r4U0Nbwec7BStQCHKpn00thERKvd5sZO
 8u59+YtxWb/fnyyhdwLAKcCg5fbE8pnwnOEWt0KOGK/WXtpMH887JaZEqvB3OPpJ3XnL
 vW4oQ8Y9TOjee9c2YR0dhpr3AeKwUblwTSSTnAlXy/uoA8sLQ1SfwyepoQYAq6ySTgde
 FVoRHXVUNbdJhzOEhFHaltfbnjeZRsVQHwgAQYCm5fEopxFhrxb+6+vdYxJoFnLpZ2YK
 nKdBvVeL5Y+xEgc4xhRkjL1Olp9m4FkQEjhnG1jVtLv6KPSF2ZvFvr95WAdV4BLFvKIw ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbxrq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 14:54:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CEoC8C124274;
        Wed, 12 Jan 2022 14:54:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3deyr00u16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 14:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBfKvB82qAlfG6RuAIQ/dwUCFEuEPmL7AsSFCS2/I41KRjm/eCYGbCgIdcXicvuwnzxVJ1X/ctgP2rGkyABC9YPvYc5/bAXHnvvDTWvaNzDgKMz6xKm/BANFgkaDIngrs+p5vHGi+kwrQm30gMKa3SJZmjW9ryEcjbLFM22R4mFSqP4KhS/pTtAfZR2L+K9e2qy+9QcNq8uH1OjC+cFsl81mm7vDwXWrrYbVBrw4q5uTHOQ+O7PB7rhj63MCXGwamQ7A/+jkPMqF5w1xd0diJ9K77bAfiAiatGvmaY5QfsKVdTy2saqfsYntzDv+oLAmOeipi5WYmg64BEsX1YKrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7DiseFBTyr0CEacb4qIwLv6YS8rDPI3DX3oOQezmcY=;
 b=nVNQtwEaIB06E0qmi0dmWSblUONm4bxkc1kjYGEpjOa02gi5m+41uJxulGhlff5iI+GvXjRAz/Yp1ENvME0tnMiGBMCKXM47Qm3jEqu3q1dWKaspCobRYby2X0NhQ/Lr4qAne/Hj8Cb5ilrViw17DEBhqPMVr5cBRON2epcQvx3LWJO2z4OjBCKxqkBrrhj5g+OVWdcOxGbS3VnSPvXsTzi+nqrxt9ATskQG+iiHK8rjki6hEQ3L0pA1HMUSXLcQcMZfpe2YQvFyDz8bMAHUMc0v5ciLTe29kx/MlTm5N478KZL9gPEdSu0q83SujZfeFWv3wv/+3JfqBTakXDBT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7DiseFBTyr0CEacb4qIwLv6YS8rDPI3DX3oOQezmcY=;
 b=SGbS4S8gDtPLCRb46XaXmjbiDS19anVZuEPgQAKqcRp8XfpFOnVuKWaCUBJG/knIXVZAPewMbd1ipfn5XJCsBuO10EE3OgmOG1o04zZrG4OHtT/ueCj/5USiAlFgP9Wny/9klwL8lWXf7bDuMbhLEDK3pplvTXvrYbcGR09L83Q=
Received: from CH2PR10MB4008.namprd10.prod.outlook.com (2603:10b6:610:c::22)
 by MWHPR10MB1247.namprd10.prod.outlook.com (2603:10b6:301:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 14:54:08 +0000
Received: from CH2PR10MB4008.namprd10.prod.outlook.com
 ([fe80::8d2e:5ded:f45e:7563]) by CH2PR10MB4008.namprd10.prod.outlook.com
 ([fe80::8d2e:5ded:f45e:7563%5]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 14:54:08 +0000
Message-ID: <e4f20498-3685-207f-2b94-0cb0ada725a4@oracle.com>
Date:   Wed, 12 Jan 2022 15:54:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH v9 0/3] Add basic SoC support for mediatek mt8195
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org,
        chunfeng.yun@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220112114724.1953-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) To CH2PR10MB4008.namprd10.prod.outlook.com
 (2603:10b6:610:c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2accdc0c-6c67-4fe4-b8e8-08d9d5db62ea
X-MS-TrafficTypeDiagnostic: MWHPR10MB1247:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1247AD55800B36FF419CCF82FF529@MWHPR10MB1247.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBq7nsKuQwTWZrTt4ktySPS7gm6SbbFJdZRjThQHHw71s727yWJBHGy5Y1C85EljLCHpS+34jeiRILIBWepCqHQPjyr2jArKOkR8wndXUeI9oKmNgKnCbEublZR5bx4+nIMHuk3DZLA2QWM42ngjq5R8Z+oP+YdgL+JOS4ky1lXJJUolWjtsniBBKYVzsQmDmqoESxowVnBy29pvDoVvy+khRiLWjR/Q4zaCPDGP9j+mHsPbgp39f4xmq1JqOViQeayHbGajG+VhVZh+bTUm8lnx9TQHTrdp+xeTlwwKfgmKxKrfp9hC9+dWw/6zR7OUyTHtEQW9IB8siXN0WIQjtdh9/SWYTYXdbj5GC4L2eAkKbBzHZQ5k1cF+wbKonwRIPOzkuAVPHUi4Ua2M5CDfQVpubjzFMhtTM3PTaunVS5fJLm7sXm6Gp38rlTf51UKzQ2uS7xFafGJwxUC2skK9mi4mtXHn+TOKDMQ2BSh6Y33011kXk6G7uJerbZmsnrGVS59gFGXN9sAc/XYdSatuuo4M1hoA2okqnjuntPQKfI5oEZBqKMo5lkMiC7FBNW5QcJLihXOF9OQS/9G8lPNZTDBpRGLbGTGt8Xw4X2NGCpahWw/+7ZPwYXl8mbIFzclfJuCsbo5KGoprK5/hc/4Lm10R9HGEB1MglcclxeSFfK3kkedKIAuEivzWvJToE61A/Okb43EBTGSSe+FJeaQhr0h1/N7ps5XZkI9Mmyi4gBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4008.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(558084003)(7416002)(53546011)(8936002)(6512007)(86362001)(4326008)(508600001)(6486002)(31686004)(26005)(186003)(5660300002)(6916009)(31696002)(36756003)(8676002)(66946007)(66476007)(66556008)(6506007)(6666004)(54906003)(2616005)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVhQnVPeFYwallIU0JmOHEwMjhFeFpNaU0xdzR2VjQxeXFXWjRGa0Y0cE1h?=
 =?utf-8?B?cENIMlRqOHg5anZEWWUydlp2ZHJHVHI0QlNLek5IRmVGQWxJbFRzbm1nOHJo?=
 =?utf-8?B?NHl0QU5ieS9RcG9WNFEvT2J5TDEwdURkMUtLdko3NTl1bjNPc0Jab3Y2OFFu?=
 =?utf-8?B?RlRPQlVBd2ViTkdIL3dmaVViT0JUekRPbG1OZGJybjRCRHdDZ09xeWRjRWtp?=
 =?utf-8?B?YUI5bEV1UElyUm5GWHFkbThLYVdtVXFMTm4zeE1ndlR2UkRTSUkyUlV2SUk0?=
 =?utf-8?B?cFFLRm5kVElJUzI2VWNyWHUxMlRDVFVhOGtDVVV3YmxTSUdjZ3p0QUgvM0tO?=
 =?utf-8?B?NzVZZkQ5OWM3RWJ3dWpmOVQ0OVB6RjZvM2lCYU5qNDVPMnJnc2Jkd2dncXI0?=
 =?utf-8?B?UkpHaEhHWnlyOVZacGZVNkhqR0lDWmo3ZElQazNKdXB4a3RocTNTeWxPdy9M?=
 =?utf-8?B?ZXFwa0lmcDVnekk1K0xoZE43b1FSKzYzRzdVMll5ZCtqY1hMNmNsbkhSc1dY?=
 =?utf-8?B?MlpEUTNpaG0wcTdodEZLcmZra2UxZjlRd1p4RlZWclZJRm5lSVhoQ3dDU1hW?=
 =?utf-8?B?SWsydzg5UmZpa2ZFTEY5ZnJDSitxc3A4cWUzU1JWc1BvQ0NJcFdXZGthaDUv?=
 =?utf-8?B?bXUwNjFjeitOZU4rb0xQaVdjOVcxaTM1NzMxNVhzdE43Smd0WEVJV1lXK3lI?=
 =?utf-8?B?T085VFhUQVhnOTdlbGR5SmZKcElYUzFFTDhTcTgrclE4bktlcDdKZEltTzJm?=
 =?utf-8?B?RytpbkwvL25Zd05OUnNDOVp3aklDVlhFejRBV1lpNWxDajB5M2N0aExpMlhG?=
 =?utf-8?B?cFFsYWNvQk9Qbzk5RkZpT1VGWXNvQnpMTEdQZVpCcUtXQ053Si9CTytZbkRC?=
 =?utf-8?B?NG1WT3g2LzJLWm8vOGticXVCQldHaml2bmdYbTlzTEtiMWx4T2ljU1FNWXBR?=
 =?utf-8?B?ZXdtY2g5NTRpYmtNKzFxU0JFMEIwS2pjcnVtb3FOd2tqZkdSaE9xZUJ2Mytp?=
 =?utf-8?B?ZzNZRUJXbGFJN2FQK2xxYjRJNnRNS29mWW1GN3I3WXByRWRiLzA1UTZvdkxL?=
 =?utf-8?B?SW5ScnljeTRkcHFQZy84N0Q2YnNSaWZaR2VMT2ErT3BBRit5ZDB0OC82MWZa?=
 =?utf-8?B?TmxRZnhCYjh5a2lrc0U3ODZrNXdoSE1CWVcyYmtjNVhhN1ZTZU01MW52VFBt?=
 =?utf-8?B?MTlSUXZkMTdNb05wMldTYWNrd3BlSTdwMXh6NVk2OTdwbHV6VjdHVUFScnND?=
 =?utf-8?B?cTNJclpYNElKQUdPWnd4S29FbXRYajNYQnkxcFRLeUtRWkt4L2ZWRTBNV2RM?=
 =?utf-8?B?b1p6cTd3RXhNMS9pT3AyVzVmNUtKdEw3TGNUZ1V3OGZpdTFsZG94R2E4ZHBp?=
 =?utf-8?B?eVZuSmVmb2NoUFg4WUpIUG1vR2pBSCtaS0tTb1NWQVFaYisrRDRSK25YVmJO?=
 =?utf-8?B?dTRpNE94WmQvejVqL2ZVVDd1V3JJeGJ6d3AyZ1NXVGRsVjhUTnNDclNVMXlu?=
 =?utf-8?B?TjE2RXFNR3RaS0xkWFRKbURvSjVLNHMwS1UxdDVzeXdjYjZqNG9CMUlFL2VH?=
 =?utf-8?B?LzVDQ0t6NzNoYTFPV2xNQ1hkOE1IRHVzRGVYK1R6dkN3L1FzUnIwbENOcXJp?=
 =?utf-8?B?V1RwcVNVNVRsMzlieDE3Z3FxYXhZeHpTcFIvTGJFM1F5TzRtQWxXajhnMUxX?=
 =?utf-8?B?bVFVN2tvYmsvM0Q2Uk41L2tlZytlWWhCWWJGUWZXOFRjamZVTFVoTktoa3lu?=
 =?utf-8?B?ZTBDNHk0T1UrMWFOZmxrRTRtTlE0VzlWZ0hSd1JRQ3NQZWNPOS9sNjdiU2Jj?=
 =?utf-8?B?azByU1VEcVdRYWg2TmtDdUdUYzNnRm9LanR1RXdpeHh5QmIrWldOSURaZW9n?=
 =?utf-8?B?UGRvb0pJSDhYYW5hcGZDUkpvejRObjlwOFMxWkRkTmNFSUFFcnp3WXBXSUpa?=
 =?utf-8?B?ZEJpcHF2NVVHSHZKcDJaM0ZtUGxhSkZTNFRkSUxPdGp6ZTdoUkFyN1JCQjJQ?=
 =?utf-8?B?bXdSdEdick1aZjUrVTZnY0IyV1JLV29KMDZFZWxZRUZtMEo5NElPa01wRXdv?=
 =?utf-8?B?RDlQR1hwQXowL2tZQk94S2I2eFVQSFRKbld1VXVERm0xUlVLbHZiQ0Z4UzJU?=
 =?utf-8?B?SHVTREVsK2h5OExWZzkxLzZoSHpjZjZubmFwL1hwREUxQTlSQjFPSGdadjlL?=
 =?utf-8?B?Qy96WDhpVDROU1NsaFc1MEhmTEhlUzZHMDVwb3h6MU5zcE1UeDVwZnNYREdQ?=
 =?utf-8?B?aE5LclZOdVRnem5MeE5LWjlLMUpBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2accdc0c-6c67-4fe4-b8e8-08d9d5db62ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4008.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 14:54:08.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM/UGoR+/fsjDvnVowkCkNeEE4Bz7fH+UgnAcBah34EkMEyCViegROcZXEU+eTP3vn8fh1U2e9HVnwP7A2lf5Cj7dmeoujqFi0A5pybzCyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1247
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=980 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120097
X-Proofpoint-GUID: KRRqT9p3tBSiPA2StKas39EsCIz9diR6
X-Proofpoint-ORIG-GUID: KRRqT9p3tBSiPA2StKas39EsCIz9diR6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.2022 12:47, Tinghan Shen wrote:
> This series adds basic SoC support for Mediatek's SoC MT8195.

Nice patchset Tinghan, however I can't stop wondering why I was CCed on
it (and Paolo and Sean, too) - this isn't KVM related at all.

scripts/get_maintainer.pl going wild?

Thanks,
Maciej
