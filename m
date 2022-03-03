Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3644CBD9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiCCMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiCCMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:21:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E415F0A6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:20:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223BjXIK013834;
        Thu, 3 Mar 2022 12:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0ony6ipuV1Q2++N4fIPRIkc+SDQhyE+UrvGdbZ1v/WQ=;
 b=lVXO/hLWkkyoChPljggxKhVwAHh1iAjUC0mRfrJA5QFgQ1nI5ah0Chf7cVIruVLASdE5
 z3QAjlMkTaIm9UgHzA55YaDU2ZRQzZnr7ofmgf9qT8B1r4lHSVG7Hv+Oa9cUJxydFrJJ
 UwOM6SePq+4aspcG2PLkkGQ668Tds6vJ09k/5cVc/6OYZCNhQ2XbFmNhftFAYeuwmeLq
 E1Quekgo3mt/oYSvFlxX+J4znIMtmbE9pbPyKe7KDEwMAY1IcrXxrh+s/hzMO32ucb2f
 uiZ0Mh7J5VjbwQA+pIhdTcR7yHhXMPrx3tIxLyWw5HBs/3eMElss83OdyfeYMByXpYyD 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k48n05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:20:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223C67vM042062;
        Thu, 3 Mar 2022 12:20:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3ef9b38adk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmqfZnYMlyWi2HytvgWN9BSsmeeUJNPItkzhHUt3jibfE+jFcA9QDH95a7V1WGKn7nsSoKQ8UhO6kYxhdJRZrtPXkVV2QnCj1qMn8WwwM3Ga+tu0B1ZoLRG7XTw1eIkPSswd/oodSU76o55fhV1z4N9ie5Vqb92uQHAtoRh1Kqc5xPV1l5993mZYkfIuc3Xq2D425bxFcqzgU51afEp5vB9tfdNI0RegpBXH78DohncVkBLt+XAKLkDy77yibp8sxhW8ruFK8f2ONRFHf0J2yjQwiCku9nPibQ+9cE88Nk6mUWTimrKkanv9XWBveuecWQiW9Z1MkGLeVRuK9kGCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ony6ipuV1Q2++N4fIPRIkc+SDQhyE+UrvGdbZ1v/WQ=;
 b=BevxHI3XNhGmvIgDh2Wuqgx3q51mr4ZvqvAMGFfmV7dv3GhvN4XqOP9n8fgxicWQnhuCYCqWoJVaJs4X+gO2PmsrwZvKwKwFzQdP+/xQxWOMY6id6j0lr75ZiV5nDXZ+tHry2sIX9jyNO6wUoMUPPfCraha4Ljs3oM5RXl+0Ig9C6NAnCAfPrHtcFvfH3xZwF/UDfyDLgh3Dz6DWdKUyTF/BGOjrSrHXIaSp7xm21VN4OoWoUDCW2SwnouAhrA8mqoiTfDV7ZJgbwnhjbiJUQFDWiw4UHLwk3rEfpET/Uu6ymICB3XtjyG/5SxSjh8HJDcFMhW5oOjicUhkFsUApyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ony6ipuV1Q2++N4fIPRIkc+SDQhyE+UrvGdbZ1v/WQ=;
 b=ZMfEdU7I3DuNdPr6EYESY4FXwAKB19ED2qUlXgqfAnu+s/o9sMWc+uq9rp8YDK7LY+d770ZSXJr+n6WRS8YsbikKpeyvP1aWxEoprkfBSEjpVXoLI60EkLnrjBn3qMx0VAlrXyEg/0+M/QGSQ2jYQlGrDy0RpP4PNAs2WC0023A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 12:20:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 12:20:19 +0000
Date:   Thu, 3 Mar 2022 15:20:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] staging: r8188eu: convert functions to return bool
Message-ID: <20220303122003.GG2794@kadam>
References: <20220302204737.49056-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43fb56ad-d104-4af6-cc70-08d9fd102e81
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595FDA171D550E4FEF032258E049@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7+HVzTRLIBqzpftLjuc2M0zGKVLSdixpfTyfZ6XN2fo0GF+0lQpPvOOoVag671YB7rnbOjiVUJshuKql9vxu74hhILx5FYoiTf2ELyt/aOV7+DktUNU/UPhuadDfM3E1W3waT8spBuBm09e+BLf9X0pUbKmcINtWYLUhKwwLd1qMly43gC+q7vnQNvHUXKjgsPFHu5w9PuopvaekLZwQVG+wcAoqemI+HLPkXcchQtq6KlXPrku8tsJiJuEw2xpFIki6aH+kPZVwg44XO6acluY4Jsm9xEomF7bH/x30vOnf9ZSuytUr8N6heGb9WIpP80dGDBxu211mKbVSTzmDANRRJkCeCL/GCrrvscNJe6tfJfR8nmG4L6g1BjS9UypNbYoTYK9KxBjyN2g1njgHP6iHZkK3aDU+zEeTx5fZc+lxFyfngHHCTzE222bNWWdUbQmkJEJI2daCL5vDovWjyB2TBvRKJ4A6qoj4C5JmqG50sqLyubzG/KPvfRQiyuzAh4It+oa/r4hZ6Kf6QH/yQFl6pHSpd1+dX6XQVj6gMg3KI7y7yJ7a9DrBrrB4xo2OlFH/SDhmaUwHwOb6gwultlhWYY+VG/FwvfiIEKEkQkv3RPPB+mgorwk7E3pHSTh/OTuW9cYRrt8WrRAEwivIiRK5mDnf+hHB6L/SLmoGmvnwP5+rLu5R2rTs9S8vL9Wx7Y03iy5N7DpEHiPbyWLCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(33716001)(2906002)(26005)(38350700002)(5660300002)(508600001)(6916009)(54906003)(6506007)(186003)(86362001)(52116002)(8676002)(44832011)(4326008)(6666004)(83380400001)(66476007)(8936002)(66556008)(6512007)(9686003)(33656002)(6486002)(1076003)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+sSQogZq7JcrG/TfwjkeKjfSSo2tDgT5ooZVNIPOjpWEbgcI17m+FEmDaTh?=
 =?us-ascii?Q?vt6e/GuFo1/4wsNhgheYn68SIxptXzeu7ghXlZ2GZlnV0uhv92aHVY8OquEU?=
 =?us-ascii?Q?9fXYmlutnpn5CAAFYZ06cwQHn3HqhiWqhpNaoSDEChzyJbGRtJe4ylPHMR8s?=
 =?us-ascii?Q?g4L+1T7+HP/pxAIaIUdOEevnLDH9DKu99wVBS68YiYhJe7rCBvWwsKh0sTFc?=
 =?us-ascii?Q?jvQiCCPbTNI3t+exRP7ytZZ38HXoFVaHG8wVArAzwXUiyFTZHQG67ryDSqmN?=
 =?us-ascii?Q?09dP27qTqVhoi7I7vkHpbgs9smOsfLvJWh25S5eb1ny2MATsdkvTpiTL8kXg?=
 =?us-ascii?Q?q3/DoWUbHlwZpLR9EcAioGeSGeFCQl1bewGxUONK/jGp4sysu9gu4uHDHcXM?=
 =?us-ascii?Q?kMRfgyoLZWjecKSVf3aNQzmLMBpv7jUrMlN/ClVIqynxc7TsXU/f4rvASZqd?=
 =?us-ascii?Q?kehVf9PulNdZ4cjJjssejbVTnaj71ZC4i3OD7IkxA66xncoIbMHgKUHS96Xf?=
 =?us-ascii?Q?SsqDz0rMr4S1REu/6WCIHYn1Z4QwnsyuqtCh9rzg96sK5xXKN689LtHAd8hy?=
 =?us-ascii?Q?FalRLi+WHTOjlRsg7xlu3Ek/TTtuo1343nl/Gb2Du619pAnh4J9nHjwanAsF?=
 =?us-ascii?Q?b6uF3a1G6pvTR/yc24sq3Hiq/R/oHd292COtaX/8a/qCq8F13sL8GT3mzVFj?=
 =?us-ascii?Q?rVfSQOSNBaJ98uf4+9GLhHekhj1iCdViQkplqQ8o7+ePmT4IhEgdClfWEKhS?=
 =?us-ascii?Q?+hLkbAwSJ9FjlK4Lk+qkJv2nF8RrpAyZEDhIb+p4/Z+qeHfIgy7BD+ifPvvb?=
 =?us-ascii?Q?WJMIkgGyUMPx7gBnGXmiNfu1YjXmmMYRt6v6edYaWMzGrnGGf+K+sDUBLXaS?=
 =?us-ascii?Q?W0TfO+UXOIawaXL97gOObYQO1ONKJRaLyAuNwloPznRLwngCFvx/iaMmD3LN?=
 =?us-ascii?Q?ZQGe6ZPXl7aJ1usbsvgYPRDlp0DtBKvNTxYJyAbDC8OXZ0gIEKOivDnj++/3?=
 =?us-ascii?Q?L5u4USD/aETdWAEoiwizcso2XQFYOeANXGXwmeqEKfckt80sjNwqschvCXT8?=
 =?us-ascii?Q?hZULPHYuksB+Kw02spCyuQT6b9yUK0W7Ntc5MBUZdDlwpxxTjBYZoLi4ZX8z?=
 =?us-ascii?Q?ndhyjjOyiOiQJ+L5AV4BnrXVjzdQqIIHYLQt6txMtPlWZDYRM1q/jkP888Lo?=
 =?us-ascii?Q?fm4SbFahpdTIH3nBlbca7uPg7MqqJU8x6QNLbzfmcUHTvWrBR2DIessc47mi?=
 =?us-ascii?Q?pLjbzHu0wHvsnxXmw5NYKM1fFqwknH6Z06lTMqcvCRyg7WviMfevY70MISb1?=
 =?us-ascii?Q?zzYSLDgj9qVekRcGtPdMIr3t8uaLg3NiMVKyygxLI/aZHyjqNlzwfNT0UoLQ?=
 =?us-ascii?Q?AzfGmXE/B22pREdMmp1IMT70VC+dgLtc7lNVDB5WcI7y9MxxRiL5VXOLjIvG?=
 =?us-ascii?Q?FMdAGxyibnDDWGjlhJmqirxMngNelIbG/jBqsv+dC8CykBWuoO3+5BUAzhkg?=
 =?us-ascii?Q?CBLPmRWC6wYbI6uX0k1zfm+V8J6bs0TaUwaO1lT4tSn8CswObz3hvaDgCNDy?=
 =?us-ascii?Q?7ix1XrhPvghdpskOETnoTBHrswAGKqx0+j1O+/w/ig3nN2l6djI9oFe6AHdW?=
 =?us-ascii?Q?8voRgPnJIlkeWYvj4RHE6l++aGsCRXQzNWP3WMpmttFsLn2LSkFxCHYWRUl5?=
 =?us-ascii?Q?xpaXUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fb56ad-d104-4af6-cc70-08d9fd102e81
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:20:19.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L63100gXns/Hyd44Am544IjTdOiZ4r2HZozT0gnrkvIFf3pMCC9o9Fs7Q4SXs0IcXMkP0A9ERuY29Ssp73cJrvE/O44m/ieriJbg+O7N3YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030059
X-Proofpoint-ORIG-GUID: Esj8xH0SFzoJ55t87KkiIlth5_TtIyat
X-Proofpoint-GUID: Esj8xH0SFzoJ55t87KkiIlth5_TtIyat
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:17:21AM +0530, Vihas Makwana wrote:
> There are many functions which return true/false but are marked as int, 
> uint, s32 etc. Mark them as bool.
> 
> Vihas Makwana (16):
>   staging: r8188eu: mark rtw_is_cckrates_included as bool
>   staging: r8188eu: mark rtw_is_cckratesonly_included as bool
>   staging: r8188eu: mark rtw_is_desired_network as bool
>   staging: r8188eu: mark PS_RDY_CHECK as bool
>   staging: r8188eu: mark check_indicate_seq as bool
>   staging: r8188eu: mark enqueue_reorder_recvframe as bool
>   staging: r8188eu: mark recv_indicatepkts_in_order as bool
>   staging: r8188eu: mark cckrates_included as bool
>   staging: r8188eu: mark cckratesonly_included as bool
>   staging: r8188eu: mark is_basicrate as bool
>   staging: r8188eu: mark is_ap_in_tkip as bool
>   staging: r8188eu: mark rtl8188eu_xmitframe_complete as bool
>   staging: r8188eu: mark check_fwstate as bool
>   staging: r8188eu: mark IS_MCAST as bool
>   staging: r8188eu: mark IsFrameTypeCtrl as bool
>   staging: r8188eu: mark rtw_endofpktfile as bool
> 

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

