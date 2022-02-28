Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BB4C6F73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiB1O3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB1O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:29:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C741EC62;
        Mon, 28 Feb 2022 06:28:29 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SCiXvD008207;
        Mon, 28 Feb 2022 14:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=tluDloyQCvtXCwamN9YK4oEMZVpS/TWk29+j4N239cQ=;
 b=fFtHQD0x5xp8+8r17Y/8ODIdqPhYMMutIgBAo+POdqye04N2/nWKGui4kpxp/gCWd+lY
 DZatnk5Rd++PJ+sW0R2rwYkx81+wXhDN5+2mP8flRvt6EeOlEt2+RfWSncNcu0FrlNST
 pCEsrwqUcf7zEJZiYtsKy0cZ61odSzYW/nVtg9Yv2nGTLqfi85NSntoR2NGwhxaf5TsO
 UGoy1At4rHMqWmzXdDPgQyDARS8Un83gV6tPbGSMbdzIuMvoak+JUsiV0WrYX37synSy
 2Aq0aE5umIk4koRyWWkUQYlThmaaOGtbIdMOdFLtRlw5uM7W/EmdvlsMY4nr/F3WHhjZ 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02md3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:28:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SEH4RX123633;
        Mon, 28 Feb 2022 14:28:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 3efc1321jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSzbmJsITh6nz0A2hdXszMA9UpPNCNG/wE89BO7h4Q2lRuONbrPkWWsLMouZaefuD3DEqV4mYsISHoPaaZEd9eOAZgvcgrcMTtqLgz23fRSvEUm4mzyW7DO+IKscClu2kABEUyROoJmiK01ljFo4gaVko+uzlLgIL3CQKvvcMQXdfdLakw8UElgaV8RoTcCFUpfRL/7xqWpBh4twA4L/9PhYMdW1uLl2Ty4oWohVSuy3+Gcp2l05NyejsQTYgURwNIotIx6CZhJBR/HHChlVnLatWx0/TGQiU3JOf2Vo1OmoNhWMS0qbkS94HaxOvj3t8RfkPul0gaAL5ZpbW8pD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tluDloyQCvtXCwamN9YK4oEMZVpS/TWk29+j4N239cQ=;
 b=SHKYwMaVkzi17rw4H3MTW6eDN5Ppswk++of30VUwoT8QkSMRjQR9c2mO4nBPtB+eQN/wk2uncSnYZumj0uVCOyJNL5oorSkxuwo7fsjqZWMMQwdfwKOwoobt7q9s62ChexFf0PF+CBw6hPWbPjyeRXNK7MxAeFC0Eokd7j+UpWpZja6JfjwdthWXq8r8llr8rnhp/aZj/TiuFwRctURa02NGqibTJOhGDBObmSTUEWRvniizt1WoHG7t7PlnQYZIJvYzQgNv9Z1sIDH9yu1FpHrEhrBAP2+v21yyMX+tc+8tM1YDzJ8NrfqLmtFya6nyHpaxRknD5GF22vPp5Fz0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tluDloyQCvtXCwamN9YK4oEMZVpS/TWk29+j4N239cQ=;
 b=n5Lr0C63GWmCX2xUlMi72fpANViUTdL7j5letk1JZxc6klkdCltPuRHYqGZPMEdxhui80hYWzV/SsCaRia0ppvjnYX619hLAH8EgH7GwYa880udunmidxLN8Ua6wTITdoKiHWbt1vyp47NRIfxCPtj2DrTspnbmOesef808cZVo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5388.namprd10.prod.outlook.com
 (2603:10b6:610:ca::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 14:28:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:28:16 +0000
Date:   Mon, 28 Feb 2022 17:27:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Message-ID: <20220228142751.GF2812@kadam>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228135530.6918-1-yu.tu@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e127a94-c278-4127-a1a0-08d9fac68f02
X-MS-TrafficTypeDiagnostic: CH0PR10MB5388:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5388A9D9606E1F96A08F4B498E019@CH0PR10MB5388.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/H2xvJNDHdD2H85J75hgY0xrT9/d9AokwCc+iGa3Q57JGXdJ6r/Gvpu/0ZKCmpV7txfZxPWkObzrwPw1L/q9t0Bw6Xvwe2GMpnIFVEsokK1o0Uvkl2ao2Cn9kvUbLQOAJJGs8q8RhBb2hbUpVqmzgla1eTJlptAiA4POQANgjXmAR1sjcwqEsSDiZUikgaV2Hm5gJ2GDszXBv31Owxhww2PN/4tz3MV3muFPE9GqInAbFoIAetGMAPw+l+dOkWP+0UNced5EK/3dzd1FpX6/XLXcBkpscL5JXfT+q91A1+FW1Wsqn6VFR18M780VLvpLAQ/uiQWQBErz0AO6xIkX52YVkVI+VtQPZa3pHm82+pdu+RXSJStY42pcjvrTmZs6CqlYYE/McJoNgidXThvl+4m+V5uk+ttd/CoU9Cj9GAXAS9ZVbLYD/vr1eRPiPQICw2dA3bgbdTyOef69XQ+lhrqoXVmP9avcty/6ATOWqYNQfa3GSVl+6vN7j0LrotJwoWinRbYQF7umJWODgsC/JJ87gs6QcQA2X1yqrWm5TpFGaEMHUYubS6Zxg0232CZyEGOzx1ZkiGCW6S2o5fdmRXLj59oJ8Vf9I2IK8CrIuxBanJIvVEDdVNiB9TcTiYNDF7qDPc7w3ldONZzirE4SUlSXcjEZ8CtBRZbbM5rtd75HhoVUC5fe2OTW4xDKSln6Ubm+OKO/nxMdleSrzN+PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(5660300002)(7416002)(8936002)(9686003)(316002)(6512007)(1076003)(44832011)(66476007)(66556008)(66946007)(8676002)(4326008)(2906002)(186003)(26005)(38350700002)(38100700002)(52116002)(6506007)(6486002)(6666004)(508600001)(54906003)(6916009)(83380400001)(33656002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VhV3V0Zi9DMU5PUEN0dWxiSzBQZ01sWmswemo3YVFwVCs5RkFCUEdGL0NO?=
 =?utf-8?B?ajRURjV3V05NVDBKK2VpdUVzczM2MlptbVVLcjlhcUtUdlFuK0l1cG1tS1lW?=
 =?utf-8?B?YW5YRkhxSmJ1dDBlQ3pXa3hIb3ViT3Q2c2ZpS2YyajgxNDFURm95dm9Bb1Iv?=
 =?utf-8?B?SjBPbXcxcFY5S2V0dXFpc2ZpV3BpQ0NkMjVWY09HSTk0WTB3RVJkUENpWS96?=
 =?utf-8?B?RlhQV0tSK1AxTWpJb1RrTzhjVUJ1cjlaUG90ZlZzUmpmN0gyREdBZlFuRys0?=
 =?utf-8?B?V0FrTjhnR1ZlMXVMZDdabnlMYXJ6aktlVzBMU0FET0U0ajRxSTU3eERwd3RJ?=
 =?utf-8?B?THJkdmdmaFc0ZTRDODNxMVlBZE1CaUxqVUhneUw2TElueFpOTmhYYWIyN2xp?=
 =?utf-8?B?blBOc1ZML01oZkRSeHZWamlzVi91THgzNlZuczdEUXlJTWp6dTR6a0pkWko4?=
 =?utf-8?B?eC9CNjlCQlM1WjJkRXJYdzR3L2xSWTNZaUdGR2J1MVErYU5EWCtXdDZFWERL?=
 =?utf-8?B?YUFPOG8wd08wTi9TV0xPTDFyNXBKZVZCRy85Vzd6YXZaa0ZlTStnWUM0bVlj?=
 =?utf-8?B?dERGOGk5UmV5bkV6c3BicXBXZ0k3Nk9sdzBUQktEdzdhZFllaWUvMHlabHE4?=
 =?utf-8?B?VGJNM2QzY1hOZW1lOTFUWVFmYjQ2TitDcmRoY1NVMklOVit2dnB3bWkvVXI4?=
 =?utf-8?B?WGdMcU9zNjVydm5keStNMTVNb3ByTXFGVE4vRjNpcGZWSmdiSkZOM0JoY1pB?=
 =?utf-8?B?NWdSYjJtYXJvY0s1bUxFOHo0eHBXeVBnVmk3dVJmVHVxQmZhY2VwWDZuSzJ5?=
 =?utf-8?B?UFRoaFRNM2pqc1FBOEliTEQvSmxDVVBUeVByUUlZVnNIM3RkZXF0TGw2MjVS?=
 =?utf-8?B?cmtiNWZYbVVxTk84bERyMk8zSXlGMTQ3RWpyT0ZBd0RpTTRVaEszcCtKSHNO?=
 =?utf-8?B?blNJV0xaT3Fja2NVc01lMEY5MXpzTG1DY1lndkMyblpPUGtBL2tzRjhtbDdR?=
 =?utf-8?B?U0xXRTBKajRNaXk5V2sxUSt1UjZxdUdUdE9ZUkoyQU9kMXBFVEtFYUN3RENS?=
 =?utf-8?B?WjQyeWh0QjNwSFdkdERzQW1SeXZEMTlTN2hiTGRBVEJqdEZsZ0FWTFZiNGo5?=
 =?utf-8?B?VGN3clhwZUlmQVd1VFVJRUNOK3Ryd05wSXI5UEZMZzU3eUZsOWxSUU9PWXZl?=
 =?utf-8?B?U1FSU0hlRThrSnRPTGNGNXFweVNSUllEeXkrbkdtaTd1YytuMmQ3TnpkMG05?=
 =?utf-8?B?K3RLaFZrS2pNOG80UGRIenBXSXdVU0JMNVBjeko0b0tFUFc5SktXR3V6Rlcr?=
 =?utf-8?B?N1BYUm5MODdxK25Bekp6NmJTUm55VS82cnVWRU9QbGpvRXJwZXRXb3RsQWUz?=
 =?utf-8?B?MnplK2VxWm1MM2VrRktBdXVsTUlJVEJUZmFaQkMrVlM3bWtsNlRsaFlxZ0RG?=
 =?utf-8?B?aXRWZUsrQ3Y2SWpMVW9zY3RTVTJ3R2VRZzdJWEU3WjRwREd6Q0ZnQjNWOVhw?=
 =?utf-8?B?QXdQdWg0N2NPaklCZ2kyWUcrKzZDeGYwNER5WFh6MnhiUVRvUDErdkhta1Y4?=
 =?utf-8?B?VjNIdk1MTU92VGpvbk5xTzJQZkhCeTlNWVg0dk9yV3lZdWpRdzNGVndtRmVO?=
 =?utf-8?B?YWNJSUZub2dYZU8vL3pLbUdKbWwvUU95blBkT0ZxMWRCbmhNcHhuaGVtVFFv?=
 =?utf-8?B?REdLdXVpalJmV3VtRTRkNHl4blZiMlZCNURKMm5nZkEzcDV5YXJWMElBb1Za?=
 =?utf-8?B?MWhwVmZPV01DeVNibTFRR2hVUHR1RVJOcTFBYlVoUzJIVE9QYUN2elZXY3Jz?=
 =?utf-8?B?NWxLbnptMnVsZ0VBNDNIOUxTdE91YmM4MTFmVkhReVVmNEY1VEpOVWdKWk5V?=
 =?utf-8?B?aDNCT1ozckJ4c0JmOFVpWjk1VG9qMDM3SzF2UFlhRWpWODZVRXhJOWVReXcy?=
 =?utf-8?B?a1BJcmhxUWxFRE1rY1g0YmdrOU9WZG1VbHFoR0NvWEZRK09MNkZ1SDJwMEJi?=
 =?utf-8?B?bEkrcDVNcUhJa0xoQXFnWjR1WWdGVmxybUZtdzlRaTBoV0pyZm1INFpjWHZn?=
 =?utf-8?B?TzdMMVgwN3NXeFo5V0QySXV5QVdNbktmS2UvcjVXWkl2R25tZVc4MDVJc0hu?=
 =?utf-8?B?RkI5WTlIYXRxSzRGc2Q2TnF0ODF5aDdDOGRCenMzTG1wRUdYMzRubjc5ZmFM?=
 =?utf-8?B?YjJlWG9YS3JWeDlTamRHeVNRVTlIcEs0S2J6STIxMGpMSU9LUmdyRGtsbDkw?=
 =?utf-8?B?MWRrRWp3SUpuUkw3VjYwQUtJTlJnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e127a94-c278-4127-a1a0-08d9fac68f02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 14:28:16.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB6Z9mBQ3xsfiXoVim8Ji/5R0L/M7UQxaeBCvqIRgj/PufYGfzzMO5Vgq8ZzGtzYMpl9cYKWoArlhEsYC9OHhyyJU3y2U5finTGVUIWGXLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5388
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280076
X-Proofpoint-GUID: lxT4f_ghybDwe7gJ8-4hJZhEWcujG0rf
X-Proofpoint-ORIG-GUID: lxT4f_ghybDwe7gJ8-4hJZhEWcujG0rf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:55:30PM +0800, Yu Tu wrote:
> Describes the calculation of the UART baud rate clock using a clock
> frame. Forgot to add in Kconfig kernel test Robot compilation error
> due to COMMON_CLK dependency.
> 
> Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/Kconfig      |  1 +
>  drivers/tty/serial/meson_uart.c | 37 +++++++++++++++++++++++----------
>  2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index e952ec5c7a7c..a0f2b82fc18b 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
>  config SERIAL_MESON
>  	tristate "Meson serial port support"
>  	depends on ARCH_MESON || COMPILE_TEST
> +	depends on COMMON_CLK
>  	select SERIAL_CORE
>  	help
>  	  This enables the driver for the on-chip UARTs of the Amlogic


This is a link issue.  The rest is an unrelated error handling fix.
It should really be sent as two patches.

regards,
dan carpenter

