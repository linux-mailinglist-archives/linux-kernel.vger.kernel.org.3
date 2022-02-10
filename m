Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5784B0690
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiBJGtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:49:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiBJGtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:49:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1110A8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:49:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A4W3c8020167;
        Thu, 10 Feb 2022 06:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FEpDxnd3XQsfS97G4Wapd+E6Qn+EADaSzylvI6TNJuY=;
 b=oJFOaVEQaCFem9FzlGSA/5YTMt5UIcvxBObndsyNQ/5YmDHlymLJh1JE4UbbY4HHswmP
 0gn3agcPme8jIVpcwSXU/XKi1fPV9r/u26MWUxCpbT0TvQfYRNcMt2TfY/GSbFHDKKaw
 cofYUD/9OYqPMJUw9r+AAZ9ILB/hRi/9PpEoQn2K1Zyq7PIYmGpaQI1X+UryMkB03MHA
 UCaO+e4qFZmWAxgnhDrtp4ytgag1GvNOfBjVVbcfUi5/sNTU/OwDFL0VC0h3LO2f/90X
 2S5GbP33TspQHw+8DHUArQcT3x1gqHrUBQX9uOhebDUW3F6mZTe53BK+MZe8xFbcrZGE WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366x0bdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 06:49:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A6VdKo177924;
        Thu, 10 Feb 2022 06:49:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 3e1h29mm6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 06:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHGlNfWu9/ialkUlE1928rsNaWK723f2J2jp7zzHqE9J7RmF2g1Q/hFwwXOEeu6ArpGb+TNNnXj8XJmEOGqS5hfcVaXKP1HdsCXONJZlxa/uMSbiYx/3o2eKdQL7Qgf8Q7pIc6XtRRvIJhOabOv8vt40m+Z41dUZ9W7PbY8wbOsoi4e8pgKStmHuUvb+W/RXHzDi+Lg65Ij4iEJJi01+Bk4z92Civ3zQnZyjlbkTqdhDj6xItHifMddoWZOvFYNbVdjH06ZDhZw9oW6U3uCGhyoHRhMneZOTEbIKBQ5WwG5ewhjUI/glcc2VMoP+eHo9gq+zA8cIPx6Nv0SwEIfH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEpDxnd3XQsfS97G4Wapd+E6Qn+EADaSzylvI6TNJuY=;
 b=ezQkkv7PzBLJTmjoHziIgWThUPiylf200OlRAUM/Y4Y/pJc2W3nD0zcI9UB4nwbjtn8Hi8VZwVHafnd35kz+rnO88MRqkonS186WOPEbK0pscN09SfNcVJEC4yz3xyvstEkP/S+o40OgaLiqVysdRgk2WjxZmGW0lODWM3vHaWwG6phAfBS///TtlUnydcD7jNYCQizV4JSrrugYDW9CvSiqjdIVVaZx4uG8U5l1iwsbhr+BwHpnqDcJOA7DDypqP0MGT3zsn+GVD0OfLvhCkBudd7+xXuH5v/RBXP5u3eilXG/KpiCHsxQ9Vzzy6x8ZNOYLzkOczAEL4WD0AKZYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEpDxnd3XQsfS97G4Wapd+E6Qn+EADaSzylvI6TNJuY=;
 b=dJglcr8KiqfjrBv2CjwKLSERUnzyjcITyz9nffgoEFOGBNatGDdrObQ8W6wzHaf5TGOMbW5BPBV8knwTdalvIpNbV47lPrBt6R5kP3Bxe1CWDCGZMwICQYNOneisPfCwIOqsBq4ycDZtfgYhkTm1pfXifGsG1EbYJE+qgXgYF9k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5495.namprd10.prod.outlook.com
 (2603:10b6:8:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 06:49:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:49:20 +0000
Date:   Thu, 10 Feb 2022 09:48:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2] staging: r8188eu: keep the success path and error
 path separate
Message-ID: <20220210064858.GV1978@kadam>
References: <20220209190752.7232-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209190752.7232-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23bd1e5-8947-4e39-04cd-08d9ec617739
X-MS-TrafficTypeDiagnostic: DM8PR10MB5495:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5495D73513E36B9306D466728E2F9@DM8PR10MB5495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgLkH74aSz6JE01T+PNyzvseU1jv1NoMnFNmJ6ggXBwbz6Qr88C+xATfc4S6BOyG5IUPPGzzta1nCx0PkySBbz/PC4RWb4vfvi9CpR8QpqFcKm2hVA3JP9BdSAUqNK5n6r0rgibjG+ldII3UvpwJCgNVHrL03z6SS5ValK2eRFCG8uV5sQY58puZvdnRTvgI9ADUNpF87kXwVD6Q+PF0t/SONeUdvdXdpgWqoARgt2lXBbYmCUidSacPddU5Zj42q50qOoq0m3ZqCCOClBty99wV46jf2LBictd+AXbhly2YM7N2lESkcx2S4IHL9eplVAKPso21tZUANkt8Tuk0isF3swu3y+4GXPyqa2gHXIkN8YvaLDkYYfCFiW0dZuKknwShyU+6tiNp3PUAuV3Y1R1TTI8VVwoYjz3OIF9OtLvaarNUSTtFuP8cl7vD2e8+MlJJK+JcojU8PRx0TctFRIuYh/LSLnVYtZrFkFY8GQwo8PEIcq0EpkxkLIV47XtvL5a8x14xM7sPaLzionSS6rU95+7M9aCRKocEuy3dbS0eO0l/1/lS8RtkXH7vTc9+elq4nDfFb6gVD8uCLd14geloD0BXpSXYt1nY6zfHCTMUCnJ2zvAs/mpP2lSZv061NVV1IWiJA/ugQ8yPZ+7RzoK3Vjox+T4Iukjv60z0ob2kcoA5iYxlfehW205zSaUPsjNg10APrWa95XxVhM40iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(44832011)(4326008)(5660300002)(52116002)(6666004)(6512007)(6486002)(508600001)(86362001)(33716001)(2906002)(33656002)(6916009)(66476007)(316002)(8676002)(8936002)(66556008)(66946007)(6506007)(38100700002)(54906003)(38350700002)(4744005)(186003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rZNxEXAdbCiXODTNEZvWxkKieFnaxN8h//NBRWlYj+garZvg2+jIcB67Zja?=
 =?us-ascii?Q?xv5txMcy54tJqza3uC1cnuRbEdSr7s94jNMvGLEcK81KLPPP+b/W1cwU+z0H?=
 =?us-ascii?Q?OLtDTRslN6hnmEJzucRrrWt5R4FpH5iz/nOLptFv1T/pJwJups74xfOZH80Y?=
 =?us-ascii?Q?V7qEYcAQdzU+u7N2qwkmma+XALB3cdeYez9GRbnY00ufGkh5Ci68Lm3UX7cF?=
 =?us-ascii?Q?M3b8X3G3Ywl9JOnzUolovKnWFw6PRNdd2DbrGk/UAWD2QfmdO4tgHiOLZQ9b?=
 =?us-ascii?Q?GhVSVHZFF5n2EZ5xG+sKxm3E6WrRHmPHanf1vL8dYvWL7u7GAyOHpKH0BzX0?=
 =?us-ascii?Q?LNfjAy6PDf60zmyIWodL/Ut5W2G0yepQ3mHwRNBK5t99IiGjkAU/MXjv9l8z?=
 =?us-ascii?Q?CM/k06HtKViBr3EU7SqxLxCKldAreNmwuZHtJlWI65u86PfiXwyoZQsDxg7I?=
 =?us-ascii?Q?RAOs/rWqrLsCZCan3m7dpZYmwebeylxr9cu2SkNR3w/mdwnfVUZxjhFfXDYh?=
 =?us-ascii?Q?ktsY6hJIq9PGUkXHSOdnwkl4E03Nie2E/sGDvDG9oT+ux8oxHenQqZ7yS0+J?=
 =?us-ascii?Q?4PQFbuAoMbgymmt5rvjt9BPBIdifiucpixSvqXOoZhb164YUuQgYVGWbd25G?=
 =?us-ascii?Q?TRyvLTGCPMy8ER/rKBJCJiItlGWVB7/NLgfVtTxX9gy0cEHHTM1MlFVssPlB?=
 =?us-ascii?Q?u9RGzF/YruIBKPzyn8XX4xX1b8sBDODG51xbzXIt/8lsnkM4Oe6hrlXpURNh?=
 =?us-ascii?Q?3FklTZ7h64AvOD91Lh0jc3Jo9atmRLoA/Do+MwzcBg0jl7JiYNdJXfBLqwMB?=
 =?us-ascii?Q?iVOCGfRZFFigGQpQIvgLABKlEYL4yjWB4Z3C+wnCCUaer2rWFho8gAeVRfnu?=
 =?us-ascii?Q?5UD4VJepRGu2s/HiJgIhP4FAkhdjizr/TP+wRArzA/xnRfgNdE5UUQkRnqdX?=
 =?us-ascii?Q?s6zPEODfLdNnz6XJuf97QbcZHXLgZxFeMpuGfCDfvA2AP7/R07FAsFFT+jbQ?=
 =?us-ascii?Q?2z9UiPNvhJsAjTl7mJJ7h6Aq6u+40BXcbD7O0J+JBJUh07rYRJiJL04/x4NI?=
 =?us-ascii?Q?mQ8LYilnZAS7td8R8Ye7qF3JLRYJinH+YbIv7JhcE1kc492x3hvu5uLcNsd0?=
 =?us-ascii?Q?rbH9Fph2hqyKOwU953EQut4MiD5zyWTKdk09QK7+wpa7lyg3G/1zivzDvlq5?=
 =?us-ascii?Q?1G8fUd6DEvNrcZ8OejPpP/fXVb0ye0tbyDVf5mqrRo/+bh3uSUvxyl07SWIh?=
 =?us-ascii?Q?TUJ78VujAIUPPDmLv/LV67lu3kPeD4yFxPBnHY/uetUFtoeet3Kf7P4HTlzz?=
 =?us-ascii?Q?Mc3O5u+XwN8ymyyJyTAIjK2QMJ4y6mJQeeAIpmbau3VY3DUKL3sVnT1or/fc?=
 =?us-ascii?Q?EZBf07c1wJuHi9hLLFNJ50sH/jvSCjPsKFHUt9pQ5C41+/L4tlu6O7OpuG4F?=
 =?us-ascii?Q?YMDkmwlYv1xcBwpwHUer+i+M6TEiueP2Ml4fD3NIGXmNJ5up/ktazhAcmIG1?=
 =?us-ascii?Q?D1gVvqTroNNhXml2OUIDpjqn/AXoK4lUj9+uEzjs9I375Zs4cNEdFnm6Zw5J?=
 =?us-ascii?Q?3mVKutuj8lMx+B8S1sHjQKzTRCMGq0ImdCbX/QBVsDE0kyCNvjdfTJxf7XFY?=
 =?us-ascii?Q?kbYkfiGJ1yb56d1onDhMTb3/x1vSgbT1FeM+JdgL1w50W0l1qZfK3y4VCL3H?=
 =?us-ascii?Q?MD0qWg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23bd1e5-8947-4e39-04cd-08d9ec617739
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:49:20.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiZOzaAUDndceaZ95j/1NBZJF0NUoxWmYsBaTpWKoI2jJlanZOMIAVcsNYXljlvX1r/R6QZV+fPX9HUc9bDjtU6Y6oE5oZ+pUc9ft6Qn4F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100034
X-Proofpoint-GUID: PxJQPVjrbMPsiSfi8uIyp1pw5dgTm4YR
X-Proofpoint-ORIG-GUID: PxJQPVjrbMPsiSfi8uIyp1pw5dgTm4YR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:37:53AM +0530, Vihas Makwana wrote:
> Keep the success path and error path separate in rtw_usb_if1_init() and
> drop the "status" variable.
> Also, remove do-nothing gotos.
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

