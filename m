Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E624D2A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiCIIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiCIIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:01:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BF163D6F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:00:34 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2297tM2R028049;
        Wed, 9 Mar 2022 08:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=P0ktE61VoGxgpYD5X3c5d4qETd9drb9/Yh4xrShg6l8=;
 b=WaBE8W38TR72odUoermo8z02DB8QifPiHHIYxKWSPQocBhylyvwLr2oZzPGGmzQvsR+f
 ZRGjSOA9OXEgoWULRyRP4aOQGoJUQpbHdS4YROl8KKXfPIniOWfBaAzjRpMbU2dzetfM
 Jf8GOWpufe7mUxteoMt6oOLoYsnd8vl8+phqSUa1YRA93B7jonVzxfWYj5rpHDE0xzHP
 H/hqWlanJhBhQj0cOqvF0MxAFfV7P6Ubq+lpVFWacgpgsTbxLJrV3mUslEDEWSeM14iP
 /O400xjfilF0FpiTZBwkn4fiWfRw+0ORD306MZezlOive53G2tzzdNA+M9vD7k5dDZYc zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2hcmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 08:00:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2297pvWZ010163;
        Wed, 9 Mar 2022 08:00:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 3envvm9spd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 08:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYMCDfnzv7igoM+dS82etyOB7w6xiYzx+oDs0WxYnPc0rMIOZYyvBkNJ4Lysi4cfpRmbpC2miqSpAQV4YpDK+X0oeecpqi6V9+dYHOOyuGOsGCR5oCNKxCqTeQT+wu3lO7weKQaAsN4AGG8Io9YFoXh5+CtuJm/FnyCpQtkJhYj+orAQ4BIqKL/AQRo0lQA3vIxgrs2MYL4g2cg3bZKjTdNGGW/+DbDBNJBXgsBP+FBoRI2zlhHy4mVNa83SnkBrI0B4LLkrTGjXByGSOXgQshm89/qSK3tW6pE51wSN/T+sWEpztpKoKX4RJzziOyBercbI3zArtPa2iLmitcTAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0ktE61VoGxgpYD5X3c5d4qETd9drb9/Yh4xrShg6l8=;
 b=YxceyJadEw69CSImNu86mP1WyS8g5sJXYWCXkFf88Emh31Dqdd/olZ4DOGCzl7hyO238UHUsFq8NxEs1+n3L8PcM7qzlhg/Ce34qHmidTu2N4Tllv8zbgviktPgQOWLP7ptPnl5xxkqxJmJA6LtTHfBEPTh206X+qqypexuDVSoSW4yMzvvvwhV4jTI1fXAxd1YUTj6N2Q6cgm8SWFs9SFW4nnfbqk7XU6ARGHgvk0+hbqwp4xNp66Ex0MBa6IHs3WzbK+WLNyFX/s5SW05se07DLpASKzVKE4LxvR+9Cgl1bKb3hIwsjhJF/DsVWi5xm2RPf0dNytYCUk0+530ZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0ktE61VoGxgpYD5X3c5d4qETd9drb9/Yh4xrShg6l8=;
 b=LbZg6oyWnBCz0b65lokVauaBnuR4ZDA3jgdKjpFKCF3MC5pSrGUdgFZL9Wcmge+YkSszVuoslfRlcZxReU26KaKXOqlt5SbEE6qNKEnL/tn0ibO/3U92Txy2zOXmEhoUTU7KK/NmwzqenbwxoxwZTqwteX4kxWsrv9sgP2B6SYQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1588.namprd10.prod.outlook.com
 (2603:10b6:404:3d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 08:00:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 08:00:09 +0000
Date:   Wed, 9 Mar 2022 10:59:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: call _cancel_timer_ex from
 _rtw_free_recv_priv
Message-ID: <20220309075951.GQ3315@kadam>
References: <20220308205510.48431-1-makvihas@gmail.com>
 <20220308205510.48431-2-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308205510.48431-2-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ea3610-3101-44b0-0d47-08da01a2d4b4
X-MS-TrafficTypeDiagnostic: BN6PR10MB1588:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB15882A5ECE1BDCA8DAC0A2D18E0A9@BN6PR10MB1588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8io/c+KkNJ8y8XTqDdGJ4xrr93vsGNX9NYW7p4cCeQmvnE95edi3xPiDNTmnp2YepGGNlThqCMnjX61qwfZK+gJUR5dIQARKNmth2gcZBQDKCbXWC3wJQfxEBdSVP83zl95e4BtvcX0w//lFhmKtim6MQKCHjnOte/ovIgZF57nSsH1GvmSLy4O/8CyAroienuzi7onieauYLVQIsvp92ukNfj+tfpXHu68uE4bQmCgyErwIecET/vVKT3Vv7GVSvpz8GIfD1PVhYyY+xUjMnNgJcRWSBQ1IyJveUScLUUoZgCoeVtQ4IBNy0fV6YIolYwCk7KoYCCoeFXCSkKGLp6apFOuUs66DRMAi2k2yAOruZPJLFYEo8ggj7zz5S3eXW//iWK0a4WjK3eY+SauBCiqMy+PbUgmTUm0au9ozM3bhXSwLP4dMz60WpyIGsRK1p6FKFyE2ZVoXSsbDmEyxc5e0NXNJ/gtDlNJlvzLMp8iWU5euXAmHzLkxYYDLtajgcN5LwYAs/PG29hkAh4AoJtOmJukts2qZqtcDX9UaXZOVYKbThOElIyuhP36iu69nSqGXxOFnf9itpCwp7uIbi/Y15tN1fLiYnY3MvlxJjOAZUBxhVvLcbc/vlsQ6439bpqW1FegWhIoYvwjEYQprecvIe8gC/ksixAdMvsIpuIvMPMGr0G789B1f59HXtYmuo175sT1qedaXpm1sTfnmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(508600001)(186003)(26005)(316002)(6512007)(9686003)(6486002)(1076003)(6506007)(6666004)(2906002)(66476007)(66556008)(5660300002)(8676002)(4326008)(38100700002)(66946007)(38350700002)(33656002)(44832011)(33716001)(6916009)(8936002)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ouUCuDc8wdTV4rGQ6JwN8NTQpvjOCg86KcgZWw0YaKNujQcTM6hle3qeFVs?=
 =?us-ascii?Q?DgCum3eo7DtI00pJPN9qIdNHiDjipqM4z2pm+uYlqpH8c9nquk7x45Ee1x0S?=
 =?us-ascii?Q?PlHRaItTGDxHFJzl+b766cyc0ruJZKYhwTDZ4tXgRAEqY0GZS4x+Ec4HSkjt?=
 =?us-ascii?Q?m36MYLBvjL5atiCHc3Aslp8wfDopq3FktPWgXnuwh2SbjH17WYW3jogkP02D?=
 =?us-ascii?Q?RMD4G8mku4zT9h3+U6V9FuBC4beiiBCivB9uNIAqESU8ZITcN5PkdMyyECq8?=
 =?us-ascii?Q?EkOb6cGSSQ8UbIKHW9so9bl2woCE+rvWvWY/dg9zLHRHYom15V1gAkAge68h?=
 =?us-ascii?Q?jxVvV82yFPWM3YbdmVOGbTWsQ675s2mhzG/a2Ga8qrra+LMJMHMTe616H4E3?=
 =?us-ascii?Q?fuCNkiaXJoNrwHVBcLqO+JyhEk2nvlh0SIb2FYAq0YI7CveO1bPrX2lhgMva?=
 =?us-ascii?Q?8QOu5o4zDAGXdGD5/BK3x1vRFlxbNeucCZCzmpLhp0PmRMYXrKaaACyYUAWT?=
 =?us-ascii?Q?Fq/z0HEgeDjZ7zPoIs/S+fKxamfkrMDOS3XalAoKNhZSAzWW8Db0HJJPtAU6?=
 =?us-ascii?Q?Hg7lKvu/ViICXZYauRm+DwWlMzryA2phJW8Uk0jktTD1VmuolVzjmamXL/he?=
 =?us-ascii?Q?Hjig4lI0Fatw1eHJeLd447/w9Sl16ENY8hYnbtKl0oV97lu2VEoLGct97Xbt?=
 =?us-ascii?Q?OmJgA9wNsVYexrm+5rs7+tk6DWF7rwk4ULce9CFBMvxOZm/Sgq7kRgUTg3XF?=
 =?us-ascii?Q?oLck2G92PSYJr/rWT7SZM8Tlzm7A+3KBe5EngG938uFmq2qkmB8whXrurH4A?=
 =?us-ascii?Q?0yOrVPZG0w8lRZbqv9adN0A03L6moVDNMFzB7crD0ZTFvt4BnL7w/KENI2dJ?=
 =?us-ascii?Q?qjs1CDmuY+o2C3J0WxI6/ymBAproD/xxG016e5/ABm8PdbZJit4SY92fTP64?=
 =?us-ascii?Q?lQrdq9k3+GhQ/Gbx2dHjsuQyjvvISGjoeRZ/PQVME8rqpYtIX81IS6n4iSpW?=
 =?us-ascii?Q?H0+31QymZ55Vlu18HjHuxQ/hCFUO20EcyiWeGcox8ccJAT+M5rDmfORlGJS2?=
 =?us-ascii?Q?Vx6w4YjLlNxwJIcxLTBF7u5Z9IfVGbP4mgO9XlXFUV7zC4o/1ovde6avxTJq?=
 =?us-ascii?Q?GwQbFfoW5Z0oJODBdnNYomIbe2HDuzKV8ZvU0mRwP4WGM8zvIBvxlsV9At/u?=
 =?us-ascii?Q?Igpfg5eCludPBGpwlYKbKB5dVUY4civxMTm7THPw69BggluQXX5nJohHXQGw?=
 =?us-ascii?Q?vJLLVkucDLYsB7EbCA0u5UzaCsNXKsWn92hVhd3vdQ2eHKyjpiSN7Yi4IXBR?=
 =?us-ascii?Q?BrRBMsbRUyEfIRghj587yfWqa5TiCMjA5p8BeuvPagRFt3Jn7qjVNwomzz7D?=
 =?us-ascii?Q?83Svoo5UyQ9xD/g5qd350bgTqjmYe5GHCJ1GiwGJGHydhPFeXo/X9ixo38hg?=
 =?us-ascii?Q?0GohXM1W/NWFTfnZTw8UYJrcR28KhQEHhjzMKjXEtmwrxYjE2IXib5OrkNkL?=
 =?us-ascii?Q?/kClab1kzNSjjlO1MaBg3CDLz4U9vPxt1D06+gfmYDnT90mLIP+cRTc0fKmd?=
 =?us-ascii?Q?0d9+c5ZzvUIzUPphYs0o9w52k4E45quQWqdUJn7DtzCcpns/WQ6EyOG4yfIq?=
 =?us-ascii?Q?XT6M4/9FbREoMbCoGtWch4uvTkLRxbD5rbSWtOMd0+BA47006qd57O+myZcu?=
 =?us-ascii?Q?ZtFkbA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ea3610-3101-44b0-0d47-08da01a2d4b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:00:09.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lXGgjXqmqu33lEuoipjyl5LGcYXrcTDL3aK6TUTv/S8K2DNZtRGfNfyNlHmPa4c8YgB/uZ3bxdRoXVJTQUW+kUhGnvlxdzFxDPOmL99XRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1588
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090041
X-Proofpoint-ORIG-GUID: jiR0mScFVgWvj5KC--dYhC8-ztZXt0EO
X-Proofpoint-GUID: jiR0mScFVgWvj5KC--dYhC8-ztZXt0EO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:25:09AM +0530, Vihas Makwana wrote:
> The _rtw_init_recv_priv() initializes precvpriv->signal_stat_timer and
> sets it's timeout interval to 1000 ms. But _rtw_free_recv_priv()
> doesn't cancel the timer and we need to explicitly call
> _cancel_timer_ex() after we call _rtw_free_recv_priv() to cancel the
> timer.
> Call _cancel_timer_ex() from inside _rtw_free_recv_priv() as every init
> function needs a matching free function.
> 
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index d77d98351..61308eb39 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -103,6 +103,7 @@ void _rtw_free_recv_priv(struct recv_priv *precvpriv)
>  	vfree(precvpriv->pallocated_frame_buf);
>  
>  	rtl8188eu_free_recv_priv(padapter);
> +	_cancel_timer_ex(&precvpriv->signal_stat_timer);
>  }

*If* then timer_setup() belongs in _rtw_init_recv_priv() then this is
where the _cancel_timer_ex() belongs, yes.  But what about if the devs
hid it in a different wrong place?

Right the del_timer is in rtw_cancel_all_timer(), which is called
from rtw_usb_if1_deinit() when we remove the USB device.  So something
more complicated is wrong.  I would prefer to just note this as a bug
until we can investigate more completely.

I believe we can del_timer() twice without creating a bug, but I'm not
positive.

regards,
dan carpenter

