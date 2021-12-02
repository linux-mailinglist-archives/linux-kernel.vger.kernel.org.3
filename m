Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DDC465E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhLBG2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:28:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23820 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231690AbhLBG17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:27:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B24h6ne023810;
        Thu, 2 Dec 2021 06:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hKSKynDyBVy1Ki23UDP+9bXMj6/UmMLwwLiLLtWRWsc=;
 b=vkAqpbNTTGtVcrNAPD5JjW6FD98Xqat2Zo7C25CqxKpdGAetl6dxXXqlsRj1UZaQDYcK
 EmAUzZnmSjrwhI29qZVWeMRus3DMOB70B04Hg+KSBUI6fHdI5cZo5v9twKMO5s6ZGH5C
 JrZTldBpf0+ZsMSPe1BtX0vEqOcHlVLqqCwZaTlh/X9gQkCPJflLqvQgsfv+kLuzE6VN
 Buytn9D8G7X1iItcFT5l+8ZpLibCiLK/FQ+oEHURiVqy416IJNTc51ap6Go0uNHADEfW
 ktMXqA5RP66VgsS5BxKknimahSIYIU0D2jSjrkMlRpz2Uo0TVU5NwsJlSnnJPrCIbrSA Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9gknmk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 06:24:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B26KqFf093081;
        Thu, 2 Dec 2021 06:24:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3ck9t393dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 06:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlgWHEjNxE3lWlJfYk3riIsqKGGpZplLoc03bSVSRieYpxaFBDM38pZBcRbGbTcplhbuJIvzAJbGsMtkQQgLdEgVHNIntV0csQxDH1ZfpRdFkQERpY8Ymr3TkCaYuSwqgoD9mJGzoRr96kVJQN6nN9E/yjFPMhTyElWE5+1VgSe4ZLdEw3bfGDprzNr9qkWj1feFCV7RJ1VntF0vFAM5xmWeHXhqbRxLlpl6LhlfhmzRTFGNlaSYbRwZNOtfw9Pr3ho+tOtu49sd+BLOhFdkyrBT83zCjqfW6B1RP5Ws5nNAnlNJ8hnR9AsbzjKLgDejl+fc1d/nJPUETtDGVI3nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKSKynDyBVy1Ki23UDP+9bXMj6/UmMLwwLiLLtWRWsc=;
 b=KpQ6w8o2NQMseJ/GEX9FFRgfSbYdYDP9cr2kx0X0c7fso3KU1azSHkPJkLcfyulp5wsblcKNnNdJQWYYCa+Aur3Li9k24PRIRx02xKx7lYZ6X7xGXlDLvBYrKpUjQq7qxzcysHdtBfPSPH5kWJDreAlSirsnh0kvYRtb29MWBBczFpsjir0D3Ufu0tI51rnKl3kyPmBUh/9L6onODfhFWXdkh3X7RDi5APSBDG8G57jlaSnwwzjb+SXy36VIZxIGKxrp2pKowFlK69mWFvw+7kQXtRLrkIQqVnGztRXgasm/gl9h6JC7PV8spBem4IOzrD99PMIg+xgq1MLV/J2TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKSKynDyBVy1Ki23UDP+9bXMj6/UmMLwwLiLLtWRWsc=;
 b=U4ylQ9/w8s7RFznd9wkYtEg3FKDPtakkBgVkU1/cNpIulqAq3ySBBLAg9cN2Evisf93yb6EcDfk0dm7oOosFzGn+c6jfXkLiuCJVwVKXXtTzDScgOZfAYfgm8hDpcp6dPtgwMZmZFSbZPthyd82AB465hBuWqSAxLyzpNrfYSeU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1888.namprd10.prod.outlook.com
 (2603:10b6:300:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Thu, 2 Dec
 2021 06:24:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 06:24:26 +0000
Date:   Thu, 2 Dec 2021 09:24:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as
 __noreturn
Message-ID: <20211202062404.GG18178@kadam>
References: <20211014132331.GA4811@kernel.org>
 <20211202061218.GA30793@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202061218.GA30793@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Thu, 2 Dec 2021 06:24:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 448702dd-85dd-424f-0c7b-08d9b55c63c3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1888:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1888084F6F16A2DACD4189228E699@MWHPR10MB1888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqpptUsZWT/byD9Ia06Bk0M5AyfOvBrvrEUBS7I0QzpkM/cToT2r1U1YY3q0D9RZ+RbQ1P25cZEaAFTOZq/5CIUzMGLLe6Kdug83lZ8QpWT+dKj32xvD4PW9j+TLTodH4/EbQpB9woXI59hY4VIjbFy9igNE51lmlIxPxGNNPvmAP0yJDtwSG3J42Z2cPkq/QIo3AommRUthGlWt/cUERtkaqQz9tqEGr8yV05AsJC4uE0gtglkDI3EdKkvkjnZoAKuigc+a585PodnYi4xehHyfniGb7vI5uPc9WBpnbftFxVIacnb175TNeqeZ9XxDEu3rwHD9Xa2Lu0jvGsIcQ8dITVjaKABkupp5fwYKVnck7jpmmQk2nF5E9Ol/zbyp4+6fT9JcC/T+fnActRhvL9OeAJABzsaJOXYCNXHOaXXNkFdc1r33pHQIP5FrNoP9hfv89iPwyVH4CMaYSpthsaU54gLrHcpi97GRU+o9wQZALd59oV06mMiPnyKFHGlJL1LVtbxIBI+aGZDfq7a3e+6Va1p/qVfr/tgQvPyrOfGUDb0mCqVZwGmC5mTFEnFTWjWEzGa5GJyJMmRm9IB+W5gtEUvlK3zqvzBzyNbZxg9vCLDRjxUvjAjcG79XSMrlaJ5xFst9FkIbYZRJdAKiwLdqkNkS8kG+yUeP/qJ4YOAu1Dw7Tis6n14XIsvXtZQecH63TPVtYYl3Fuyj5QW+9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6916009)(8676002)(186003)(9686003)(558084003)(316002)(44832011)(55016003)(5660300002)(26005)(33656002)(54906003)(6496006)(8936002)(66476007)(66946007)(508600001)(6666004)(38350700002)(66556008)(38100700002)(86362001)(1076003)(956004)(52116002)(2906002)(33716001)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qscSJ3UQq6gYSvznmQ1EfUKsVtcUv2DL8i+9mw38sns6caDL5KHPq1Hkd2Dg?=
 =?us-ascii?Q?DVle8II3zRbbOXiUC0DMaGPDCEH0q4691+UtkLNURzS6gaLjelqGgqXyQZfQ?=
 =?us-ascii?Q?XW9J8iltJir+cThyFbU6P7Vq9M6ByhMN/D5DyusRU1B3WMog5UfBs0XkkoJY?=
 =?us-ascii?Q?ex8CsPEMnbCKtxGdoLMGGv0xSdv8IZafi/q1FaEgc7jM4L2hLnfzqyntRxy8?=
 =?us-ascii?Q?hy9y3oO6/T8TcRRjgGk7q6nDDe3abahSf3ohBGAUJGL271QT4PSuXd5jGlF8?=
 =?us-ascii?Q?wtt+Kx0B3/F0m2YmB9ee1XnNcYI/4hK4fk/9S7f8sdMxeJRzSoVNSolL1g8R?=
 =?us-ascii?Q?w6S00Hs4e6w+fD0qzjMYp66m6VWvCqdn51WrZLmikPcbKEptv8Xqs3KPHazd?=
 =?us-ascii?Q?wMKwIy4hKdKbvCfVHG9spfxNylFd8d4kXZa8LJIpbd/Xb0dhx7aigIa2yYlj?=
 =?us-ascii?Q?oKQpj1Mf10dTzC59B7tZVFXcCMaoRPVniIYT0xpaWGo+j+DL0y9NRfyp75Jg?=
 =?us-ascii?Q?CTTfCXqumNA6tpBngawSiOS0r7b5nZIwxEcndPPkmn+PUBQSSYxstPS5Bgzt?=
 =?us-ascii?Q?oGYFZnFvVwowe/SLxFjh0u7+G7OsZp+jgYtY6scyLP8oNWxmFLcnDBOkSLEP?=
 =?us-ascii?Q?xBWgSf8SK9yjuu5ZT0B78zfA4yqFzHEPpPtTYYfMAwHbWk7F7up5a6d8vpMp?=
 =?us-ascii?Q?RomhAoAb1TGeH3Kxs9t6YLYwZ0ojCn5Xl2xyXAOuth7/8c+42susSOBB61DH?=
 =?us-ascii?Q?EM5v0P670jg0+g6B6nGKg9LqywuhyqF8uBiNwgZkQrhpqG+Q5ceR8Um0v0BT?=
 =?us-ascii?Q?FGd/PXpQOe4kJy5DGKClhdwfFII1wYAWdfxuxgaLtF/n/jagIZVCD+JJnO1E?=
 =?us-ascii?Q?oTE2EoC4CWNzvxxyvS9ApifDNZLxKKjIrG4da4Cd+ZoeowG7Sz+lNAYYQliq?=
 =?us-ascii?Q?up+D99MMKca/LxBGes6G+NALVW58nAhdVuJPEun1kJpI9e2eTBuo3HUpoPV5?=
 =?us-ascii?Q?8t6w5r28TGK30Pe5OwHEImzJCyBagYz5hfwzlKN4DYB9gg03aJxVvdeTbVFl?=
 =?us-ascii?Q?0KbijLjduJNjdGLYsBDQ8BtAphEYmvu6KjOfc/8MN7XL6u4SY5BUPjlN7us6?=
 =?us-ascii?Q?r487vqHqi5ehCmhIhDM+SqEVUguOB9IjySGnkszXxoGjhoL8NV2eDsoC0Kl7?=
 =?us-ascii?Q?e2tepppV4AP7t2augqAAGFzJH56lcVhObaFuGe/0bkp+grp9NOeEv2WXwD9h?=
 =?us-ascii?Q?lKOvtcBtEGGCFCztFqJIaVTU5nj7AurUExiNd28yiZebAD8ccaZP3CgbFELf?=
 =?us-ascii?Q?YfOgmVHYSZy0vqvvG/yFJh84Os+A9XuurMxsaT1aAxJp+iiXuEqdUrEqKXfy?=
 =?us-ascii?Q?iln9UzQV88lPvTO09IXxm+wLIpnfvsme1JHbLbjFvO/3Zk1Oj1IOco1oWYPE?=
 =?us-ascii?Q?Tn2tLjObR3vkwSKr37udJKMTY1WPpV8OJULuKU3U6IL/PxQqDN59oqLi7Dbe?=
 =?us-ascii?Q?zbTZrb/MmRDOfNQF+eJ69RZAhO4ohDnsXWnaM9j59srbcl3asiGtMdQfUwSl?=
 =?us-ascii?Q?tzV/k/FHPAzmn7iLc0DuZJK5X1Hr48rsIYgg3gNYrxo8+sVHwW9gYxb2tZT+?=
 =?us-ascii?Q?QyZ6zDmxq4l/rUE211tGxBlRiGEKfhts7dUyN99TVx7fV6aANjj16JiiME0E?=
 =?us-ascii?Q?xTIh00RZBTKzLhJxOJl+T4/xpGQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448702dd-85dd-424f-0c7b-08d9b55c63c3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 06:24:26.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BePJcDpaoMcjzH5TcizXNQ24FndAeOmQul5zaMyhgr5k2n/HGRMX3PqYcBsSvd5sClLfcmIgyRFd7CeTHwC0mgBdrLW1FElEXcY9Xq0SjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=729 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020036
X-Proofpoint-ORIG-GUID: 3lskO418eCqU-t7tKKz2f1jdXQyZ6JFA
X-Proofpoint-GUID: 3lskO418eCqU-t7tKKz2f1jdXQyZ6JFA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never mind.  I can just add some code to Smatch to ignore compile time
asserts.

regards,
dan carpenter

