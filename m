Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5219484632
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiADQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:50:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7816 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233866AbiADQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:50:35 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GIi3K024995;
        Tue, 4 Jan 2022 16:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LSm8/DUPSG8upHzgbhLPCuOe8t9rjy9hqhLqxbvM8hE=;
 b=swbfuP9hCGKBkiCJ3CHqsRatYteYJJVvjjs6pxW6j7O2mhEq8U+wQLjeaCSFBeE9zD7H
 uaXc5xrr4Bm1hITKGWxqEx5ARhH8XANGUVoKPO7zo484u3YYICUifj0dWl9tMEnKk+IE
 lY2LGHeBXAcwPk1+9QuWOshM666SZdHoyX2yVZVlWHZjkPtNZtfjqfiVVPD+pudKvvvX
 he64PJI6IJlWl843NwrzPaWX7C9oee1z1J9Fh0P4YiUZScR1YLmm8XtqGXPuVoaMqBSS
 xo0iLiLu7LC0qKbJ9dI7NqyjlHnva6JMnJmGKeeMP5DGou6ux7QAkDiqoYjfkGHNpzst 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc43gapmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 16:50:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204GjFXV121871;
        Tue, 4 Jan 2022 16:50:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3dagdntpbx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 16:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C30dSZPZMeuLPPMW+DSY98kQVJ+Got8zA48PXEi/5ZDffalFmy7RVhbSj77BHv3ecdG4g6QBvEkgYph8LKGLgociTWDE5FyRWDEFMlXYnNu204BmNwFfmad82m582Ry1P8KDctovzyLRp1nZPlz3vKY3wHJsZpSX3+ZT4MaM+2PON57VUjfEVW6XW4iz6IdtbE7VVu24CYObAHmc3Mv+x99j8WCa8i1NQgKNicL0Gur7mEF2PkPp8k9OStdJeTTAnpTg7Fs4LeuuD/1TQtTv/CoylISovJ38pG+JD7Cl7Xi2aGH/uHoSvMO7VYI2PAk4j6lsEAPYeVuNQLMgabMuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSm8/DUPSG8upHzgbhLPCuOe8t9rjy9hqhLqxbvM8hE=;
 b=VIMH7CnayEX9who4WX8IKm+Nv84hJc9v0P0vOM8umly6p4UthEvZJA/YWUKz6TwJo3rCRtoAq7i8eWA2V8jlEpfUIxtijWiILyoDkBaKl4hpvoEPAuqUCqthhqVj4gqrxPLY5ohAuZVKO2Bl1ypI2D4AdtF5xR+1imM98BoJZ0L3/WxtXaMaN8xErzZaAmHCnxEDylez6MI686nT72D0qIM/nCLiQcHkSGjYTVBqC1TL429Nxg0wBJUiroHpdcIB3h7kkDifbUiwNgUMl4/F2naQFWLS61FgTelQEFQPp+hZhjrpLoPcGB/XW+Ea0bw5o49cnUwUF9Fox2LJ1JN9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSm8/DUPSG8upHzgbhLPCuOe8t9rjy9hqhLqxbvM8hE=;
 b=nmud01DBSx3D/UHblOYLega0w8RLdl/qsLUcZKoiSh7j3Yl/Gikd8QSyFmyzttumeq1Bk+ae8/tGRiD2NcuWL6Z9OcsI5Bxk8S41bTmWzCs4Fojw6o6pMHEfteHbrzqjSFpTsVZspGOmVCxx0uX+HrZfxxufmpLnhOGv/fN9+lo=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL3PR10MB5490.namprd10.prod.outlook.com (2603:10b6:208:33d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 16:50:26 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%5]) with mapi id 15.20.4867.007; Tue, 4 Jan 2022
 16:50:26 +0000
Message-ID: <bfab8ff9-9762-f90d-3f25-b57362f05b0b@oracle.com>
Date:   Tue, 4 Jan 2022 11:50:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] xen/x86: obtain upper 32 bits of video frame buffer
 address for Dom0
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a3df8bf3-d044-b7bb-3383-cd5239d6d4af@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <a3df8bf3-d044-b7bb-3383-cd5239d6d4af@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::19) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d027eec-2e90-467d-157b-08d9cfa24e9a
X-MS-TrafficTypeDiagnostic: BL3PR10MB5490:EE_
X-Microsoft-Antispam-PRVS: <BL3PR10MB5490462617DB807F0069368E8A4A9@BL3PR10MB5490.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZBkwflI6/BAoD/qqaXrl50gqSx+elX7UPRSlfQXqabxCpFAjdSs+4BIHH5X0kIvoy+BVB3bed1j9wxGNFKZ0alLOtkdYBFVzJsjy66luYu98VcPj8HcYXxILts9pjOqFYMs9E5joEWK0jBuNDS+IkrBopLTBwdqa/RUbNHOwoyb+UPrvVc4pV7SmmY7ylgpio0aeLvdJ59663Fn3H2nEpRowH0TU6BCwF0ibJSZ5GkRPdPoPmDdVrnhRCmlNhI4a02bbznE26SMhtZ4+TJx42r6hNE90auYTCi//ZBVojLAGipQvILInEn/grX1XTu5kmuu37UHiz5Vmk1T5cARbWjG2hxatiwMMP+EGLN+RHWIKO4tGwW/3EUEBdIbMlLx/xBvm0sJ9uUarVZxw0p2vYNtEmqxiOU5HDlyF7kWK8skmKs/SZSUjI5Ykn1xlINNOeOXWrE3R/UAeuyELXNduRzzpoEk4SL3osIKLZNusA7pv2x0UT7JdGTuQ0KzPxzWiWzkVq9lr8GZrQwaUL3WPR/4UPq3Kdbg3XruFlcpye9HHM4g6WlO0lpF1ED5o50MNAxjRXa3UTc06Wl14DfCF+6tcco+JVz0Xa4ESSPIzvKIaAd2KpdEh7ALS7vsG5jcoo1L7Tg7noxORQ6mrEGnuv7k66f8rfgO585/lO6ItQjPagqGPUR+CJxEXoUcXQ1uWMn/t5FHZKuWDTqUgEneBOR8o+PB5OyaIwZzrt3acVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(54906003)(6506007)(4326008)(66476007)(6512007)(110136005)(66946007)(53546011)(6486002)(66556008)(6666004)(26005)(86362001)(316002)(2906002)(5660300002)(186003)(2616005)(44832011)(38100700002)(83380400001)(31696002)(36756003)(8936002)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNhMkpjMExsY1hpOUgvMnhyZ1dyNHRtZklOWWVHQnp0cVM4aEhTV2ptdTVS?=
 =?utf-8?B?MVJ6MVBUMWhEbU5BU09XZUdrTkphSUNnS1RpcmwrSVNjT1QxbDNEUWh0dW13?=
 =?utf-8?B?dEpWajU1amxFanNUdFdJZzJ0RHprSm1KS1dadWlpaVgvNlRPUzhHRThRditN?=
 =?utf-8?B?dWx6Y2tzOUFrQUZPL2dGb2NBbEV0RlJEUldWUFdUaklBUGRnNmM0L1had3hB?=
 =?utf-8?B?NjJoMmVjLzhIdWo1dmNZUldZMkRYb21uUzlOSEY1Zm9PeXZLM3BvUzkzV09t?=
 =?utf-8?B?YXdFc085SjVtZmYwd1RIOE51aTVxbUZIeWZBWVVxNzRBOWlFY1hsVldJQ1lV?=
 =?utf-8?B?LzB2K1ZrTUdzT0lLeG9vd3VFUEM0SEZhUlN1S1FKczRneU5MNk9hUTV0aHRL?=
 =?utf-8?B?MkpoNFNsZmx3K25oZGhZMVZYWFRtbTRBN3hXWkh4NDd3VFBURnVRR1ZPVFlY?=
 =?utf-8?B?U3BTS090ZWszRk9tQkJyWjBibGtNbFVKRDBreEoyWWxidHE5K1B2RjRGWkJ3?=
 =?utf-8?B?UktBR2E1QUdibi84U3MrWDBVcEM5NGs4NlhENkdDMnN5cUZkN3dScnVnakRR?=
 =?utf-8?B?elNVeGpPUnNicTgwN01qaE56MVY4QVdtYllzZ1JIZ2RSdy9hU01jZzdnaG9W?=
 =?utf-8?B?SWpRd2xrU3FBU2Rlc0sraVU5NkgrejhQSVVwSXcwS0JvczhWV3BLQUJHZHdM?=
 =?utf-8?B?dXhESGRZei9VRW1qS2VveHZzWGRNOVhXK3AyYWlzQjdUT1gxbG9HVG5JM1Za?=
 =?utf-8?B?VlllQk90T2E0R21HNkI5bzBETXJ1VXNLU0Z5MndoUk1QVkl2UlZzS2FMNjB6?=
 =?utf-8?B?SzhzazBpdy93QXBRbXlzamZtY05QWlpCYUhuMXNXWXFRcGQwZ2VRc3Z6am1o?=
 =?utf-8?B?MnRoNENKWmNvOGlxcVprdlc5dVd0a2NOYWNXZTJYcy9RVk93emZFN3l5cE5I?=
 =?utf-8?B?WXFzYTlZOG5BSytvY0lseGdtV3U2UjRweDNnMXYrd1cvaVluOVJldzE1V1Y2?=
 =?utf-8?B?OGNDOWpLMGlOMVA5VHB3eTA2cWtaMjdsZWZmSDhEYmg1U2hERW82RHFFSjNi?=
 =?utf-8?B?c09WR256aDFXU1dvMW1zN1B6Rmx6eXJ0NStGOVJOWkJvYi9YMmluQkJtRmwv?=
 =?utf-8?B?TXpwN1l1c1lOclp3TCtxOUJ6a3lZeWV4aVY4QmtZNDgwK2IrcEoxMHZWeVo2?=
 =?utf-8?B?Sjl0NlJYc0Y5SW5UT2NmQ2wwK013SFRxdjcxWG9MRjcwZ1VpN21kdFBFTi9U?=
 =?utf-8?B?YzZNRFZCbDBtSU13a21IS1Juamc0LzlTRi9Edjh4enNDRVkvQW13R2VhS011?=
 =?utf-8?B?YjZtZGFiWUo3ai9CS0pMdGFCdUFRQk5mZ2lkNXBRelpiYlBYMjJYVHlPRHlE?=
 =?utf-8?B?aG1kV3Q4Zmk5YUtCVVpKWVZURmVNRFFoc0UyMllOVHgrNDFOc05DRFdmdUxX?=
 =?utf-8?B?S2lJWmN6SkM4ZHB2YTU4QlA0YTBmaDVJckRHbTVuajg1TDArdU9aZi94aDJv?=
 =?utf-8?B?eENZME82dDZaWUpTbHd6b1FuYmc0MExqN1dEYVlQWWNQMmFZTHpmcnpCWlp1?=
 =?utf-8?B?T0g0bnlYekN0NmltNGQ2MTBKSWU3SmhqV0c0MG9TYVlSc3lDMDhRVllraDBQ?=
 =?utf-8?B?Z21HSDV3U1BZWENnUkFxUzJoK1hxL0VNTHhmTGJoTGV0YVMwR2hVU2pvOEJ6?=
 =?utf-8?B?UDY3SkkrQ3VoZmtyVVhpOWNJdHo5bUZBeTBMdTFleTNEUTRvQzBadEg0bEEw?=
 =?utf-8?B?dmlWOElkajJYODlVVkwyRzJ3cmV2OFhQbG9zbWRTSlFkSzVsTnVrOTR3aEpP?=
 =?utf-8?B?WkswenV0Mm0zS0Y4aTJ0NWVtdVVuZXZnczhVc2dzdG96Q0t1VXdDMkl0Qm0z?=
 =?utf-8?B?VDhXOVN4NmFVTzV3L2hqa2hIMlZhTzZTRzFlTjFTTCtLVjJSMnNMODF6WlpU?=
 =?utf-8?B?YWRiRnlvVXlPMEllaTNad1FaM2U3aEdYVEJhSC93NHN6ZURpMUVzc1kxVDdC?=
 =?utf-8?B?ZExIMjI3Y0xLU25XY1hOMlQzYWJBZTV5NGZpejBmRzNla05DU3ptRXhZMTdV?=
 =?utf-8?B?UjZxcXZBUkp4V0VyYm5lZXhqQmRmb1h4RE0yZkdUc05aeTVTU2lGcUozYm9Q?=
 =?utf-8?B?MjQwZVVtR25Xb2tpM1lZZmtOUDR5Sy9JSzFzRGlHNjAyVlBrNW8zNVcvQ1RO?=
 =?utf-8?B?UTdjdlRmb3BtbFFMNFlLeldyRnZHUjBBeDBXbXdYK2U5OGVGLzZ1aFZVNzJs?=
 =?utf-8?B?UnR6VmNIak15TDJhVVA4TVdwWnl3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d027eec-2e90-467d-157b-08d9cfa24e9a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 16:50:26.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1FaVmXzCoYtW+g5RDBlNdsHBzdxoC4ZB/sC7RZzvfUeUgn+/mwb0i/+KOwcIOu9qr8H0517aJUwGjXVlPYqf+Qxgc/pGX5NR+JMkBZgWto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB5490
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040112
X-Proofpoint-GUID: Bzxdp1i6hjReWpYNrkpE-MOAd0IZ6enC
X-Proofpoint-ORIG-GUID: Bzxdp1i6hjReWpYNrkpE-MOAd0IZ6enC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/22 3:46 AM, Jan Beulich wrote:
> The hypervisor has been supplying this information for a couple of major
> releases. Make use of it. The need to set a flag in the capabilities
> field also points out that the prior setting of that field from the
> hypervisor interface's gbl_caps one was wrong, so that code gets deleted
> (there's also no equivalent of this in native boot code).
>
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>
> --- a/arch/x86/xen/vga.c
> +++ b/arch/x86/xen/vga.c
> @@ -63,13 +63,17 @@ void __init xen_init_vga(const struct do
>   		}
>   
>   		if (size >= offsetof(struct dom0_vga_console_info,
> -				     u.vesa_lfb.gbl_caps)
> -		    + sizeof(info->u.vesa_lfb.gbl_caps))
> -			screen_info->capabilities = info->u.vesa_lfb.gbl_caps;
> -		if (size >= offsetof(struct dom0_vga_console_info,
>   				     u.vesa_lfb.mode_attrs)
>   		    + sizeof(info->u.vesa_lfb.mode_attrs))


Do we still need this test? All 4.0+ hypervisors will have mode_attrs.


-boris



>   			screen_info->vesa_attributes = info->u.vesa_lfb.mode_attrs;
> +
> +		if (size >= offsetof(struct dom0_vga_console_info,
> +				     u.vesa_lfb.ext_lfb_base)
> +		    + sizeof(info->u.vesa_lfb.ext_lfb_base)
> +		    && info->u.vesa_lfb.ext_lfb_base) {
> +			screen_info->ext_lfb_base = info->u.vesa_lfb.ext_lfb_base;
> +			screen_info->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
> +		}
>   		break;
>   	}
>   }
> --- a/include/xen/interface/xen.h
> +++ b/include/xen/interface/xen.h
> @@ -722,6 +722,9 @@ struct dom0_vga_console_info {
>   			uint32_t gbl_caps;
>   			/* Mode attributes (offset 0x0, VESA command 0x4f01). */
>   			uint16_t mode_attrs;
> +			uint16_t pad;
> +			/* high 32 bits of lfb_base */
> +			uint32_t ext_lfb_base;
>   		} vesa_lfb;
>   	} u;
>   };
>
