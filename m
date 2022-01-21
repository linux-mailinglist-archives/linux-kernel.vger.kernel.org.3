Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3B496657
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiAUUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:30:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232988AbiAUUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:30:35 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LKQjbJ006864;
        Fri, 21 Jan 2022 20:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GK2U+f7Rak4OEWs4JPIMfYxvZn6ErrJjPCqN3zuRB3M=;
 b=x2o7CPUk21GzJZUJyfvcs9+1TcIZvCNw7oIKnnDCxQgWxuHHB8Y73DSJeeCa0/U5GjLl
 QYUTntf9ad19mFvWGsnswaLKgHQYhToEHorpaE8O6NpyyaYKVfvNQbhbb6gCxtOd7fY4
 AwNyNCpu1o3ZhJeVz+z4AFtaQkNwjIvBP/wy5LfPFjkDpKBjHoEP4u5zqXR/l8SwE8C+
 220vhyQaZwE+Z6k8xISkqhLNgI1pnN8ixEMdyl78jXu+CnUnV24eZI1ZyJNTOYFGSrGq
 h/aibuFWx+ka5XU5vrOeYdbefawuW/ficN8wmzBn9MA+ARtnZ/AOPcVykwkc4RRZ0ayj dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhybah5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 20:30:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LKGjPx135544;
        Fri, 21 Jan 2022 20:30:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3dqj0wfby5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 20:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRCKA4iqQgI6n77wAMoEkmhm3qr2owIjgElUoX09H0dfE+6tRq6MfIUoeH9JlJYvXknRs32oLjMXkvM3sAWZyiwUNCRqLuZykVePed8VMt2NGgIi7vw9fbIIzMEIGPv+bOXEVKJDiOT9t8N9g/ga9C46Knej1qSTXLajg/de8NVl7FcpqtuyfXbusnfuxN/Mpi21n+PnwY0bfV/KG6SMu8pT0aNWiWfIINOA1lBVN3/IsxCyCN+ay0Q0a7ZjtpAT3GEtzmwp38ZJH73ZPq5PxRLKv6sdq8RLoGekIuBfAg7T2wpOXDYmlCPmGp9RxYqGGiBzJ3njFo0NlhzROjDwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK2U+f7Rak4OEWs4JPIMfYxvZn6ErrJjPCqN3zuRB3M=;
 b=lALVBVoKFg5+b76b3y4SoCZVOFJ9VQpmLKYfRSBCVjULCs8UG3d0gdrTMi3AvqdwDOimukWuNMZDJkh8e4YQS0Z/rHuLKnIr++j+tZrtO8+K2gglV3Evcggb9EB4s/jGrd3Qt/8KLZjXNJkDOD71BNVG8n4kypaCAwhSR2f/8eOxrzm7zPu1lMi800vYOpB4Vch9bJB4Wj17M32CanThExtTUQgP/x9jQAUqQJNqYEF2l1kMBR8FAK2n6Yme3Sy1gTsg09sxXpAMr4hgcK95gJV7hWqZbzOkcmchHaeDHd848E1isBwS6+kyJ288m315g0CQLx7hIwtzxl2HjSuN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK2U+f7Rak4OEWs4JPIMfYxvZn6ErrJjPCqN3zuRB3M=;
 b=VYYh6D3iSsSTWrgOmRur6feDDBrABk4qWRejLpl5358vDOO+aRmptixj4JqgmntlYztXZiwFhNynukSw4Ft+PjPAhWrU8TUA19Exj2+Fi+o/B7rLxIfMiDM4nS0sc0w20wtYmEuQPC33WX5rKIcaOLfQtwxyaX9mXher2GV5WxU=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SN6PR10MB2798.namprd10.prod.outlook.com (2603:10b6:805:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 20:30:13 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::d914:c494:66ac:a5b1]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::d914:c494:66ac:a5b1%8]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 20:30:13 +0000
Message-ID: <533df35d-fc61-e196-f01f-01da5294440f@oracle.com>
Date:   Fri, 21 Jan 2022 15:30:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] xen/x2apic: enable x2apic mode when supported for HVM
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <a34aff19-4530-7f44-c849-4b3eb2aa3d00@oracle.com>
 <20220121090146.13697-1-roger.pau@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220121090146.13697-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:806:d1::11) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5371b998-cfa6-4b57-8cff-08d9dd1cd3d7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2798:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2798DC75CE0A74F1B8CF1BE58A5B9@SN6PR10MB2798.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJpVM4mC9YLsSoIZOwkmzxUBJ7g0O7XTJMq+lGUfZT+93GIsNJEBZFh84ai4Eizx6J466d7W87EVIzg/p3GhhzMND6JIdgq/etPK3X/seftDul/dxmm0GwSDmg2wiFa/UlyS7k9DRSF/X5IunIVdm+oDTzGPoIuEXkfVoXg5KPXTTmwFPY0WQYNxRTfm75wZSb0SxDx4Kirw0KOqAMGBsP2TL9PVeSD3zZ1sCljY0t4YEluQM0eWk8pTBBrH/4aCHQDoFwLe+2n7vEIxPQiitdqwU8mTiBKVmVU3jlZ2m5h17h2Mpi/YZhtgexd6dpr+EKN8qpV8V2IOd/n1C1mz+s0MtjKemzlZy/5cXG5qGNvko++JrcNpaLrYvLvOWeGrohh1iz36KSpCmC9d4+uj610DH+ByYtrasBgjjY/vwLKxhWu8WoJUqh4iBGPDFWx2EVXhJ4w4mW+L20clKCWBjIYGyIFxx4M92F4nIWEhRqUYn8U3jfhDpmsGZXoLkJqfL4npLT71kS6E5vbUIIR/1CcAwOeZzILp+LgBwu5yhmg2rdbD42eM6fwBIfTeTl4fRbmm93ogadmc5ubHSXTLP2J5ts0eEhqvTJkQOX/u9nxmodt+l9ktGii3IoSmpqxjBdpuyAJyCXtWVh/SCAuSnFSuFSV0gB+PvOLacRRCtt0v87YbzE9W+blQVbn/WmHJIL7XCUbo01NPRWSDk3hUO66pMWdIEekVwP/zqH/Nc9WGYwfW3domyRFhkI+HrLUr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(186003)(508600001)(86362001)(6506007)(53546011)(38100700002)(83380400001)(6512007)(26005)(4744005)(54906003)(2906002)(6486002)(2616005)(8676002)(44832011)(316002)(5660300002)(8936002)(4326008)(6666004)(66946007)(31696002)(66476007)(66556008)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9tZVVxNjd6eVRnT2xPb29wTWxWSmdRWDRvZm5KZVNBSHk5M1RSZEg0SzJa?=
 =?utf-8?B?L3FNQW1TU2gwaThqVkVVVDJWcnluN1RHWlQvcWNYOSt0SW02dHFRbFRDcnFZ?=
 =?utf-8?B?bmRCM2ZEY3hUVitxNXRTMGFPSHo3U1dMelVuaUpUT1A1ZEczaThmaW5jckdv?=
 =?utf-8?B?Qk5PTUFpMFpMRGFjbTFSem1wL0xkT1hDUnZDTE5uMlF3emUwejFENEFNMkpZ?=
 =?utf-8?B?T25MWXZ3N1IxcjVtNHRZM1hrNlVMVUhUVzJpc3poZXdsTEM0aXBLdUo1U25T?=
 =?utf-8?B?OS9CenZNZmY1K0RmaUFqRThRSjU1TGdtNjQ0WmF2QVN4bFI1SjZFYnQ3RlJm?=
 =?utf-8?B?Y0VOUWRlUWwxejVtZndsdTY3cUZzdTZXWGFObmkrblJkcTBjSTkvZkMxSUl4?=
 =?utf-8?B?WVVZaytXYTdjNG55K1RmSjcvMnpxUEJham0yUlVqUFpRYkw1SFVHMURjMVNW?=
 =?utf-8?B?bkpUYmlBZ01pcFd2RDVIYkxyZWNOclNpMElxTTUveWZsQ2VObERLUE5GTlVj?=
 =?utf-8?B?eENOQnl5ODdoT1ROWnU0Y1NDK0ZzRjVoYmsvTXlqaWd0MDV2c25HMlJqd1M5?=
 =?utf-8?B?dFBaWGRCT3Z3MUxRdHRxMjFJWDR1ZHFDd21MY2NNZktFRHRUd09pNUVPbXlo?=
 =?utf-8?B?YVMrbFFlUWFEMnA2UmM2VHJVWnh2eXNRK05rbWdPbHFRY0tsbjgwa3JlZTRi?=
 =?utf-8?B?bG5lVFFlZFlrTFV1bERIZzNXNjBaMkNTWUxLL0dVMjc5VnRGYzU0ZnV4WWls?=
 =?utf-8?B?akQ0YU5FbXV1M3ZSVit2eHZOS0pWa2l1bFdOSnMrZmZjaTZRSTk5VkRkRUtW?=
 =?utf-8?B?YmJnZEFkYTBCcFN3SXV5UHZCNzAyR3F6VFZCMTFpc1pQbTZCVmdMN1haOFVh?=
 =?utf-8?B?RzJvR3dmTktZT05idUJGYXBDYkhXQThGUjFHa1dsbzNMSzRFTytYSGdrNHJ5?=
 =?utf-8?B?Rjg4YlJDTzUvZ3lneUhaZHgrK0JLUDFPSW0zYWliTEUrak1Td2k2SHBNNXBC?=
 =?utf-8?B?Tm9rN2c4eHJrcUZQR0pKTkwzRVZZVXlUT2ZwUnR5Uy9SN1lRWm5IcStZK2dI?=
 =?utf-8?B?K0xvYllURFhxcHp4ajZtM0lrbGxRU2UxeVFTdGVMeTk2QnhyaGx4SmhrYXRt?=
 =?utf-8?B?em0zdUZ5NjRSS1BIQWEvTUNpelJnWXhkVENnUS9BU28xYmI4dFRaQnl1ZU80?=
 =?utf-8?B?cmptV0MyWUxNQnE5LzBEWXl3N3h1OFM5SXhLdHdDNE00ZWZ3bEtiQURMRGNs?=
 =?utf-8?B?aytWMDFISm9JandxRS9RZ2twSUxtUXZXOTkyelRzNWdxZkpPY2xWcXRTMTZS?=
 =?utf-8?B?QzlVMU10MXIyd0tLa0Zuemw3WmhtOXROQko5L1l0RmIxVmU4T1pOdlZreEgx?=
 =?utf-8?B?QzQ4ajd1RFlXaW5vOHFQTVEveTJHU2hndjlRMnVFK0V4aWZQd3o0bWJtNVpI?=
 =?utf-8?B?NUlVVDdaZXpsSjdoRkZzOW5jNjEwOG5GSWJlWEJKbUxwTUppR1RxREtURkd1?=
 =?utf-8?B?aStqMUJqN3F6Qk9rdS9HSXZ5bVJyNHFzSXlBZWZpS1NsZ1pMR0FTUVlJblpR?=
 =?utf-8?B?V2VhdUlDSjFXeXNEdFRuTFAvZ0ZBd1lQV0NYSnhkMHpDVGlkdnJoOXE1OUox?=
 =?utf-8?B?TklvcStwbHFSN1d5MHBwSUdJZTZkT1IydUhtU1dITDlocHVPamhtS3JtaThF?=
 =?utf-8?B?SUJPeU1XZm5wZnNrdzJCT1lBeUlNVVJVTDhpWE45akMzYUliTDhxZDhwdjkx?=
 =?utf-8?B?OTZHVklYTTcyRjcrL0JQYlJpKzdBSk5GNk52bU9WRXNaVUhBRy9IckNPcHVi?=
 =?utf-8?B?Ui9mOXlpdTVrL0N3bytTbkhkZHNwcVFCRXdPM0R1QVRLaFRkT2V6VDE1QWxN?=
 =?utf-8?B?ZW81ZU5Cb1VINXl2SENwRnRDSWM0bm42TllQN3RRRmZzYzJXUkQwc0xpaGJH?=
 =?utf-8?B?TURlR1lwK2FTV3BaMTFaMDdJNDVXWGgxTXdYTUdTbUJvZ2pRUzJNYXdaM1ph?=
 =?utf-8?B?V2R5citqZHR3ekg2Q3MyejFLREFnRGhwRGdqTFFxdExpZ0dVckNMY1ZITDVy?=
 =?utf-8?B?Z3hoeEk4VE5LU1pPWXdIc3JhZ2drVVR4M2FoaWZaKzRDNStlYmoyTXpDN2Q0?=
 =?utf-8?B?VHp0NDJBY1hmMnY1OEZIM1ZoaVZqZE5sdTNNMlAyTW5ucFRMVXFXUngwRzBn?=
 =?utf-8?B?NEhwZ01UZ0oxTnVsTmlEVTAxV0VBNEovb1F6OGNhMHNVRVZXb2pHMXNkanhj?=
 =?utf-8?Q?32HsPwHW0ckmgxEzJp3VOB4WRSzaqbipwPPzX1cZzE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5371b998-cfa6-4b57-8cff-08d9dd1cd3d7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:30:13.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1F9UGYnpxegQR8NHJO7PK9wy2x1mZHexkpA+56Y1ITT2Vfu9baFIVF2azUYPuzkYo2uuhK8t38dbt5/7hozfl4CrQyVvBEdB/w8UUx93HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210129
X-Proofpoint-ORIG-GUID: D_uzoI0Oo47GmcuTfH0RO8ugxOSaEMBf
X-Proofpoint-GUID: D_uzoI0Oo47GmcuTfH0RO8ugxOSaEMBf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/21/22 4:01 AM, Roger Pau Monne wrote:
> There's no point in disabling x2APIC mode when running as a Xen HVM
> guest, just enable it when available.
>
> Remove some unneeded wrapping around the detection functions, and
> simply provide a xen_x2apic_available helper that's a wrapper around
> x2apic_supported.
>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

