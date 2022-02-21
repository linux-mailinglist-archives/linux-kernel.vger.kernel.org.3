Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CC4BDDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357609AbiBUMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbiBUMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:23:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4DC13CC1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:23:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9SObn003808;
        Mon, 21 Feb 2022 12:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=SQp1qhHWzZLAYKGy304FJiEugYh8wd2SH3xnRMfmFbQ=;
 b=u6s6ys+juIKsq059Mlyine5XwQyDXRJibD2iYuGBNFvhhuzkAY07+ttmDoLsL1cc+g2V
 Ps5guXsp+RIjsRaaZGKLe2gOmEKtpWbvG3kCIMyg8Nyfik0xLrIym6XK7tuQJCiD3mZb
 OzO7n9U5UcxLyuLj6vtBuXFDI+sgLFA9e4+LMWHtjZBZhuWk6LOqGVO9cfJc05gPgOgp
 LBnhie3Z/twb7jaZIyziERYXC7G5m+cktF7H9RaI1A4/uhajhb3P53CekeigFva14yzt
 bTCTbuOkCgTgJ6GTWcoSNKfkBBn2jBve3aFAdh1egaC6abIigfyBcPcK5j2eLnlhWH43 pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eas3v3xqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:23:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LCGndE032049;
        Mon, 21 Feb 2022 12:23:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3eapken447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeMgk2i01/7VvZgM2ShATor3hIMhCugrS1CxS5ajMlMuhJH5NkB2uZxLQxvwBlHVKRu0cxi3DL9c2J6//NrPatJ56rkGXLfwf2XV+RvscY+Hnm/S+ygo0FRp9iDzJnLDFPI5UJ+cLeCKsiGf/UZ5W5CbtWQmXW1f5i1a2yGmrcPtQqSJ428XMgD1j7PC+4qv+R1N7VNePPvlhMkP3DnSIXwSGz7cYnhOaGtklJEv+KHMZpmqRWLi/QbXE7TmH0ImwBU4SGW6vjGUBML0uYBIMjPSznfi/dpXvbGPlN5tS2rsujfq5pPnJo9SL1YrNzkK3zX10bcmrdJ4tjmMTCUAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUssJKuipegXiiHO+ox0uZsGrhOl+rwe/nxatVrmEKo=;
 b=GJfnLpp167JZwkt5gE5VxN3a1qpkWp23qehse9rVlX4RB2jidi3AtPCIFwQAfQb+IpUMYOKZZEjvwTQ1pRIe1DYV0pjC4XLtCmAxHueqX4FGVRmIqJx6KzHg2pT8bykLnaNbSiIdHg1no98xq8U4qJWzK4RGPItf8bX6DHQmfyFNX8kef8YL4rSZ9ZcXEVtiAJcY3/BTrwlfHYl4uyWhjeu8rAL8JXAD3JwWWh1kY6KcXW3QZDVYfoAES4Uz/hoNGTTuReKv+OkOor0qmi3qr/7Cx5yganRBbd0v6O2nlCqCeYonh/CyrI16PfH8q0lbbrW0P6tH+BdVuk6nGfWMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUssJKuipegXiiHO+ox0uZsGrhOl+rwe/nxatVrmEKo=;
 b=P8gqKp9+w8odArThGf5R6IVqXz9KFI0ggA3s6KyraX7Wo7DFxYUE4jIxOlsMSSI4U3rotTxpA3OrPKoA5+G75W+W9V4MiGnUHTa2oXahofxEEiB54SVRwyobqLuLaQdM4KegU9ecBDDOgRGZrEjOn16wPwI4tbBSXQIEg2CntC8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4727.namprd10.prod.outlook.com
 (2603:10b6:510:3f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 12:23:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:23:07 +0000
Date:   Mon, 21 Feb 2022 15:22:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Message-ID: <20220221122250.GE3965@kadam>
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-3-straube.linux@gmail.com>
 <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
 <94160654-ec16-cad2-3cc2-46628caaa17e@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94160654-ec16-cad2-3cc2-46628caaa17e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f8b08d-6248-46ca-1d2b-08d9f534ea60
X-MS-TrafficTypeDiagnostic: PH0PR10MB4727:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB472719869203F6B26BE34E208E3A9@PH0PR10MB4727.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: in0N6BFB/t+guQxtxXJ/fA1RzkB+YB8OcPHKspxgYf9aEh2vlE8rod90r5IHfvro0yEDvCO+E1TFFKnaQmYNsLSMzebe6xin2m5fYEqXfqcDJi0zlUL7jBoYJR/v+d7516DPsye/jec+i16reKX7M7OA86Zyu5ISJBBjhwczoNg2oAUxLB449OBgmlPCbevGSNlcVVQmycHpWZSmCWiT3TVKu2ze3qAvl8brvcu0tkzMNPCiyQDkVFlogUn/ScePgCksjsgdfFb9JsAwkUKBr2nzJAsQD6rXIFG/wTVLu9zriYfd2a0GwUtXZlKz6hwvH3/bb6nUIGeIEg7j2p7YCbnV0M/MxbGlFCn//w//Q5LS1hiOePBPxsvVnavhpr1AdSSfwmdOzq3Y2up9mVyx1LsVvo24CjsjB4zE1cwNAcXzDXCLU6osPizTZFjKr+nwv8vII8aWGbfOobzcQwnu01uU3VU+WstO4X5RiOV2cEtVHRBlaaEewSt4vxE6FdQHMlB/T/M8Ecd4X4I2zZXiP+PVOCF7j7Cu+NakX6Z4ZncoVTqY8KrfH0K1SQN/IZYpcS42Z06c0dg3v9+7Nn4tBjuPRwB6MFnMYz9ByNk0nuMSa2BorVFfCMcSQRANyNnCYOByBU57DKzZ4Do5/c2M2s+Fy3u+SxknJNTM2pG1lgiLBalOyJg4Lpu5HpAVx653+e3X6Tior14SeANrBElWbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(508600001)(33716001)(66946007)(8676002)(6486002)(33656002)(66476007)(316002)(4326008)(6916009)(66556008)(86362001)(38100700002)(38350700002)(6512007)(9686003)(1076003)(53546011)(52116002)(26005)(186003)(5660300002)(2906002)(44832011)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FbdVrmPR4dNSaDhmAuAot6c2oRSjY26ORfN2I45HgLgddg+iTwX/cz2ieb?=
 =?iso-8859-1?Q?ZIRj+z11Bcydnq8YJ3ZRSOkStKiGcdz6ZkQcth6UqIXxwRUMmHt06AwHOY?=
 =?iso-8859-1?Q?hKnWat7K9zKthnd2h6f0StBEJ+xWl4li5xuBaTI7yGrjNT9Fqbeb2II+wL?=
 =?iso-8859-1?Q?gQN+WzAKmX0Pw4sTdMG8s7nkQwXRUQX7ZAnYCQmYY8vlAtTSp3DFwpwkU7?=
 =?iso-8859-1?Q?PJjI8hJD3HpKmQq4ZrFakEiqDsyeklZq5ItpR0rgCGucMlbSveRw6Mozk3?=
 =?iso-8859-1?Q?Jhfc2dWzyS2oATXGl1b2knsE+BE6xfsYL0r6xRfz8x/WDRd4L0nMZHZ0QK?=
 =?iso-8859-1?Q?cXKd94EcpTvvN5DOuVEtRhjmmiDfL2l80OnYBIjfJB6VhO93x9AZl9uGeJ?=
 =?iso-8859-1?Q?MM70k+BiEmYP+XaSFaOKeeZ26rVrwqVYPdTazv/iEOj+RoBQFdQBbb6qSL?=
 =?iso-8859-1?Q?xpmRE2m/XRW/7Tb0n+GvLh/1B4ctIiwdmtKhEhYlMtxZpRvyKJW2kOksck?=
 =?iso-8859-1?Q?F4DirrI9ICIzWJz3K1egaMqUdSWAGd+egko0qx1MW4Sy7iY49umO8NKbna?=
 =?iso-8859-1?Q?ErxnAT58cyjbugUnp97no7+szwtKKfP1+TgPDbcjwx6BQOAFhJ3p+sNdqf?=
 =?iso-8859-1?Q?pyqnKGeMEa9t2kzPjtK4RNuBFK23vk9t8Ya7W+V5DurO10JJQMaJUCo3KX?=
 =?iso-8859-1?Q?itpYfhpwvPT2NoD3yBPXYIhQ4iq2cHEw4JRXlnyay8K1ZwltpRNmLyGscs?=
 =?iso-8859-1?Q?YYJefPf66k2dnYLDGTpwEarE4txB8ubNdX+Snr6vXpH9pBRQ7boHLRQIB2?=
 =?iso-8859-1?Q?nU5jTYDpQe26FGAzWcj/NonLiY4k+uXz7NsxtYl6UrpWT+ZApmxmE4aNRb?=
 =?iso-8859-1?Q?e1bLjMuXdJb6/jKU8nh88WqGViG/YrvKbrQqoMvY9+FYCSWoJfYTs5Afig?=
 =?iso-8859-1?Q?h/BefBOXXfNSkfw/HPSrGuho/mx/QXgl8p4Uz/vo4+6rjiGXybGN8J7aZP?=
 =?iso-8859-1?Q?mK+VgrnhgB/M2iLflCwvKcGK32Bl2sijfy+w0WRgjFPEgPx+ekLJl7uP90?=
 =?iso-8859-1?Q?2aGff/IdsZ1n2S6I5WW3z6Tv8id3SYBBz4ypNlc/c9ULGJ4/lya3uawhnN?=
 =?iso-8859-1?Q?6KZwghJpy9MAlz6ZRVDEg/fnMR0KdkhCooR3SJadz+wIa2+3gFkeZ2+BHo?=
 =?iso-8859-1?Q?3TyYFntxJ7fnWiCc9xFRqdETlXUDreJQJx7kkgKW394+A5g3dSyIC9qzMW?=
 =?iso-8859-1?Q?hUvRcRTHbUxCoYeOQtVBbxCEmanZNDyfDYlfdlsxCCOnAMC2ZZhAqNHLnX?=
 =?iso-8859-1?Q?kof5EzgUOknQInry70iswW2Y5Atu7S8IMfVM9BKSTv3IUO3kgCRFEfZwgs?=
 =?iso-8859-1?Q?5k9xSHdLjIToYO9zD/bCJ2iQ2Di8qWs2o0Oy+TTz8ycyi0l04eaiTH82Iu?=
 =?iso-8859-1?Q?z2kkJSgt3dbrK0n6eug7O5CRIrDIngCO6NVngyYqsAePhX3R3c1DcA/LPy?=
 =?iso-8859-1?Q?dSIJ/vHzTPzhK905YrJbOYEwo6MIYQ2Rn4KyRqiwKOl/D0laQ5C0Ilwo+U?=
 =?iso-8859-1?Q?7H9TydV5oc14U9IWfxGCWc7ocwfweSkvIi5k71l1yCrThqqBfnj7mgoJmU?=
 =?iso-8859-1?Q?QpQE+3QaMJvBrCBesEHcj92kq46VjMdT2WpNONlVcvG1LEsrtVWcn95Pz6?=
 =?iso-8859-1?Q?lM+l1BuHTIPYgWGrMR1Txy6ScqLr+na+oN1bFF01id5+LDIcp5EeeedbcB?=
 =?iso-8859-1?Q?oANw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f8b08d-6248-46ca-1d2b-08d9f534ea60
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:23:07.6719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z4uRrEAIlfnlMu27lO11uI7Wd8F5TyiVw4fdpaGzHLxwaxP1A60RsugjmZ4Faom3HR1uNwKgXmR2e4O1lDISL8UmQ6zGLjtn1CQKLDeEbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210074
X-Proofpoint-GUID: _g0YT504Rw7sVPJMDYRFaLUJ9r4tQlDb
X-Proofpoint-ORIG-GUID: _g0YT504Rw7sVPJMDYRFaLUJ9r4tQlDb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 05:30:08PM +0100, Michael Straube wrote:
> On 2/20/22 17:20, Pavel Skripkin wrote:
> > Hi Michael,
> > 
> > On 2/20/22 18:48, Michael Straube wrote:
> > > -static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
> > > -
> > >   u32 rtw_ch2freq(u32 channel)
> > >   {
> > > -    u8    i;
> > > -    u32    freq = 0;
> > > -
> > > -    for (i = 0; i < ch_freq_map_num; i++) {
> > > -        if (channel == ch_freq_map[i].channel) {
> > > -            freq = ch_freq_map[i].frequency;
> > > -                break;
> > > -        }
> > > -    }
> > > -    if (i == ch_freq_map_num)
> > > -        freq = 2412;
> > > -
> > > -    return freq;
> > > +    return ch_freq_map[channel - 1];
> > >   }
> > 
> > What if channel has wrong value? The old code returned some default
> > value, but with new one we will hit OOB.
> > 
> 
> Hi Pavel,
> 
> thanks for reviewing. Yeah, I thought about adding a check for channel
> value between 1 and 14. But I did not add it because I think if this
> function will ever be called with channel < 1 or channel > 14, then the
> calling code must be wrong.
> 
> Would be nice to see what others think about this.

I'm glad that Pavel noticed this change.  This is a risky thing and
should have been noted in the commit message.

Just from a review stand point it would be best to leave the original
behavior.

I have audited this change and I do not think it is safe.  It seems to
me that one way this can be controlled is via
module_param(rtw_channel, int, 0644); in
drivers/staging/r8188eu/os_dep/os_intfs.c.  I don't see any checking on
that.

regards,
dan carpenter
