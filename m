Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266BF4A95B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350786AbiBDJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:02:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbiBDJC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:02:56 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2148Bw3B012568;
        Fri, 4 Feb 2022 09:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Pjw7JJtI+86a3RB31hn+2sTyz6OysKgwiLbY6/JnlSY=;
 b=ihe6XnYcXLJmRLr1JAgjKeenN5rDi6EjSOfnCN6Ia7o5Mc8V0NU1O+35hUkMJhlA6gto
 MBhFdByOIMSspQ0vRUcw/VMkbiGjYfO9UEssqwqRndQPaeD4bfkRUq1wuu34WldS1oI3
 Aw2xaMeEyv222KfUzCDuNaT6zkUQ2DGK6QN2q7B0dJZ9mlLqqhi8T0TVrI6P8AxhRFap
 XvN13dM9+n3WSgYmog/Rwbq2L/6Ib9VQWqpdR90K4vH7Mfr8aYUntNmjXQAfF7cwFO0d
 zZDsbjQwNe7pNyaeIsADzSy3Qs6aLeP9xWoBuG497u0Mrgqls3Q//wZsOWmdEAJHN/H1 VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevt1mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 09:02:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21491qoL127831;
        Fri, 4 Feb 2022 09:02:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3030.oracle.com with ESMTP id 3dvumn53ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 09:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foFd2T6g7KmCxIqtaYrPaaK3kbZoxiQ+4jNxrg7/jkXqaflzBSNHwN0SjS8LMSdi5mz8Y7Kv/9SGjkydARXnHZEH8yt7Rl+NO+1FHhmjlgMitI2owDskFFBbsgWIx6hT7x38B2CycooFSkcquxCAg6br4QNV9ocvQzeHNxJaGWeB8zmY2iuvh3doOUpApmU9dCRBYjzUONQax424pJxkE/+Y6jggc/g9L5IzKkll6gL5OMkU4etLz6JBPArLuzmcSgCqjXo8tDdkLb8DcIGptPxk36OE9LGiOqxchvG+Tq2GRaIedRLDbfjFJV4nHqjsDsbk0r/W/DNcBp59BcTrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pjw7JJtI+86a3RB31hn+2sTyz6OysKgwiLbY6/JnlSY=;
 b=EN1sdJOTgL22fkQvCv631+b70mU4hpbCVoKLxn3TxBFBh56e/NVJPUOfp/o5UVLKAiPjZx06nqnQMiU8z/gH3mmFH+S2odh1CM8d6eQ90sqix7H9EIEZ5hx+g46CwzCuyomkAm1Gd9EONieGUpoEmiXiErc6E5fMBa8E/TEum05Oonu+5FoN9x3XCD+E905UggNt3fkN+rljz0/yMXC/K4k4rrIzcfHOcJe13N8gS+8VrBfxVKilMlzL3aa6DYtzAlUn4oAJAF8JklSEI1ADmOzLN0qepwEJoHbyaaxn/ulggoILYdshV+dl3hcLqag014RnRL9LINV+BbBTcyzZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pjw7JJtI+86a3RB31hn+2sTyz6OysKgwiLbY6/JnlSY=;
 b=yXBo4mh4+JdSNIGCGnk8BBNCoEerQQBeMZf9w3X6qqX1b33dwoRNKPF2As9uFk2YIRn8QHppFRbF0+0RDJ2epcdPn7DzEQUTe/0EnDsGmz2sOCeweK9GHqm5+1FegppRsFC7B3LlEntiv5RRRc4FqJhkOUNgxlQCmonXNgOlpYA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2453.namprd10.prod.outlook.com
 (2603:10b6:a02:b0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 09:02:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 09:02:50 +0000
Date:   Fri, 4 Feb 2022 12:02:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: pi433: add debugfs interface
Message-ID: <20220204090227.GZ1951@kadam>
References: <Yfy0QSxL+3lbPlLK@mail.google.com>
 <YfzeEHJcd+qvYGZ8@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfzeEHJcd+qvYGZ8@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1351b29-2850-46c1-16a5-08d9e7bd1ee2
X-MS-TrafficTypeDiagnostic: BYAPR10MB2453:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2453FE69956600CE0379C41F8E299@BYAPR10MB2453.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuyFW6sDxTYY4VQPY/ClSCs9KhPkrWU7ODLsT74eyO1+c94P2ksNow9dwDGcxKPADoqItYU4BW2SzYX5Oni5A46arW8FI9JulNByr7LOHp7pxljbGLool2LbTIZqMdtwSZukmkj7JQjteb0O6uQeQZBRZb4cuojvmKCmth5dmQZ4GBahxwy36ZlUcfN8578YgS9+EBiuaKoSXvb6W0C9LM5XaVLHPzAjeHn3En8WaoRp6VBWgsSp2vxFA1r0OMT7MLxxneskMX/U4nSFJQx688l1wJ0KeCbD/R7Ay9dak4Ts7QAmREoTGj0P7GJVVJSXkz+wob5Ya35r8fN521bXeVhDb+jxrWDoyoz0f/X/WiQb7mW0MDzA+QCo/h8/j2UOpBulAvvfa0aMGy0tr6pWNVE9ButGTpctv3hWuJavruVfdEfJ47CjQh1pZQGALvCiZzy6YnApHtItg53U9Bu7FNkoTyuY4eGsY4HBXfE1RIedAZG5aaF4sc6xdXNDZErHPwwud8xC5z9CC9g27CF7JeD+vkl1ZGEsmcYpBWNkuQtZM6KbJKhuAgS/V/jGfv4ezUqmnFP2keBzq8FaogK4oLq6ipkMfKEULSxHpepZ5sANCPia9bNicXtW6pa0EL/JWmfioimAFh1xMMxcTRKbWbDpYsyBptzP7uEQKYAhBW7sJTrTy8TOfDRH4uqLOBMGabAjLKdrcgyVnKbaCUGV3+hS/+oSKCKs2oaG0JgwsnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(66476007)(1076003)(316002)(33716001)(86362001)(4744005)(66946007)(66556008)(4326008)(26005)(6916009)(186003)(44832011)(6486002)(508600001)(38350700002)(8676002)(38100700002)(5660300002)(2906002)(6512007)(6506007)(52116002)(9686003)(6666004)(33656002)(5716014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0v2OYZHQnXzdmK+UjdVpC90voNKv+moymV+dbtG1Dibq522vLd3gQd3yvkn?=
 =?us-ascii?Q?dRVEOtC2FEEOgXL0xItGANKMq69LT2p6raWeD3FP0lCqObpeQQzJ6E1Tp/Ml?=
 =?us-ascii?Q?LnmqwfbMTA3Sl+KULgdW+kQbQalC8ZcM0ITCHriNoubqFpAem7dX4taPF7DZ?=
 =?us-ascii?Q?QVCecbmstXmJ7JVhBfkmTOcJ3TQUrYEHOJ/1m1B0Bq+KsfVmuRVslP07rgus?=
 =?us-ascii?Q?GlxN8wyXBS9bx+ZhXjsp9fv7nLRJ3fEF6EhFugOUBueP7gbzCfIeu4EM/yap?=
 =?us-ascii?Q?gxCj45EGkUwWTNGu7O7vIc4/yT4U4CLTiYUug1kCekjr61+wJquXBZAF1Osf?=
 =?us-ascii?Q?P79KZ3l7WkO8p+qjY3mKofEt4QszWDjYB+s42qQrieQmcdS+zAIcSV05nxlv?=
 =?us-ascii?Q?VXZiu9VvafSoiF5PeTic+jTQquntIv0YWPE1pKBLcMESpR1NSgPAMYmffY67?=
 =?us-ascii?Q?+eMwh3ZoF9wErrldLST4b8HXsqA4ZHxDl/gPwuR0QIypyYQRPAm1NzoJBjDM?=
 =?us-ascii?Q?5gv6Xuw1WTSoAfHf2aW9M7Usg/XOvAYVOX1SCpYHtqtK1qzVHrqP/vjb192W?=
 =?us-ascii?Q?DWAj8cTm2Uuy6Vy4nfLw8n5FsB8/WHoUMTjQRYNZp2kuNHXDUC5uxj4/tvSk?=
 =?us-ascii?Q?BJt9BNWNJzdYF1O6/DlY0ItYNaHkmurSfpx1IFEYyefin2Tq9LVPKsonQGg9?=
 =?us-ascii?Q?E/7ao8Z87Kv5YtEAxD1irhPB9/EZbSeIytcX5qYtyNduw0QgAWIuGZ9bzglJ?=
 =?us-ascii?Q?L97oFyHEyHtWzXT8HEvcXqCne+2zssdkC2qpprFAMA0qwXSh3ytNwX7nox4o?=
 =?us-ascii?Q?g/WyOM8Tze5uqJ2+rrO72DneCnZ0ChBlV4ee/cRW1CW3T1wdClTi/M3GuEYl?=
 =?us-ascii?Q?U/aqOpnJO0kd3ZF8U/rDiKosR+sqRgZieCOxsKExM101WJLT7v5tZhEUT6EB?=
 =?us-ascii?Q?alYXscSYMW2HE+mZi/cPIuNQDvy8cUpKaI1Tbw9rMNjfTvhGpcgu8wM+ZH0p?=
 =?us-ascii?Q?KVumgE95wenYbyPCI62zxGFBkSbcL0VpPBMbZtGnO4S7VXjf2haGCFvzqIeW?=
 =?us-ascii?Q?0oEv8TALsXqZKHcLGmqw6tFO6juHv5nu766rjQuLyDw6O1YDErv/jCG+dNMj?=
 =?us-ascii?Q?fN5dnkfFZGf11CdDzw0oBENBpJW74j6vsM6aCJrWcSjEqDuF6g0niE7n+Dz0?=
 =?us-ascii?Q?mSOSAlhcHfGcPO6Q83yh6thRILW0I/CTqJyWy1vDAnUtVx2indmZSGUx6P7K?=
 =?us-ascii?Q?Ibl210gBG4AWFitrSHZk+Bk0bJbLSEgX2j2DSoWTwq73FaSNhxwOXZVLo5V6?=
 =?us-ascii?Q?OL06t9f7ptbRPEHPeXDvGSHjjy41GF15L+tZNej/xRXNMzO4lH5/KEsZ/Frf?=
 =?us-ascii?Q?TGEPfK5rq/e50/40MaZ3SsuMVtQgN11vZtIlbMZT/Ha91f953q+gq9t858Ld?=
 =?us-ascii?Q?idWzsZlBPOek33uh1qp4LdyS9HhrvoH+i9/nn06WRUicNJosiPjWjwQdLunK?=
 =?us-ascii?Q?Liv1nkhY1wu7OpGfRfmkQQYLwwVAaGP3mD6NjWkGUOgDwUYG1pks9MouA8rd?=
 =?us-ascii?Q?zxsP/o6K+pYRa1Dgq1uVgbLO8il+mp6DgLKbu4lKAycCMMupQvoU1StLCGxb?=
 =?us-ascii?Q?4RpJPpgKEgLMfYgVJ+aB1vvUE6AeD0Fjr65kWNi4Su0R9lPulb3q9QpzVX7s?=
 =?us-ascii?Q?8tCVZDpZv+iQflCQXuHsN2qUnHE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1351b29-2850-46c1-16a5-08d9e7bd1ee2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 09:02:50.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELQXa+8PHR1SV0dm9Zs0IPZzrHuvyPZymeb2LJbB6c61KIBiwfLfYqYWRPBfoNnKd1iitb3JKJ8fquEEJN+XnUuYd05otJH6cixzhFLBlBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2453
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040047
X-Proofpoint-GUID: PsDdMxDxwYVHATbEcFLlfR6Jg2gKy_Ep
X-Proofpoint-ORIG-GUID: PsDdMxDxwYVHATbEcFLlfR6Jg2gKy_Ep
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:04:32PM +1300, Paulo Miguel Almeida wrote:
> This adds debugfs interface that can be used for debugging possible
> hardware/software issues.
> 
> It currently exposes the following debugfs entries for each SPI device
> probed:
> 
>   /sys/kernel/debug/pi433/<DEVICE>/regs
>   ...
> 
> The 'regs' file contains all rf69 uC registers values that are useful
> for troubleshooting misconfigurations between 2 devices. It contains one
> register per line so it should be easy to use normal filtering tools to
> find the registers of interest if needed.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
> 
> v5: I had mistakenly forgotten to git add changes to the rf69.(c|h) in
>     the previous patch

Oops.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

