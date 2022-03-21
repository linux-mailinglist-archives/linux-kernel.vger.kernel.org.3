Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FA4E233D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbiCUJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbiCUJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:23:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF89143456
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:21:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L6aPQs019422;
        Mon, 21 Mar 2022 09:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mII4DtTxvjsN2KHVLJYalTVYbz6wmPOvqTgUZsFv/xk=;
 b=Q3IED2nDtp3wa3zjq8/Xw4FAz/99DhmGFKigs92M8pR0Wm5FrEgfFFLG5RDz/PUuVKK5
 fUbv3dYFChSTJQ6xl3E/olasZEM/AKeegzhsR19cRwD3Q28Oo38Xx86q5e0s9ClazGwD
 OgdjDxo6qVQNq72yqtqkmvEC0L/A8G2z4NPcn4YH+YcqVT80QkY/bVlwUBLNxge868Hy
 Aeu1hYrC2OTVoBQeeT2hc4fA1uoH28DSEE118SHBQBqk46KHyFhQReSToixzsTS4Cc8O
 JxVXgylDNrsFoky5M4YoKZmnO2EnerNS54oVkQPjOcW66Nifh7H/CuByQ0kcJesPh4RV YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss2ngj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 09:21:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L9HfuU125832;
        Mon, 21 Mar 2022 09:21:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3ew49r2wx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 09:21:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYtdmUGqAB94D5CJd7VhCWJYeA08gVJS1xZKHnUW765MfJ8f8KTwUdsz/0UnuWslU+GJ0CJbCoo5UaN5LnU6MLzRvc1SOkqImKLy+8bs9mcdSUI3DzEH1I7BKBipfZfhDMijM4FHYUJmGVfI2YuO/RNJf+XkxpsPlAm8n2arlW3p4qCDW8wVVmm7nD6C6BSe3ZO5M2exnMAAx/6jRfGl6EhDUZxYl5IpRFKHv49I9VmcoLEi+qJo8yOCzHyaJgGJASfLCBQAEWKs+/ZQusnsLr13sXWknRiVE2pbIIeElpS5+Ns1FrcoLgt8pkJRg+4dMqPjcFVpO/RSiaVlcfVrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mII4DtTxvjsN2KHVLJYalTVYbz6wmPOvqTgUZsFv/xk=;
 b=MPeMg0oedhGxIi/pFM/QD/slIHcPDf60WyTXsj0NTi3BFXM50jSWCoxQaPFDA4xqV2KUsYf1RIJCHk+Asfp0Ie8R6xXgoth+llpwa6Z9sLlUg7K1wxjCigJWcXMz+igiyAtxUCxXHRdB/LfkUyJtnL/lSejm/qDajVVFTvgpM1BWe+ZMAuQp1HMmDXmHbCUS3trN0qcSWMsEaaWLPu6mPFxN7/cxmigVCuI8GiboUowU9NPEuEDJjkXIYd2WOJ+lxtpwrof09Tw5Uj7WVdD/ItkiGKOqzKBgHBMg/qoY+2Qy+4fRpVJiX6RZ38GcfgGASoVA5NnvrJ7Q4dbSbIeB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mII4DtTxvjsN2KHVLJYalTVYbz6wmPOvqTgUZsFv/xk=;
 b=TyX0NmBZ7Glnjae/PJ7XHUf685lODBsv3nyswTGfG5BlFvNcyLEhM2vr80iiJpHlNmdbqjScbH5psyX+LEzFPM22Abb3gWzBTOvUVD6XHPfZ21oO9SHZdoE7NEHk8bIsJMNi0VLMygLiVnk3wS1XXZwJhFnpJ/VOXhKOG3dO4/U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3460.namprd10.prod.outlook.com
 (2603:10b6:408:b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 09:21:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 09:21:45 +0000
Date:   Mon, 21 Mar 2022 12:21:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] staging: greybus: codecs: fix type confusion with
 dedicated list iterator variable
Message-ID: <20220321092132.GI3293@kadam>
References: <20220319202058.2518847-1-jakobkoschel@gmail.com>
 <20220321084844.GG3293@kadam>
 <23587784-B0EB-4FDD-B5BC-DC1B16404DA7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23587784-B0EB-4FDD-B5BC-DC1B16404DA7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::29) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e0ec66d-d6c5-4f10-00b2-08da0b1c37bd
X-MS-TrafficTypeDiagnostic: BN8PR10MB3460:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3460F486F24D763EBA7B41278E169@BN8PR10MB3460.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDA+wZpxt9H8nR+v83S6A20NGdtwSuG92yakOvseVqvD523q3ICLfuKfg7UPlkQ+lEisMcqv/MM1KcmWo3SsoYk9YM4hiFuuMo0+DBrqxu37ZjFqbUoUC5KlKWjUD8KCkc3007GCLSwR8H7poJSrsUZ5ToyhS/UuS/dNivNhWBVV6H4nVMke8LEAtwypJb7UDghHWvlzgRIyVdgfdH9seOIlllhKm+LaOESx2KkSkEfXHXVtN9lkbvFQ1Us601JsVc9d2O+xu1D+/bvi2EUkyDFqMVikhQTfGoBt4TRJMJT9zt/ynP3ccoPZaBaZ/6sQAf2OnBcmYZ2qqp4VP/aES45naB4EeEBDbZwNpUYlhl9mFo8ps7lqPoWweHIYlVbuUxKamg0Wvqan06m0jqSO/GuXTKW7XPtJNYmBW2JXJ6reLAGjTYgfvkOIswVkydWWcfFgNZEKu1KcHZZopDGCpdkTKwxHnulB6IvMyGAhqdQ9Bq7jtdU67Vppq3EVnL3WzpD35UaZW44cdozrwfPPIlR7juv5c/bVb5S1c0NghqvmG9+tR0PXsDf7IiG8ey4SgGP6FHb2+7nPkgOXZyqq+N6wSIPqR6WNoKCR7OPm5nGfUAzFwoCCgfwhBaOGF22Yw8kZLIY0kBm0rrj9Pieu5/1QiZg9WOPQim+5GL8+tCeAndLaW6G5/zATxPyp7fAO5ETIe0Gfq2b17GuNlJkreQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(38350700002)(6486002)(83380400001)(38100700002)(54906003)(316002)(6512007)(9686003)(2906002)(508600001)(66946007)(44832011)(1076003)(8936002)(5660300002)(33716001)(33656002)(6506007)(6666004)(7416002)(8676002)(66476007)(66556008)(4326008)(26005)(186003)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQsXxHbhQEmNfscPYqHCi+ScKbH0pSX5GTnNiGLWF4BoYRF1z8g5g5yDjn95?=
 =?us-ascii?Q?U4iA0VabKEYxqyvUtkzOvxdUbG2jfx7rvCVX3MlEYp7PoOgRauxX5K5DmRE5?=
 =?us-ascii?Q?PzZKHMHUjSUw/AoqvM+ok5y/SoCUEi4MBu6BKeG94+KgqHp8lnWVN5EW8ePQ?=
 =?us-ascii?Q?p+D05XhFf/IEM0u8obnIa0EeJcqLlVXK4Ctezjo6Acr3hkn+59QG2t43bnEF?=
 =?us-ascii?Q?M+IdPzk8PruAe2DQ761QbuDhjHOAemuX+jhymzAKiOvFUy9CKwjfBL/LGo1L?=
 =?us-ascii?Q?eALpMfvwksO4opelhwBDy0HRwujOnEqMlm0ZCd7bhjmF2tjuD1+5lQkXvy9e?=
 =?us-ascii?Q?pU6mJTF5rlG3qn5EU4nEM/BcsByOrgJoxKSEt9Lh1wXI0tc4wS1t+277N7Th?=
 =?us-ascii?Q?FrT+i190YKp4fumEJ0C62jm318PbdAy5X4WKD4+WrMROB4U4x7s72geKz0fg?=
 =?us-ascii?Q?rFz1FavuHPB7y4+4IiZ3KBCzBwxcgqRpEf8A7rq2q7Kd9exvFca28v2JDR3T?=
 =?us-ascii?Q?Dnp/NgbGz+yR7PYjrG+s7DHzVv+5ILL6AMkQ//UExNtnYfWgA+zD1M5Ak2sm?=
 =?us-ascii?Q?GQmMwurP1id4qg8n8Ti9hPEE7cvwqnaCHUnazY7ad1QzDiVCa7DqUB62zrKF?=
 =?us-ascii?Q?jvO+rF/CB9L/5RC5A2XH/fGteKUlR7wEeU8sIzNeQd7e4OnZK0JCl0Fc+DVY?=
 =?us-ascii?Q?cO/puZQuYxlGA9LRtr6oyvXaC9IxMP07PJSuGELX9JrVCoe//BuirN5epE8I?=
 =?us-ascii?Q?SUFjjo+sw57n2a8DhitlDyEOJMzQPURdU0vitly8pQmKDSd5F7D96y8quXrX?=
 =?us-ascii?Q?pTjUKO5zUrFArEsQm3LDEtMZ5XvAG9vqMtibyIYzfTyW6zo+SBzR61jwZLln?=
 =?us-ascii?Q?OylxkxdaUnduoeVcYjAZqZZChTEAKWZsLGnzO9H8UC/59ouz9Dl7BXuPFv3C?=
 =?us-ascii?Q?gIH++DZJ6Wf/fVPzTGWv2IadR/hQoX73Ori/3cNjeEBg0hDhw+I/fZH08EDS?=
 =?us-ascii?Q?YZeL8VYdu0aSFBArqDkIFQ+yxvsTYGVdsGLIwPPzHTQYV9kkQXIUIxDE9bC5?=
 =?us-ascii?Q?/Q25zfC8yv/5xLbVotPbRd6Hs92S2Gu1zalZkGJGJhBWPrPtTIpKkQr/48eI?=
 =?us-ascii?Q?2tQZ1z35jQfoRD4IQL9+DBqmo1ATAg1NbDm51yD1qRnDsuRI+pqC9r0FztuE?=
 =?us-ascii?Q?/SlzZ1ECb+K5eSu3PNv0oZ2nBZjXfgs/fiHgA6jXC9Ylsk+F+PoShCAtbK63?=
 =?us-ascii?Q?1i88E661zj0x0Cgg/526bFeuxZEAvKW34qWDlyNQEUhEPEgQ/koyXQUQOIdW?=
 =?us-ascii?Q?vIcOxkyKMJV8id4urpenFURqWUwBxO//If30tajGhbMFm6OPDJZ2hjg3bS3e?=
 =?us-ascii?Q?jY6rHdxo4adzwQhanJbj63iKae2pfy4ILn2Zskbd8bVaQin/upF0ho6OSQHp?=
 =?us-ascii?Q?YHl3KAycpyPBc1bVRbNFAEscUArihZD5M/jgsA/Q+cotW08SVi72aA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0ec66d-d6c5-4f10-00b2-08da0b1c37bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:21:44.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLFgX7A8qqnot908npxWk2vmlbr0RrUuGNTFdsiQCD0AFwIiGwEeIaJqd5+J4yjYHpdD4NBhSBnffYfKyuwoYqI38FdFnnElVNT9vHw6m9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3460
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210061
X-Proofpoint-ORIG-GUID: jMRheSVjpF8uMbfgVvFtmojJMMUrg9js
X-Proofpoint-GUID: jMRheSVjpF8uMbfgVvFtmojJMMUrg9js
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:06:13AM +0100, Jakob Koschel wrote:
> 
> > On 21. Mar 2022, at 09:48, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > The subject says that it fixes a bug but it does not.
> 
> Thank you for your review!
> 
> I don't agree that this doesn't fix a bug:
> 
> > +		}
> > 	}
> > 	if (!data) {
> > -		dev_err(dai->dev, "%s:%s DATA connection missing\n",
> > -			dai->name, module->name);
> 
> Using 'module' when data == NULL is *guaranteed* to be a type confused
> bogus pointer. It fundamentally can never be correct.

Ah.  I did not read all the way to the end of the patch.

The bugfix needs to be sent as it's own patch.  Just the one liner.  It
needs a fixes tag as well.

[PATCH] staging: greybus: fix Oops in error message

The "module" pointer is invalid here.  It's the list iterator and we
exited the loop without finding a valid entry.

Fixes: 6dd67645f22c ("greybus: audio: Use single codec driver registration")
Signed-off-by: You

 	if (!data) {
-		dev_err(dai->dev, "%s:%s DATA connection missing\n",
-			dai->name, module->name);
+		dev_err(dai->dev, "%s DATA connection missing\n",
+			dai->name);
 		mutex_unlock(&codec->lock);

We're happy to apply the other stuff as well, but we don't mix cleanups
and bug fixes like that.

regards,
dan carpenter

