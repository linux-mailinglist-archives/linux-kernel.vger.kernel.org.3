Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894454B0B28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiBJKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:43:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiBJKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:43:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3593FF4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:43:29 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AAA5VP008857;
        Thu, 10 Feb 2022 10:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=lev2qQmD04Rt2YzCExTcHTJdzEWIsN8LTYsISuZgxNU=;
 b=Lj+ZEqGRPB1bemmshGjhI34ftBJPd0RJ977dBMwdwGsk2eA1V9T1Efe5S4WvR5oQYJdK
 umcuH5w4qeF9s4zgRCAJfzxSfwfZnUcIpn68AwebVy1mTR+V+tgA5hxmt8NwiWLFm90T
 0tV/HD934c1V+QGZ1Y/2cCpB1oER6H37ND/lR6Pq2I2pZQ+dyI5CQho1RcZ2CVIjPn1l
 I3IXAOCycCmBZ7e1qDOqdpYAhthsn9if5T71VI5X1Zq2fIZSfnQ5zTXSC3CSu5NgEiHf
 REJHmP0aZQqjmBnAYIYxgPT3NYmQIQjzd9fCV5Vhumo1xfw2Cuu+1qgfCamOSyRzkpVd UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgquyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 10:43:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AAft7b169283;
        Thu, 10 Feb 2022 10:43:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3e1ec4khcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 10:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXPalVbRXQ6dB042ZzmtqtTSqw/2ElrKAXEdbZrE+62GjmPvJ/4qs7HndxSTZQxJPS+oSixySxhG2MHQS8SS0j/p2rP9MqV1/ZYt6RnG1HjXbtJ9h2mxjhuJ/F6tNJwL4NOdntf7Gp533y6UgR64lZDmNiUPd5G0glJhcnT3n1W5sWKI56UnitVAPqHHkPAU1AUdj3iKUdKGNevGZRvJXM4NysAS0XalryWVnCkXUVIOYDLtuqNC8MdcMFbbHXT03s4kZIsvwRZ59le9yxAxd/chxyR9hySY3GzftZjaJiEdiucd6rddiD8nx4/faU96Tmly4CpWDbBx26h/6jvHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdJu8chJssmaWEY1ufYIqkqu41jHxV0P+5yYVe+IVwE=;
 b=a0F5SIoLGnwB3/jXxzuOzY/9NcjTxEovKjcUXkiX4kH0u5uq6rwZksnMC+K+5JlZvQ7jsqhg678R1qz9sP1XZm7zFiVrqYHOKfNHAnT4LPjfiYX73jjG1eHhUgJMk+SiseY384xqkBL4fYtIgZjlZPirIT2FoaGTNx5+P4gA1tRVHEpQp4nq+gIk441xhc874BEpca5rYWi/dffGxkBgyJE0g3SR3hZprYCtsvsk1OMLo+rBvKtCGKLNXsa9H8m4FnguHJiviIhy3cgAKF9pmoUaFwOIFMkPR3UuFbS5Me7079tSI7wd76BIEIKQW5NH1xCOb+qkgC8tUsSmNhRO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdJu8chJssmaWEY1ufYIqkqu41jHxV0P+5yYVe+IVwE=;
 b=AZgsJn8UNdwTHPeea3A5UaDkhvj++kjE/tIqtE6YGi4HExKZqEBXe/ParCdQebnxjAoMSqTzTOQWhwCTgealKH/zvaOA634OeXcDBc39B1EdjxExkwd/0mSWEIrKWIhSrYe0lg/3gMeAb+PbItmRBvs7AiQoWHnEqeJGs8mHivg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1353.namprd10.prod.outlook.com
 (2603:10b6:3:9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 10:43:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 10:43:10 +0000
Date:   Thu, 10 Feb 2022 13:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        'Jiapeng Chong' <jiapeng.chong@linux.alibaba.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Message-ID: <20220210104248.GW1978@kadam>
References: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
 <03591933cc384d7e91ede82f0cdd76a8@AcuMS.aculab.com>
 <9c563d78-f883-65ee-9e7b-cf44e3b238e8@wanadoo.fr>
 <20220210080603.GJ1951@kadam>
 <eefeb019b58e4b1a814462c709d224b6@AcuMS.aculab.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eefeb019b58e4b1a814462c709d224b6@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0053.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1539f2d6-0fd3-4655-b38c-08d9ec822164
X-MS-TrafficTypeDiagnostic: DM5PR10MB1353:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1353D039C41B2CC62DA24C4E8E2F9@DM5PR10MB1353.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbZPqxQgmBgJNAetWWC6qmb2PMsbMG9a2tCiVxd2gRybGyT1qq3aXuGMTrXptEuG2BR57yvWta1fStisJ5xr1e7H8/0dm8rHuoa1vBR1lzL2KtwzQfCpflDvimfXsUki+XzBv8xBtusRE92AhAKeKt+CBmAnptlbM1mWwbstxzLqYgo6VxIIuGXvZQN2NFpIQ+p5TG8tOL4gWhkMls2w1Jpq1cze7diD9t8MzznS3SZGE4jxB3zHo+KYpS+BoOwaoRaW9bk4DOi3Kr8I4wzbLhthdLpCu8XSrqyx7I6DFac2CqOsl3ujpyaOe9rn2QG2Wq+ye0fkBa6iiFj846tN+tK4jg6OImImRPnGWcVSHfNeDFwoWwr8nsAQgeA6wPMgdGpwbn9OMcXwfUf7YEHbnbyQCSjoRaSq61poKj7afyTmFQNjG0Lwx/fE/QWHGNoLmyTKoSF81om9fe3csOL9LMxZySe7IZqwAc1W1dI95YRM6mHEwWnv2+WhpVNxnQ2WtyvGSqEPPX2KDjG6W7NyQsJSPVqZLxUrUVVShuvdLTbvIlQA1YMZVx5K+1bpi5eNIdOwY9xTcMIXZDYt0/4ul1TP7bZ5/skhIJrKmOFOh0INKEJBcpdVGNbv5rb35XEyQk73zzq3AzVmgQTDsJfeBSi+90HQmMCI+KGhdNok56EUM2t8+9YqLEHgh3lLP0HnnKSc2cjS7cGxmkEXrzhPci7XtSln0nszdMYifghg9x8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(33656002)(86362001)(38100700002)(38350700002)(6666004)(8936002)(44832011)(5660300002)(6916009)(54906003)(316002)(6486002)(4326008)(66476007)(66556008)(8676002)(66946007)(53546011)(1076003)(83380400001)(186003)(26005)(52116002)(508600001)(6512007)(66574015)(2906002)(9686003)(6506007)(3714002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UKIeUoEaMhuYoiIkKyFmOiCjaWQVY2EkH4NjqyXEk3vgouJMJ/NlzMU487?=
 =?iso-8859-1?Q?E5L7MZ7NO96h7yOLb6jPrebJWSUcrNM+aHGe7dmK5nf64D7EpBattSdY5n?=
 =?iso-8859-1?Q?4r+zjweV9mxNLU6//6k4qKsIabmuSAIecsDXNaH+ZmMwVp7/16jPmIlYqf?=
 =?iso-8859-1?Q?+kK+IpsE7F9xPXydi5R3+BwMF/A2D6xT6Yry7ymIvgkc48EwM+CMAb/vaG?=
 =?iso-8859-1?Q?Cehn29Btwl+vKXG+lhoYWB32ZgJTXrM+/hx+V9yL1D9Tz0PGSzbi3s+3nX?=
 =?iso-8859-1?Q?XkiRPANkoqFb7SaChUdVZgCsVsngmGoykWqzNKUPaWJx1pdGUB1athVvKe?=
 =?iso-8859-1?Q?Mi1/oDUBFYO1KBO6v4g/7tkeV5NfZagxmDCiM1wYkjyYue+hZx8k3EbpyA?=
 =?iso-8859-1?Q?xSbUc1DoAO7ALIHw/zzS8riSCzpjOO4iQ0523BPMefbITsbfYI68ZPxYZv?=
 =?iso-8859-1?Q?bQVxg8Aq0OZ8yjhbFjlqD1VbzUjXycI6bLo4RqeIaLb4xfptYnG2OlzK8Q?=
 =?iso-8859-1?Q?fGrmKrm8659XTMHqsWlX1m/Za39caT2kJ+XzG+pNeJlzh+bOjr4p0q2Nrz?=
 =?iso-8859-1?Q?ic21ys/rrh7+h6eJCkSWkR4EGsYEepZrJ/Qar5X3x/JzLYcwpMiTlt9RQf?=
 =?iso-8859-1?Q?KwIJt5GL7TgWz4QA4FolwelpfuSwMgUbvTkVeP4NoIwCybktVvu0AijBD5?=
 =?iso-8859-1?Q?D6xKYEvM3Q+pJHSFFA3kNFYvg0h6IDLnOFU/rKEnRkEdnTmDNJ6ptEki6X?=
 =?iso-8859-1?Q?suLIoY9628jPpzR0B04DzvsTW7evKss0G0+hJ0SiiA1YK40dFLufP6E6iw?=
 =?iso-8859-1?Q?cTowQvWs2hweP1I5/BOWsVj1aXh8GNqf/bj2xx0G2vlUyVoUx4+dUggIV7?=
 =?iso-8859-1?Q?l6Fm/IFebu7B7oL2bXVOIRaZbNAqfr0HGIi6W6qj+L+CtNnGlSy2DRgfsf?=
 =?iso-8859-1?Q?A5TVcMFx4sQfCxu09a2T5zNfEXIPvMT7N9bv3IcoQxTtDDimzPzN8TSTWj?=
 =?iso-8859-1?Q?nCCzRWCYDTv5rrpfbNZLZEfNggnat0UVMjEHwabeyKiBTz9ljVmeeqHWje?=
 =?iso-8859-1?Q?QFlZEjjk2/fsRVtdJ8BLG+UwhvHv8bbcN2cmWWREh5ej/0lyMTUK9LV8GK?=
 =?iso-8859-1?Q?yuf7/RM7hfL5imx3SXuz2mvmC5Fal0jJw5Pdpz/e+8KEe9sJMzKtMC+KA9?=
 =?iso-8859-1?Q?VyfejICueAqY73LBPLYcrCPng/g47wrLVZqsZ4MN2dUo7DVK/37GRDsfHu?=
 =?iso-8859-1?Q?lRMawYNqawXJWZnpbMKyRcYjtSosXKJ3Y8VfVUOiF3fx10gxzGOpBoIflC?=
 =?iso-8859-1?Q?dZqER58IDxKTQjdtqMEzl4CQLyrw65P+OwKeh8KC0V7t/bhz61kygCywF+?=
 =?iso-8859-1?Q?4Ma1T6FNFeVxwWo3HF6yejiihCwlkBmB0k6A7rgS6CIoW56PD/UUVMIdRy?=
 =?iso-8859-1?Q?xpxtXWcxEJ2O4EHph+FxVWaV01LynI2ZmZpgNA1ZwYcmrVn8fHtUJyiZ3D?=
 =?iso-8859-1?Q?aE5vsPDKAUp9WBLW6xXz0mnvvVSZhmP8n4E404osjQQj+wamFSpECuZr6s?=
 =?iso-8859-1?Q?TQgN2/qkIkYY/IgBEj3TAWBeMuOvnBlFTMCRD9F0Om0WQkQmyXPY3PR9/I?=
 =?iso-8859-1?Q?BsS4rqcQMr60EUAy/a/v9b3iVqdFe+5NhnSPhoeeuqTk/R/p9BuiDv6w4K?=
 =?iso-8859-1?Q?GWR2365tWWMLvlyU+7+Xp4QXPVii8T5fNDdmmgAX7vbdeas68Jdk5VVvPF?=
 =?iso-8859-1?Q?r2pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1539f2d6-0fd3-4655-b38c-08d9ec822164
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 10:43:10.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcSpK4rB8KVjT6I6y9qiLaEaHVLHBGwRiT+NuWWeqL4PqOEJ+9tg7vallNj8jAmldJfee3fYq0vpm6S90ooWFB0j0wmH8zaNKIKOj9ZFfxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1353
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100058
X-Proofpoint-GUID: zLvszeSO3oPwWAIZn94Qv-IYmigWM6lO
X-Proofpoint-ORIG-GUID: zLvszeSO3oPwWAIZn94Qv-IYmigWM6lO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 09:21:08AM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 10 February 2022 08:06
> > 
> > On Wed, Feb 09, 2022 at 08:15:13PM +0100, Christophe JAILLET wrote:
> > > Le 21/01/2022 à 14:34, David Laight a écrit :
> > > > From: Jiapeng Chong
> > > > > Sent: 21 January 2022 11:50
> > > > > Subject: [PATCH] staging: pi433: using div64_u64() instead of do_div()
> > > > >
> > > > > Clean the following coccicheck warning:
> > > > >
> > > > > ./drivers/staging/pi433/rf69.c:286:1-7: WARNING: do_div() does a
> > > > > 64-by-32 division, please consider using div64_u64 instead.
> > > >
> > > > That is one of patchcheck's worse warnings.
> > > >
> > > > You need to check the domain of the divisor, not its type.
> > > >
> > > > do_div() exists to avoid expensive 64bit divides when the
> > > > divisor is small.
> > > >
> > > > 	David
> > > >
> > > > -
> > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > > Registration No: 1397386 (Wales)
> > > >
> > > >
> > >
> > > Moreover, the patch is broken by itself.
> > >
> > > See [1] were it was already reported that do_div() and div64_u64() don't
> > > have the same calling convention.
> > >
> > > Looks that div64_u64() and div64_ul() works the same way.
> > 
> > We could mark those as __must_check functions.
> 
> That, and some kind of AI system to filter out untested patches
> from (presumably) students who think that the output from these
> tools 'must be right'.
> 
> Same for all the patches for using swap(), min() LIST_HEAD() etc.
> They are at best churn and make the code harder to read.

Churn is kind of the whole point of staging.  Generally, churn is a net
positive for any subsystem.  It's good to get eyes on the code.

The truth is that I looked at this patch and thought "I don't know
what do_div() does" so I moved on.  This is the first time we've ever
recieved a staging patch to convert do_div().  Next time we will all
know the issues with do_div() better.

Adding a __must_check is a good safety measure as well.

I've looked at adding a Smatch check for ignoring the returns for
functions which have no side effects but I've never completed that
work...  :(

regards,
dan carpenter
