Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F894ED570
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiCaIZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiCaIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:25:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC75C6837
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:24:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V4FSqV030446;
        Thu, 31 Mar 2022 08:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oYR+VrbSlDAJHgfzvdIIUIbFn7DJGMJZqsNCEEI1ffY=;
 b=PvEo+car2Rv1dtCYMluqXEBCPWFRH427x6wkQv905x84Ioh7nhM/jjRGlLM2mYSvu74K
 i2GGOtXp716Pa1tXPYnsz1tUuhu0hl1CvfyVNY0pRGdUn1B/WPfsaL3yAfYdu7epBvZZ
 8OxCfiY5htn5UxQwTmraqND0qPOrodKWq5uApHnpYfdcZ/RCGjbUgJdG0jJ7YW0Pc04D
 E1J7XFQ8pYvb082+DTAsVXn5DL0GvgsOy3yzcPfjehEIcDcvK44A1vEUdN5jxzJWtqYa
 YnXcErF3uC3fljeYzSlR+/bWaVcQrddfNER5/11xZyzyMkmOR6mVUSVerLVWvMM13Qe/ ew== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0knbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:23:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22V8Cbco026831;
        Thu, 31 Mar 2022 08:23:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3f1rv8gabb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH9O5PBjKNDvkiuTX6DaG1JL0yQTO/G/J7wJkZHZbF36/YB6rSyymbkiqlIbjW7zoONGAaaimWzxORshhxOlhNBHUhR5D+j2M8Vo6vLIBrfkZM10xvdE5IIGlCiNI3/ZhBhrZ2Bp+Pgd84nXXeLJs+AR/BhD5OndILOLw13aFM1pVTREcMh1JNbUfYrOqi2b7qpwjxuki45cPkciqok80m58vneNPklNg8tUNUYKXh3rj0kZ4mkVACyujQlW69D6ALDK4pbrT9aQsv0sw/3gpSjODVxyddgG6wpkBkRpKpQb0XiLoZHvTC4eGYgY9SJlOrQIU0OQ1DBev7p9jTS27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYR+VrbSlDAJHgfzvdIIUIbFn7DJGMJZqsNCEEI1ffY=;
 b=APzWVKl4nMwPMQnrVa+p0EJD+pO/Nedwa2ZguhBaOvcSam5xinX09ETl9QBFgzEu2d/rLumdHdR2knxKiRJ1xD+QW0H7dZvVTnEK/DlYiLoecujVCCli06dy6K5UZpn/v+YmUQaZ0vR6WkHcScMjBujxB+FGyjNV8UOJl8a2Eip8+g6SYAIN/Gq8oZv5x/qC64czrgAg9tTZWoa5bfyEjrOH5LoCkaYjaWDsZHF9SeJuOGR6RUK+S2KMIYFX1gcg2YyB7fhaCJqxVcGGQ9Mja3ZPh6EnYS+ctsh6YzQoobAD7zu9VXcBGcFiknMPsD0MVOvqF4puFmXanlNGNqViFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYR+VrbSlDAJHgfzvdIIUIbFn7DJGMJZqsNCEEI1ffY=;
 b=TK396aY1H7TgZXRw4g44H2Mt3C6lFSTzNf1Mi1L93AHRwyXtWHBSdU3ZnUZvh/wsEIRn3gs+OKl/Juj3zWy7R4OG/8LreYjBoVBwiyP+IBdxn7i3gNZVW5hvDxBCp7ZUh+IivG9FNug01m66lO2nGq9TkVArcQJwy3uqW1s9FgA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5474.namprd10.prod.outlook.com
 (2603:10b6:5:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Thu, 31 Mar
 2022 08:23:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 08:23:52 +0000
Date:   Thu, 31 Mar 2022 11:23:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com,
        David Kershner <david.kershner@unisys.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: unisys: Remove "struct dentry
 *eth_debugfs_dir"
Message-ID: <20220331082333.GA12805@kadam>
References: <20220331064751.29634-1-fmdefrancesco@gmail.com>
 <2098282.irdbgypaU6@leap>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2098282.irdbgypaU6@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94427687-0375-47df-c025-08da12efca09
X-MS-TrafficTypeDiagnostic: CO6PR10MB5474:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54744C4E2607335E25B8F3AA8EE19@CO6PR10MB5474.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Te2ZI9sgDRobAmF7Jes023ylsut3kVzjjeE5HG/Gy+7vBeT0qmXcEEyfHIqwmC9f+jY4uFuj7pWRXZe5THztInRCHNHebjffZf8NcqJwgd9E8UV41QXc7Hf/3u+jYVYsNfpFeiL249tOJyzVn9zRk85MFzKzkW0c7Lb0C0weYfIrZycTl5gRWQH+2Lkc5w1RwVgaCaUxMz0YvFKvW8kzRdrHyNYI/5SH/6HKIb5SlfRGGovcQk5x0R+VzQMXvtMvWOWdAVJJ/fC6XlTbTAIzs9Yoa5aL+jM2tVzGv/W5/2jvzYPGcEKFz+b3fvD7YbAe6drsyxOm2Xc0HEpG7DLN4cV2rqNUM/wpYYBJqx9vlxBal1BUoRDMEe4OwApOWgCP90MQa9DE2ovtRgFeQfwEhxEHhssdg/fcEoViofyeZ/IcjQouqQ3Ht6LsAD7VuHZlURUh5McW05sVlut7uU3mgMlY9zwa28/MT2lsBr+8JSY0kUHA1wHAclMNVH8Mky0dftWpYyLeMVhxvT/teDF+b6FJMPWydTeUX6XzT1ZD4qIIHqJRnbRkaIfQnGdjY0l9XzSrNj5obFFpPOnDbkU4J68Aoo61/7s7a7uHydy2LHb0ItH93KOq+ZtW6KOjmolWSxVIfYTQ/SS+lIVlDBsfPC0oA7m+t4bE+VzfmNVdONRN9nlkyZYDUY/TxX0dgfVehpiarQ2cCsZAZFDKAFOKww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(33656002)(1076003)(86362001)(508600001)(316002)(2906002)(558084003)(52116002)(26005)(6916009)(8936002)(186003)(44832011)(8676002)(6666004)(6512007)(38350700002)(4326008)(38100700002)(6486002)(66556008)(33716001)(6506007)(9686003)(66946007)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+YaOv73JG2GGUysmcJtDuJrwyvuZhWn5eUms8wdlk+VRYYxxLWfjq+JEul3?=
 =?us-ascii?Q?3G0UXGM2w3hYeslZ1gYfzZ17yXM2u/n4x7RugE6P/ZudVM+otjv1ph0PwiFJ?=
 =?us-ascii?Q?W/uwyDGTnP3QH+CX5WFxgDnlNPT0OhS3IAUw9aHFpSg0ZcmZ9CsF5zPIGN1x?=
 =?us-ascii?Q?BTI/M4Dl7bKe2aJ1eHdNWOXAF/umVDfX8DhQYuEsTlhZJijZULMXlWi1hPf1?=
 =?us-ascii?Q?HflD+RI03jfcjd5vAtbkO7tErFwhW6MgM/TWnGcbSM8+WNQzUQmACYF9E7fD?=
 =?us-ascii?Q?iPVUV6btjJCtDPU7XvReiZVRObI3V8IdcJIQxH9Fmue30i0hIF6xt42dXj4t?=
 =?us-ascii?Q?KvZAWuOo/VzmAVXo5lU01q71fHSONxCjFy3m1sOAwWdolxltIYraCMq+/mUX?=
 =?us-ascii?Q?i6r9Zz6st81XzpFq0MazxztHLuF8+d6uUJ4PzanV8lvaqG6HTjDCRBs1YZjS?=
 =?us-ascii?Q?JePOvZmt3+nN4NozjoD4LVoA/cuYSdAuHsLQBDhox5JsVYoV9ZZ1QOmn/Enk?=
 =?us-ascii?Q?Crj706hTntuo3sdT5eZpBCut2NRtKGyJRxUS9q64hiktnXhzrNZ0u67qCQxQ?=
 =?us-ascii?Q?pKDatb7yJsgXZj93ktbNeZSJ6XrQPeliLLTouYXqpFjD+AqZSaCSpEk6H74Q?=
 =?us-ascii?Q?ZNeE8lQ0CE5MGgYSNSlUiVS3aYvaExj7/iasxU4GBmghbomO+UXhx+fQz2Zk?=
 =?us-ascii?Q?0ZFGh/O2YUCAV76bvkgGwVJcdv4UBFHUmhXY4yi2tq1R7cwdYbJnrQNTy/Bm?=
 =?us-ascii?Q?SjBQ2qgVU5R6MdhroAnSUzbJ8BXrMKP4z9bluG7U6rQ0l3WOF4o2CV4bQL6u?=
 =?us-ascii?Q?TUDZZTt0z8PzN0NyA8tBmkrMJ0fj5NN/LXW+AKjYhNXR0smPhGeL+k4e1mEK?=
 =?us-ascii?Q?U9bex0PPdC1lueGq+5XKYsYREVGs1xF4E22Utg7rGZ6CFp7RjBYD0ztlP56a?=
 =?us-ascii?Q?7qUP+9U9walzNhOD5HEECedtkNZcLhnHK4s/w2l4lzGA6PW0lfrzH5xoDaTr?=
 =?us-ascii?Q?JIa51lMGG/AvGJzbtvfWubnv+aAINOzOaxAOH8nsqWk7mrBTcovpWI3d3IcT?=
 =?us-ascii?Q?87xlMBbZp+pJshnDpKrGVtVn42XY2fCB8r5/goByPnzGxeMWIHNnR52p9VRY?=
 =?us-ascii?Q?uqhAyaU2bFu+tIH+/GvbYGGnWZ954Od8gt7btAD9RVjIXexQ2lVwlWbxfF7e?=
 =?us-ascii?Q?6Usl/ksyO44OQuOIlfFW5B4nCKqyRhXCj2QHRjgiSH/BlnBICu0u4KIks49C?=
 =?us-ascii?Q?l/vrBtpol87pm8DLreLrWTHtcWa2heHAnjTBNO14Yk296bE3hYzk24DT3jp5?=
 =?us-ascii?Q?Jj3qhdFL0cb9cbMgH2wrzuHTF3ywje6CCYcJ+pinVepSxdfPAHYdkg2oZDpD?=
 =?us-ascii?Q?VwhaCfVAb37xPErw7XPeFD9xLS6ZsmeOPnmyRuUH+GZwv3KFmIHbUBTxfOjL?=
 =?us-ascii?Q?AHljrwQU7hP+roMYKU7QFCb3Fb/cxC08tcpbjVuxrGEl7UWja4pt/MRuxoDc?=
 =?us-ascii?Q?mrZlwN5EU2x837X1AauNlLgdTw+9qUXg1f0kloaLaXARRUvfoBQOnoKpP72I?=
 =?us-ascii?Q?Riw7yruWe7cZQ3oF9X80Pyp7iwcdtkVYkflN2sbhg/TnkYVKUTPvNnKTKTeo?=
 =?us-ascii?Q?eoh8/coqjRNtBBj41pRcGiP3pS8ywSWQ51mDyz4iYWVe++5/xT5lBHSNFxLq?=
 =?us-ascii?Q?bwsQ/5ACPIus3ZrpMI0ykO1ZNFF/S3tyTV+qw8nnH4yRetFLSqcHYvRf5srg?=
 =?us-ascii?Q?rgU1pCrUHeVW7UB3E4akacnsgELXky4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94427687-0375-47df-c025-08da12efca09
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:23:52.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfqOYx9E0HHbrNrnI8jehtTPbF1MoeIAt4tfaoDW+V37xz3ZM1K97sNQEruLtOldXLSeYjXxCf/Ht1vWTAkJzuHQGJAKF0iaX+hbAHDcMjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5474
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10302 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=640 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310045
X-Proofpoint-ORIG-GUID: mu8nkXJimSjz_3BqbMiUn8rkA9JsD9KK
X-Proofpoint-GUID: mu8nkXJimSjz_3BqbMiUn8rkA9JsD9KK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:00:59AM +0200, Fabio M. De Francesco wrote:
> Is it the case to remove his entry from the MAINTAINERS file? I'm asking
> because I don't yet know how these kinds of issues are handled. 

Yeah.  Send a patch to remove David's address.

regards,
dan carpenter

