Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B52479A09
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhLRJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:55:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1816 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231405AbhLRJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:55:37 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BI1hXXT022254;
        Sat, 18 Dec 2021 09:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0gz3eC5syfQxYu1tm2v7nxudfRy1sbFMYfEQZ+XfdQ4=;
 b=sr2CbMpnDAaxb8dEaaZtW2j1ZoZrptvI+3Gqi8UhYThjAMKU1ssb9EjWIMwnK/CEwGqF
 DapLWqunQCDYQ5fG8yRXbTzpMIPAsoH9BCn8GnI4oG0F/9x7tjpyv2wPIiC7wXyiJ0iS
 5O2/wjiCUh02NGZ7ZW4T33nxwR93YSP00RaTsuHcKI/pp2dh7476Q2hLM7X1zLxLt5V7
 YrsIpGIKkpQgCC2QSYlEpPbdAoWLGlis32MZowDBUb590Jmi4FVGpHA1f2jsXaY6Ocbq
 ONoSdUjXMNZ2VEeeLHVAdXtjxW2uWp7PHZ+2PKpuT5+t8x20ex5EVOY3owUR2X2CDlBT 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d16800fyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 09:55:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BI9owuh181298;
        Sat, 18 Dec 2021 09:55:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 3d17f0yhhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 09:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULMItKEObC6q7y1X+S38suVRGYunrwUWkH/ETPFK5zj2cZj9l3hd33Z9HYsqNqRuEyMruyxVw2csuZj2pu7B0icLUZ8L7UGRfrbZhmNsF6mq28N6djvmimjc9eKrIz7LSSZwvxX+WeVSZh712pxMMJcn3FSzdvwauVocsCzaN80efaHxxPbqlHA1liAHJqrY+7+Oh0QB6o/q3EfzoA44MXLew2XSMicy+Wx2pMEJMaIuFneDD5OUZYVK8zovvvVtNAW+7osP4Vq5jJrf/e+uo8V+S67RWHN1190gUAiDBYNlF35rLLsZHmUiVmDt7iE06ufwXzDRTTWl86fCEYL/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gz3eC5syfQxYu1tm2v7nxudfRy1sbFMYfEQZ+XfdQ4=;
 b=FKKey44q8YqpLXgF9knjaxQptOXYUt5r9SbCo5pXx7IKf7vs8WN6J5I5mB9tN50oZntpRc3KY2iiCpHgiDhyU0anRiAX3fKbNyY/J0OczzW841iQ3z4wAS1LHu0RTUB2FTAwtqtt/zncDOKt3SNi+rw6+0Sa94TzrLCbnAwynk8eOiAWQ9b7HvBHlhjGEi7UFHUJ/M3synPKSfZPlG5r7Z0VceepkyA5XQjr/ue9O7d8eMXN0wvo9Zg3tg9Nyjl8x4EWU30BX7YfycHxNGWDfDYLJsBAQqhcdn7pJZqTrljPTFbLM5Fz07QXX/USGhpCzyA2XwNiXQ3zMP6IQsdGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gz3eC5syfQxYu1tm2v7nxudfRy1sbFMYfEQZ+XfdQ4=;
 b=sY3MUTfGPLkl2YyRKoS5PwjPVC2xli03FXjvDk+cOCWZzwK5EUN6XxtcrZwpjX3lBbGMtY2uV/iOGMrT/bId/pQ7L0TDn6kBSXtEOcbXy++fHruQPEIPqBTKaIPN8d+PjQOd4FsrjrrSOScdGQkK9QOntmknORCsXcNqy1qa+B0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4402.namprd10.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sat, 18 Dec
 2021 09:55:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 09:55:22 +0000
Date:   Sat, 18 Dec 2021 12:54:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     davidcomponentone@gmail.com
Cc:     zbr@ioremap.net, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com, unixbhaskar@gmail.com,
        ivan.zaentsev@wirenboard.ru, yang.guang5@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] w1: w1_therm: use swap() to make code cleaner
Message-ID: <20211218095450.GI1978@kadam>
References: <91568d9c9ff18bb9c850687252cbc38389786229.1639792249.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91568d9c9ff18bb9c850687252cbc38389786229.1639792249.git.yang.guang5@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd29ef2c-99ff-417f-b52a-08d9c20c81e7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4402:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB440242205EC1F08BFCBE22238E799@CO1PR10MB4402.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18ZRw825CisHc+V3LrVQICuwEVWbmNQn4PBqZhFjwcpyrxsO853sPC46cq2WQv1BFtAfmhrleKQtXXFZhseej9y5cxNUx18/QuVNnHAyfGvbyGetpFbC/CTfN0dILz7MfzP70cfwByOjvWe/Clh+3W8tLNhoM7x57Y8XNniC8G4Cf6iU6r9mAuXUmRLYEUUQpfQSlE9IZN+ZV2E+Gx5zMz3s809W5WwV0/Jk6B+u/f0msBMARkDjRcwmchtcSw4ut4inaUpvmyCAqr95hq4Dv+5k7cdcCewQKLvp6ZjYZ8kOwTxWvUvLMN0xhGv6GCZAv10DFLQmi5cIok9LKtB5FRM0I4HQ7q8KaU5bUgpkUNeG99RTvg9tZwQAKDHe4c0xSQQvk+BER+mjdCLAegkAduaaoHxCBQ+op3OX7kZ/Of+Na27XuW8yr2lExJ+/pFbluSQ/0gcpDRc/PvmPip92z1z97ooIO56F7/E6c89IPewRvHbgrXJc1iZMgHMa1QxLJX/asSCDUJ8g6LEgMBs4TOx6/0le0sAvxSWTCsmydoI07pyPgLYzthbRDrrYsfGR+gEb2zvjF/cTGazVTzXTNqQlCm5VflCNHD4MqsH7dyeqQqCiK6DyxqWdSs8PXv+bmY6OoW7KHZakMtHuxA05SiIAxMAZ87Au0JEF3Wdrflz/GrWuUSPZB9r+OImQQb4xSz2cFYZrRelYOw/bQj8y3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8676002)(8936002)(33656002)(6506007)(52116002)(6666004)(316002)(86362001)(33716001)(2906002)(83380400001)(38100700002)(38350700002)(66476007)(44832011)(66556008)(66946007)(26005)(6916009)(508600001)(4744005)(186003)(4326008)(1076003)(5660300002)(6486002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZHqKK5tUeVcrfTnwrSz7GIkTzmhAzHneffwL+6Ssfga6z7G+La5BwPM66Nq?=
 =?us-ascii?Q?aUEa31JtVQeAkIX3D6FU7uMFA+womB/y809jzUTFknwBwnRMTN3aLMIRN3kv?=
 =?us-ascii?Q?gk4mgm0VGLBrK5gg8MrwIa1jJg4yDF9j6Tsc9SNbVGv8qzLmvk9zXkUSFec8?=
 =?us-ascii?Q?x1HN0ehBwj7O5tMMj3LG6XuJwDRzXh2PN2j2wTUYMvZ8CD8trxLJrx0chkfX?=
 =?us-ascii?Q?XzCt4Iyij4NCGiqBAK8R0JrkRIsYUg/W35sc58tIjgHWQj0cFtTjlAAQOL2z?=
 =?us-ascii?Q?FOHJi7ABONFv5loUsqbDpNL9/nh0fD3Lecm9zBXws/rhwBOoKlUEN0cStZrM?=
 =?us-ascii?Q?Ob0JsMZCnSTGDwJ6KwWL89VuLs+cVJsoHrEo4mQ7KdPxOKZTmw7+7C44dKUP?=
 =?us-ascii?Q?IB9SRdCg1TU3KHQ33yZu2QGfVPZCVSM5EGYHqA2yeRPniCYN3CnDz0NIAQfa?=
 =?us-ascii?Q?nh/z7tRrjhC4tJWlrDmVoh+aBq7NcP6JtV6V/lGS6b5HLIGCYxkqqJocsizY?=
 =?us-ascii?Q?vXMMYHAzv4mTj5cD1WvlXqbWtrBoptTNhTAcVwqYSsA58YerOCUM2gm7PT/B?=
 =?us-ascii?Q?RRZwiXv7GEHHTPEBk93kEoNnjG1O9xYVYPIzJ6p/hxfS4lK59ipsXdD0pDB9?=
 =?us-ascii?Q?TBodLXrSkPc0vJ/mLFJREE/hqPcMuibrkOy+W9eitYLb5KA4lXVgORHsmvAO?=
 =?us-ascii?Q?KydNgu2UMw++XcsroFLmJAZbg0CaKR9+CsUB2fHjZjeTio6RkoMbxoh2pU+l?=
 =?us-ascii?Q?0zWHwJCog+52k1N0Zy1Ta423jpwrYU5AHAW4uDnTW981qpZTXzHsJxV2HX8s?=
 =?us-ascii?Q?KyUCHwmShZX003tsPr1TvPcsOw5wvKCjDCE0hlnTaPpbNxMSxim+Ndh4NPko?=
 =?us-ascii?Q?1LWzQhwNFeqXM1fUgYmdFWiW/+Q3oElIDsZY8jy/n9VNw0c/mOk7TJvBFNiL?=
 =?us-ascii?Q?wcJWLlZvBuX2A0PUOWASwOa0ththG2k6+si7XstwSzfk1m8/OsuCVY7raBAc?=
 =?us-ascii?Q?WyNiAp5CJEjWehxgd4vhy7GlNRnUozrbYFSInQD1iMgEYUNBQRlSioEBeIbj?=
 =?us-ascii?Q?O7Bwv7iGeY6LHVkmAjdzRNZsiB9t/B85b/IpBJsykm2ENNch9Qah76Dc9XHL?=
 =?us-ascii?Q?flhNC5rKVE+WCvsx+4J4dq+SdjcOX9fwQ3mbKkMogqyCG+6Mc8QKFv7F26ha?=
 =?us-ascii?Q?IqWyHyZYGCp3VmprkNXreQ6xeWYSHIt9wK42TIYstalMBB3o900lkreDng66?=
 =?us-ascii?Q?RTjb+2Epnjf2j2trPhO+JIJe87NJvxLaRCJKngt2YZo5pniKk6fF4OETQRUF?=
 =?us-ascii?Q?fdXjpIZij0v/z7zSntiQ+qVjgEN/NfOUXYwCDPbKGisUkqnUJr8uwypqQ7hI?=
 =?us-ascii?Q?Qh0zFGwjq8+eTBYCTpjKNYEnjG9QbtKY5f6K24xgGUvdpEZOrDjjqEDsDlf9?=
 =?us-ascii?Q?yspB3pXHUjtSHUxWGMrGGlY+gY1oSlwQ06Iu14w3bMgzWfGlaiOtBdUfJP0h?=
 =?us-ascii?Q?EXYPrrdHoDraeC4wO6OIjIy0sV1xjRb9Icw9zpDN90c01sG3X4smmsQ/wnsH?=
 =?us-ascii?Q?oIDOzVVpoayIDWH8c/kWErhi1Fk6VXPfvJsYMlmM3ebJnvvY5kAOqzhECBUl?=
 =?us-ascii?Q?ZglmZyY2zpIHTXKT3FIxev+A2niO8LMLAtAPQhDJ3uCYc/hSzVNOtTtc1IMF?=
 =?us-ascii?Q?7GadkV5MMvX03H6DGfxS4nP8UfE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29ef2c-99ff-417f-b52a-08d9c20c81e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 09:55:22.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K7PILOSYqiADkDpb8+AKCh17+8+nMOCnbBo/Y22pfbp9GdhOUQSn3/CpduqpHrrgHjYJADgYxSuEZRF05kb5oDXpSrpKrSobF5VawOLCAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=761 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112180057
X-Proofpoint-GUID: FJIH4r-CTqK1o1IRUlRunWVFFCpJvQc6
X-Proofpoint-ORIG-GUID: FJIH4r-CTqK1o1IRUlRunWVFFCpJvQc6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 09:58:44AM +0800, davidcomponentone@gmail.com wrote:
> @@ -1837,7 +1837,7 @@ static ssize_t alarms_store(struct device *device,
>  
>  	/* Reorder if required th and tl */
>  	if (tl > th) {
> -		tt = tl; tl = th; th = tt;
> +		swap(tl, th);
>  	}

Delete the curly {} braces as well since they are no longer required.

regards,
dan carpenter

