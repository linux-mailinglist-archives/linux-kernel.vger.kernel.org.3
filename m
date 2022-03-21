Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8037B4E26CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbiCUMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347337AbiCUMqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:46:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8CA9154D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:44:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LCcBQo027768;
        Mon, 21 Mar 2022 12:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ynI4XTAz2hVVQaWyQMK3tAfrHCYFLWc1PiX8KbnXo8s=;
 b=qtBoma7xQ0YP7Neawiz/FdtVXQp4gm1cjNRG8FspG3ud2AFwA5QOM91C6YZ+NOgxS7qN
 Fsc8AXNG3bdFkBVe9298fnUA5PLrTJqsz/+hYzWATeMYFV96pXLHeEMLmotx03jN1/+E
 T0OZanUkBUgtMry15siAwTKPGjDcMXrYxUkQmj4qwryTuFyaDjOfAGleDdrnHt6g9q7W
 5IROf2sVcqw+ripxOndQ0fsr430EwBrdt6av+dPFBxz9nrDvFe1X0YVxKtwVkefuee4W
 TUXoNTFtWz6iA9PDWh6oxkmqG4XUFmHbu1R8UvKNfbuIsGTX+osLCVokAZIwD92jH/57 jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1u5pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 12:44:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LCf72q137413;
        Mon, 21 Mar 2022 12:44:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3ew49r3bm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 12:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC9iPNX0QNHxPfQF7Lrvzprmp8iO2o5aVEuevXE42Y2UtjXBkFIn+puVBkp36zsFlodssFFtzWsOChQtxwGoXkvqR9KtwKwfSlSdqi7WOyXkh72s/XtUiMaWDAPX9KPPbWED+p57HzaPC1v5d+0jPdsOxQShhgAzlldEebR8eFGK9dEutiVJOyiTFDOvhKMhlTVxHAp91B30KJlSVTWGFIIZrM0i/hhUnEL+sRSy77gwcWhHe/ddzSruXyWD/End0fqTbrUXlj5C7Ca+vcsnb8GVUhH4DGTzYwBG/jUb2i9b2M+fEzLDhDtV26ddevfvgMHqZe84uyFp4+Vv+dPwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynI4XTAz2hVVQaWyQMK3tAfrHCYFLWc1PiX8KbnXo8s=;
 b=AlOWc5PRhJxM0KqiFCXaUWcUoF8KSbNQNeoSkbMSShCLAA8ayGEtyZjvX+XacPnm0va4a48oO/O+G/1hgBxfUk6vHS517jHGBmMaW2ytBCKhJUlxyfXzisKfFZGiUGFmGQVpqeWbwZLtYvIzdbeRCf694vsCXxeTsLSaE4hDbe7k+2fNl1XF5tB73yI7r70LGaIJwUX8mipWlUduyolnJigUTlyADOVeHNsBsjdO3NYoGTBGpEhbtGr87Hb6vTDkpQZkU3CIqmrd/4vxSa5RDZLyrEwJUaZboibLzahO9XZ2G2wRNSOSOLHTBOpknYIPnDy3e3UfIMJjZEe2WwRBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynI4XTAz2hVVQaWyQMK3tAfrHCYFLWc1PiX8KbnXo8s=;
 b=L5KZVexh4/Cbb2nyv8kiIbejY+Mfl80Wthadr5En+i7NTSlnquR/5PquRPAWV5JVjeLFb0i69w+sD5dAiTQTFDjBSkCXxxuta3xHk+bkCzc+4UGN8sSqw85ia+hMkEE3o2xjocW4Plp7i6jN1kbzjiq5dJGPNEdc9TRI1HYd7QU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2255.namprd10.prod.outlook.com
 (2603:10b6:301:2f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 21 Mar
 2022 12:44:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 12:44:25 +0000
Date:   Mon, 21 Mar 2022 15:44:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] staging: greybus: codecs: fix type confusion of list
 iterator variable
Message-ID: <20220321124412.GJ3293@kadam>
References: <20220321123626.3068639-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321123626.3068639-1-jakobkoschel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f08299-3ecd-4b63-b267-08da0b38881c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2255EE3C14E8A8FD4021A54C8E169@MWHPR1001MB2255.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+bYFujeRq2PUoUKayvZ0+e4zNv2MePnmgH22pB/bQyk3yqx8d6oWL2ZD9TshQIDNYRFsbVZ+iqUfBmDy6zjhB/WjpSwfiCUzjlKt8pIwwWiWBVF1XbK5mAXKZxogqR/gD3Wk1LUI3uphx+6bBb7Hknk05cBa7kLLTDaADnYOJQB59qjonRRo3lAFFgn5bgDbI+QuP5tNcLYMm7kiCO2e53P2vaVWPjt8OXnkbrimiVTcThH+zvmxD2vOIIDsXAatdLUvgUZCiM/m6UhreLIRHOQEgw4OFXr0oh61vHS4K5wQkk6nvKHx4rVdAxsMK3IjGsfwccAd4LvTtzxDSQxvazN0G0izq7uQYyjaQWQl84U5MiH8w1mYGVJc2qa1TxbKrzrb27j+pF90doagnN1UufLPZF0qxiHboyHD1xixqQ0l70SUZrDkFg2XNNf39PCxsPyyQrAXcS+odvdP71QVb+dnjCNkDdsaRK2bfz8n5raMBecqEH8GZ4O7p94QdiYJnLOFVJ7RnEh9arxcIdFfpH9tlATQ9ficVpSFFSJLvxZwybLECCG6SOG7W03aY/RwuyMtHP6RHH4PnWs0XTx79lIEECkBj+VOcz3SF5j/Ix3aSR4PE+wMfgTNRbfyk0VcMaYyF6LxSiq061fW/hcYMbelJr4v5gKTp+FgPqbk+/n0AfaA+r2/xp2SgoBx5b4yeloEOXSWqNOnKPsknl11g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(7416002)(33716001)(33656002)(66476007)(2906002)(86362001)(66556008)(6512007)(38100700002)(38350700002)(8936002)(5660300002)(316002)(6916009)(6506007)(6486002)(8676002)(54906003)(6666004)(4326008)(508600001)(26005)(9686003)(1076003)(4744005)(66946007)(52116002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbMA5YUZXpAfM4qN4QxGHZHVrxuHYQKmx8DtpOTxyjcK+p06kO/L5ZzZWTDU?=
 =?us-ascii?Q?fcyz2U5guvyqdBpujEGzcpE/TsAAtG/u4qXpcklF1BSvIJKmr743Q4J20HCs?=
 =?us-ascii?Q?LRyGXCdXpC9f14tGTVfjBT4ERn7/fZl2DuhNuvbBtSzJz8/BHhQVZYbJYn6n?=
 =?us-ascii?Q?IOoQV25Kk7Nq4Dxa/0VQ99n6wzg/g/tdIHJcVBFprQooQClgSpHk6zaqqMaQ?=
 =?us-ascii?Q?Va4gAw1nU+r7AvneWFJ5WfPlqD92cBrCzeALaJYe9DvLz1PTx+UYrStyE5oD?=
 =?us-ascii?Q?9ANJejl1C1zWXtJL4Rp6TqGdvzb1ahyoM/N/1bzplvJPo4/3cD0sR7u6JrfJ?=
 =?us-ascii?Q?lJZEjR7BJJRcjsk9gZKEZan5y9Yqtq26SP4qyfxOIu9zb7oxHkmEMGB5BNuq?=
 =?us-ascii?Q?ybZ6TJGFikuT70Gjl2G/XiYPkLFdyx2QV2DMFFIPPJtEDWQHCsZBg9WHKSqB?=
 =?us-ascii?Q?uALv1EbiPKq4LQju3RgR2aVwh30jlIfceVGhhTG1hE2gy8OHFBYHG1BMX+cP?=
 =?us-ascii?Q?FI4JTpijBLrlekeNaKaTdbOHb45pC1Dv11ys+V9HN/oHpX48ZPnWgFqoZwn8?=
 =?us-ascii?Q?+a1yqHfBC4Jx4YdYke6KpbSJs97K7Fzdf9J6piDRXMu4kI4YxrW+Twez4OAw?=
 =?us-ascii?Q?4lroC+Mioo95qIXjcS4LLdiEAwVroovgz1ZaL0Tv3TvUVYC4LsnbThy8RCBG?=
 =?us-ascii?Q?so+8QAoFF8kM3CHq24K7PvuFAl/WOmkFQHofjbNobnRe9qQwkc9HGGnpagf4?=
 =?us-ascii?Q?KWvpu56P4lJ2PhOzcVEKrp9EOk4bZIl9MxvXZZ75dBbPUCbLTuX0tT9zZK4I?=
 =?us-ascii?Q?/8iTLboaPpX6sl4u4g8NZ/GTBO3xk7GK/mmJbbNxzu+0zgOk2RKOL9Wwqj9B?=
 =?us-ascii?Q?cIkeGytQ9qz8Cj2RwhQpdi5P2jAvSHPT6bMSKIsJhv17ApbDfrqvCVnH2JCl?=
 =?us-ascii?Q?4mjc3zNlJLYPXMw4K8+/24jC28NpPmnPbYArjEXDiEfNVEZJ4BRYP8O88Sww?=
 =?us-ascii?Q?a6D8ac596Yjao8oQ7TU3goFbDBzt2eAPPSA+hIbRgFoURqimDb6e7QMehUMY?=
 =?us-ascii?Q?iMhrRZehQQPxS+Jxe50iYpSE7H3o7BkkHdBlLz6gIkDAFm3I00fWOOmAdDR/?=
 =?us-ascii?Q?mYnlqapAwqLOGMA4nGw8DQbVVtyorV61pUbkczJP2pf1AtYa8x0AA1WwNlCw?=
 =?us-ascii?Q?6jrdTFmRccg8GpaBNarhdQunnAlEfipTGwLPirKqh4jgM2tWloQclrj2uej/?=
 =?us-ascii?Q?rst+ZmErjlBjiGpxwhScnySJOCA/xNhUzGMy610FHw5eCTtskGedR4ZCFFGI?=
 =?us-ascii?Q?TLgA5NPaLcNds/jjbf3VmJGn+O1THt7b5u+sn3ExXgWgsb1Q/hkiqktSJaGd?=
 =?us-ascii?Q?r9ZDbv4m0lKwtMrwNcZiFKyBEfAZS4AN79LiRb9rS1aZ/eEYqT9CmF99y2qw?=
 =?us-ascii?Q?pZp6w93+O6CzjCCJ3iVOwwXBdFE1QLfTYXr1thDMsVw6vFyP2gv8cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f08299-3ecd-4b63-b267-08da0b38881c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:44:25.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PohefQdOp4mWlbovnyZY5KiSDqmJIG2yTOmZy7H/PV0j/RyXTvoECRcg8P9eMtfagi2xrVQx2g0RNFIoCzK8/V0EICONkBCan6/jdX5KRuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2255
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=977 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210082
X-Proofpoint-GUID: seb1Pv6W8jlyj5VSrsp8KFE-xg95TXwo
X-Proofpoint-ORIG-GUID: seb1Pv6W8jlyj5VSrsp8KFE-xg95TXwo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:36:26PM +0100, Jakob Koschel wrote:
> If the list does not exit early then data == NULL and 'module' does not
> point to a valid list element.
> Using 'module' in such a case is not valid and was therefore removed.
> 
> Fixes: 6dd67645f22c ("greybus: audio: Use single codec driver registration")
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

