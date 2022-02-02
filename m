Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAC4A704B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbiBBLsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:48:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5142 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbiBBLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:48:37 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2129iPmX022156;
        Wed, 2 Feb 2022 11:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=c2J+KE+Gud11Sy268Hy1tLFs5QF8JG7Ot59aDlmqBlE=;
 b=J45DnGnnfycwBbgbcgf/d2WaXnVcNTEd/EHHnepe/NOSqjFjIyKKx0TC5ZUm6lYRFi8k
 12YyR2Qoy5GboIUxzHOeS16kxToV0F2pDVCWxr5CC4WAIYx/QDU9fEh2jQLIIfR8wpik
 EFpnZm5sRO6PLfAmqbFqMnOstfBp6DlF5mKZRHa3WxiPpgrKDqUrCxldhLx8F2MIAtqH
 Yh1mBzeJI6G8Y158g21itWLGIVm+MHaAXdjKdgugg+L/ZjsbDSG7TPfXUVUAS2dmnYrc
 itGvLE4l5LH/U4DH4EAo+FD+7PJiu/6BzYF9h47HfwDhdDcmf9vH3LmeRZJoM7hNytUv Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2n8yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 11:48:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212Bjiw9104648;
        Wed, 2 Feb 2022 11:48:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3dvumh6vp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 11:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7ldIIODz/O/yh0iR3WwJlrwUoW2D33ucuK844HEzWy2vN7LbZrcb94mYnx3ChMkyWjk4C6ATasXsRMWxXb/QFkciE36S/InWi0T9sSFlup8M70kxHirmKbGr7ZW6pcKLTZMuS21wmCfP5//8aZ457ryTIBUho4biVVQhxCaDzoO7F3lYEIgRJJu9c4h68HFXsOs138Za9/o6C0ZiNcP5n3N70OKQBdTWgH121Sf0lOF1H9NnWfygET9XbVpX4hKEh73WlSnW6upEO4z3TopzyeivmL32113/LJNFteJKzW1RHU9b/8bBlvvSyjusKQuuou6NSRd2Xni8yQXFkdtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2J+KE+Gud11Sy268Hy1tLFs5QF8JG7Ot59aDlmqBlE=;
 b=Rn/f9H41O+U3I9SIwQmTdKkELapb6TaZINmBdYbZOmQezC8mLwD4fWcoURzQWf7CyQtFhQ6r/KT+1BmZR/RviLTNsOqUzewZbYirphBIDqeXVuDCrVoQoOyAZk3oYi9YJgWqcerv9PRIguxQJU2P90Fjdq1z5pCgsoLo03sUe72OGG4kDoQBKSmNkHFcF+NHrOCMA6FlqH1op8ONpCcrisKygGIp45+/2yA2ROithwZTqIZN57vAyw+/R9lKFDN5blHFJqS+xp1UhEx4CKDOD3otZ+kgRy8yuQ/ciiQ73MwF7a5S0T92p6AQ4ZbIPzPm+LY6lFFxqy5EjuSvKAFCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2J+KE+Gud11Sy268Hy1tLFs5QF8JG7Ot59aDlmqBlE=;
 b=oiBfOh5odzVIW4JwwwlQEmOAe0P0fP5YwvO7qVL5GDzMyUwomfe62O2WnaYqp0nU//EGOl0VVkjAlMLgOeKyCknxqpkYgcj8QLPy408XRgwrs9z2rmRSXVBkwHikAgSzZTtFKqdzQsAmZNO1pSDKKTS6Gf+9UqhlBDg1CGUbnWc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4881.namprd10.prod.outlook.com
 (2603:10b6:208:327::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 11:48:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 11:48:24 +0000
Date:   Wed, 2 Feb 2022 14:48:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Mitchell Tasman <tasman@leaflabs.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] greybus: svc: fix hello processing
Message-ID: <20220202114801.GW1978@kadam>
References: <20220202113347.1288-1-johan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202113347.1288-1-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e02e7f7-0521-48b7-e97c-08d9e641eb37
X-MS-TrafficTypeDiagnostic: BLAPR10MB4881:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48815D20515FE39E99A08DDA8E279@BLAPR10MB4881.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ym601ri2JOwzM5bi41FBV7BH/8WTOetLUISWbQ4JwY4Jja1SE1jU2XJLGDWOTpyP+hZm/mxIcuwl6UOnb2iBZ6sKapCnETOhoj8noCRee6W5v+a9Mo/I6FMINVAnxXjE0jqg3g0DI64DQ+SI9xiZHwZk1OpC1EcnaeZa7JLvrfwLmlJaQgb1GibG9CNVfC+z5WhwcjFulZlouFG2IkOxnC+IP3fiKK5MWQ7eO/LOXzre2+5Rk/mRb8qj9UBiDba0yp1+zXV0xck9DTI8nmbzOKnd7/D9dJPJrdxTGUovFRINe0873826lIR7uuxmc5qeZYy3nTffejcihOuptyWeCehCdjBP6Vgad6NkJEJEvvGtvUgGTwuAUxnqbU6D2QgKIxpTBXcnarE5kbIlGuCG7e9qcRt1WQ6YZalRywKzg3u4F+M9aok2TTgOAJfOxlOTWtI2yiU6JkfHzxY7b8KSlxzJYbU0r75uhYfSFvDCTHd3dDEP5bsyz4S1v4DWnD61O+oGTpSKYUkfvPtpmeQN6kMBISSxn7p3o2ezv6JaiGGOKfR3DlMgufHyKaH8RPuF3sR8kjgYBbj3SwAcbYMTzzz8CFqNQ5i3Bw74MRRdjpHz1bm/4wdptwhvGN9gQI+7xjlF+TcWj5X1gNTMDobzvyS7zD0qOfwyhNQBdeAQA7irNfbCK0alDwDY31oHpOpZUJewNc5b2raSNmI3Mq3FkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(33716001)(558084003)(1076003)(186003)(6916009)(26005)(38350700002)(4270600006)(38100700002)(54906003)(19618925003)(316002)(66556008)(5660300002)(44832011)(6506007)(33656002)(52116002)(8936002)(66476007)(66946007)(8676002)(4326008)(2906002)(9686003)(6666004)(508600001)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ouz9Elk7yVN9py86i7qGhMkAaVUcT3Z1PnHKEeNzMC79BHm2I/ivNmSZsQ/?=
 =?us-ascii?Q?ZqnCfXJyKVuC2eLxOsZrbhpaUvKfccmo9D7UNtGX01Z9Qp3m4iVFY/frL6Rw?=
 =?us-ascii?Q?plhbjp+j41nzSSee81E0fumyv1lwiX1OyQWlNOCrb6k10uJr50+3Zl1nGDVh?=
 =?us-ascii?Q?ikUNgQ/jzNwY1Vl8Q5wXtHg6/JTBlPI6U0GPRDNELmY8yBRpnNWLGBVwAJdu?=
 =?us-ascii?Q?sjgHeN2jI5LzaMWn4v0kAGIs0MvEFLT+P3ReZP9HArRtveI/iLJ41QBGx0sT?=
 =?us-ascii?Q?IE10c0/e5EJhpANylwSdVpWTTCeLSfU2VsLA4LEz9wmAYakkyNT89/Kc/I19?=
 =?us-ascii?Q?P+1PLUPL0TzKUADYxAcrUG8Jxrx3rxm/d1VxgBxlCOxo9JOv4D28Jue4A4x+?=
 =?us-ascii?Q?//gP2biEP5XVczFXFIrFWAgq+HtKxz/xYTmPb7e0P/aa/0iyePr6tkFquDuC?=
 =?us-ascii?Q?gqaQvfCqgGSSpOyWnT9De0Pbxny/53Dk8G/ffptHXI4SLh+g1ju2E7lQIZbK?=
 =?us-ascii?Q?UuTLPe8uPE83SLracNXhBtU/Ddd7H2l3eOxG9eSBWdsDxDRLJnyebp1JOUPc?=
 =?us-ascii?Q?O44NwnWXq0d3HOfuSGOn0B4ICq1l9GbHET+iAbEp9uDE3cqRgWHiXpy7gR8l?=
 =?us-ascii?Q?1pQn07TQ3DEReA09nNr0RUrmbSdyrGd2ZcjOHkKz4mZdyrog3eMhPrl7tAjU?=
 =?us-ascii?Q?ZzChJj3y5wvZY4D6DRknU4A06SHMax7csn7oU0hO69E9+nTlDsXIPSwHeHDB?=
 =?us-ascii?Q?evJd+wOiK/AucqAasSZOLae3n0JdU/6s+w1KygZ/KPQQM7IUuzrj5NBbnVNn?=
 =?us-ascii?Q?6PwYOxi515qsbB75DWcMoea41bssyFhfp8Bmdat75+dqMecEx4/aOrNkyNy1?=
 =?us-ascii?Q?Qc6HRvFFhNdnc5Ut+6lcV86S1DqMcqmvx0klAQuBMOwlYu1Coj8W0Fdumfkd?=
 =?us-ascii?Q?/3Wn7v9JeHK8TTIf28pW0vwqp4lu1NTdC3QymHTDghFxTVujvSqUkqrz3uQN?=
 =?us-ascii?Q?+Wno6Fi1yiz/4CeC6HakfY86+XXfei+pocmHVnvs9KUN96JeglH92O1Vhm+u?=
 =?us-ascii?Q?L0led9Vd5hrOku3HnTSfXDGJgvbvPADT6vW1RBPV0RxwazyUhIOMDG5Z1Apf?=
 =?us-ascii?Q?GBykhG3zk8yS8o2jxnLVrqjVA7A4p/1knaOK8K20f9/Dhmi3bpxSpdTQO2mS?=
 =?us-ascii?Q?AF6/fJc/VQaPzOUzvNgdDmKcrgLchpo56bjXKf3NMMxtSDABaID7zuSwlazE?=
 =?us-ascii?Q?y//2d5flofLz5wYmO2vtAYMG9yyGe2m+sCHExxR6A3p22h9jFnc9Rlz+MsT7?=
 =?us-ascii?Q?q/834/GbAlXKR+hepxxNiagHH8JKYX5uPC5T+B2Hh96Vcmm4bM23QM2dAdMN?=
 =?us-ascii?Q?2BWho3Opwk0+OskldAT7X660KrMXNoUecqDYJ16Iy4YfBo41IgwUY3sXnmxR?=
 =?us-ascii?Q?NTK1HpsXF2dyBu3HYBZ/Q0+oEZroGjOmT7k7YhPINawB7zKIXtHhPcZUmwKi?=
 =?us-ascii?Q?HSD7ewGcZs1r1DTiWDr+Oh7KLzsXCPJzW2UbY3pFl5N5dBoJg7NO6WrYFNbN?=
 =?us-ascii?Q?c0sonPqZNhCjj2+dIbfMitJgW3CN9A11hQq29EnuT/HFM4FdY4tevrSg+qYd?=
 =?us-ascii?Q?41nLCfWQzWc8Q2h/JrMJacS6LoCgJwEaC62oTmEJ6znValCpSlhgde428qnR?=
 =?us-ascii?Q?oLbyPyOJdDUWcSHZHMjT0IWOSLs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e02e7f7-0521-48b7-e97c-08d9e641eb37
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 11:48:24.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVEz5TKp54kvwFF9c5NrN8YMVMgU3/iD2e9gBLBVBQgae9H4DAMDp8laxHaFnqlPjLRDwJaYy/NNgzF0hWhEm5gK7F99EPQtdhyJHBgJ5R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=825 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020063
X-Proofpoint-GUID: i2mivkofwxVc7HMcrFZ0Q9qSZ4l3Bptl
X-Proofpoint-ORIG-GUID: i2mivkofwxVc7HMcrFZ0Q9qSZ4l3Bptl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Johan!

regards,
dan carpenter

