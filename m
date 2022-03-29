Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE44EB2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbiC2Rs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiC2Rs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:48:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F71E7A59
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:47:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TFxNU2010693;
        Tue, 29 Mar 2022 17:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=ky6jKUqVUx3nvVAGnP0ykQxYXbVTbMCUbso+r737BsE=;
 b=gh4w9g5nfVCLlIuQZpBalwfBlG5qH5q9ROd/VKhwf7xdu378wQI8a35RO+CXygLQ60/P
 QAJ12amLQEN7OQXv1mDQCWQ1Fx7RqPZYkZQzBCq0OJlMYqDnOPOcFgXPj0hbTMptoo1w
 eC5oNKAlxgz2IxYzvhmXfbpYHx98XhYL0+2zRDL58v87C60prH8gHC7BsUAUg5jWigZ+
 06dHS+Ov4bqYMhYzKfQX36R2h0G38i6PNdj4kgN/slg+dkeQYTSSfE7HZtUmLYDxIWiU
 M+hS3yDjBQUj8JKcAbyjJRppovOgOapCQCAwc/LMcQmv7tiH4Ybcxpr/BkNI0XBNw6is eA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1teryaqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 17:47:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22THapOE136239;
        Tue, 29 Mar 2022 17:47:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3f1rv8dd3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 17:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPRw3ATZkMi9t25Sff6s/4bxZFQXPx0c7gFM5jiJXnqmqOldHFjla0XaYW7+R5dnZYa5Vlcr+Iq9PL9P5iTZ1H5vLf9Yz8ZkZAiDZ6+LuFm803M3j7fDVUX7pAdln0hhwZv40LCeZoGzchaJiqI405Hdt+nuZi8Cd4PiemtqZRGK6nmQFirARqkgIfFWfAClF+AUulf8UIp+g6pBeYRtxl6b3e2BxlusAjuNrbppSvc6faBbZRrpKcOyuNmBY2gRG4iVlUyHR8LxSv7kns6OtYp/uIvxi2lVR8WLDfoAlcj9ufcfQwfaRpvbkKfqgU2fK5gKaGzA0C8p9KCYNJXpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4UX1ewd/SIbnWfuNel8bnPJINicPJ4WN1wRCEqhEPo=;
 b=IgSAYJYQMsHREthsou4kvDvvjuuVrr2M522VdtiQuGSCMtFHfiKkwSxU3u4c6s19VF8TdfzxTCjIEy8dwtN3+Lasxnm+ISbpkYs2zWjZ5NFe4Id04oGqTw07EMAmsT2XsM6HuLQWZJH/QTX07rw9T5yX2wxymzHFKykpk57FdwGyWpN8OG2Pg9KUR9b2zpd4hKs5VTC96VxLQt6auc60klTKPYo/uVBQz15ibnrweEheCK4Ug9kBWKkm0cQXZc1Wy7zlWg4BKM4DQoGSdHlYBQ732L2mJ5tWQ+QjyOaZtIsOd1emo4cmuEJoV2NQUdzT0LoNW9ubKJk258mQ+hk3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4UX1ewd/SIbnWfuNel8bnPJINicPJ4WN1wRCEqhEPo=;
 b=sWgB5Qy+Prvthx4I/qyBF+yBNdP08Vmng2HsvtBwBPnkJhyUlhp67edVvz8dZzOSjChLXJV8ckqnngUg7QyDoauqXzqPPjpkFeqbDRo81cKuVNJR/DWboMKWLN6P7fTjfn7dP+gExS+LEa5LGGRlSUyI2K1Y2WGZR79q0sPi9Fk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5163.namprd10.prod.outlook.com
 (2603:10b6:610:dd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 17:46:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 17:46:59 +0000
Date:   Tue, 29 Mar 2022 20:46:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: Properly test debugfs_create_dir()
 return values
Message-ID: <20220329174639.GC3293@kadam>
References: <20220322083858.16887-1-fmdefrancesco@gmail.com>
 <2030244.KlZ2vcFHjT@leap>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2030244.KlZ2vcFHjT@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 908ef7cc-7607-4ac9-f1de-08da11ac1fa9
X-MS-TrafficTypeDiagnostic: CH0PR10MB5163:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB516383AA6FBF981387762C448E1E9@CH0PR10MB5163.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDmJjLlAc0988FZonzdT4nsPrvaGSCAf+NMIYVRrU4U/HKhJPfApf8UxbFBCkfav40S/iGenXBuzrd2hE1/SL4Au1tGLxIT75TU9+0fuQ9GEVPdN31VfvnmSK5bJuJzbpxHwEdbj8oZU6cLuisWLHjm+slesjSXQRQ6uMwiXImAR3Va6RIDPHv7YUR7dPh0zwRP+r9dsc4MOwEQmzRni0QJ1PcCnZlFpFQ6gkWzZJ45ljy1fJN7JOQiSvDtpbT0M55DSHKWe59DRx5VS26r9BoCOgUy6UowNIBnV9maYT4NKCdTv06Y65QKAG7CpK/1Bcp1iKX/uPKaLiYL52ldfv2dlWEkn73Jp8zj3rwF+6Ar6jr4kWGS6qAzLkxD6trfpzb4eRjWJsDWiLw22Zi3fgAcYzq5LifO+ouP8kkPj0xY3DFFalkqxOgi6h6Oc3WpJecd3ZAfcwwtRSXFgRNsffzc8qXgyCecKOG3DE7PVK8iwTFm/DH14V1UH9G1SpUyRLS5rPXv8Rv+xg/Z82L7D5Yur1IWdP1T+F0CKpy79eLcOxVlKgQonp8vaBXkGFeUm8KfnqA2Y0QUGlTC4Grnt3N8mcGhNtf1wvtYEafmt5jmJetyZv2Nb6d2pEMOBtD9Nvs9ZG6rhUA7adbQdz3fiPVA+zQykjhDo4OJ7zooQrLlX1fo7FWRJJ/u+uzPmLadSkTzgsmi9fKXSQPiG5kn8nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(5660300002)(66476007)(38350700002)(66946007)(4326008)(8936002)(6486002)(38100700002)(52116002)(8676002)(83380400001)(508600001)(86362001)(6666004)(44832011)(2906002)(33656002)(1076003)(54906003)(6506007)(33716001)(6916009)(316002)(6512007)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8hOQIrCuzcfh03Rsv/+9+Mwd6V2vYpRnn7gEP8giSegNxN43/koM97vPk8?=
 =?iso-8859-1?Q?OqVut6rvZqzS5xYBNcci7Uc1VerPcrR4PwHsYPLZR3UrRRv9wpZCbsoXI1?=
 =?iso-8859-1?Q?18Hd7eg1mDMf+Wk+t5iGQt7OXucu7aQyOCnG0YX7YmlNr3SyQdBQ1Dsx4r?=
 =?iso-8859-1?Q?BjfboA9WcUieV0Mbb7rNFfpQyANAWxGMcd+w1pUe8Zm0L+XzsoiGRWJPe1?=
 =?iso-8859-1?Q?Vmg7hWERIYsAHzgzWA5LksbxAwaNFdzXmtmti+a2jPYxfA7yqfyA7dlx4h?=
 =?iso-8859-1?Q?lf+jQvbothnjbSrApq//3mD78ysbH95LRNUKg7a6Z+w3NBHXb5vvCAYwwe?=
 =?iso-8859-1?Q?tCMjT+RfWFP6bGP6M6jKptpwK20Y89P5H4vjdVfL+XpMJeFpSbXGo2pJji?=
 =?iso-8859-1?Q?Wy2SAR/qGY2FB+TJaxhW3xNONT2an5cXLQHm+kfLWdUBfT7PAaHcaAT0Gu?=
 =?iso-8859-1?Q?omG5MXIfBmc3X9Vul92XtEWpO+uJn30LEQVBxFLDr69ZwUb4+g/sJ0CH/b?=
 =?iso-8859-1?Q?/FG0f4Rww/JIBYh8t6Oj1zZg4x3sBIhtTgvs4RYRmlaQAJiZgGeCklnfDc?=
 =?iso-8859-1?Q?0H31iFo8mrDyuGLmjtcrbzQpJe79h/aO9vlkbBBE8zcoEqktHyD+jeecDQ?=
 =?iso-8859-1?Q?lOc6KZ4+60AiD3emco1jNCQF5CViqfLTtHXHwGv5F1gbpie3uBRUN/bmbG?=
 =?iso-8859-1?Q?7gcxGNZSbPP5axcoAMdvxUf3A+ogVOs6wSTQjb0ZLL6J4tW1lNVi09lBpO?=
 =?iso-8859-1?Q?On3GFpJarxyvLqGUi4sFExCZr+RtIRl1meUeckBJl+psqXm+X/HBeyDbQv?=
 =?iso-8859-1?Q?8b8qaDbipPfg7aD/5fsjucD3paWfTXO2+kBh/f/FLkEySJYDadDrUA9okE?=
 =?iso-8859-1?Q?WQwcM9Bq/0Ss3laohrKD6tOQmB5uQOfNReLB6XsvWGwONFBQXC0dXLN3FH?=
 =?iso-8859-1?Q?+D1MzwZsndztQpTmFgcTK3Ksa0B9vvpVSEVMGrI7KyJOkGAhCV1R7C+yt8?=
 =?iso-8859-1?Q?Duy4hqu6CWYdiQ6+LNKV3kWEmKzQfhxeX63nw343tWz0hWV9Aw+MPoR1Om?=
 =?iso-8859-1?Q?vpCqdYwjvSXQcADJ+hH28N0EQYMbwpwO5m8ALDuVVGGj4LyeLMpQtbCtZp?=
 =?iso-8859-1?Q?7l8pGByBlsYEgAkOYoRshj1EmKxq5mr7ifPBNoEV3DL3FlrKG7kvtxdcfx?=
 =?iso-8859-1?Q?USuRu8I0T86frqcsMJs5zeuV0TshCUDrCj5HeZgobbceA1q72+lYMhTern?=
 =?iso-8859-1?Q?7PSHoCCr0uqT7mWVsVHoi3YZIh+hk8CavHGcoplAxK2flPQl+FW9yCijuh?=
 =?iso-8859-1?Q?PWsfmL5+GmIrFXJ4nPDiecHYLkI0TPSE9bBtu5FAG1xBXt+M8jcM7FHdxL?=
 =?iso-8859-1?Q?CsOWXh2Zf2fyHs2K2CtyU1DREciSdm/G/hmSrslCHmwuTGW9+JFEd2byUJ?=
 =?iso-8859-1?Q?ETamam5oObD4Bg2jf08mVr3T3Av3SXX7GS1KkmBQaa14IZQOEeIUG6XkY3?=
 =?iso-8859-1?Q?aaPZXk2TsrYnKdCSRxrT66SNwjsGn7wy0J9va1rUags2+EpXTEfF0K8fV1?=
 =?iso-8859-1?Q?DWYo9UAnwoDFxHsbw+hWthIAqxVjZJ9zWsXhmVYAjf4iR1fDHV3CP/E6AK?=
 =?iso-8859-1?Q?9d/3oL2/f4a0GjtF7xsgEEpzFfglJKu1u8m/FD2tkIS6nTBqVREWkvqEwP?=
 =?iso-8859-1?Q?YWfZ6ZUDwyMcdpe0zQLhaoSvx/7WM0z8v6W1AvLnIwvUsOwotxFMzYiga6?=
 =?iso-8859-1?Q?IOlOoxh0qtlmuZonxEa/j6fcV5E3tbCdIcvOVJDcNiDnhv6514hh+VKQ+t?=
 =?iso-8859-1?Q?9Z23bAKDXx0+Z1fGpdIEcv2qkPr8qgg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908ef7cc-7607-4ac9-f1de-08da11ac1fa9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 17:46:59.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K1NFU4tLC8yIZyUSl5GAmvGLgixUFtnKHUQkl0UBo+eSv1/qK4KjO09PsN3IM5Xpn21VZ+DuWnUGWf/TqCxPdsMUesqp3Z1g2h5m8COri0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5163
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290100
X-Proofpoint-GUID: bQ70FDrmVUL9f2CuGlTcjYSfX3W5Yf8-
X-Proofpoint-ORIG-GUID: bQ70FDrmVUL9f2CuGlTcjYSfX3W5Yf8-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:00:49PM +0200, Fabio M. De Francesco wrote:
> On martedì 22 marzo 2022 09:38:58 CEST Fabio M. De Francesco wrote:
> > debugfs_create_dir() returns a pointers to a dentry objects. On failures
> > it returns errors. Currently the values returned to visornic_probe()
> > seem to be tested for being equal to NULL in case of failures.
> > 
> > Properly test with "if (IS_ERR())" and then assign the correct error 
> > value to the "err" variable.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> > index 643432458105..58d03f3d3173 100644
> > --- a/drivers/staging/unisys/visornic/visornic_main.c
> > +++ b/drivers/staging/unisys/visornic/visornic_main.c
> > @@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *dev)
> >  	/* create debug/sysfs directories */
> >  	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
> >  						      visornic_debugfs_dir);
> > -	if (!devdata->eth_debugfs_dir) {
> > +	if (IS_ERR(devdata->eth_debugfs_dir)) {
> >  		dev_err(&dev->device,
> >  			"%s debugfs_create_dir %s failed\n",
> >  			__func__, netdev->name);
> > -		err = -ENOMEM;
> > +		err = PTR_ERR(devdata->eth_debugfs_dir);
> >  		goto cleanup_register_netdev;
> >  	}
> >  
> > -- 
> > 2.34.1
> > 
> Hi Greg, Dan,
> 
> Now I have time to rework this patch but, if I'm not misunderstanding, you 
> asked for two contrasting works to do here...
> 
> Dan wrote that "[in] this case you can delete the whole devdata->eth_debugfs_dir 
> and the related code.".
> 
> Greg wrote that "We really shouldn't be checking this value at all.  There's 
> no reason to check the return value of a debugfs_* call. Can you fix up the code to
> do that instead?".
> 
> I'm confused because they look like two incompatible requests. What should I do?

Greg is saying delete the tests and the error handling.  But I am
saying delete the tests, the error handling, the devdata->eth_debugfs_dir
related code and the call to debugfs_create_dir().

There is no conflict.  Delete it all.

regards,
dan carpenter

