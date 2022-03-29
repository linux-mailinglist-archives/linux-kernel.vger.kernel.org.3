Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6D4EAA60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiC2JVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiC2JVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:21:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F08205CE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:19:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oRmn012700;
        Tue, 29 Mar 2022 09:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JMG4+cwSkWY3qdleRgysvcdh88DR7UPaS9+8svIu08E=;
 b=XER0h57czevqOQLKQpGaMyWzlw7Cc97UjqyiYmeNNKFrJrp9VhnnmdiONq0HQw2jky9x
 M2H9ES3HFqBjPNbL+6kpb3iOJ+R14Fq057M2W34zXz5Fgv1Id4782mAlEGHVCLL6UE+6
 KqwFg8vKbnrIkypTC3TUUoIipMm/7ZpKnjHpy89a1nnlS4c0xEEQO4UcSkPD3vB5VVAY
 lI1VovxFYBd1AuZ2iNYpuecKdONaDkwwynS1CQWKHPOa0z2eQ0JIgVVWKHOKpXgGlbzd
 1XHV7kzOf56M8tBhhaZScLuWgDZMBTGECUE8IQk2l9ZVzglNK7fXs772DBqe3Blr7KAE zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0e3gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:18:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T9BPLS111834;
        Tue, 29 Mar 2022 09:18:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3f1tmyjsns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIOESTcYI77w6gWutpvkuhVWeMBuXJ2kevteOGTG3ReQfw0ggEErwGyTXVouK3UVRfkxoHzrXJ+KzJwmxt7xmz1Y6dZ8lzYYqDtGvwEoEfvxpi/jN6GxqUJQvTpFWk2x6S0/XXgP9vgP5QBcSMUuLOpJRMqDGC24jKGoaWgwqZP3k+mw+NFhx4L7rbbMj9qOFjsvAorTy5LmCaGgGdLS5s0HT1GlBvR1VHJDaBCvq6GGaFDdgnOmwc8ps6bjnDiRf+iW+90PEqdDrrsG9LpMB6A2xbWn+C6u5qjD3S2QAPr7/hYjiqR6nb0j1vIulzLbL8xDRUACCm44nqv4Wyx6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMG4+cwSkWY3qdleRgysvcdh88DR7UPaS9+8svIu08E=;
 b=Y1QcqiDMXnxvFqnne4WLCJVJyWas119p81o6RgvQi++AgWeeOMYYV1BZexXDZKa/57VmUmfx3jLi/NZK6xPjCfvYk3rFLPgRSwVSqiCrkdEfCrN76oeBshCW/Z6/zwM8uUdYVUlWp6TakxsIOftFdnj2eLlbADSs0b4tu6PPYKAkoP9IPaYWcfYPmYyfjpafQdS+xU136O2Qaqo2DS4LmFwNhDZdzdagELaAMbDBk16UBkpN5/4kOjAobLrOqJJiiejpvR+ssErFyZM0WvZiSBI8qlsuPDuz/W/V8M6dkYTX7EWbSGcd2PnDNUiH1iEUeT4CNsBnw33ptaEBximt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMG4+cwSkWY3qdleRgysvcdh88DR7UPaS9+8svIu08E=;
 b=vB+zuvszbzviDuqnIp0XZ2B37WtMHtpbcLl4YmHgz5xUS6uV7lr/AdFig+qm1+eAASPd0aBzDzIKRnbGk6d+e9bJywDV+Q7v0aX+S3ibn96i/g/ucz6EMDo2DZyrLYiyVrAkvbWlghj/c83uGMJf0k3YGGFAWo+c6+IMozYb9Iw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1384.namprd10.prod.outlook.com
 (2603:10b6:903:30::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 09:18:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 09:18:49 +0000
Date:   Tue, 29 Mar 2022 12:18:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Colin Ian King <colin.king@intel.com>,
        Samuel =?iso-8859-1?Q?Sj=F6berg?= <info@samuelsjoberg.se>,
        Charlie Sands <sandsch@northvilleschools.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, ira.weiny@intel.com
Subject: Re: [PATCH v2] staging: rts5208: Convert kmap() to kmap_local_page()
Message-ID: <20220329091827.GY3293@kadam>
References: <20220329055539.29299-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329055539.29299-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae133bfb-950c-43bc-ae36-08da11652272
X-MS-TrafficTypeDiagnostic: CY4PR10MB1384:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1384594C5E5CB3463C60852A8E1E9@CY4PR10MB1384.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZENSE1aFC8KX4Ek8p1V7B5DR+w55S2kfmtr/j9VdWjOpfCmK2BNL/8RweU+w9zAx8ctF9c8US8EXvh3qhVBA1GtXjj0nAP5BKPnTV45SzEjV0Q8CLvlcFLRfRvcPJf6+jsEynIN2rkl+yTIOb5ApgZA85pVvLhtgjlM9VckxzmZMDUyambcrexD5y27pB7ujkKuPvuYGq106UNTV0z46aa7QX+3YElQ2BECIpHF+qV+Dv3uK4OVVasHHiYM5pvNEp4H0Blyd1JFwsg/fwiXkkF7bdfBIRRsKxj6biWZ6W1ctYnYG8n/Cvlv/IN5Ahy+Be9/PEFiBMxTCazxWcR4UK9cKj94U+F6mV/vVeOdHZ41tIszsifrL3B6imPM8ed21yXlNhTDr7ca/77MzcUqSDacDf00QMkmRi0D6FVanuoXbPWyTjKRLye/L9SIFNhiOHOIvx0/5He795oGV3IfcqXB9ZLxLZXrRPEDzWGn5UHt+7rF2yrHvPKnfz7z8voKdJFL+LjZNLGBUYOdwFzBNLoM8NHJrlBLNKEJdbeE1x9+HhpLrnFrn6y87vpJ8GlltD+ZlByhABHQpL/Ny/Ca0jm35eHe02POcUegGsi3Zpcm63aiWRugJrcrMNjFIurWWHbc0KQW8zkg5O0k0Ib6yFL0yHWIV9l6Ie47Yg/Mf9NatuN3t9rCvFPkOt9v3KKq2D4D89Z98dju1P1Q5P9Hpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(1076003)(9686003)(6916009)(83380400001)(186003)(6506007)(33716001)(6486002)(316002)(508600001)(52116002)(66946007)(66556008)(8676002)(4326008)(54906003)(6666004)(66476007)(6512007)(2906002)(4744005)(44832011)(38350700002)(86362001)(38100700002)(5660300002)(7416002)(8936002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bsvpps6J7O2wnhcdqHk4U8c7U44Juu4GAYJ9+mXzy6BZLaUEum1HkDPk4liZ?=
 =?us-ascii?Q?Yn1D955DjeSLO/IBWS7If4kQemTtdtA0fRuYAjealxE5THjOJ6vsGRokfyLe?=
 =?us-ascii?Q?pW3IdzMInE79rRnfv52/zoD0+8xWnpTINIB0OTQSqnBFgeE0k5EmdgWZOT68?=
 =?us-ascii?Q?Qyc4pltgQbba9wxlwXYD+PtxPksZ3eeOXdK783idw/0lQeFoVYqtt9QL5bZX?=
 =?us-ascii?Q?sZtrG2sWVDEyA0Rugs4m0D1qUIucOHp5bwgKtg3Gx+C4uMwGBBMQLa1LJGjk?=
 =?us-ascii?Q?pFARF6DtqH//V0RlXm5Wh2+s/znc9omzTMfUEE9xiwljBweAlO/8gvePsu0u?=
 =?us-ascii?Q?Ts8AqbM3r5KQX6fpapO2lwkgTRIhoryY+cTzU3jfBmY6LldvYGdCeq0qOcyC?=
 =?us-ascii?Q?Op55MzIUN0/PGT3d8V6dDGOsPr5CBjD5VvHKO9tZ88jJxPnycUk67PsIUh9e?=
 =?us-ascii?Q?/eg27cn+HL6JciC+m1blBEMK7sTnfff1f3jjI7i8vCnuL0PRMkh8L1halqtE?=
 =?us-ascii?Q?Hh5kFzORagrmUbEDMCbPt/j1HE9of8cmA0UgzZSBb3Yw1kbFpA4VstGJuX5E?=
 =?us-ascii?Q?GFpPAb/IwHcRqMZtU/scq55ppQFwbKZozfgC6uUVqQmzwl++6GWJpkBRNxFO?=
 =?us-ascii?Q?cqoAwkva4JjUgZaEB8/+yIQtjkUKm+0HARTZI50znAD8cusmfaFeBoRToBkT?=
 =?us-ascii?Q?Ri358Esrtu64rP8Z3u03LTeg6zM2Vp+vspOe9tuQ6Ix0njAsImSrP6QvbL6V?=
 =?us-ascii?Q?LblpujF1DjXKyG+S4nqkbYuelimlm1L1NkwFdKV5gt53hRS7zHE2b0gAAfWN?=
 =?us-ascii?Q?73ENh0e9yVvxLnv+jgiZt6xHoX5xJYJP25JBxcGUYWhiD5lWRXNrTwAvghnk?=
 =?us-ascii?Q?RvZ7/tY9Ww3P6Hzq7gKsf81Rf6VMvbakEHlLO7AOZt0SZG1b6W374ZiObSHK?=
 =?us-ascii?Q?n5WUpukKiFDzwC/Z+qnVV3j7oxIZB3hUgeGyYhNsf+nmie6Jsu2DdkWTBGBd?=
 =?us-ascii?Q?37wA4XTWzdu3xjBSAAPeFVDbEjBM2P+MItw+ARkmk4Flj/ujyHM6EDVYf9no?=
 =?us-ascii?Q?XIoqODUK0Xtir9m7gvG7m1NdfAc9xIK9TzFa6khtLEq/Sx6M7E7k93VWDK19?=
 =?us-ascii?Q?QrvT8y93ao0I3IlkrPyvixqJjWkK3f84jVArrOFFYYBX+zaFlT1zR7tM2PxO?=
 =?us-ascii?Q?YAQAkU65EpH+pnv84conIx8/boKbANtAIF+hw3IBVdHX+erL7DaxUC1dDOaM?=
 =?us-ascii?Q?P5WdJEk84zimi4Y0W7a/9ZCume5lUeuiNOvbmVGCD7UOuhbKENmULUrC8mA2?=
 =?us-ascii?Q?+4Qw9C1+hVASrAhrZnUi+y8+l98FIIbF0KzxhKSvMxncqc83Y/cbtfDHXm1o?=
 =?us-ascii?Q?Y0ia+PAMPmpQEyxVsIN0/yq56Hx6I9vTOwL748uE0MPD5F1vZ32svakJptkc?=
 =?us-ascii?Q?Vw3pa5VC3B0I7WPKZJOd9twtrbiss8I/6It5uxuPsp4u67YMM6Aw4P6nBPSO?=
 =?us-ascii?Q?c3KwpKiX4sz2CclwwoMBscySgT6+N2XK3kMizyhhwPlvqVFqS2pw16ILVMoe?=
 =?us-ascii?Q?XiSBa6tzSz5T89bkllC8Vgkid7J6DNmcQWEmaudfy+XB8zWhluP2OU+sqmox?=
 =?us-ascii?Q?i2EJCvyLDnwjgzmkAmIRapf51KNv72XONV0YuSiE0YvpYXcc9EPZ3JGaT1Wh?=
 =?us-ascii?Q?YDdehe3DxcvcEcJlAQErJDIZWojTHMOWRlMeN1tWyW1P0owYKP9hEHL9P8Ny?=
 =?us-ascii?Q?fhrrZDsPIMqB9aZAS2JOhA0Lpvh3XRE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae133bfb-950c-43bc-ae36-08da11652272
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:18:49.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwW0a9gNbueWhVRZHfexAyPEbKmtvzMBMnh3ZD3BAG+REncgf0nGINNjtG7F9uNEKt/TE1fMSXdytNoSkT6SFmPk6sUIRLD5+nQmK21eyY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1384
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290055
X-Proofpoint-ORIG-GUID: rMDKRT1-srd-AmE1ba_0Klox0ocjOROm
X-Proofpoint-GUID: rMDKRT1-srd-AmE1ba_0Klox0ocjOROm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:55:39AM +0200, Fabio M. De Francesco wrote:
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index 805dc18fac0a..56b6cc845619 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -92,13 +92,11 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  			while (sglen > 0) {
>  				unsigned int plen = min(sglen, (unsigned int)
>  						PAGE_SIZE - poff);
> -				unsigned char *ptr = kmap(page);
>  
>  				if (dir == TO_XFER_BUF)
> -					memcpy(ptr + poff, buffer + cnt, plen);
> +					memcpy_to_page(page + poff, 0, buffer + cnt, plen);

You meant:

	memcpy_to_page(page, poff, buffer + cnt, plen);

>  				else
> -					memcpy(buffer + cnt, ptr + poff, plen);
> -				kunmap(page);
> +					memcpy_from_page(buffer + cnt, page + poff, 0, plen);

Same.

regards,
dan carpenter

