Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69549C4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiAZHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:49:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31236 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238036AbiAZHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:49:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q4oNmP007704;
        Wed, 26 Jan 2022 07:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SlEhJvvIlommu8cX2Duxb21atfemQhakNKLyTpWYAi8=;
 b=ZGO38aGVjOFXQvDDsxk4vmQB8+vtEM1J3SQGMOiOJkJQIsRJRrhu10ZBISWtFyLTD119
 aOYvAToZEgjtozpfuB5DLoU04g8XMnly4OCqmqPukdhCqZKx3Ki0N13dcw3/Jzkj82NR
 nj70zxiXVcI/BSr8qzJF9DNzRTvhcIJmWZ+LZoGweYJ6Genk4nkzJXHE6ixdFhuBrpAy
 eumxvmsWVuTjV+/HjJ6rCd+CizVCKkCXwScvyM19rTEuflmwlZ2N6Tpi6kkeXTHNVyc3
 5k+iC24bO0/tKV0CvIjqSaOliModmmA8JGVZYL2OmYgLNmaL7bsKEyE72vLrYW5Ek2o+ mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s5drj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 07:49:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q7en7r065025;
        Wed, 26 Jan 2022 07:49:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3dtax7wrsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 07:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqRUjhSrlYAvtV2T6XL/dL2l02h2yEybId7ex5gMuhACn28+DI0puk+jiY/ED1OCZt+wuyU9Qu0ad629UtqikDinav4M5vI5H0c742RXsATXrMV17BbQH1ztg3ywbn1No3fTGnh5i7SulIG04SEbqzyafc3W9/LW8RIpH8ilQONXTtaumLqDXei/0G8/WApdoff05QkJf6cJ/uTGkUpHWUvUdH/PBM/0l6heh4ALIPyOQcze/dQX1RsjvQhJ4OzP8fpCb47aJTRQmxurFqqd5B6JB3LnDYGqd0uwmEVfuSgm0ecxDnFK1Rr5nJ/aFNiquFNyoVclW47dxcouMO3xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlEhJvvIlommu8cX2Duxb21atfemQhakNKLyTpWYAi8=;
 b=kP2IUOF5HT1ui+sBR69p3JsQ3tuWT2g5xdywpSq/x637N0Dv8o0DUT3pGVlkCbE661r+oD5KqvhuQQwJxcYZntTjZeuBC76qdVmpunT5T8uFwufnn3GdTY8h1qJtiR8yIJduFgO3f8oooi9tgs1FZBXDtpiHY9aHce1xU8ZIkUWZqpGx6TUkXn1uWo6HV7RVPsXZMo4du1W0sCYL88qTTpSIICAubdTfc4RhcnyvvEP1bwvXgb3aCVn423k7QskMp/BkVT6/gtwAaHXFEGLx96aznQBXKOBwLRhjRJtllnGJDgPfR8KtUzVe4AiGxeYiLSgLSqpUI1ogmhoT1/VRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlEhJvvIlommu8cX2Duxb21atfemQhakNKLyTpWYAi8=;
 b=h0CU95Lzq7hPbLgm7c2XmLVhQrmheok+vk5J2s6USmiWaNYkEeejUisHjPzRnpAftz7YisAuQuC3uuDg2UGJiGtNi0sJ52Guo8Aq9JXkQiSh0b8myUFIxNekUzOmAV/IhO533BzB7vTlv7i7bEbAVVVVI8IhljO0ZRozT89ru2I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5161.namprd10.prod.outlook.com
 (2603:10b6:610:c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 07:49:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 07:49:36 +0000
Date:   Wed, 26 Jan 2022 10:49:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: r8188eu: ODM_RF_CALIBRATION is always set
Message-ID: <20220126074917.GW1951@kadam>
References: <20220122170547.68378-1-martin@kaiser.cx>
 <20220122170547.68378-4-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122170547.68378-4-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356aed46-ea4a-4a0f-d341-08d9e0a065ca
X-MS-TrafficTypeDiagnostic: CH0PR10MB5161:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB516117609CB402A946DE03F78E209@CH0PR10MB5161.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyJk9OlHJB9JajX3s2p6aVQARdZ5LUWZ/Ie7GOfWyRvhinvzPuPCkihV+aY061uL9VC3/GqWEqeTqVIDdQ3EU4phQTenC3MTvcyXorUJiYLoWczvnLXqOicaQZkIAIXShGJxzJcCePnWsd5fGaacqGGPAW6YG7OChM3SbWHJwXilfXHJJKhA92K3x1kEkxZvTlSXNlHf27nJU0LKC1OaRWjRtKPNJk8CNK/pYKJ5gazn3kbA/v5N49NMWY+6m0IcaGrL4u8152cElOSYvAOHHzpu87BSXdkI6/rCa7GGulJd0EJwFERbjAipV9Ax8GDxaXXKfe1io52+O/+gAw0KDVLIlNGNmep3DklE/kINASDAyWQwQPDp6ukb6swHayCLQPWQwz2e3u6QqpZA6zmYQ90DEFSdV2N0PBkvb32fjkE6xOL1Rf/2s0xLigTw2Ewj3+JBq1mTkLuBJplavQWpdU9Z5d1yC8ygMWvE8WDwgS3u1E4b8OQt5ZAl6n/Icjhdp8Xeo7NzhpxXQ3Qv5IwsXS70mTR5bkEaiOd0Sx8hqD0GO6rQfzmfDdA3tQKIZglpzQ585IoaeDQce6d33XeCaf3pNu37vYBobRsfrqU3B2IVesNcHJr2oxAQw1tAKVnBGp1tOgOSQdh9g+DSI+c0kotxdmxhJnFfWrd44ow6/teSjOqutkG2ke+m63WHQLLVy4ohMRUzOHFWWMKAubYSgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(8676002)(83380400001)(4326008)(66476007)(8936002)(1076003)(26005)(54906003)(6916009)(33656002)(38350700002)(86362001)(38100700002)(186003)(66556008)(2906002)(66946007)(6512007)(9686003)(4744005)(44832011)(33716001)(5660300002)(52116002)(6506007)(508600001)(6666004)(6486002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6joRz/u+fJc5bNoRnIyc3pwMcxaQjz3CtWygPujyDcRgHFPJOpGTIA9vemv0?=
 =?us-ascii?Q?poag3AU9cxbsTOETHSIGAiWXMcNb9Hr7pYG9ZZ5cN91If6APPTgeW5htdLGU?=
 =?us-ascii?Q?CdlsLmT4GGxNpP1Q4gJP9oIQFcFIhLgu7hW35aSgj5IJBRlx9u445MjWTF/O?=
 =?us-ascii?Q?duH+h4PtPPKeC04Y5zde3xfWnGwvz44PISiq3qy0sG/nFrd/6x555b/GTZbk?=
 =?us-ascii?Q?aYw/azgRf37UeNhbY/RBaAWOzp6mpi9enQpLEl2mb6Pbb9lASSkT6TOJ12iC?=
 =?us-ascii?Q?fHKDdQtruKd8l2phhYqg5mw252jCXEjoGw8moc8fZv3rZrt8hrQeVK0WuGbu?=
 =?us-ascii?Q?msWSfK7g10rowD2l4jhrstqss3Cg0h36UolxNk6T7FbRDBXKr7noE/CnHXzv?=
 =?us-ascii?Q?cxGd1zgMB6gR9F5zlhqWsFmr6Jjb85kLd46oUEJoAUGYqUvSxfqUi3L+3ltt?=
 =?us-ascii?Q?WjnthiJt6teB3qL4xUVw92ApOi4ncS6/i6IA/LmPucJI14K9ApyHYnixFbB0?=
 =?us-ascii?Q?u+Q/9z0sS8lCnnU4FB2T5wz+2tNWMIGFKm2fkc9c6PtNUVvlVAHMEWAeHSxF?=
 =?us-ascii?Q?klORaK+QGw6TWCH9Hqx3iTkftDQE16nq8DPYddXVQt30HmKi/p2nFj7Nsm+j?=
 =?us-ascii?Q?qxPLkhEWswFkGAolzVnpCQ2Slp4p2d9f2nuaTv7LcD6lEO+YQ0TcbZ7PSTbW?=
 =?us-ascii?Q?ogS/t+nWPW8Wjqotm2h0XJEOiY+qEzWbFCZIED4Yk/tpaRCzBPRKdpMvhZT1?=
 =?us-ascii?Q?Hs54QS0Dz+6srVBA0NxwcMo+7vBzsYfSuqD2eoIoYiKJZuqwjdj8Xct+wHgo?=
 =?us-ascii?Q?F08zo7WMnKyCd37riw49w0A7oLTSlb1x9t4qLt654UlOIs0Og3tAUJ1O+17/?=
 =?us-ascii?Q?wk0pF6FNp+TwaQNbIm+OY5bP1l/TE18FnLI7zW91jSf/g1CsIVCXzQlueEbA?=
 =?us-ascii?Q?QFy5ZxEsj3ISPIeJ/07p/pHOoa7S0Pdj+jVBtINWY21EIuxEfErsMWVa9vN3?=
 =?us-ascii?Q?rTo6S8jAWJk58+4VzrtdKeGiEYh9DgeWTf0fKUN09R/bZJQAgWg2LSbVZ5Tw?=
 =?us-ascii?Q?9PMLdAmLFKJV4MEiLMl2N7nwgOfoiflwNbS48uRmthLob0NoA4LGGeAjXYIH?=
 =?us-ascii?Q?negdoATZlfYqax65JJTNKYhcJ/FNhUvI/moWDUqzj8TO41fBLmRKVv8VWMP2?=
 =?us-ascii?Q?SE/US877fHllcThnAF/1j2sEDU6LWKf0Ta55ex862nQAdSvJ/vHDiWHjrwQ2?=
 =?us-ascii?Q?gFImRY0sNIXvx0WdSICAsih3BHWpYr++Q5YkzOSCb98T7KtPdHA/sL6R4Wdc?=
 =?us-ascii?Q?18PeRy+CNecb4NuR17DaU03+2KfC0QaWyWAeWxHoPQLqutbqQR4bYX3yfK6z?=
 =?us-ascii?Q?iQcgrAsxprRp8ACG6mH16CiBrBYeyWliZeX5QQfykUDPz2iSDqabs/HYGfsM?=
 =?us-ascii?Q?uWyuXeKS1S5zEl35ITNlFJC1YlJfkbVJciy5SM8/CPprfKSKEPHDHJMZzdm6?=
 =?us-ascii?Q?oGA4uQQUVKDTqvxKPvLjnJGQ5iQVXjlToeAWdspU7aPlEQ2vJCqcTcBZGPeP?=
 =?us-ascii?Q?U33PySgi/7HlxpDCkmdVgeO0teYVs5koE5d9OLo3LE1P26iSBG+PyIkdZSoe?=
 =?us-ascii?Q?0YhSw7xFwD5LbrS8nZLZ57PdXvRXYkmf/3hgViPifsF9kcMio5p4aUYAcRJT?=
 =?us-ascii?Q?chzRtLexuht4xFQwkzu1be5qR04=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356aed46-ea4a-4a0f-d341-08d9e0a065ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 07:49:36.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SF9MCvizPbCVCWUxDspdC0nbi78hlDrqZKXTH2xh7NT+tanHptBAzHvvbRFyQaT0FUfIFSkg1pza5o6OosfVUJlJAc+24tGgDAJfT6uA/ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260041
X-Proofpoint-GUID: yNx2Tm-8GLimX480dIGXD8sCQuHQ0GpR
X-Proofpoint-ORIG-GUID: yNx2Tm-8GLimX480dIGXD8sCQuHQ0GpR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 06:05:46PM +0100, Martin Kaiser wrote:
> @@ -36,10 +35,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
>  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
>  
>  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
> -
> -	pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION;
> -
> -	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);

Wait, why did you remove the ODM_CmnInfoUpdate()?

>  }

regards,
dan carpenter
