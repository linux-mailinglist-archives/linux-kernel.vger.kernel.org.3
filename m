Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63A4B13C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbiBJRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:01:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbiBJRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:01:38 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC27B8E;
        Thu, 10 Feb 2022 09:01:38 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AD9bKO027662;
        Thu, 10 Feb 2022 17:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=8Q5nP8WhPNTsLt/dcN85kdfqNtXFLa7H07ltxBHPJIE=;
 b=G7Z0liMj7E5WCbwXk/XJZMMKRMghdnhE5lM0Oj7dipV4ZuB1aUclxKt8r+8CqIVS3T/J
 93B/OzXJnsiFo/UgenMWRxTbR3Gxi63kaQVkQtcrWlaHZaKXlQSsCm41dmnOXV/4+pX3
 CTd3LMEVKFDlnTJteIEzhFrQGRy4yNkZEYeeThHaMJ5FQ82g70s+GKO71KvZ+UD+rUPz
 rt7J9Uxfw/WXD52nJqXG7/Q81CCJWa8a5oxF41S/3rCHJL3e4QNnQiQe1E1923b0MMux
 qoTKJSxYscP97iGMcL4F3fLH1e3CW63zqOEg+yMx25FEZ2HaYwNe3cwbVmAvmWHI6Ovg Tw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e4f9e13eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 17:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+dj80Ovu6doG/xrbdvBdqPgoXdZlJ+VpGg8Gx4/1DnCsHx4PjBMp4UXnleRmu9h7F1RCA40YPXZdEZKs6o8Dpr0Cj3LKJRJQLulcYzGBMyZnE2SaN9OePJMPaAiaSRBElT1RBngKc7yvYUSvUZZm5DKXzfkXf14rqQbe4dmvFOkvXtMCOj/UeCUIYsrlkNK/WoCOTHE67cEihsMy7R+73qu85CQ7ZCj/W7OxLKX65tXtcFZ0FE8BzRfdAPJLNYsMT5L3iDCMQuO44leOG/kxCbKCHo0hNhP59qKlnE+1xBR7nVTIvhNTkOqY1EnNCB2VJIqKxzpfV0sKhAh7+/YLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q5nP8WhPNTsLt/dcN85kdfqNtXFLa7H07ltxBHPJIE=;
 b=XkOiKRDEfd+d4K4UCOQz0BRcRXID5O55wsCJvlh4gxwVchPRsyvVdHyxCHumq18BwqTHrSWAu78PQg5MChl09SGG4bxkCr50IZ+r8dzXQxGqlD+U5R07TALohD87++sky3zBFlGda6LTYpMEvyKHPavd0lm57GGKphBo8CgwGnIhFCSgxA/OuiBeoGV3HVo6vTbcl7JpCGcSTb4kdWzbl/YJ0H4YnOvGOZI7rV7NUA69zaj9MboMTrKAbsDRN+CN+WrURgz7izakjWmj44Vm1e47Ax4vwYRw6fRoMOB5aMpgC2WPCcO4K9V5Oy1MmAr225kiIgHkdvGf7/Y3OTJwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR11MB3008.namprd11.prod.outlook.com (2603:10b6:805:cf::18)
 by CY4PR11MB1304.namprd11.prod.outlook.com (2603:10b6:903:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 17:01:31 +0000
Received: from SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3]) by SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 17:01:31 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBzcGk6IGRpc2FibGUgY2hpcHNlbGVj?=
 =?UTF-8?Q?t_after_complete_transfer?=
To:     Mark Brown <broonie@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
From:   Yun Zhou <yun.zhou@windriver.com>
Message-ID: <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
Date:   Fri, 11 Feb 2022 01:01:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YgU1+cIlANAkJCAL@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 158655f6-f737-49fe-1c56-08d9ecb6fc11
X-MS-TrafficTypeDiagnostic: CY4PR11MB1304:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB1304A03F746C0E6B62FE16E69F2F9@CY4PR11MB1304.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMnwogPOEbHnGUmkFWrAQiH5azQlqoiTnh9KhnoT+3tGJ196jwv3nxE2ySBXnF2H6AfYe6kQkaNgQhlnbaHUNEaanqNB1ri70IBCphO2IB+EbaX7H7Q3uTx3ZVPzgie/vBFWQAV0X3Tq7kQ7xZsjALT6NfySPuRIxinS1Ls69T5j2kmhWV4oaC4a7on6DISulZju9puLOX7ku3gflFbs2tnron3DUBZRTGnRWwwXLCHoSOPYfZFWzeNnFuHUqrsitk6L7mSIi/621Qf31XICtARJJMdOr4u5KXaRie/fzpvpNPBgr836gBsDi21WoV6tPie+d7pc0eOrxhlMpfQL4OMUm85PH58TQZI6rVSbAitSvlBaubF3bK6U95Ug3boEGEA2+4qsF8/ee3jskTldj6n9+3t59cQv01TmbGiK+W9T9+7CThD+6W0gGBhHYHnVbX4+IaFzDdiK67+dxiJo4ZvA01drB667vwLmlgG2Fk6gEvXUvRGeH/vWv8BFo8qqZ2tl58M1r/+3c0h6ICx5n8jiVh4Jte03D3Y0JYtimsf6VZT0PWb0COL70QOprQteyup64J67H2NdDc8l/TtbHlwoPvIFDPd0fEe+isU4yyNBLzdz7JWgWF2iyCe41c3oiJJ0tttn8dyFcrGaN8wLHDxgFByD1m1p38T7INUtMB6ImYrAaae9OXbxym4DUOYezXRj+CpgLphfL3T1TbTByq2+T3IRGLfPh/zxT4583MqNbTq7zoSVQ7MxIIgygoVl0WDXEVrwhe1/20463Q9kZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31696002)(4326008)(316002)(86362001)(107886003)(66476007)(66556008)(8936002)(6666004)(6506007)(5660300002)(66946007)(2906002)(26005)(44832011)(186003)(2616005)(52116002)(6512007)(224303003)(38350700002)(38100700002)(6486002)(83380400001)(6916009)(31686004)(54906003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?AisIIb+NZtqOnjAEiF3S0GTf++9nSCCsiVbof8y7Zh1i3nlYohkYBb9H?=
 =?Windows-1252?Q?eUkviucepUJ6MTD/85+0AcMIHYGnlzKqhbxEPAeWi9/HGrb1G1tBDM3S?=
 =?Windows-1252?Q?2J1gufi+em7h7J9oZ0IRzSyueg75deH1CWqxng/xk+d0U0UxIA5XZ9DT?=
 =?Windows-1252?Q?V0jHtsMvYSc92b8Ot93QyVxbSFFlTkfNIyrzVEMl7POsWDe+H+7U83Wy?=
 =?Windows-1252?Q?CyfNrpYbC9frGIwWfNCJDtbAxz/NS+dfViZck6JZs/WvepkZnxmWFJbl?=
 =?Windows-1252?Q?zNtwU/XZXtLt0N/0cHCEzyqppiazhiqJ+lL3R+o3x5GywpB1RkYoC42K?=
 =?Windows-1252?Q?V54AZN60tQYqsCW0IODZm+dJwzVZKtvLYpYDZy9qYnu921wE6BAnJS8p?=
 =?Windows-1252?Q?BcrYyMq/qgh3olKcwXTTrjZcMt7hj0uGgKtehR+Ie5pBdjXRbH67Evg8?=
 =?Windows-1252?Q?xR2rj311tmXc3bjp23jZzx85U6rra0d/Jd01d9R30EfAG62ZsIfZoLQp?=
 =?Windows-1252?Q?kt7WEgMrxnYZHkZK4S8z9zO9Pm42wwwKddBLfK600UULXr5sXFwXyEi6?=
 =?Windows-1252?Q?hZiKhRwbbOiBhQqSIwEgFgt+akwX+adc5VBzPds7+UMWL/kL25awnWVJ?=
 =?Windows-1252?Q?v+SPdXGbWIAep2DKimllOxKx6ezzM3QCYgGMAxvUVbxUpeuSWklEs3iE?=
 =?Windows-1252?Q?Ma76aedEJI38JHqdCpSSIvru/HFmyDH504C4uv1pR5+1e6Akm57KJ84a?=
 =?Windows-1252?Q?ahs9XXps1lVcBOBRpje4blPjKQUiLJ/qHLnOnRXZ7JqRpwi/JUWudOYc?=
 =?Windows-1252?Q?lnlDFBcNyoJKcwWUaIQFCkh2h+XcXtyh6ei5M//QEd1IIbd9idOR9vMb?=
 =?Windows-1252?Q?8REGDnOQbxqFnJHlQ62GXNATZqhc/6rnDmYrWE2IVct/CwZDnIVEy2fJ?=
 =?Windows-1252?Q?Mn3oqiN7yPJyjLw3NMH/fQOOCT5sJcovlt7jMwVXDq47aHjOyKgmIzEY?=
 =?Windows-1252?Q?l8/R7Ep9Mb7C1Dvodkd6TevnloritejkjacshB8lm6+uxlZPdsTShgF9?=
 =?Windows-1252?Q?vYy3gBfl3pGzMJh6hD1ReWv6fkZ312zk3HmDzJasgs7zzh9XJrwkxlWp?=
 =?Windows-1252?Q?d6+TtHwUFVbn/D9TFkikKVAy2euuRu0+m+hWV4fC5IGUG5ElInX3xtSX?=
 =?Windows-1252?Q?J87PICDAuokc/QoWPF7ZfD/S8H3PT+wYjIgBuDSJKD+s2+sfiWjXNVzD?=
 =?Windows-1252?Q?D+nZhDfX8uhnoyMtBB/GnGS8kESQ5kshuBsB6SwTwp6TH/5CznoKc2eK?=
 =?Windows-1252?Q?OLnWzWAChorYm040J6+aHGJbhsQrLWU9yCLJaBhORgkIQ2gwr7YAD7aG?=
 =?Windows-1252?Q?nOEz2BJnHOCLH8qZbrLRbT8kCNXpg1kTRtwIFf+wiN8n1MafPs6s6hxt?=
 =?Windows-1252?Q?N3JLp3VPzx813eoekUvRuHWMktyrAg610oNUjkdce5VOuTJGyiC7kPDt?=
 =?Windows-1252?Q?jK/BMd7oOkY7eH1lDZ5bXNInyQghASEG+i4aCQwIJ/xaFnaYVG+OpbYq?=
 =?Windows-1252?Q?uFLJzNCXAaDPXNnOSu1IGjf2CqDUb1MTk6DAyFfEF8pncfxPPWN2fHre?=
 =?Windows-1252?Q?vtGXJejPah+NXoeIIOIP1BASyKof3RNSJpjv9yNgdMS3dF0YWNltQTYU?=
 =?Windows-1252?Q?pQuAQsPiSU9dipYa9iKxHigiHX/4AfIdEdYj1YgI3fg/aDF7iHg09mPV?=
 =?Windows-1252?Q?jyjcCL62EsemnuFCs5E=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158655f6-f737-49fe-1c56-08d9ecb6fc11
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 17:01:31.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rB4iqyMDfOgOaiSCiOfxiNfA4iHDVv3dua3/WvbXNBKDc8nbSOvjMybYgnaLo0MtzP0UtKRoD2asjj+zVdRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1304
X-Proofpoint-ORIG-GUID: CnlcBKLihfshz_YX1u-HlKCwtU_VAZiN
X-Proofpoint-GUID: CnlcBKLihfshz_YX1u-HlKCwtU_VAZiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_08,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=974 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brown,

>> If there are multiple messages, and each message only has one xfer,
>> and the cs_change of each xfer is 1, during the transmission of the
>> messages, the CS will keep active even until at the end. This must be
>> unreasonable.
> This is not something that most drivers are expected to use, cs_change
> should only be being used at all for very unusual hardware and it should
> be used even less frequently for the last transfer in a message.  It is
> fragile and anyone using it really needs to know what they're doing but
> the feature is there.
Maybe it's not normal to set "cs_change" in the last xfer. However, in
most cases, SPI messages come from user space, and these messages may
come from multiple different applications. We can't make the whole
controller fail to work normally due to an inappropriate message of one
application.
>
>> I can't understand why it have to keep CS active after the
>> transmission is completed. Could you please explain this in detail?
> The feature predates me working on the SPI stack, the obvious examples
> would be a device that doesn't actually use chip select where you want
> to avoid all chip select changes or if you need to do some other actions
> in the middle of a SPI transaction for some reason (which would need a
> bunch of system level considerations to actually be safe/sensible like
> making sure you're not sharing the SPI bus).
At present, if "cs_change" is not set, CS will be changed back to inactive
after the transmission is completed. If "cs_change" is set, CS will not
be changed. This obviously violates the definition of "cs_change".

Therefore, I think my patch does not break the support of "cs_change",
but consolidates the support of "cs_change". It also ensures that the whole
SPI controller will not be abnormal due to a message from userspace.

Regards,

Yun

