Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D551E01C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442733AbiEFU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392220AbiEFU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:28:44 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EF68F89
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:24:59 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246JhqYQ031490;
        Fri, 6 May 2022 20:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=HCYO/PKNkNt9dSgBRsGtNUDzGvbgZrO7vZc15ezn5lk=;
 b=lT+bnU6SkAuuoffENw+RLcMx0L+P5LlpDgk+5mrWNVYF5xVvsjPBWgAfgHYrJITu736U
 FePOUab3J2k72M3UWfsWRdxR2Di37y9NrR0mvETrR8FkTthQCr3nYiZJW1oNOjECXyDW
 eMmi+/kDDzt3+PtATI1GY74W3AhK1/kW+WxZUYJrv6wG50gXmiOZ5dYZ3IsNKpLAVhrK
 H4jAgGP7R/X68dDk+JW8qJxFXtu8pEcF47P7WjA3wCskdP4wbPEsyCKsPUi3HvMX2HC3
 Lp8fL8gtk6SgMQldujcoiMnjwuCIdGpX3ezcp990WfdaN2vK6ibMGVf+HF0ZJZKsPRwG xw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fvbfd97h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 20:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0ncNNTXJ9M+75fYEj2wbb4PZl2BDNwq4c148a15qDN+3EMyQHHORP72smt7ihGR2E87qaIMnzV3UGQBmUi0Nl5hGjDUFUeNWCGHQcgdpDloUGLqCkxrpQBvGRm9WM9i626kmeQPfpLDEIJbG2Y94T6VJeYWp4Vi5Jmw8andxdh2/62FivrcYj032nR/PMt896loQoG5hjwg2u4BqqDaWnLb88YqNC78GyXsMWUELZ/We5v+rU31NFaxYMsX6m34GhzMyoZx7bZheEPV8gE2kW/e+nik1XyDGMv60j5HlQ27cdtCBEP4vRsunQWqqq9fGxp7/OGsk5sCOIVYZq08tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCYO/PKNkNt9dSgBRsGtNUDzGvbgZrO7vZc15ezn5lk=;
 b=hXJDPkl+igx+1kmJoaCAmx1ib9VcdC9UaOxuCM36EeYgcPIqYoRJrmKODc7+a7dGJfH4QDXcLhx/ffSfbG3Dcg9yYx+7P21YrTg8nmUxKdMC/7MkadiQR9/cNek78yNVyN2ydf6BW4Z6UESF5PHa3tgPUqJk7zMoWoOYTX5WF/rv7Zsl3xg3eSY5snyP//cyVbgPr0ebRpUxo8nzqMP/Cnd4NkZzh5l3iMZWNXZRCt9cvsKco6sbBiE0q/vCwIFLVE0MmFLbmmhJjiLWK/bCdruZvd2ROIxXbkjg18zzTlnp7jEMHKAyzxmr6kuPe8IWxR6n+LkDYOou5I9XAj8stQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN7PR11MB2610.namprd11.prod.outlook.com (2603:10b6:406:ab::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 20:24:44 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%6]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 20:24:44 +0000
Date:   Fri, 6 May 2022 16:24:34 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <20220506202434.GJ12977@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
 <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnVgxEcRTQPu/DHE@equinox>
X-ClientProxiedBy: YT3PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::18) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ae5bb1-ee18-4762-746b-08da2f9e751e
X-MS-TrafficTypeDiagnostic: BN7PR11MB2610:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2610A3B93AC5ED93564BED4883C59@BN7PR11MB2610.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKoMtENAKSJc4fcZd6WuuxHDbXmrwbiJuyK5hNhvMiwKKL8woCm1ClXuNhRD/jD6xo2QIerdLBmri5K/oTioYLTw1qgtGPuA3VI3u+veSn1q+l9cqFgtUDFrU0EVK8VGjIgEFwIIAoQCumlkUaWVVzXfP/qEyatCYtGYvG09De6ogQs3Dx8oWAHdHMO0026HNJ8x8BCCYjjkchyq/VuSyK8WZenBNzUmawjaUPvAFpu1lmVCQ0kRfOd7mpevRt4fDfZtTXqR32q0mdO/azJ3eH/iDxMYKpgokCM8a0+vxGIyNDVczBq/gEdc/L/NUhccL6Q7gVRzUBvdrFXtVeHGeQXV608J6wvOWf8lWytGJt6R5xGEXzCF8jWjRm5/Gm6a/0VJlHff+4q7vc+yiq8akTm3rsrC//EZqYMbSR1wtCNFRsrZ5VQTM34e3B1CTlZWVBWW/zWXD7iJyXfSgKHtVYHRdWP/eNOaEkmKN24X/qU7mjdoIPmDjJJAzO9oz/I88F4+obcqc+r9KyOne0sxDuwJhh5CElXlfF9J7pNmDFMSNTzUoItJ5agHqVhdeZIlS26dtzX5Du+nkvaVfiyp6tx2QQ6VnJR77spkozQ8hqd4MdoCnnbEZWD57+urOLnd0ebaSZEKv8MwFq+QsUoO/PfLCJPzUzzanDcm4O18JWNysiPMGuX2rV9Dlkt/Iy5KLGocFQqAOgnSqfJh5lg9qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(83380400001)(36756003)(1076003)(33656002)(66946007)(66556008)(8676002)(66476007)(4326008)(2616005)(186003)(38100700002)(8936002)(2906002)(6486002)(38350700002)(6512007)(26005)(52116002)(6506007)(5660300002)(86362001)(54906003)(44832011)(6916009)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWhV3RGt7rXy5s29inuQ9bSN87c0Z7ChgvkujuuHmt9XEt6HMrvNdAsz28bO?=
 =?us-ascii?Q?pJLn52ytKcHzf1euOI62Q9GGucBNjUR9k0YCUi437dT/1jRHpqb2X9ywCQQ3?=
 =?us-ascii?Q?YoQGi27y+xafZs6Aweo2NcDAfs1XSQyEq0WhPfXdJ3mKieeW25Coulay7RQv?=
 =?us-ascii?Q?b8y9Xku/TVsDEey/hiaJ1zCT8zuGSKDskhC8XxlTKOu6slSvzLqZJWKLDLEK?=
 =?us-ascii?Q?qy04ifk1GPpbQoMLICHrTUfW0bxSFS4vfKVZpR8w4f/NKL6VMNe4GoV7EC+W?=
 =?us-ascii?Q?lC7VsQljE5LiBeKm0XRwoKgo6SS3b5z33ZGN1GVFQIoCaMrXcqblR76NiTpr?=
 =?us-ascii?Q?l87D4zpFDSqpsar+69RRZQ7kaF2RvH5mwmaQfAboJvj47pYLS2JMbQIYj5/N?=
 =?us-ascii?Q?2osJowhUvJcJt3eXzknHhSXmG3CxNSjleL0bM6ZzfadJVImWpSDwBnNjA/NV?=
 =?us-ascii?Q?ZYeF0pUwqKCM3jZ7sF/g9OsXdknzsKGxlgkzmGoxI5iZE22SasAS4VPGDnW2?=
 =?us-ascii?Q?Cj7UtYLyOqI+hLv1nGpe8lmXlql9iheVhy/KkgKgr4Go4zy7l6XL2BaMRKH3?=
 =?us-ascii?Q?SBRXGUCkB7or68e+fyymxvIxxLV1PRny8F+LOfFNge4utrWLDiyILxma2jJQ?=
 =?us-ascii?Q?EIFmiBC1MBDcYwkkl19jP31kU9whf8tscIHICwf8gSS46tG3J12A5FJz6EI0?=
 =?us-ascii?Q?LW9YUOvcW4ozNS6YcHfkjbo7nhcLFHbic6F4+NyfeAgtZsrU4hQ0AOrnyLaI?=
 =?us-ascii?Q?rBVIPg/KAhS10mDK3z77N9bBZWEmu7UsJ6lObnHaZU1Nv7rAbapdg76+iI8p?=
 =?us-ascii?Q?nSSeYrAKYsQ62AM6Q2zOn98U8xxNobtbi3oP6zgev1ruaYuYRyCADWqgCavz?=
 =?us-ascii?Q?zG9cD6k4LO0r1CWlfXYl3aUmfh33lM6g/fTVMcwl79g7qm4MqZkvsiO1l4gk?=
 =?us-ascii?Q?9oRQ+1ZolRkGGxzA4S8+CGPEA/pyDateL1EMCaVNjXltB3GanL3TQlTLqYyL?=
 =?us-ascii?Q?Mo5btfb7oX8lus1xZERPoL90BSntkTgiU5mstaed2jeSC9KFYMm6Ume21Hjs?=
 =?us-ascii?Q?57k8YaC99Uaw0S07eAKG/u4/BRQngPYmStmz/5QuPk6349Y4tG/anIA/K4py?=
 =?us-ascii?Q?CJRXvcJCB1jtdK6sfMfJjl29GkVEK44QYH6miABzHSgqIY+mW3iboZsWZZlW?=
 =?us-ascii?Q?LjYLtWjBS0SvVLUSw2OYJqRWCKNjbNVgSfunqv+e9LuZUBJPkJx47jWNgpY4?=
 =?us-ascii?Q?d+NczSJq1EOIi6Ya7spCQsI5LhMxlQYddz1HmRJWp9hiK5RkI3qbg9KiocA4?=
 =?us-ascii?Q?fd5V11vANfiPAX+kap4N/sJ/mTeWsoBKoftXpmP192v9Rcl63VJ6fAkXy4wT?=
 =?us-ascii?Q?XYwZQSJ/NyYdkGSWcPRB/BtsI9jFEWwYJt3DU//oeqT/TO7EfRGlRQV0FnTm?=
 =?us-ascii?Q?wQ+/QdZfaTnjx3Ewku0HofyJkgqfwqFBMy9BqnEwFAB1Oyzwk/ecVP7vX2gL?=
 =?us-ascii?Q?fzXLDVZLThdmHdGPNDAhg9OSM1qi60WxazUAhYOLbCs7vDiTEKr2KAo5TgI+?=
 =?us-ascii?Q?KXFExHuM0/1ioGw8aTUOonJuOTC74z71f18UyyBojutYlxoCZ/g8ZySEmsZi?=
 =?us-ascii?Q?lyyI7oe4ocTLx07d0ZRo6C2YnHxcjQL94MdgA4NOCu6Z7Wydi7lJxUDkFVDo?=
 =?us-ascii?Q?fIB9qQ+BrOh0Be9UXMLPNyHSI+IMo604OHufck6nowO61Rs5nQE03Fl9Gksr?=
 =?us-ascii?Q?CXDXhSP99RIqyQzU+fRCsOH1JhePJeQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae5bb1-ee18-4762-746b-08da2f9e751e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 20:24:44.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAOertCAEqsIHwhyPe7M26DDN5M9107dgOB1AxadyG2tQVNYCRMpOmc50pzb4GU/rPi/uP2DaGmszFXpJaGmG8cUzZeG+dYS089GHfM/bt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2610
X-Proofpoint-GUID: V-r2aReWNRVBQjPg35w8gmcY6NiAS6iU
X-Proofpoint-ORIG-GUID: V-r2aReWNRVBQjPg35w8gmcY6NiAS6iU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=682
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060103
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 06/05/2022 (Fri 18:54) Phillip Potter wrote:

> On Fri, May 06, 2022 at 11:32:41AM -0400, Paul Gortmaker wrote:

[...]

> > Are you working off linux-next?  If not, what is your baseline and what
> > are you running and what do you see?  For example, the commands below:
> > 
> > The ecb86 that I sent in this e-mail still applies on linux-next of
> > today which contains Jens next as you can see:
> > 
> 
> I was yes, the point I was trying to make (poorly) is that your patch
> conflicts with Randy's patch which itself is not yet in linux-next, as
> normally I send everything together at the start of the merge window to
> Jens, as I don't have my own kernel.org tree yet, and usually I only get
> one or two patches in a cycle anyway.
> 
> This is not your fault, you couldn't have been expected to know this in
> retrospect, and I should probably look into getting my own tree/GPG key
> sorted to alleviate this problem in future.
> 
> In the meantime, if you're comfortable with the idea, I can just resolve
> the conflict myself when I send the patches onto Jens this time and
> include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.

Sure, go ahead - just fix up things so all the last bits are gone; don't
even worry about patch attribution; I don't care about that.

Paul.
--

> 
> Thanks,
> Phil
