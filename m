Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504694E2DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351053AbiCUQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351041AbiCUQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:24:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F394666D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:23:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LFXlwZ011802;
        Mon, 21 Mar 2022 16:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vzP2PX4Bxyh4iVfWLKerqFKeOgyFti7tjqeRVPNrMRM=;
 b=PzeGvgm9Msb9e2cjdfQwnqe35Nsi8gOERcWNjmJzKcD/gbTBDgE/9WGYnfP+OkvhoHcU
 08HqG6WfTSzVh4TkAWorzHLuDOIymJm0txbLlCQRryiOTjS0Pbf5VG+ULaeUDAM9diJ8
 oz+GqZ4h8OqOk221Pi7h88mgnSIgizajfvar65STKwTzw9dMxtm+bRlanOaa5v5sm7i6
 Abt1XBMJY2pn+2lGwSA8UNVQmVahL6sRhmsC3B5/BS8wi0KGcp1Z4Y1or7dHJLSuoNEu
 +uNjYuqa/FogyNpp8Dk7emA707A4uOYDps5WmpkJ42dsphjqTILebi1ZPQnUKPNvLv01 WA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss3u8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 16:22:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LGL9lN018458;
        Mon, 21 Mar 2022 16:22:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3ew578su80-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 16:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd0auiV0M+FvbTV62YidS3sbVXhrx/QxXSUdGOXeS/o3vw7/aHwyscDBH7fFv2KCkBKU7jQ4Q/bf3BV2fDlg0ODu0gQQNrlxs/0DJ8qRlKeGbaniVDT5EFANwArYgfBrCR7ywJzY19hyQ2n1uOw60Z53i8UJtuqxw81hcneUPFxmT+A05PrpgniSZqkq3biTKdoKCd6hvjw1YEpWX6IV/yfMrayW4m2IfMqERbUcjeY5q8HSXGbzqcfAE211NHfzYqEMel06jC+J6e1s78pDM/dYDYi/bEuM5y/X5Q/JFBSflnQW59qw5Bh96T24tK8fq0W1zlt0+APKgn4WhtPVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzP2PX4Bxyh4iVfWLKerqFKeOgyFti7tjqeRVPNrMRM=;
 b=XnMGVj5P339Hv8TfEl7U1S1/54nn6WWSw4bxRHv6kR7t70ecjrTpDeKz0xEqYIuKCLSijIFHEh2YNjYqmwa8Rr8+AqOohvQ9VmeSkJZyOl4eIWCgYSG8y9meGDHJAmGCRuHCYHnZeSVrXmWbm81CQ60GqOfvVmTPymkBF64K00LxgH7zYQ40SXL00tkzyX2rU7cRplDwQKCW/Rcl2WbY2yXLfH88PH/FioKNpPtWkj9l1YcIyIRahnYQJ6CnzJViNOTudjD5EWDEEtp3gLG+07Yjq2oFyav5tCrzZ1fZo3fJSUTL/PkELQ1KraBPfua7AJ1v4THyBCpuTGaqZGg1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzP2PX4Bxyh4iVfWLKerqFKeOgyFti7tjqeRVPNrMRM=;
 b=YR9IKNsdCC/nWLXglNfBN3Mp80SU4RwSpovSO50Vj9ZlQif1qUVY2uNm2RUwDjfZQoS78/u+02JIJkH+fOMFyrhJA1FiXr2qtk+8Ycw6tFNur2fC8vrITQr5dWHoRIozHN0f42X8w4aW/x7p61qD4pCw9QJoLRY187ltTsbgym4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5568.namprd10.prod.outlook.com
 (2603:10b6:a03:3d8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 16:22:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 16:22:45 +0000
Date:   Mon, 21 Mar 2022 19:22:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] ocfs2: fix check if list iterator did find an element
Message-ID: <20220321162221.GQ336@kadam>
References: <20220319203106.2541700-1-jakobkoschel@gmail.com>
 <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
 <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com>
 <20220321135435.GL336@kadam>
 <75180dd18a3f460891cd93f7fcb3aa1c@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75180dd18a3f460891cd93f7fcb3aa1c@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 731ca3f1-472a-4c4a-1967-08da0b57081f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5568:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5568F7FE2BC9AE54C2558A758E169@SJ0PR10MB5568.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B96oxGC31mOoOWdKZrvykwCBDR+usibaUdvqR/yYi0XE1lS9g6UvzyYRW/+CXJYXeYdvwui39EyvKsJrj1xkS1H68FlBkUksBfermXJQuDuwdhDLuSx9/pawOiIbkqjyL9zLkUyODVETtP/iF9XKT7G5UltJ2BHbXJu6TGnyypleh6Qes+gNUmfrKscjeshue2cWshTL/Now2WABH7O/37M7TzvZEFRCt1q4lwzKiuaZap0ruaQ1yVHE+wKEsOwuc/Ucrcgp2dGzI4p4SuGDYQtm+wZbGqP0KWN+wBwyhTg4Jr6Q/CilwyA+V1Vhzls65W1Q6mA7ga5Uw+4YGk/TGriaH2UPatAVMoOzE3USyT4jGmQ4dv4v5YxuDuk9sfzexqIr8iMmfciluutHS9ENv6m/fMnnmIlhvbTeAAYkE2r5mZ6pDP8ErWY71VOhSYI89C5qtvBOJBzJFgAfgCS5CR6Z47PO4Jgh5/YTwgSMrHbLoaGUojofp0o5B5HbhDEPbTMeQBB43YMdUMghQLSuypYRjN3PPN+pWDmGfj/O0PDeRxEY4g14kUzbUHLsPOijk5GL7+CANTsjSrmKZ0FxABPptrB0xO8vZhfkCylThKD7cGSGuEK7UiYpQJ5LM9uC0I+2EAGyJuFJXf9lL+GyIIn9aYE+naAHsPXlYYhfY2EoqOinM67r+Fr7DOe8TsepjCPIEcNRDccf9XMGH4OKWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6916009)(6506007)(38350700002)(508600001)(6512007)(316002)(26005)(186003)(33716001)(33656002)(83380400001)(1076003)(6486002)(52116002)(8936002)(44832011)(54906003)(4744005)(38100700002)(66476007)(4326008)(7416002)(8676002)(5660300002)(66556008)(66946007)(86362001)(6666004)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nbVuDx8nZvGH6Dunlox/cj9XSmUQwk8tmn9yRcJGSlAmSOF5IiZT+10sJdg1?=
 =?us-ascii?Q?vQNmqSq3fBfbiUBcHNx8RaClouXGBtvJ7Y/h3AFeJ0rN1RFfgaVxE8hd0CgM?=
 =?us-ascii?Q?Z5H0cpHRhvpcHsoTC9Dkzytv8hHIeT0Om7cPdLMemGpxgf86Zl8tpepv/arH?=
 =?us-ascii?Q?rOrZHGa/ikM70tIamRSaoCJVhi2+2mtvM0W3SJAD1STuXyH3xHaDNkO+JDZ8?=
 =?us-ascii?Q?S376OoTYwYo+dkjcbC+qULQrfqAdn9q18sJOMVydFFhQeAnQz6hSgw42Syv7?=
 =?us-ascii?Q?Eoiw5/NPuQydGZt2+JK5OddMM7RbINEaB0frvwOioArbOt2hz3QdZfAqBmGj?=
 =?us-ascii?Q?LGbXGjLMDSCGldUzf1sBo9bx+ryrF5/h0Z/8s33fntgWZ/8D0oO2c5CG/Cui?=
 =?us-ascii?Q?ZKhcH7KKeybKEEobRhOW8IUYXex3q2AEUsxA6IP4VandPxJm19eshM/ljF9P?=
 =?us-ascii?Q?F103sORGP5HxWSceRr8UvQCAPg6W3F8Ir8hqNVVhsCiOkS1ZW6+x2ukHOeFL?=
 =?us-ascii?Q?JM7UJqyulviArABp0D+BE/jvwk8mym8jzovfAIzRTySnkIjhE0R2VQl34BDX?=
 =?us-ascii?Q?pTVpiaDSZnKNg/Nlj+ol3nhjI+7SbNjAbYCcpk9yd/cuo5I4gi4+s7v9rJ5P?=
 =?us-ascii?Q?Pc4gruQCzdk5H12Ipm+deeiNXHBgnlzYdwgzN89hM2RptA7GoWlvn2SkA2Wq?=
 =?us-ascii?Q?5q2hgQUtCToqu+AowTPJ3L2UTabztBBcHecGKrcckMSrb59zs1V9+fV+5vMe?=
 =?us-ascii?Q?62c2HTDbINwizV31S3O+hDyxpZWEnUlMkTOo5dNSmC5kT65ZF3znn+Q0tu+V?=
 =?us-ascii?Q?7n+DUZwLjv27NVmtGMnoGK1g/bTU/+D+WyoDF0CN/4WQpXN8FQ7j2NqX2yA2?=
 =?us-ascii?Q?jKIZuSXg1qIewIw9lCFV4TNaADdJwJWyQuIVAdhbPrw74rbWWIOCcj0rShdk?=
 =?us-ascii?Q?sjnXUVhTUMbB+y+CyrR+1ISUNoJJGCEhRfNhVnsIZ9Y6XP9DmxlnwblQamoM?=
 =?us-ascii?Q?p2PDuLJS7mhU32qN4L/PnCUuRLIrRxS1j90RS5Fr+bHYdhS7VU3ZtOCXOa+b?=
 =?us-ascii?Q?MJePFIiMjIr5vY2LmRVKYjbMqLdNiB16TYTOfWZx8PW/EobJLe8/l5t0L1MF?=
 =?us-ascii?Q?IheuXeDho6+2pX9oMoo/e/I126p5rwtmzZHgiCNFMbV9WZPzysG0XmxMSdyk?=
 =?us-ascii?Q?J9ZHvDt6NU+x1mkRgoOiFdNZsSzq0OEB2v1FHM1bS1L8dpvPid8+jL6194kg?=
 =?us-ascii?Q?Ii7lM+GCEeXZlmONaeqZDsci7JT0cWx/BZhvjbiXX276raRg5VurDAZTdh7s?=
 =?us-ascii?Q?ri6NE8+GVbzRTjpgvSBZVn1M3cNMBTfKQNHht4KMJz6lJD88BSx7avnbOO+7?=
 =?us-ascii?Q?fKq02/JFTfK8yCEhc+0InVmH0qEwThnncZ+mKti3+dapKni+DhJ6Yd1RL6yW?=
 =?us-ascii?Q?31wZ2H95jy7VMXHCnOVz5hiZEcT7favlHOioqDYJp7rJAtJiBuu2PQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731ca3f1-472a-4c4a-1967-08da0b57081f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 16:22:45.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Pfw1YbE6xsdSUccUpN41hqocWOLly5UXYXAO/RD7PxsIYKLczCy3wZsXzXNX2m2ysqS20EKeDZhEBuvqMxXPca34SGOURY9Qt8DUX7h1Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210104
X-Proofpoint-ORIG-GUID: 9eVlIrmUp8knXfxSMLVE7U4B75noplic
X-Proofpoint-GUID: 9eVlIrmUp8knXfxSMLVE7U4B75noplic
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:00:10PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 21 March 2022 13:55
> > On Mon, Mar 21, 2022 at 02:34:34PM +0100, Jakob Koschel wrote:
> > > >> @@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
> > > >> 		}
> > > >> 	}
> > > >>
> > > >> -	list_for_each_entry(res, track_list, tracking) {
> > > >> -		if (&res->tracking == &dlm->tracking_list)
> > > >> -			res = NULL;
> > > >> -		else
> > > >> -			dlm_lockres_get(res);
> > > >> +	list_for_each_entry(iter, track_list, tracking) {
> > > >> +		if (&iter->tracking != &dlm->tracking_list) {
> > 
> > This is an open coded version of:
> > 
> > 	if (!list_entry_is_head(iter, &dlm->tracking_list, tracking)) {
> 
> Doesn't list_for_each_entry() terminate before that happens?
> So this code is probably still horribly broken.

There is ! in the condition.  It's just a complicated way of writing
if (!0) { so code works fine, it's just messy.

regards,
dan carpenter

