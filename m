Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787E04934C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351704AbiASGEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:04:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33106 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351664AbiASGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:04:29 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J5vbCC022260;
        Wed, 19 Jan 2022 06:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uipC2jllDVnSDq3U9awNrkEGKIZ0YPMeIR6CN07FV58=;
 b=l4hqFuY+Y6bjuFzIRhveQWBKttR8RnVuBm5aaA/nDR95c9O/CfePXaWR6er+EI9og3Wr
 e4naVtULtCWt0+n4tQhA1jw8tTLRqbVC/Ng3qyLhs3GC59OAtpX6UKxAlg7dGgKATTjK
 BiaylhAzieOPdF/OrlF+Bq/Ms59sUCC6YO0Y2kNGDzqpqkL1aTdWWilgKjGSIZ5VzlHH
 a6YfXEAB3de2+8wRm+qGWACVsrs3bVf/Zhj5fhYT67hvIEeMR9YxH71C72y0K8L285R7
 kIJDlWFRw1SlFP+KNyotKCykFPv+2Z69oHC2PzxKHkUc3nHVYNruFRu2xr/kAtKpWoHw /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52v2y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 06:04:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J60b8H180541;
        Wed, 19 Jan 2022 06:04:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3dkkcynskc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 06:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaJGEm2a/gB9ENBn0Ns43X8HaJNJmIxribkAbzdKMnqi7B35oYAyqjdgXs7diDCZF4I+eg7tRnq8u/6JHiLWsxM2tHoSw4LN6aXRNeANLo0QmM4GzT2woV2w3NmUSCR0a+WxgJFoG707GT5jaOQZJ2PgXkXx4+lVspHJyo+xma52PVnrHaCCnj6Use0x43PqOwvzHOok8e4awEG+WvWbRIr7YLhOANcY37V5O93hhrzqA8qf70QVnYucJYe+cXXsT6pAV0mTPcvOvhFwlA3wBVEQ7j0vgDT3dQjINdmYH+Y6dJMnXOc9luRNqzxZ0qQD5HCRiMW83fUa4FE4YlJAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uipC2jllDVnSDq3U9awNrkEGKIZ0YPMeIR6CN07FV58=;
 b=BfKb5N0HE+asUPxklsaoLSIj+P3IhzehR878tmS6dKXiu3I+wN409wE6mtwd06ruCXZfTMe+h6oK/zRgdXWeUy/0C1nqWrboR5sSFx6Xcu6P70/jKaFuzH7eVIH6EjJ/149HC0TulsRSeMgYKnpxbtn2yWEZ3DpQwaqD5OZZc6vrpAUA5Hgmcdfl50Z4GZLf710BFuqn9Hkv5xjJRyj7tId/3EdLoSdCkeh32go0v9jH3AuqWeify12ifAwT0rkwvdI9HiX55I6Jb+uwKxJ/E9u0Rxt89Qlcp8EtKY5b+OovEZksjmmq85nwQYwoSpFSSu/UDLILa33oH5MZiwetqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uipC2jllDVnSDq3U9awNrkEGKIZ0YPMeIR6CN07FV58=;
 b=R81MqUEoFiT0sBzPr7N7IJeDHHbSeyRAQgXLqtE+8WEohoGKbQ/d9b8EvGYQaA0Lw47ZqvokqfgGS2IgGjXaMOTqVYyvjGj1VhTGaAR9x/kpo/LkCpP3lfw42kxN3C4rV3BD+aTQyD6NFYntuFXxJi46lOqqUV8y7f0XARv6utw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2784.namprd10.prod.outlook.com
 (2603:10b6:805:d7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 06:04:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 06:04:19 +0000
Date:   Wed, 19 Jan 2022 09:04:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] staging: pi433: validate min/max bit rate settings
Message-ID: <20220119060400.GL1951@kadam>
References: <20220118193422.GA3155@mail.google.com>
 <20220118230312.GA4826@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118230312.GA4826@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 900bfa3f-d23c-43b5-d4d4-08d9db1187e2
X-MS-TrafficTypeDiagnostic: SN6PR10MB2784:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB278494980EB6ED0FFAE9149B8E599@SN6PR10MB2784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBqKhf4t5yiuZswvUQntFq41JF7Yddjtxbt7nuEfIiqwQvYZA1LVa+D0f2yOfxGx6Mwf9Rm2sj4hOh/grX9UwQTfnOegNDgfx1AdOwiId21s5hc4eZnvJs70sfF27J0Ee9uW9joZDBCH7uU+bokDtZj0UNs7BnBaXMMmyJ67RxoOZZic0DaeddQwqvsFkNzLL6baliRUTWBJ4enrXuFtRayKzAPca8F7gZp0YGcRgGfI76MxdDfDftw1dMpnhNb5WBE/+r42LF0ayvxBCDhHayF8G8hCnfvz3T0ndxImMk3ah/lCIGxBXCHikSIBiGei4VTwg6H0AD8kK2AWdXYiYZw7wIOk5wRzdU1AHVuCiE3K/eajWab7LlK2yl8vViFDvIvu7O/HeJCBlc3B8pDT/sNFfWTJh2iZCygtEe+CDPldz83gUY6f27oU9CIGQ+v5SN4jvq5F8NL/MStBTDEBxzp1Gw3b9OPHzkHnUPUUXynwJlWV4zxPNzPOj1R84lWJSN1wtFTWqLOZgciqLy/yprNYVwZF97ImzgsRwIc8VoiAwRypFtUxJoshxZO80M4ocSrXKVuK7f8fZDC8E7xmiFwNPXa5BmrNAhA48paKl7FpttVf4yAAF1vjhKZk1VvoZFETGoGFZ6pSXOikmtEecLjKxheR1gXFOmJTBWoNNvVqIR9VdRaw+n/NrrDIIcHLNW9lBboT/vwIlplUrbsLpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8676002)(6512007)(66556008)(44832011)(52116002)(8936002)(4326008)(6666004)(508600001)(6916009)(26005)(1076003)(66476007)(66946007)(9686003)(6506007)(5660300002)(86362001)(2906002)(186003)(558084003)(6486002)(38350700002)(33656002)(38100700002)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rzILyA4/kebTA6s1S4kM6eFShiP6HwBMI+MHn+psRRWVjdM4GA6eI1FwStwL?=
 =?us-ascii?Q?4Un3GgQAnPxgVaAzDRx7tCbM8L9p0L5mllfmFCc9QLGxS6qLCvQossgS4fwJ?=
 =?us-ascii?Q?kVqQxu37IkvBl5frQQC3AxgtrWpT0A68GXhcmEIDqJe8I1r9UdibWRC1RIpk?=
 =?us-ascii?Q?/mCPPlJvLytpEoULIB6nmFgaBZrLAHYmiiGdcHteduv9Mq/T7TvDsW/PlK/l?=
 =?us-ascii?Q?oYtQKTfhadkGDEZyaCDV3Rd+m8yyhPo7JS+MFophzYhRkZMtQPVaRYsuilwy?=
 =?us-ascii?Q?LupVmUVtB/6AqufyKsIFIZPBPyaePJOsSWgy/AgYF1aZ0laebmJZpKWSB3gZ?=
 =?us-ascii?Q?cp9HzS5Ct/5MOTkp5luheek1BQLKtX9u0lHZFY1XfbseB2Keg+KTw5ZCZNLv?=
 =?us-ascii?Q?8tL8ZfGnnahXnK/hdfeXCcnnPy/eXZzUhl4HPY2rHh7ENR8+3qROlZ4nZ1GV?=
 =?us-ascii?Q?lVfPTbDrw3y+DpuTcU6c0J/NDSVOtS/e3qfJL3kThkrojgvW7XjGoCOMdY4P?=
 =?us-ascii?Q?iMGcZ2XMmhUOckZ8I3iMVh3Aw8s2/z8sRBdyc/MQ5v+OqfIFr+ocUXBU9c5L?=
 =?us-ascii?Q?HdJnK6ZxvKLs4UJzMujabisEzuiDHrYyj57z3QU+28hucz4EIVgeq8765BNs?=
 =?us-ascii?Q?26h+o0/tgnkHcrbBI5C3YGTekehm1lpAfyb1RXRIV9R6FD9kdpU66OPF8vN4?=
 =?us-ascii?Q?QEwBggKzCB3UkxwpU3FOmjKzOSUvvqUUfWwooaChvf01wThymk3qMeuO4C8P?=
 =?us-ascii?Q?uf/oDfRcqfLWEL1vinBPyoQIdqPr6u6GHZ3p1TP353mPk9wMsGKLU7R/WGWu?=
 =?us-ascii?Q?L04Ihp8qm3nuCvGAYz20mEdFRMgo9iifK4TKy7Jx8JNDgMrOUcdfGhaK4Pbs?=
 =?us-ascii?Q?VxcqCv/cUkw1Gsb7fNF4b6Lx8RfcVlWqr3lE1azhKzpD4Q3G9C7F3Up02x3/?=
 =?us-ascii?Q?SKgd9VgBToQDmver80i8qwb05tIIcs9dBBfNG/y6ISKMc7uDaUXnlYgT+rIJ?=
 =?us-ascii?Q?0UAFCFvMj4njlrFcWzbiQcUxfCwFaWsCbci4aMpe9IIGhh+/j1wrYJA1bg7F?=
 =?us-ascii?Q?ELjNMp12dr0hK1dcf9mOBGaLHhDBpexpW0PA2A4yRGTHnMp6LPDSdQAygW3z?=
 =?us-ascii?Q?TcJuCbO4vDX4DC+SUK13+5awFY1heLRlMhE3IKO2K+3r4JePZx2mcNaUH+uC?=
 =?us-ascii?Q?6tOTa0Ta941bitBbvXteE+IqYGuGRlA0FhH4qafMY33gTrbZRqgJXFrdRoq3?=
 =?us-ascii?Q?qTqPB9iFRym5Fps+J/EHldZmXcZMtdke/UbMMFmKMqAZmFTR2cflHxYTh7Qn?=
 =?us-ascii?Q?bCHRSgl9NPLUGqIe+lxXV0O9dtXkvDUGI8bYAD1sh+tydOURNH+EQ0LzkIux?=
 =?us-ascii?Q?7y0UXvj64YknzVTr8lJYzzCh3KXWMY6jPLYIljqJNsgIv6TwL9r0V+q58tjX?=
 =?us-ascii?Q?gfdvu7qZqxPpsj6gsgYAVjPqnOfZaFIBd1uPjidXN4Yv0QZPPQ8J1HOI/P7t?=
 =?us-ascii?Q?s+Yc3xLcbqXoAGq9TRNxpU8yOQZH5E4eFoGHbDe1my/o7qfRs0hexPGPgEnI?=
 =?us-ascii?Q?A6d5JTGFISNw6kvOPVE0km5T+F6wSVci2Otm9TTCXjufqT3TVVHefesn1vIW?=
 =?us-ascii?Q?p3qKuNRjyi/zsats74CwlWX7gody4GTIJrShI3qVsSub7L+iLstKGok4AXz9?=
 =?us-ascii?Q?P5N8UzxPNferNNcxKTLGsI42Ynw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900bfa3f-d23c-43b5-d4d4-08d9db1187e2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 06:04:19.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y0Z6RYV4+TAxv+lheBqnGY6TTOLV0WADT53zAPx1K3QMgSXJ/VzuYqI7V/OxJ18UXf/wa71QBPL1XSzMuojZyckuJX7Y1CTgn+ZxrJXl1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190032
X-Proofpoint-GUID: RpVytXRuO92-Z_dLGWVBoooqm9Qacy29
X-Proofpoint-ORIG-GUID: RpVytXRuO92-Z_dLGWVBoooqm9Qacy29
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm fine with this.

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

But please do add the note to the TODO.

regards,
dan carpenter
