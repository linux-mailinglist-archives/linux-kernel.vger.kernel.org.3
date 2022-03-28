Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908FF4E9F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbiC1SiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiC1SiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:38:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFC5AA4A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:36:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SIBDaH024718;
        Mon, 28 Mar 2022 18:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K8Co3OxBu0LBrdjQyeOHOq/2plS6AzoP5VTaoUCZoac=;
 b=spWhhvlvNKFFGgYTA160Cck7oU3a+EmKZ9XV4+khy02rAEDjhJ8ml2lCUYYRnQvmxuEz
 k8CQphAw+Ox/bYdpgiEQd4fXvyTes4l4ei8j6Eke8IwhMflAv55mtQYNfqleV4TvXxS3
 dzJO27jxS9oba4IiY+g8CcPab+YBQKQXHr6AK0WU+AmVKU8AukbfT+dXAjaLPGavVfbm
 FY6EBdslUmlxG4OdREGO7xLoDBMIucekMuOF16JGfNEWbcOIt9uNEuY11UfBq7kEp6mD
 XbWp2ieLPsFFSKsNrSMYothJwE2g5ZqNw/dTeBiYdCr1gHiHcelMhkLQGy1peLdEinMK iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb4csv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 18:30:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SIR0Eq066169;
        Mon, 28 Mar 2022 18:30:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3f1v9fdd91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 18:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3lbsL80u6KH8Y8AtX6ZHDOikoIL4IUdN9ogUI7R5DaTp2vGfUnCbYgciIqogQ8++EfqJAlWTu/elpbJANn166/R8m10sG0nZHUhG4gVnOr2uke4ELKqzEoVtLS0T3Thq/u8l94RPOXHh84qPvcVXEMX4v9jF5dEJC2/F96SPGkqH0Jum0p0moxhwMisoqS7D496R2z8mlNXx66cAclM+ApBP1DJGIZ5A8dzeWBDcvgSY7xcRqlxZ0MQ4IhNOafAJ1G01qp7o1TiVFERpRy1gH8GGTNWEaegNLZatXVwnPny0SjAbyQ1j8HVdSECUJWbwUIp+PIbNYc1QBNlTHAmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Co3OxBu0LBrdjQyeOHOq/2plS6AzoP5VTaoUCZoac=;
 b=mTtKeUnpqB1Qlpo8tuO8Mmrjvzd9Sxx6X57StNiFHlWYSUGSfR6UTUzggQLU4YFdlK4zW/QMK72FYaLPd8F6d6/h/f6F2bIfcGdN88TtwMErjMoDmoIaeSbKZd+2zJnLa4mEd/f0++dEiqzaIBti3tV2v/9g1xPu5/6oVKM5yMLWkaPjlmJxubBe1TN8J54MAtbvQ+H3Nro4Kh+JAJc922Zt6CJkJt+TAqATx+CMTzN3UjHrcKUrTS/6+lYv71JTn8kDetp9fFejikcuKnsqdXDGqgGwXL/Q1hm8YH/AWSgxsb3Apjuu0Uc2BSTr2pthqzdnUawabxz9eWJ1Gm2Zww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Co3OxBu0LBrdjQyeOHOq/2plS6AzoP5VTaoUCZoac=;
 b=Ykws+DltcfGyZj28Ve3fMobS8FqpnP3Yzlu6UPdRLbLzHnR7FVFJRp5kGZ41b5JqWvp/SQCBdLqC1w6nwazJH+cbYVkEu/EjpDDi+4C3aPm5MQeD2LoiOlqOwX5W287BE1yaAGJGOW8RIucdorV/H0P2Flbn5dcYhwKIcVx6C/U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3548.namprd10.prod.outlook.com (2603:10b6:5:17b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 18:30:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 18:30:44 +0000
Message-ID: <178e363e-28eb-679a-b30b-6b058e7aa436@oracle.com>
Date:   Mon, 28 Mar 2022 11:30:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: scalability regressions related to hugetlb_fault() changes
Content-Language: en-US
To:     Ray Fucillo <Ray.Fucillo@intersystems.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        'Aneesh Kumar' <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
 <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
 <e4cfa252-7be8-48b2-9f19-019bcc0038af@oracle.com>
 <8E9438A4-56BF-4DBF-9424-2161A488352B@intersystems.com>
 <1883d31a-639e-8717-39b1-426628cb0d56@oracle.com>
 <CD631DCE-22C1-41FF-A55D-CCB393230851@intersystems.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CD631DCE-22C1-41FF-A55D-CCB393230851@intersystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 491d0434-1e4c-4f1d-ab57-08da10e911c3
X-MS-TrafficTypeDiagnostic: DM6PR10MB3548:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB35482E7CB363686B2FEFB0CFE21D9@DM6PR10MB3548.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFdoU6c3XhPpvEn1kwiSaTzbqroN/pSNnqDIx2dEPKwqkRH+qd0c33CCBAeqAGE81Qmzo6Wta52M9MtqWfFe5bEaXdkKLEXwsk2omiYF5u0bNKWpY1Kj+FfyJJwbPT47q6kzBakO/7QN3mx+AbEBtU9wJIkZS8rHrLtZExz5Lz3R0VCWmG/+VlwTlboRzEO8+j+I21Kh3n0i2VyM7HymCaRjHQwkXiH/+HXXKrWdJmy2GVU8bWkGvhi77UePyaYiNCAB0YGtwAmEyV4GKslHNONFxsCL9vb6X9jEy4q/JxB74pDSzpxsIjS9OGxD7ZuLNPawRncLyd+QvUl1u6SNoE8l9NaPdgcwi6DxtKpQjU51tqEZ9WtOiKkv+bxl8udyTVkpaAJx4b0GZsc915DL5Pa7MMZ7LYtPaSPkaft0Ay4IonT6uH0599KZkcBMaclX1Gc6WNA7P8LrGOE6ALXpooRy1iUuzzDT0w5XmO4CCqYkyTzJ60a/pYIVLrKrj3T+ze/N71wA6KKY79Q+pt29RO10CAS7Tu6jL8b+TZMx3IvhYDNTSiNQpl50XW1bhFVw2dS16zTa0CbVjxZvZl8vVxw1AolX3hUqlbjRKONRHr/5Cpa8KrK9XCQoESg04eybqOIkLZ8YW14kqVuzm5vRyac0GxrO9ueqcnvKAvBnD2bUAZx36eKCmN/JxJjEaBysHbQzOMB6pWfWo2QZj9XdCYZQ7E7RN78vX+peW7Nbf+0VBidiBXJs7pfXpjFoTQT36EkM1dXnZt9zI1sBe91P7B7kr0743m2OJ08KTa/9ou7GDTkq+lrokWodmwmkd8DtVKPF77YrbznaD4DcGW9bQkW872oITRzRKwUSixljcQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(54906003)(38100700002)(5660300002)(66556008)(66476007)(31686004)(38350700002)(316002)(8676002)(6666004)(66946007)(36756003)(6916009)(2616005)(966005)(186003)(31696002)(8936002)(508600001)(2906002)(83380400001)(53546011)(6486002)(26005)(52116002)(6506007)(6512007)(44832011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RMbENGTlo2TTZKRFN0WlhmQ0U4bjNXTGQ4WmtxMk0zQUFKeE1SVHl6aC9t?=
 =?utf-8?B?UVNKamttMUE3azUrL0FVS1p0bktuNlBpeW9PaWY4amZEMEpobWplQllVNVpH?=
 =?utf-8?B?NUxCZjk2dmU1TEY0U2lwTko0Z25jS3dmdFFQUmRINWhOWmx3czVFL0Q0cFNl?=
 =?utf-8?B?MXF3Z2lrNHNWRm1GRVlCY3VHV1BBNmlsTms0VGpMRmNQYmpGaGZBWFVaM3h3?=
 =?utf-8?B?amdyRlZvL0IvMDE2V3BUemlxVy9leWlEdStDakhKSTU0eFgyYnJFeEZHT25Y?=
 =?utf-8?B?YXpCRmxLNnF6V05CSUFHSUwrWjAzNEdROHM0S0xkZGR3V0VFck9JQmtzbk5S?=
 =?utf-8?B?VXpudDM4c2FDQWpJWTVUbVZVTE0rWk5kcTMrOEJCY3JLOGZmYU1PQkxHdGla?=
 =?utf-8?B?RGc1dUxEM1EwcUF6RlBKdWtSa0pENzRIOC9VRDQ3TldhdlhXQXkxODFyUmpO?=
 =?utf-8?B?Um9sV1h1STREMHRjOEdlTWcyeTlWbzFPN1pxdUNCVCtqSlN0eDc0UDQwSUtD?=
 =?utf-8?B?TDJSMnFHRGVtdEh5akxpeUtmUEp1OXB0ZktCUDhrTVY5OFJNay9pWnU2aWM1?=
 =?utf-8?B?L2c5dTdlTFhwM1Zlc2c0aVNua0xLNENiVVBtYWhiS1FLTUtnaXhQdjJNVGlq?=
 =?utf-8?B?QUQ2OVRFWGR4VllaWno5eFZpRVByT01Jc2Yrd0pSZnp1cnA5MkgvdHk5eDY4?=
 =?utf-8?B?d0tVQ0hUbUNJLzhua25Fb3BMMkh1WWRORVpzUmRtREpCYXIvU3FQSmdhTzFs?=
 =?utf-8?B?OFVnTS9nL2dDanNvcWZkSEJ1VHB4RU1sa1V6WWhsVGhKU3J3WDRtaTdGVlJj?=
 =?utf-8?B?eUtOMmM4eG1lbG1qZzFXeXdLanN5aWRxODBucUNMMnQ4QjBoR1RIR0lDc0Rx?=
 =?utf-8?B?OUtrajVTbitDcHBTbWd6NGJBQ3o4ekVEdHZPUkYrNGk2WDBwbXA3aXBiYm9P?=
 =?utf-8?B?UkVmY2VhQnVLeHhxNUY3SU91U3Z6dmdSZGw2ejV1SmFTWUp6UWVJUkdZRG55?=
 =?utf-8?B?emU3bnN1ZlJLT0RlWDFndVd1YWRnV3hoYnFaRDJadjk2dXRCNklpaUJRK2ZK?=
 =?utf-8?B?NS85bS9oWTIvb1ZDRDI3cCsyaUFDWERnQzFTNHRxRFJNYlFHam1md3FmT29V?=
 =?utf-8?B?QUNETTFBem9ad3U4NVJyc042RUpHZWplMDdHYlU0MjJrMjhpeFE4V09zK0Nz?=
 =?utf-8?B?dWFWVW5PTitwMTZrMis5L0VuOWZxM2dzSkNJeCtZMXY1T2c0OW1GbU5wOXMw?=
 =?utf-8?B?RXk0Q0RQeExoeU5XT3ZUZWRxNTR3QVUyMjNRVlBHUkpqdFRaR2RkaEdiKzVl?=
 =?utf-8?B?RHdjM0Z0N1dyTnJuR0dGT1MrendnRGtBOFhiZ1pTWk5CNUU2cEJkUnJrQmxI?=
 =?utf-8?B?NGJIOVpZZC9lcExMUndiK3VGQW9HMnRxNTdBNjBHK3EyNU0zVWprSXBtZW1t?=
 =?utf-8?B?Z0NmUnAwTzZKWEdaRUdlUTEyOWtweTJIYmlKdXF1RjYyc1NZWThHM3VDOHlX?=
 =?utf-8?B?ZTl0VDk4UzFBUmRIbkZzdHRCQUh6bHB6WEpzWlVOVS9QUUZUeEI2K3M4QVdS?=
 =?utf-8?B?b1J1Y0Y1NGN5c2Z0TllDUWV6Z1MxUjJGSlRHTXRNUTV5OFg4aVZHL0J2UjFK?=
 =?utf-8?B?QktUTXlHVWdEQm1KZXhnT09GK0tGYVJUbVRuV2JPa2krbUZsNGJxTDk2NGZ1?=
 =?utf-8?B?NTQ3bzBhdnIwY2crN2RVRTBQWXd4a0FRdWdqM3o2Y2VTdXVTMU5EUFY3UFhS?=
 =?utf-8?B?TUMwTkM2cXQ3N010NVYzSkdmV1FvZE9LK1JOQk52ZmE4UXVpc2VsaDViaTAw?=
 =?utf-8?B?QlhWaExIcU1CTlRGMERHa1ZXY1NIaUt3TFh5dHhuRGREc3J4ZXA0RzFhZXZ0?=
 =?utf-8?B?c29xdFRFWElzRzZ5U0RPNTdWUlp4OEV4VWlpNzFoSW9sRy9MdnZobkVUMDdn?=
 =?utf-8?B?Nk9HUHFHUzUwd20zbGR5alBlbDBHckhwRGd6WjFvRE9yamlOTjRUR3hybXha?=
 =?utf-8?B?VzVHa0tOeUtuU1BSTHJNRnN5dkhxRDBWU2NsalZhTG10V3NWdXhFdk93NnZ0?=
 =?utf-8?B?bmxWRXBtL2lpM09vTFI5VUxRL01MM0NWTHRhb3dLTlZEdENURXlwVjlFcHdP?=
 =?utf-8?B?NXc3S0k2N2x4VkxNQkZwZ3dNMkJNdnpZeEQ3WndrRFd0b3pWRXZqZ3pUOWtO?=
 =?utf-8?B?aTJnc1ZkeEd6R2dqUnQ4QWNFVmhjQm5DWDhBcW1WS0NHYUkxNmhVZ085UXFZ?=
 =?utf-8?B?L0VEaUVwNVVhQ2ZpTXN2cmkrQzNBVE4weVYrNUwrZHg1ZXVpUkxKSXIxV3k2?=
 =?utf-8?B?OTM4dG9MTjUyRnc2VkJVb2M2bEhCamtKejhpSk5NMjZDQTVjMFR0aE5Xa3A0?=
 =?utf-8?Q?H46h2bv4RIHSaE3c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491d0434-1e4c-4f1d-ab57-08da10e911c3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 18:30:44.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZcq6tWw9nV9nigL8qJcgVeiq7sAdD7ZZ+DYEVIJ8tCezYV2AyOZhlSTstKZB4Xm8tz2+b8mjmBkq9c5a+MRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203280099
X-Proofpoint-GUID: 8_TCKhI0N9ZDqkYTTvwD5wyJ0aWj8kvN
X-Proofpoint-ORIG-GUID: 8_TCKhI0N9ZDqkYTTvwD5wyJ0aWj8kvN
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 06:33, Ray Fucillo wrote:
> 
>> On Mar 25, 2022, at 12:40 AM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> I will continue to look at this.  A quick check of the fork code shows the
>> semaphore held in read mode for the duration of the page table copy.
> 
> Thank you for looking into it.  
> 

Adding some mm people on cc:
Just a quick update on some thoughts and possible approach.

Note that regressions were noted when code was originally added to take
i_mmap_rwsem at fault time.  A limited way of addressing the issue was
proposed here:
https://lore.kernel.org/linux-mm/20200706202615.32111-1-mike.kravetz@oracle.com/

I do not think such a change would help in this case as hugetlb pages are used
via a shared memory segment.  Hence, sharing and pmd sharing is happening.

After some thought, I believe the synchronization needed for pmd sharing
as outlined in commit c0d0381ade79 is limited to a single address space/mm_struct.  We only need to worry about one thread of a process causing
an unshare while another thread in the same process is faulting.  That is
because the unshare only tears down the page tables in the calling process.
Also, the page table modifications associated pmd sharing are constrained
by the virtual address range of a vma describing the sharable area.
Therefore, pmd sharing synchronization can be done at the vma level.

My 'plan' is to hang a rw_sema off the vm_private_data of hugetlb vmas that
can possibly have shared pmds.  We will use this new semaphore instead of
i_mmap_rwsem at fault and pmd_unshare time.  The only time we should see
contention on this semaphore is if one thread of a process is doing something
to cause unsharing for an address range while another thread is faulting in
the same range.  This seems unlikely, and much much less common than one
process unmapping pages while another process wants to fault them in on a
large shared area.

There will also be a little code shuffling as the fault code is also
synchronized with truncation and hole punch via i_mmap_rwsem.  But, this is
much easier to address.

Comments or other suggestions welcome.
-- 
Mike Kravetz
