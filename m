Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C14E521B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiCWMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiCWMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:23:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92C6E7B3;
        Wed, 23 Mar 2022 05:21:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NBLfpf017302;
        Wed, 23 Mar 2022 12:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cwf0RuD+TEGwPGVTpUjryZdR4wHMEE8JM0bJTX8J1iw=;
 b=o0d/j9X0Lz2pLRTa6cdLAv13Y6xmgHUlP02r8UL5Ykj+v+pMVogxCM2j7X+t1rEKPOCB
 2Hs8S6mlEDKefXs4IhF4o6gZwWvVsBMROP89JQqOVIhXFx6sDNYmp6h5X3W6Tf+7lB3n
 knc28EKfh9B7DM8DxBINYe5igfsATa4povzIDXaRkj9y+9wiMPIVcLifKyvzwNblTEGh
 8mgKzRjIniLiM4eamdnlX/wZhMVIOB9WJIw7AANy8TH21AjkaqTeRjXsmYixH4Hg/20W
 YtiK7Oz6Filf5SVYIwfBJT34ptPc93XzmJKvtsn7rJVJogpRbOuADUW30JevMiI+O8qB dQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcs3n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 12:21:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22NCGDba078901;
        Wed, 23 Mar 2022 12:21:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3ew578wr00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 12:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD3T6eiTnMWMecIWs5VjFcFaFAjM3BkgS+v3ep0CJ6SZp4AoFCiqSmaABy0hKSRmkykfOX10mzBnrdlR8hW1pDSgIyjugIhQHXaSBgE+EhRzVlhv2zISrfQnfihmEGSmBME+Q75E8GfbK9/BQfIL67p2xflZKjHD6udgylKDnXhFgyMuxo5srvojQ7gpYkmvEwdv/Bzig8ZGZRMU62TxQ4ufXx2wmGssygd1HR0UNr3mOvVOa9xQP23QUyQQxrkoUOqluYlw2lcpsBVF/eHEfXxNs73XtwIX5kVuHpwAvuSVdhclkOFLj1r/jbNiiEyWr1SJ3Wnbk1VX1REoG5XIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwf0RuD+TEGwPGVTpUjryZdR4wHMEE8JM0bJTX8J1iw=;
 b=ehUVy6Cbz0RHbIw5UfhuFNx8UY7vVALp85EYq0Lbz0Oz1nMGNr2R5duTWmrdvPQLNkvsScpt2l5t73lcA/s/Bc+ce/uob2wTF2FFGCvdwFhlzBE7HT2IpvzTB3IHRfDNVJjhApG72b56/cNMUDMQ4YSlzFIjB9psG0x3xqIQvr7q4CF9E8zvMsC1+kTMU7wSQejP/uxeiH+1r/FmgX1n1q8IbGSuVA98kIjxx8u7I03r53BeJBNAHuAnluap4AVBVBcrAdbRyEGyNpDevst015Q59x52+HsoG0oegvGS96RZQbG6wfEzsgWAe274KE0riy/E9zhrJK5J9zmWoVguwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwf0RuD+TEGwPGVTpUjryZdR4wHMEE8JM0bJTX8J1iw=;
 b=GhzJlHQBSiVN6XQ8vmpZF15TIG65NyW/Gv9ilL9lx1nl4IysyfjYv0lboRmnu1vqV8VrKygDErFQNvHeLzk9HcGXwgEAuN3T+cGZJYKlFmYzXOQORuaBzqAhARkd4RaDTz6ENH4xBXcXRiZCkUZEFzKqCywB2fJlrSlTLlv4j4U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4069.namprd10.prod.outlook.com
 (2603:10b6:610:f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Wed, 23 Mar
 2022 12:21:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 12:21:33 +0000
Date:   Wed, 23 Mar 2022 15:21:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] ksmbd: Remove a redundant zeroing of memory
Message-ID: <20220323122113.GC336@kadam>
References: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
 <20220323065111.GO3293@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323065111.GO3293@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b450f3d1-ff2e-4f89-299c-08da0cc7aace
X-MS-TrafficTypeDiagnostic: CH2PR10MB4069:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4069ABDF5BAB0934B6015ED18E189@CH2PR10MB4069.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCf77WFuuGMlVupj2jvXqe2uHcaIA6QhZ5h80DgHix/780plgCsY3dcdRLseOw/EL1boGsNShXnb2gmz0WafeH80e7CKjzr7Yg/J4IjRofOSIRkKshKsRQM1OR6Pn8M+7x/qkbCcZiprt5VxGH9rMNE0VDHAnv84LcPF8wWumTmaAt2KgR8XdTKEnYNY1WvE+9bDxdIy4eERVvlzIOg9UZOWNhf+z0PTETQo61MGVt3/shmH0cvVAG3SxGp4wfuTwWehmb1cRsX2frto0evvL1IvoR6qJUZ0fnqWIgzJN6sq0Y9ynHAYzO+0R3zInnxKychoKEWceCenu2tVeRbSk6of3V/qRd0lNVxXzsbDtoLRWO3RIbRc/uMm+ICRqAmU1zBVJqjGADusrwXdkpYGUPYiEVV0s8kfTcuxlwHwfSpY/TlQAkm8Ih/TYSOmP0/v/0hNp/TZyIhNxMqYGDFfZBBp2q4JMv7bWWNimFFIMPBPFcq4unW3cOohYhGDiXB9k8p70kplP/SGlJBRf8BetLCCkcIpecOPzfazGwAt0NgLgm8jxAddytLYN12sLaBssJ2UR/ShjGN8BZ5wp832RNQ2QSkikbIwfj+2G1sBgQksCYZeDEfohEqXtQui5Il0zoBOG7Bd1ZbRL7E2OOT054AFXFyQQHgwkKUU0tqV6xIOUc7a63BDm1WSG10sziO0ap0vGMsL5HqW/oES9p0KwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(38350700002)(8936002)(186003)(86362001)(44832011)(6916009)(316002)(2906002)(6666004)(54906003)(5660300002)(33656002)(6506007)(9686003)(1076003)(508600001)(33716001)(83380400001)(6512007)(6486002)(8676002)(4326008)(66946007)(26005)(66476007)(66556008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eamSCNfr6PLSdlMXohX2aqBhXshVSjmHcQ9F0xAo/zsGgSvH/PV3aoCfphAg?=
 =?us-ascii?Q?KU2uqa1Vif63k79V4wVBeq3kLHNPqJq2pGpcsjmglU96RNlKfKZHI6B/v9j/?=
 =?us-ascii?Q?Xz3Nm7ESzlr9K2VtKNqdgwDcCXb8n+pbIITyx+Dh31lDhV0D2i1LHot0IiRD?=
 =?us-ascii?Q?NRlm0cnFjQE451WQVsTkx4/8efBCc0TJNRSqjR3kcgKrjfi064gkI7uYWNpe?=
 =?us-ascii?Q?jMm9DdXevMlmsIMgQ+gdwVhqXJ+uc5vEmLOR0PW1NVS1v/4GFaXVst30RN3o?=
 =?us-ascii?Q?zljqcJWgj1Jg8ZM6mtOSsGYTSycVjBZE7QihKpw0wUAE/dpJ6b7P7FUqYwxT?=
 =?us-ascii?Q?iiTJpy2ZLuql0aLXAR+uPnWjKUz1AK4WMR5888RhNG8I+SqgKscppAUWlf8K?=
 =?us-ascii?Q?/EUC641HUJhH1fyDFjLDDDQCOWtyHIpeXk90YDY7OOhemYf1IKyBrAF6kyCI?=
 =?us-ascii?Q?YQMSUMADNB6pBLjUhqMoyQQFuncb5TAfCf+5Ok3cjyi6wAQXlYi2O9e/6nYb?=
 =?us-ascii?Q?tq9zzvGfn/zR+cuL4+ctx3UKC9LBXRwNTJKc99j87/cZtX71zngksYvf++k/?=
 =?us-ascii?Q?4IOZU9nme/1a2/nS6duat0NgLukr6dJbc1fEk4tJGDZ6cAMgdRnsWt5gbfNA?=
 =?us-ascii?Q?17s0SVMrPe3m5o0SlLwPdiBfu2y1EcIdveQ423U7yeSHdLZL9Ndx6YvhVSCD?=
 =?us-ascii?Q?M5NovVJ3mO3Hw3XWh0gwpYuzAUmhjDOtkCUTY7WddgmxoPBMK3aKl1Ny6b9J?=
 =?us-ascii?Q?Obo9McY2G43LTAjYC1Lf/HX+ZVbsi3vIo6N5vept5I3DfV2pwIxSRpvZXdmX?=
 =?us-ascii?Q?F3xHIsg7+wSdQ2Mng68ygR1XmL58pUh7ncGsotrqNlnoRln8xtSeSVP4ecvT?=
 =?us-ascii?Q?wzCjxHa1sil/0i2RZd+Bu4Zul7BHP8vnE9ew2fPfMUX85SQEBQKP3YPbw9lU?=
 =?us-ascii?Q?g7Jg9UqTtsUBLiz9eVfa/reoJJ1ekzys8iKK1Bh24oO7FCs9ddihF/qv31qa?=
 =?us-ascii?Q?iZSEVxixxNcIbGBxESy1psTamDdwU7ibKctwtQ29MlFs9eQZjQldrkVc8OK9?=
 =?us-ascii?Q?jseNkYaevKOS4HT43Ot5PDmdWn89ZmEwALQfNEafkzYkHH7zoK93eBysJVqq?=
 =?us-ascii?Q?gjnJUVMPnsPYrzqrPWUY+8NKdxSBWSvafR00e8IAF3JStcLqZTZDnQ9kXFDA?=
 =?us-ascii?Q?k8x0v7KD9JjwD/74vOtd3kCZKrb8hIZMym7+vXxcDgyPUM45WO6ZTTqfE4eD?=
 =?us-ascii?Q?nNsLLtFviopPX5BWSeH5QyXjvgf+cCgRaLaaNc6ebDuE+ZAKXzb3Oz5K6HZJ?=
 =?us-ascii?Q?HruxF+Tbk9z37z8CXLvQwnvmHU1XDo4QSRvAaYn55Mdz7D0dtTtuz4diFZh1?=
 =?us-ascii?Q?hzcSOgDbRsuEgKCb4JeZzEdotuHfB51jl3q8KnMKpgHLzSypqWTMk2Jd3pJE?=
 =?us-ascii?Q?tGdXXzMaCTDW64y0WkGvtzULhTB6VqFVE5C27Eyvn822fezp7EgXNw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b450f3d1-ff2e-4f89-299c-08da0cc7aace
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 12:21:33.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd19Eh7TeiBnoOSfMy48SM+iMxShn7YkQ8cHfqc1m/nUjs0z7uqTuSS3NIJEHD3c4Lz64X6T6KKeEsDu0mfJEERCS03udDzw4CEwmfrv+yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4069
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230071
X-Proofpoint-GUID: 7HffZtGyAhl3AaSNF0u_51RYiAH459WF
X-Proofpoint-ORIG-GUID: 7HffZtGyAhl3AaSNF0u_51RYiAH459WF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:51:11AM +0300, Dan Carpenter wrote:
> On Tue, Mar 22, 2022 at 09:29:51PM +0100, Christophe JAILLET wrote:
> > fill_transform_hdr() already call memset(0) on its 1st argument, so there
> > is no need to clear it explicitly before calling this function.
> > 
> > Use kmalloc() instead of kzalloc() to save a few cycles.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Alternatively, fill_transform_hdr() has only one caller. So its memset()
> > could be removed instead and this kzalloc() left as is.
> > ---
> >  fs/ksmbd/smb2pdu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> > index bcb98109bac9..0e4f819e5859 100644
> > --- a/fs/ksmbd/smb2pdu.c
> > +++ b/fs/ksmbd/smb2pdu.c
> > @@ -8434,7 +8434,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
> >  	if (ARRAY_SIZE(iov) < rq_nvec)
> >  		return -ENOMEM;
> >  
> > -	work->tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
> > +	work->tr_buf = kmalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
>                                                                  ^^^
> fill_transform_hdr() does not clear the last 4 bytes.
> 

Oops.  I was looking at the wrong fill_transform_hdr() from smb2ops.c
instead of smb2pdu.c.  Sorry!

regards,
dan carpenter

