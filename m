Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF11D4BA320
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiBQOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:37:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBQOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:37:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715C10874A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:37:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HD3FD7002481;
        Thu, 17 Feb 2022 14:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0rrzg8/f50qYFuEnQAT7x4NteoNad7z4Je4Ct4jhKdU=;
 b=Id6UtLLXhooEXeUXIm2M0p5Y+t/ePhf73FTlm92qJwB16Z2ReyzR3W3RXZZXjYmf6cte
 J15UY2GT5wI4N3xFcEnUhnuhkTmy7ePHMYfTL+cmIPR246yAfpcFpoJCQMdwYlAHM4Pu
 l5LOj98wjmCQqC7M2hb96QIFurw4hcnYkzW/EfEfHLudIVG8Aj/L99ws+huNEkjYN1b9
 nGiOlc+AiBLS5ihjnLHuZv77rKmCoKdJTuYOw+z8j1fMrZCpUFWVdb6gA7UOyWiBM2pY
 o5KQojHUgoPqyGiz0Ok6oiVE7J7MH9k6l7PU1QM4hk0qlekoCIys38jZUG7cQobuHhU9 Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3dx50m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:36:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HEWThk005231;
        Thu, 17 Feb 2022 14:36:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3e8nvty43s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 14:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddX81NOWsp5icsEv7wR9kdf8DVEMXompi1R9hrMa6rIAkOsUPeoLGlKelWyTO1/rURkqonhXguBYXI+oERHfJcgxJl+xVtERn9ATw+sRV7m9reiDi9+hBl6ecceQStkyKPcRVqT2yvK9zb7xDsDCqUkHi/9zIKL3vGAwSjOv2BX+8bLS49hF4aj4QXKmDD+UcCs1hDiXzXL5DYx+Sgjcac4AqQDpuKHkYzCvdGGvHcqT/tXc1DLt3m39rWiWAeINM+lUFjBVhzjt+nAiWqc1mu/zONX2vLioSgyHMVlzZmprzx36uJ/yoVkWbUJaGc4WddFvUIaQPNFeFrjfeuPbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rrzg8/f50qYFuEnQAT7x4NteoNad7z4Je4Ct4jhKdU=;
 b=JZPu2Hewr1iokWQUCOEz8ePGXIqXiBY5oeN/GNEfss22Uu5cuqBa0sYi2w6YYjU17UsOyM7sOz3fNomNp3AQmXDVpkvoH9UKqt5cuSqOQo3bQEx7PmGp8F/k4OlWNZ4qCLKN+wf4pUKa0rjPT8wRe0Y36OOxiUHK1gsDMghfdWilozQ9Jar9pxpIkAa1wV/jRFomQsq5Ls3VQ1JvBcNEA+b4Oep9UzWiQ47/uhl0IN9Xb2ABy4ZPM5rB4kg8miV7cufHBpJyqre4mrictayWi7ClEJAnB8d4WMQG61lTD5okSSuEsJWsLuogEmHwXrpLLEua3KH/ygUaViyZBrhIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rrzg8/f50qYFuEnQAT7x4NteoNad7z4Je4Ct4jhKdU=;
 b=FOleCdraDHjH/QuDDf04s4AflXvXhg/uoZm29Q92xav1NC17A8EaxldLZUlcetpyVNgbYJKyjlQb/VC89nn4VSCMILh8hBqrgNliGfvnX+Ogv1ccwMP4tgxxOzbgwvM6eSqYilNtQdZrljrhrfW/4zUkyZm1HS1j2EeSc8+jKO4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN4PR10MB5638.namprd10.prod.outlook.com
 (2603:10b6:806:209::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 14:36:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 14:36:48 +0000
Date:   Thu, 17 Feb 2022 17:36:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/15] staging: r8188eu: remove smaller sets of
 converted DBG_88E calls
Message-ID: <20220217143631.GD2407@kadam>
References: <20220216010709.791-1-phil@philpotter.co.uk>
 <20220216010709.791-3-phil@philpotter.co.uk>
 <e187df14-403c-2908-e4f5-8d38d7f63810@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e187df14-403c-2908-e4f5-8d38d7f63810@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a932f3-cc7a-4c07-97d3-08d9f222ee0c
X-MS-TrafficTypeDiagnostic: SN4PR10MB5638:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5638C6363EF6C615EB49501C8E369@SN4PR10MB5638.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08nd5If5PCAM8/DBjx1een9T+jusfdSFyUY9eGxm0RgWqH312+me1v4kseflG6TkD3pLFYjRiUCDHk90rbqcSwMkeqFByypcVk7htXbBQ4uLDlwa2HHp4sxmxTp4451rktxKdBG8aqpVlBQhoLmVYHAfZZlKr9i0h2Wa3ZIsMgQ2uQ1fiHeMK1TaMQg8RWBdq9Tlvvrh1QIQFHJ05PR+qefKpgN8w+hswep6Go8i6C9wkxNBVUQx/hy5A52HYcnIN6tpDxyB08nlMXeE1YvsCduOYLcLDlL1KpDiAgITN18aIkJPzmyEA1seb9GVQpPX9Mp1AXvjPQuiRt2FC/L10vpVu4XCoIb6RsEiKyyiN3DQ8/wgy4De2gY9WBaFnhHXh5hCuS3ZDd4fDIFuIa+KDfiao0lh9Lw2lqWczXoC8tXFW/TWBcLK9uyZGKWuBdjdlZto/pIkO3PnJzCVt9gj6HR7uPGXra8sGIvEe6Vx5UANcH+ite2T3pS1rodKUp7AHrlJdjB9lR2mB3Ryc5Hh+EIWwbSj10Mj/m+DQYecmLvm/mq/vGIKX7MnyHju/iuALqZDL/cqtKEEc4iPirlxufrCQfR82RQi+bD+fapHaABOJqzhs4QJBUT9/1EJwaQkQJaGWxXeAXBn8DHJ8f2n0Dlo8lFq8A3AoirMGlsF0vFFVVyjrx/NxkuV3xMxtBmeWdHvoyuGykfApumS2G1ApA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(4326008)(66946007)(316002)(38350700002)(66556008)(38100700002)(33716001)(66476007)(6486002)(1076003)(186003)(6916009)(26005)(33656002)(6666004)(6512007)(9686003)(2906002)(508600001)(4744005)(52116002)(44832011)(8936002)(8676002)(6506007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OUkSTcLradq8DRFdYerxXWeeufjy+UmdjMrBHMCdQ6SC88vpibuT0qoC36kf?=
 =?us-ascii?Q?9BhD8urI7xFUkbTD5c+OIz9/VPNlpy6g5Z82GksjGTOk5D/UFcZYJ79uRdgK?=
 =?us-ascii?Q?41f/7dD7HzzGo2lNeulUhRCywxUfSCqophNqdFCC7Y1XMrL8lof+Bs1NfQfo?=
 =?us-ascii?Q?WIljZWlbBXIvkk1JSar0NdfAAjU2I/Qk1J0JLamnCVhdND0SXideDSJknTSt?=
 =?us-ascii?Q?YlZ0b1VZOOnwfwBQnqsUxP00QgpK5JrRg2iQN1qIBwvQAej4+cCV20TS3bEy?=
 =?us-ascii?Q?uwi30AOSW6z2uUQIDrVJckvgZubLX+DskUStF44uCWqDD5Nd8+Lm9Z8ner+G?=
 =?us-ascii?Q?gaisrFj/l/ocih0anGCWVhxEi3voxqIYcStI58ki55B/LCYREoU6IYH4HHNM?=
 =?us-ascii?Q?OSFHLtPG6U/QtH4xIaUW61kkAa5+HaEJ9r4nwyNV/75kVvDYwNZqYcaUJXhf?=
 =?us-ascii?Q?agjo04goA09LeocXx4RKSce1mA3OBrcZ55VymkJ/4rQjuWEm5gfa0BXe6fSR?=
 =?us-ascii?Q?Q/0H9W2ke8a3wYKtzNMR5P5sKqz+anMVrizFuBQzBexRIpUyArb0bY6SvnDi?=
 =?us-ascii?Q?+cJlU/Tlh3Ph2g7GsFgDhp91YX8yMrtMwpzuuSOW1E4kqnDcGKMys8Fy6gp7?=
 =?us-ascii?Q?xa6jK8IQ+rbdAUfxWjC94yMfqKInrajOhkMxt18SYQ9/81eHYN1N2eOe2q5l?=
 =?us-ascii?Q?sainM9Qasd2o0CqV9VfiULoAG5+ed1/TKJ2NbduAnb5QjPy7mmC29+cN013z?=
 =?us-ascii?Q?Y8LroTMUTyN8+JbY6DLaS6XPCFYulNS9PjcZ7oti+uWi2sh0RW3f+UFJrQrl?=
 =?us-ascii?Q?B1+GOlhiaq4L4e7jgk3pB/qt+Pwo54JczoJuwjYvaKIVDf6Qqnnk90Dd39+B?=
 =?us-ascii?Q?vWbxXeWoeF4/yzVnCRsN2H02IuE6FXX4wojuDB4OJPshGNO7rqX8hTsX70hs?=
 =?us-ascii?Q?wtZ4bunBwwhv+2qbv9EJl++0dWR1lPPHF5ZA44Z3L4ib+o3pfbTLD2Rz7XRy?=
 =?us-ascii?Q?S6VBVAO1MHhrSIm8Fyffiq7a152fogdwMLpLRKNWOy+jMWIwtjr6Cr/RkmcT?=
 =?us-ascii?Q?bqEIHXab9nA2GUStrlnNtwflZu+DuNUKSMwH8xHrMuAhFMUORkfCfCnMwScU?=
 =?us-ascii?Q?6GcaQQdF/HXY3BwJTghfOJFy4kQi2H8/JxafaCj03OKZsXc/cWD2FbB92Fug?=
 =?us-ascii?Q?sxCdNzM3655fKqz00KVaSiGUPQJ+jLFplvDErl6/SLNOmFU6QE9IiiC03JcJ?=
 =?us-ascii?Q?pwarU/IIDnNFWo2uIpd0AdGVUJaS4fajUgsCPpt/pXN73zYL/y0PwVblWVa0?=
 =?us-ascii?Q?o7F2YtCwFmlSV9sL1FA4fVtfgpLCHTfyPBM8fGepoacKPoOtI7lZp5MgXshz?=
 =?us-ascii?Q?cWBKtY3iCcwBHq+Xq4gTwdmyYPXI9vL17eY4E4jhFOB7jOPY7h99KUbQAJKv?=
 =?us-ascii?Q?PAP0LBYZ01QH8LECsDv6Jtb+kyy33Yw+J75r50SFS2V6sK0I6i0vkT6mfrmp?=
 =?us-ascii?Q?fGBGSxulM1Pq3sbWM9xWF0C7+3BQI1kV6TQt5yYY3kSeaEMQnxC7nC3wTQij?=
 =?us-ascii?Q?h/CzEdtMwjtDgLieWf3XzSVksHkE7lEajGZBP1+jbNCvwEaXgieWgISUUVe4?=
 =?us-ascii?Q?ml29BeEfXjNAzbRhW/WE5BQUFTlwO8Q59l/O1fIgzsLyMBIk5dB7Al0dc0F8?=
 =?us-ascii?Q?UeSL2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a932f3-cc7a-4c07-97d3-08d9f222ee0c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:36:48.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltkft5yuUWVGQv3gYu8UeyROEln/B72MwJ3NIHDnUPJKzNf3fNnp2qFLCJZIDq6CiJ9kcBe+Ymb95bjT0TVRBxMqww9gSx1E6EqvX+Lhe5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170066
X-Proofpoint-ORIG-GUID: tkZeQhAn_I2Avem7rhktkLdaDCOZaUvd
X-Proofpoint-GUID: tkZeQhAn_I2Avem7rhktkLdaDCOZaUvd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:42:57PM +0300, Pavel Skripkin wrote:
> > @@ -1467,15 +1447,6 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
> >   		updated = true;
> >   	}
> >   	if (updated) {
> > -		netdev_dbg(adapter->pnetdev,
> > -			   "[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
> > -			   pmlmepriv->assoc_by_bssid,
> > -			   pmlmepriv->assoc_ssid.Ssid,
> > -			   (*candidate)->network.Ssid.Ssid,
> > -			   (*candidate)->network.MacAddress,
> > -			   (int)(*candidate)->network.Rssi);
> > -		netdev_dbg(adapter->pnetdev,
> > -			   "[to_roaming:%u]\n", rtw_to_roaming(adapter));
> >   	}
> 
> drop if

Yeah.  If you can drop the whole if statement then let's do that.

regards,
dan carpenter

