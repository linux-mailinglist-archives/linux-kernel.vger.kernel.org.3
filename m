Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E66467F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358002AbhLCVIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:08:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38120 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235379AbhLCVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:08:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3JjNpj014831;
        Fri, 3 Dec 2021 21:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=szOXj5f+2qZZfgQ73vq4k3ILmT/WdvXYPwEh83QnMX4=;
 b=JMwdHivr5FWAi7Uu9E6o9YNuwBpMRm2UvudrV+uUe3XKJR6Z3/xsuE/grlkNFEwvsr+i
 8ms12eRjl8jhu3PJckncLW0WeRxdt7RuhO1r2IF6AJy5gzlgif7+EoUtywF88GRTYwUF
 kly65p4XNZHBWE3elbCeHXuaeWtLAuft+wTcN/JEVnxCAan83kIOZwMSx1XtYaxRYUtw
 D+pNkgqRfvAHMNnXYGcxKpi9tqszxGj7gODxbUqagmHmvapcpGEzFdi8QZXTiY12Vwwo
 yq0CmDfmUjADYxtEhDiUX726/r0V3Caczic72YvXzn7bVBXmZbpcb7ETp6lOg8dNGn7Q Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqkx5jydh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 21:04:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3Kfnkh196003;
        Fri, 3 Dec 2021 21:04:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3ckaqmtrjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 21:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN1RXX94Y1twwFEPXgO7MFBiVpOpY8nSPPS+XvbSmXrSitLiJfxd9Bz6YlJLPdQ4EPeOAscccIM5Er+LJ8kVcMB6k6/tYBpPBYgLzMWcylxQVwwzvKm0P3KgW9eHTO+xnili/eP0ansq03UPJ0Ldm582Ngyr3a02trfIvEjfg0RA/Q64zQDANeCijRxwGdGIk5SLDMhPD4+oiNHlSEZy3DfR4I0DhORXwaccNBbzFoG7OaFzMJ6ao+/Wt9M8HRI5A7Zqr3ulxhzzyq9Q9h3DmtNbSHR7fiLRZ0am5Jh7n5DlZQ2rD/xMcR01uN91RAsYWk5XKW0BIY/CeS9fJGrm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szOXj5f+2qZZfgQ73vq4k3ILmT/WdvXYPwEh83QnMX4=;
 b=QMc0tkb48IP5cQL7CwAVYv0QSpfwxuXR1z3gBazjABo4wKvmyXaKDOV9/vHfX+u1iB9lNt5VlaSA+uMIbZ50zr3JhNYNzAzGq1LWT3yYvvjg/lLLRrUHobAHJ8ac7v6Of+HvK3SVlqcZKhO1gW2kN2EpgdfsXTcuxdwU7XRBrJQiZiaSz3Di0WKRr54t/30w9cUuOfU+SOPOMWg6350Vrrax42asF6RBQrjWnoUrSeiOJ/xtYuzKoW8leeAqs0Xb42S3siP4/PCu92CK8O/39FS1YWIt+psAe/1w7vFeDLlh4IvuNs+EdqtUs8Xl/QjAqhI44bS+cU8L7T3m7yK4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szOXj5f+2qZZfgQ73vq4k3ILmT/WdvXYPwEh83QnMX4=;
 b=t7EiTie8iKJ7hsLMSoo9B1QM1SN+HDxJqBfmvCPAsnXkMZx/VHxYLsRcXgaSFSTeddszgEnBfq554OAwyfnrHm0kcB8KTR/jGwmxVCC8TBqzDg1A4+ByfaAxDFIosJ5oGNQXQGY8W//ektNfmdz9PQVVW4s0Oi7kWunV6nxKnvE=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4192.namprd10.prod.outlook.com (2603:10b6:208:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 21:04:19 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%4]) with mapi id 15.20.4755.015; Fri, 3 Dec 2021
 21:04:18 +0000
Message-ID: <a6dd44e2-6ea6-d085-0131-1e9bac49461a@oracle.com>
Date:   Fri, 3 Dec 2021 16:04:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
 <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
 <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
 <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
 <3d71577f-dabe-6e1a-4b03-2a44f304b702@wanadoo.fr>
 <863f2cddacac590d581cda09d548ee0a652df8a1.camel@perches.com>
 <1e9291c6-48bb-88e5-37dc-f604cfa4c4db@wanadoo.fr>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1e9291c6-48bb-88e5-37dc-f604cfa4c4db@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.107.202] (138.3.200.10) by SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 3 Dec 2021 21:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea824a3-aec1-47d1-7fdd-08d9b6a078c1
X-MS-TrafficTypeDiagnostic: MN2PR10MB4192:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4192EF91F93A39FF9F2FA4648A6A9@MN2PR10MB4192.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2q2/OxiAY+BiE5VhtOTWyR5uk+ZDPIgNcN1hyaen02kq+SOUdITYYl6uOWar4OsULYDdcqx29S3G1Odni39prgCO2gsiKnkau7g7b0SZsRuyjVyyyVE6WfVmcleL0kNlD9zJfW1eKlskAglenPFNTw7iWPdvmWDZrNqCtB0g0WxMSm9ecBtINmO/T2lu/62Tvp6yOA5WqgZHkJyX9cpYeS4kyOaVvtfN0UsKXRSxGqPvMInlM0ku1+ONLYXIt/0HVO7fFy8PR9N7U47h5MIz3FlH/jAaAgKi+H0USPlm3n83TVg7tMbBgNjowkiG1GvW7FBCFhcVrETVghnYvdCoShp1OifqdRZ4g4H+jK6LVErrHoK2tkOv15Xf9HjfYLO2HR+flbEYPvil4tJWbbgi68hamau+y1eI5m8FMHHRFmlYtungeBY4lVBSxDF6aO1xATkkFo95bgSteu6W6wP2WqyUXLrZhq3gxI7Gsr+O1PcVrSRw1ucgYsTBCVMBrc/2IcpBP24LjB/HClGYIEQgw/bcsxNjE6k0oYyvEUF+A1cu4+CicUExe9KsCuvzeor6AILdT8XKCu6UpsZqcYZWL+y9EMa9w0IoNpYtYHLhr3z/ddOgh6rBAhbVoVxr7MoVJENYg3zauFeJk4l8HCjKeI7bgvguqIJtJtYep8IEDchlZI5Mm1SaRK5eZYa5X3SgWo0c2/lW4kBHn/OKp1tQ2N5B/mhbi5KPew1fXbsBetdWX36EHqkUFq91Od0Z4XZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66574015)(4326008)(26005)(316002)(8936002)(86362001)(44832011)(2906002)(16576012)(508600001)(8676002)(7416002)(36756003)(110136005)(38100700002)(6666004)(66476007)(66946007)(31686004)(2616005)(956004)(66556008)(31696002)(5660300002)(186003)(83380400001)(6486002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3VySmtaRHpGQ0d3a3h5U0Nqck4rVzJ4TGJCUzg4STAzeGwreFdGOGV6QzA1?=
 =?utf-8?B?bUhMMUhBUlg5OXFaRU91cDJxb2xZR0RxT3NubTVVM1VDNkJaVzlGaXFXanlU?=
 =?utf-8?B?c2NtZlNIejQwY2dQNy9reStmUFBvQ0l5MmpRNFFCN0JmK0MzQlAzK3NRcDBK?=
 =?utf-8?B?WENKY0ZDVjRheWl6dklOdmhjaHltTDhzN2Nqa0pCeFRqUVZraDRyUDNOS0Rw?=
 =?utf-8?B?NEN4dll1NXoycWFxRFd1emR3S2RVNjRGZDhEdWVrRG4xYXNscFozd2ZJTDJv?=
 =?utf-8?B?SVM3d0tnRTJ4RkUvTVBWY1BCaHNNS1NUeWpZS2xYOTlodVBETythYzlCdEp0?=
 =?utf-8?B?SDFTMDQvekpkWWI3UGp2RDlSTDhmL2xQK1FYZG1GVmJENFMzN2oydmdiT053?=
 =?utf-8?B?b3FJUlBMdkM0djJ3dkdFTEVZekhMNG9tTFVJaGZzQWhweXRnRStLbGhLS0lT?=
 =?utf-8?B?SFdJSXZXMFpIQkp5NldCZUo0Zjk4eTlVUDBHL3BacUpBY2x4blNsclV3Qy8x?=
 =?utf-8?B?djlQTDNtb2dBWDVWRG9FY2dta1ZMK0NsQkdXS05saFlSY0lYV2JJdzgwclhD?=
 =?utf-8?B?cS9yeFBqc0wvNDZKRUFKSGVEN3FBeEhXNWZ6Ukg4MkZNYTRTeEErckhYT0k2?=
 =?utf-8?B?YWgwRm15U3FlV0FnT1dPRmNFZUN4clVrMURDNUIydEovaGxoVGJZVzZ4SjU3?=
 =?utf-8?B?TXYyMDRKeEtqUmFxR0tlRkJYNjAzR0xQZFUzWStoaFROb2FUeHFtU2VoeHRw?=
 =?utf-8?B?a1M1c1FQb2hJb2c1aTdpTUg3TlVJSmRnZ09tREF4TklhZUVBc1F1MWF6Z3Jn?=
 =?utf-8?B?NUQvQ1ozeThVQUcwVEQxc3dNZEppVEJOWXVyU1RrRDRYNjVSUWNvSmJ5eEJ1?=
 =?utf-8?B?R0d0VFVVVDd5YlErMll3TmYwbUtheC9Ka2NqRVFjaEM2bDk0TWdXc2xMNTE3?=
 =?utf-8?B?VGJ3ZEhVWkhYM1E1SXhHTjIxOXA3a2dWQlRJZjQ0Qytuc0htUkxkU1VSZVBX?=
 =?utf-8?B?Z3ZFMThlUFVvZmlKbVA2a0locU4ydlBiUWtSVFJoNmZLUWpBcTRTMkVaMnV5?=
 =?utf-8?B?cUJqeFNtMmdOSWMvQ3QrdzFkZnFRWXY1UWxmYlJXemY0cDQ0eGd5b2ZnclJs?=
 =?utf-8?B?RjBjcDNFWWdnNXhUL2U2VGJOQXdIR2FENVBHY0RGbGhDbW1FV0MrZDRSYUpC?=
 =?utf-8?B?Z04wMllyQUV0c1h2Mjl6dXlYN1RJUnpCTFZHdlc2WGQ0cWtUeDVJam5OV3Zy?=
 =?utf-8?B?cllVREZxc0U0clJOaDJMNzlsdEhlOEEzQXA1c3JwUUM3elluSnBFNFJJK21H?=
 =?utf-8?B?cnRNbjBVUXRXWm9nUFpaRG5JTGFwUFIyK0dWRTI4VUVUdnhObWVHalJNbjlr?=
 =?utf-8?B?bHV3Y1UrMWZUK0xudHF3c2ljWGNIWDBJWCtneHpkZVRabWl6SHlIV1J0dFNC?=
 =?utf-8?B?QnliMGNiZzFYTVF3NSswT1ltUHJSQkJNT1BCbDk0VitUazZLQWpoNUh0djRK?=
 =?utf-8?B?VVJzZzlCRjlzeEJkR2crbitDUDIyd1oybnBiOURoc09SSkk1eVVxWWhOMWVr?=
 =?utf-8?B?RXVjbHRYZDBSN0pobnkxM3h1bW1od0UzellST2ZqbVYrVEhkd2xuVWVYQ1N4?=
 =?utf-8?B?WXpnOHh4MDNzSmhkNDhacDFkTnNsWVY1ZDN0eExPbFZ5cDJzWUVrVXI0THI1?=
 =?utf-8?B?b2V2RVdudjdxWXhZQXRqL1YweVo0YkRnejN0TE80b0xVSGVMdHIxakFCVURr?=
 =?utf-8?B?WXNBdjRZSGhVRE05KzgrNzR0NDhKVW9icUpjWlB4MFd1OStXRzlac2hWM3FT?=
 =?utf-8?B?SytaTnJFSmpTektYRlVNcmtJRW1ReDBhazFlR3pzNDJ0ZW5xWXNaNVBwYjNM?=
 =?utf-8?B?MTJvYmg1UlpIb2I3NEc3Uk9oVHVYWFFJZjlIaHJkSnBKVGtpaFZWWnVYUDht?=
 =?utf-8?B?WEhUMGY5WGNOQjhsaVQzT0YyZmV4eXRId3FCV1FvcVJ6MzRYc09Sb3FIRUp3?=
 =?utf-8?B?cWhQNWhWSDRUTndvOGNWUUFkaDVTMzFBTmF2YzJUVkltaHl6QWRPbkhGRkFL?=
 =?utf-8?B?L1pCaGFhYnVEWGZkZGRtRGhKYUZ4SkdjZ2JVd0NoazFORS9TU3NjUzUzL3Rn?=
 =?utf-8?B?bDNNL2RSa2pSUkpQV1Vac2x3Wm9kNVhlTTExbUZ2dVVoMlBmdVFwSHhxVGdB?=
 =?utf-8?B?N3hjVVNsUTg4RjY4c2kyaUN0K09wM2RENHdjWStVY05jeUVFVVA0c0IwZWRx?=
 =?utf-8?Q?MlODytgP7Ek76mPPH0cvDlypGQhrqVRRxlEP1jzUiI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea824a3-aec1-47d1-7fdd-08d9b6a078c1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:04:18.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjCh/p+jwiH28u3dulEacD0hwO1CubbnGss8XBo/JG9q5eZHT3GTwLhc7pay1MBABOc3puHV3zee4R2StHsdoZuX+PAqN9OO69Cmo6JQ+80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4192
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10187 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030133
X-Proofpoint-GUID: K1yRVTY7jyhcxZSyIV47rN2jvdC2qh4u
X-Proofpoint-ORIG-GUID: K1yRVTY7jyhcxZSyIV47rN2jvdC2qh4u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/21 10:54 AM, Christophe JAILLET wrote:
> Le 03/12/2021 à 04:03, Joe Perches a écrit :
>> On Thu, 2021-12-02 at 20:07 +0100, Christophe JAILLET wrote:
>>> Le 02/12/2021 à 19:16, Joe Perches a écrit :
>>>> On Thu, 2021-12-02 at 19:12 +0100, Christophe JAILLET wrote:
>>>>> Le 02/12/2021 à 07:12, Juergen Gross a écrit :
>>>>>> On 01.12.21 22:10, Christophe JAILLET wrote:
>>>>>>> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid
>>>>>>> some open-coded arithmetic in allocator arguments.
>>>>>>>
>>>>>>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>>>>>>> consistency.
>>>>>>>
>>>>>>> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
>>>> []
>>>>>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>>>> []
>>>>>>> @@ -442,16 +442,14 @@ static int xlbd_reserve_minors(unsigned int
>>>>>>> minor, unsigned int nr)
>>>>>>>         if (end > nr_minors) {
>>>>>>>             unsigned long *bitmap, *old;
>>>>>>> -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
>>>>>>> -                 GFP_KERNEL);
>>>>>>> +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
>>>>>>>             if (bitmap == NULL)
>>>>>>>                 return -ENOMEM;
>>>>>>>             spin_lock(&minor_lock);
>>>>>>>             if (end > nr_minors) {
>>>>>>>                 old = minors;
>>>>>>> -            memcpy(bitmap, minors,
>>>>>>> -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
>>>>>>> +            bitmap_copy(bitmap, minors, nr_minors);
>>>>>>>                 minors = bitmap;
>>>>>>>                 nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
>>>>
>>>>         nr_minors = end;
>>>> ?
>>>>
>>>
>>> No,
>>> My understanding of the code is that if we lack space (end > nr_minors),
>>> we need to allocate more. In such a case, we want to keep track of what
>>> we have allocated, not what we needed.
>>> The "padding" bits in the "long align" allocation, can be used later.
>>
>>>
>>> first call
>>> ----------
>>> end = 65
>>> nr_minors = 63
>>>
>>> --> we need some space
>>> --> we allocate 2 longs = 128 bits
>>> --> we now use 65 bits of these 128 bits
>>
>> or 96, 32 or 64 bit longs remember.
>
> 32 and 64 for sure, but I was not aware of 96. On which arch?
>
>>
>>>
>>> new call
>>> --------
>>> end = 68
>>> nr_minors = 128 (from previous call)
>>
>> The initial allocation is now bitmap_zalloc which
>> specifies only bits and the nr_minors is then in
>> BITS_TO_LONGS(bits) * BITS_PER_LONG
>>
>> Perhaps that assumes too much about the internal
>> implementation of bitmap_alloc
>>
>>
>
> I get your point now, and I agree with you.
>
> Maybe something as what is done in mc-entity.c?
> Explicitly require more bits (which will be allocated anyway), instead of taking advantage (read "hoping") that it will be done.
>
> Could be:
>
> @@ -440,26 +440,25 @@ static int xlbd_reserve_minors(unsigned int minor, unsigned int nr)
>      int rc;
>
>      if (end > nr_minors) {
>          unsigned long *bitmap, *old;
>
> -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
> -                 GFP_KERNEL);
> +        end = ALIGN(end, BITS_PER_LONG);
> +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
>          if (bitmap == NULL)
>              return -ENOMEM;
>
>          spin_lock(&minor_lock);
>          if (end > nr_minors) {
>              old = minors;
> -            memcpy(bitmap, minors,
> -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
> +            bitmap_copy(bitmap, minors, nr_minors);
>              minors = bitmap;
> -            nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
> +            nr_minors = end;
>          } else
>              old = bitmap;
>          spin_unlock(&minor_lock);
> -        kfree(old);
> +        bitmap_free(old);
>      }
>
>      spin_lock(&minor_lock);
>      if (find_next_bit(minors, end, minor) >= end) {


I don't think this will work anymore, we may now fail if another thread gets a minor above the original (i.e. no aligned) @end.


-boris


> bitmap_set(minors, minor, nr);
> @@ -2608,11 +2607,11 @@ static void __exit xlblk_exit(void)
>  {
>      cancel_delayed_work_sync(&blkfront_work);
>
>      xenbus_unregister_driver(&blkfront_driver);
>      unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
> -    kfree(minors);
> +    bitmap_free(minors);
>  }
>  module_exit(xlblk_exit);
>
>  MODULE_DESCRIPTION("Xen virtual block device frontend");
>  MODULE_LICENSE("GPL");
>
>
